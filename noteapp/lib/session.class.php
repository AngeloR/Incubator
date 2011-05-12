<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of session
 *
 * @author SupportCon
 */
class Session {

    public static function Attr($key,$val = '') {
        static $store;

        if($store == null) {
            $store = unserialize($_SESSION[appconfig('session')]);
        }

        if(array_key_exists($key,$store)) {
            if($val == '') {
                return $store[$key];
            }
            $store[$key] = $val;
            return $val;
        }
    }
}
?>
