<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of WeditUser
 *
 * @author SupportCon
 */
class WeditUser {

    public static function LoadUser($id,$full = false) {
        if($full) {
            $sql = 'select * from users where user_id = '.$id;
        }
        else {
            $sql = 'select user_id,username,access_level from users where user_id = '.$id;
        }

        return db($sql);
    }

    public static function LogIn($username,$password) {
        $sql = 'select * from users where username = "'.$username.'" and password = "'.self::Hash($password).'"';
        return db($sql);
    }

    public static function Register($user) {
        $required_fields = array('username','password','email');

        foreach($required_fields as $i=>$field) {
            if(!array_key_exists($field,$user)) {
                app_error('All fields are mandatory, please fill out the '.$field.' field.');
                return false;
            }
        }

        if($user['password'] != $user['confirm_password'] || empty($user['password'])) {
            app_error('The passwords entered did not match.');
            return false;
        }

        $existing_users = self::Find($user['username']);

        if(count($existing_users) >= 1) {
            app_error('There is already a user by that name.');
            return false;
        }

        $sql = 'insert into users (username,password,email,access_level) values ';
        $sql .= '("'.$user['username'].'","'.self::Hash($user['password']).'","'.$user['email'].'",1)';

        return db($sql);
    }

    public static function Find($username) {
        $sql = 'select * from users where username = "'.$username.'"';
        return db($sql);
    }

    public static function Hash($key) {
        return sha1('245u1vn'.md5($key).'247y35');
    }
}
?>
