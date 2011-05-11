<?php

function appconfig($key = null) {
    static $store;

    if($store == null) {
        $store = include('appconfig.php');
    }

    $path = explode('.',$key);      // db,host
    $root = $store;
    while(count($path) > 0) {
        $key = array_shift($path);
        if(array_key_exists($key,$root)) {
            $root = $root[$key];
        }
    }
    return $root;
}

function get_route_options($from = false) {
    $opts = ($from)?$_POST:$_GET;
    foreach($opts as $name=>$val) {
        $val = mysql_real_escape_string($val);
    }
    return $opts;
}

function app_error($msg) {
    app_notifications('error',$msg);
}

function app_success($msg) {
    app_notifications('success',$msg);
}

function app_info($msg) {
    app_notifications('info',$msg);
}

function app_notifications($type,$message) {
    static $messages;
    
    if($messages == null) {
        $messages = array();
    }
    
    if($type != '') {
        if($message != '') {
            if(!array_key_exists($messages[$type])) {
               $messages[$type] = array();
            }

            $messages[$type] = $message;
        }
        else {
            return $messages[$type];
        }
    }
    else {
        return $messages;
    }
}

function app_connect($db) {
    $db = appconfig($db);
    $c = mysql_connect($db['host'],$db['user'],$db['pass']);
    $s = mysql_select_db($db['name'],$c);
}

function db($sql,$c = null) {
    $res = false;
    $q = ($c === null)?@mysql_query($sql):@mysql_query($sql,$c);
    if($q) {
        if(strpos(strtolower($sql),'select') === 0) {
            $res = array();
            while($r = mysql_fetch_assoc($q)) {
                $res[] = $r;
            }
        }
        else {
            $res = ($c === null)?mysql_affected_rows():mysql_affected_rows($c);
        }
    }
    if($q) {
        return $res;
    }
    else {
        die(mysql_error());
    }
}

function force($something,$newvalue) {
    return (empty($something))?$newvalue:$something;
}

function appinit() {
    appconfig();
}