<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include('lib/app.php');
include('lib/limonade.php');
include('lib/rb.php');
appinit();

function before() {
    option('root_dir','incubator/linkbait');
    app_connect(appconfig('use_db'));
    $theme = appconfig('theme');

    set('THEME',$theme);
    set('THEMEDIR','views/themes/'.$theme);
    option('views_dir','views/themes/'.$theme);
    layout('layout.html.php');
}

function index() {
    redirect('links');
}

function get_links() {
    $toolbox = R::setup('mysql:host=localhost;dbname=linkbait','root');
    $link_list = R::find('links');

    set('links',$link_list);
    return render(partial('partial/link.html.php'));
}

dispatch_get('/','index');
dispatch_get('/links','get_links');
dispatch_post('/links','add_link');
dispatch_delete('/links/:id','delete_link');
dispatch_get('/links/:id','get_link');
run();
?>
