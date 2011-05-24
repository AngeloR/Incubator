<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

return array(
    'db' => array(
        'dev' => array(
            'host' => 'localhost',
            'user' => 'root',
            'pass' => '',
            'name' => 'linkbait'
        ),
        'dev2' => array(
            'host' => 'localhost',
            'user' => 'root',
            'pass' => 'root',
            'name' => 'notepadd'
        ),
        'prod' => array(
            'host' => 'localhost',
            'user' => 'root',
            'pass' => 'root',
            'name' => ''
        ),
    ),
    'session' => 'noteappsess',
    'use_db' => 'db.dev',
    'theme' => 'default',
    'view_path' => 'views/themes',
);
?>
