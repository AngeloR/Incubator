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
            'name' => 'feeds'
        ),
        'prod' => array(
            'host' => 'localhost',
            'user' => 'root',
            'pass' => 'root',
            'name' => ''
        ),
    ),
    'use_db' => 'db.dev',
    'theme' => 'default',
    'view_path' => 'views/themes',
);
?>
