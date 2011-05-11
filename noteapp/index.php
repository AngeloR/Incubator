<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

include('lib/app.php');
include('lib/limonade.php');



$now = time();


appinit();

function configure() {
    set('THEME',appconfig('theme'));
    set('THEMEDIR','views/themes/'.appconfig('theme'));

    option('root_dir','incubator/river');
    option('views_dir','views/themes/'.appconfig('theme'));

}

function before() {
    layout('layout.html.php');
    app_connect(appconfig('use_db'));
}

function home() {
    return html('');
}

function note_list() {
    $sql = 'select note_id,note_title,note_description,created_time from notes order by note_title asc, created_time desc';
    return json(array('status'=>'success', 'data'=>db($sql)));
}

function note_info($note_id) {
    $sql = 'select * from notes where note_id = '.$note_id;
    return json(array('status'=>'success','data'=>db($sql)));
}

function delete_note($id) {
    $sql = 'delete from notes where note_id = '.$id;
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
        $sql = 'update notes set note_title = "'.$note_title.'", note_description = "'.$note_desc.'", note_text = "'.$note_text.'", created_time = '.$created_time.' where note_id = '.$note_id;
    }
    else {
        $sql = 'insert into notes (note_title,note_description,note_text,created_time) values ("'.$note_title.'","'.$note_desc.'","'.$note_text.'",'.$created_time.')';
    }
    
    if(db($sql)) {
        $sql = 'select note_id from notes order by note_id desc limit 1';
        return json(array('status'=>'success','data'=>db($sql)));
    }
    else {
        return json(array('status'=>'fail'));
    }
}

function preview($note_id) {
    $sql = 'select note_title, note_text from notes where note_id = '.$note_id;
    $res = db($sql);
    require_once('lib/markdown/markdown.php');
    $res[0]['parsed'] = Markdown('*'.$res[0]['note_title'].'*'."\r\n".$res[0]['note_text']);

    return json(array('status' => 'succes', 'data' => $res[0]['parsed']));
}

dispatch_get('/','home');

dispatch_get('/notes','note_list');
dispatch_get('/notes/:id','note_info');
dispatch_get('/preview/:id','preview');
dispatch_delete('/notes/:id','delete_note');
dispatch_post('/notes','add_note');

run();
?>
