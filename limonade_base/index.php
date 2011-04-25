<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

include('lib/app.php');
include('lib/limonade.php');

appinit();

function configure() {
    set('THEME',appconfig('theme'));
    set('THEMEDIR','views/themes/'.appconfig('theme'));
    option('views_dir','views/themes/'.appconfig('theme'));
}

function homepage() {
    return html('Loaded the homepage, you can start configuring the application.');
}

dispatch_get('/','homepage');

run();
?>
