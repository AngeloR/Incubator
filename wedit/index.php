<?php session_start(); 
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

include('lib/app.php');
include('lib/limonade.php');
include('lib/markdown/markdown.php');

appinit();

function configure() {
    set('THEME',appconfig('theme'));
    set('THEMEDIR','views/themes/'.appconfig('theme'));

    option('root_dir','incubator/wedit');
    option('views_dir','views/themes/'.appconfig('theme'));

    layout('layout.html.php');

    app_connect();
}

function User($key = '',$value = '') {
    static $info;

    if(array_key_exists(appconfig('session'),$_SESSION)) {
        if($value == '') {
            if($key == '') {
                $info = unserialize($_SESSION[appconfig('session')]);
            }
            else {
                return $info[$key];
            }
        }
        else {
            $info[$key] = $value;
            $_SESSION[appconfig('session')] = serialize($info);
        }
    }
}

function before($route) {
    $page = 'Default';
    if(!array_key_exists('page',$route['params'])) {
        $route['params']['page'] = WeditPage::Munge($page);
    }

    set('page_title',$page);
    set('pagelist',  WeditPage::ListAll());

    // Set up user details!
    User();

    print_r($_SESSION[appconfig('user')]);
}

function page($page = '') {
    if(WeditPage::PageExists($page)) {
        $res = WeditPage::LoadPage($page);
    }
    else {
        $res = WeditPage::LoadHomePage();
    }
    
    $res = $res[0];

    set('page_title',$res['page_title']);
    set('page',$res);
    return render('<div id="markdown">'.Markdown($res['page_content']).'</div>');
}

function create_page() {
    set('page_title','Creating a page');
    set('type','PUT');
    return render('partial/page_form.html.php');
}

function create_page_handler() {
    $page = get_route_options(true);
    set('page',$page);
    $required_fields = array('page_title','page_description','page_content');
    foreach($required_fields as $i => $field) {
        if(!array_key_exists($field,$page) || $page[$field] == '') {
            app_error('All fields are mandatory. Please fill out the '.$field.' field.');
            return create_page();
        }
    }

    $page['page_creator'] = User('user_id');
    $page['weight'] = (!is_numeric($page['weight']))?0:$page['weight'];

    if(WeditPage::CreatePage($page)) {
        app_success('Your page has been created!');
        if(array_key_exists('homepage',$page)) {
            WeditPage::DesignateHomePage(WeditPage::Munge($page['page_title']));
        }
        redirect_to('page',  WeditPage::Munge($page['page_title']));
    }
    else {
        echo mysql_error();
        app_error('There was a problem creating your page.');
        return create_page();
    }
    die('<pre>'.print_r($page,true).'</pre>');
}

function update_page($page) {
    
    $res = WeditPage::LoadPage($page);
    set('page_title','Updating '.$res[0]['page_title']);
    set('page',$res[0]);
    return render('partial/page_form.html.php');
}

function update_page_handler($p) {
    $page = get_route_options(true);
    $page['page_creator'] = User('user_id');
    $page['weight'] = (!is_numeric($page['weight']))?0:$page['weight'];
    if(array_key_exists('homepage',  $page)) {
        if(!WeditPage::DesignateHomePage(WeditPage::Munge($page['page_title']))) {
            app_error('There was a problem setting this page as the default.');
            return update_page($page['internal_name']);
        }
        redirect_to('/');
    }
    else {
        if(WeditPage::UpdatePage($page)) {
            return page(WeditPage::Munge($page['page_title']));
        }
        else {
            app_error('There was a problem updating your page.');
            return update_page($page['internal_name']);
        }
    }
}

function delete_page($page) {
    $info = WeditPage::LoadPage($page);
    set('page_title','Deleting: '.$info[0]['page_title']);
    set('page',$info[0]);
    return render('partial/confirm.html.php');
}

function delete_page_handler($page) {
    if(WeditPage::DeletePage($page)) {
        app_success('The page was deleted.');
        redirect_to('/');
    }
    app_error('There was a problem deleting that page.');
    return delete_page($page);
}

function user_login() {
    set('user',array(
        'username' => ''
    ));
    return render('partial/login.html.php');
}

function user_login_handler() {
    $details = get_route_options(true);
    $user = WeditUser::Login($details['username'],$details['password']);
    if(count($user) > 0) {
        $_SESSION[appconfig('session')] = serialize($user[0]);
        redirect_to('/');
    }
    app_error('There was a problem with the username and password you entered.');
    return user_login();
}

function user_register() {
    return render('partial/register.html.php');
}

function user_register_handler() {
    $user = get_route_options(true);
    if(WeditUser::Register($user)) {
        $info = WeditUser::LogIn($user['username'], $user['password']);
        $_SESSION[appconfig('session')] = serialize($info[0]);
        redirect_to('/');
    }
    set('user',$user);
    return user_register();
}

function user_logout_handler() {
    unset($_SESSION[appconfig('session')]);
    redirect_to('/');
}

dispatch_get('/page/:page','page');

dispatch_get('/create/page','create_page');
dispatch_get('/update/:page','update_page');
dispatch_get('/delete/:page','delete_page');

dispatch_put('/page','create_page_handler');
dispatch_delete('/page/:page','delete_page_handler');
dispatch_post('/page/:page','update_page_handler');



dispatch_get('/user/login','user_login');
dispatch_post('/user/login','user_login_handler');
dispatch_get('/user/logout','user_logout_handler');

dispatch_get('/user/register','user_register');
dispatch_put('/user/register','user_register_handler');

dispatch_get('/user','list_users');
dispatch_put('/user','create_user');
dispatch_post('/user/:userid','update_user');

dispatch_get('/','page');


run();
?>
