<?php session_start();
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

include('lib/app.php');
include('lib/limonade.php');
include('lib/session.class.php');

appinit();

function before() {
    option('root_dir','incubator/noteapp');
    app_connect(appconfig('use_db'));

    
    if(!array_key_exists(appconfig('session'),$_SESSION) || empty($_SESSION[appconfig('session')])) {
        set('THEME',appconfig('theme'));
        set('THEMEDIR','views/themes/'.appconfig('theme'));
        option('views_dir','views/themes/'.appconfig('theme'));

        layout('layout.html.php');
    }
    else {
        set('THEME',Session::Attr('theme'));
        set('THEMEDIR','views/themes/'.Session::Attr('theme'));
        option('views_dir','views/themes/'.Session::Attr('theme'));

        layout('app.html.php');
    }

    
    
}

function login($email = '', $password = '') {
    $email = ($email == '')?mysql_real_escape_string($_POST['email']):$email;
    $password = ($password == '')?mysql_real_escape_string($_POST['password']):$password;

    if(!empty($email) && !empty($password)) {
        $password = pw_hash($password);
        $sql = 'select * from users where email = "'.$email.'" and password="'.$password.'"';
        $res = db($sql);

        if(count($res) == 1) {
            $sql = 'select * from settings where user_id = '.$res[0]['user_id'];
            $settings = db($sql);
            $settings = $settings[0];

            $appsettings = array(
                'user_id' => $res[0]['user_id'],
                'autosave' => $settings['autosave'],
                'theme' => $settings['theme'],
                'preview_library' => $settings['preview_library']
            );

            $_SESSION[appconfig('session')] = serialize($appsettings);


            return json(array(
                'status' => 'success',
                'data' => $res[0]['email']
            ));
        }
        else {
            return json(array(
                'status' => 'failed',
                'data' => 'The email and password combination provided were incorrect. Did you <a href="'.url_for('fp').'">Forget your Password</a>?'
            ));
        }
    }
    else {
        return json(array(
            'status' => 'failed',
            'data' => 'Please fill out the email and password to log in.'
        ));
    }
}

function signup() {
    $email = mysql_real_escape_string($_POST['email']);
    $password = mysql_real_escape_string($_POST['password']);

    if(!empty($email) && !empty($password)) {
        $hash = pw_hash($password);

        $sql = 'select * from users where email = "'.$email.'"';
        $res = db($sql);
        if(count($res) != 1) {
            $sql = 'insert into users (email,password,last_login) values ("'.$email.'","'.$hash.'","")';
            if(db($sql)) {
                $sql = 'select user_id from users where email = "'.$email.'" and password="'.$hash.'"';
                $res = db($sql);
                $res = $res[0];

                $sql = 'insert into settings (user_id) values ('.$res['user_id'].')';
                db($sql);
                return login($email,$password);
            }
        }
        else {
            return json(array(
                'status' => 'failed'
                , 'data' => 'We already have a user by that name. Did you <a href="'.url_for('fp').'">Forget your Password</a>?'
            ));
        }
    }
}

function logout() {
    unset($_SESSION[appconfig('session')]);
    redirect('/');
}

function home() {
    return html('');
}

function note_list() {
    $sql = 'select note_id,note_title,note_description,created_time from notes where user_id = '.Session::Attr('user_id').' order by note_title asc, created_time desc';
    return json(array('status'=>'success', 'data'=>db($sql)));
}

function note_info($note_id) {
    $sql = 'select * from notes where note_id = '.$note_id.' and user_id = '.Session::Attr('user_id');
    return json(array('status'=>'success','data'=>db($sql)));
}

function delete_note($id) {
    $sql = 'delete from notes where note_id = '.$id.' and user_id = '.Session::Attr('user_id');
    if(db($sql)) {
        return json(array('status'=>'success'));
    }
    return json(array('status'=>'failed'));
}

function add_note() {
    $note_title = mysql_real_escape_string($_POST['note_title']);
    $note_desc = mysql_real_escape_string($_POST['note_description']);
    $note_text = mysql_real_escape_string($_POST['note_text']);
    $created_time = time();

    if(array_key_exists('note_id',$_POST) && $_POST['note_id'] !== '') {
        $note_id = mysql_real_escape_string($_POST['note_id']);
        $sql = 'update notes set note_title = "'.$note_title.'", note_description = "'.$note_desc.'", note_text = "'.$note_text.'", created_time = '.$created_time.' where note_id = '.$note_id.' and user_id = '.Session::Attr('user_id');
    }
    else {
        $sql = 'insert into notes (note_title,note_description,note_text,created_time,user_id) values ("'.$note_title.'","'.$note_desc.'","'.$note_text.'",'.$created_time.','.Session::Attr('user_id').')';
    }
    
    if(db($sql)) {
        $sql = 'select note_id from notes where user_id = '.Session::Attr('user_id').' order by note_id desc limit 1';
        return json(array('status'=>'success','data'=>db($sql)));
    }
    else {
        return json(array('status'=>'fail'));
    }
}

function preview($note_id) {
    $note_title = $_POST['note_title'];
    $note_text = $_POST['note_text'];

    $note_title = ($note_title == '')?'Note Title':$note_title;
    $note_text = ($note_text == '')?'Note Text':$note_text;
    
    require_once('lib/markdown/markdown.php');
    $res = Markdown($note_title."\r\n===========\r\n\r\n".$note_text);
    return json(array('status' => 'succes', 'data' => $res));
}

dispatch_get('/','home');

dispatch_get('/app','home');
dispatch_get('/notes','note_list');
dispatch_get('/notes/:id','note_info');
dispatch_post('/preview/','preview');
dispatch_delete('/notes/:id','delete_note');
dispatch_post('/notes','add_note');

dispatch_post('/login','login');
dispatch_post('/signup','signup');
dispatch_get('/logout','logout');

run();
?>
