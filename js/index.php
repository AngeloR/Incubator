<?php

include('lib/limonade.php');


dispatch_get('/', function() {
    echo json_encode(array('type'=>'get','data'=>$_GET));
});

dispatch_post('/', function(){
    echo json_encode(array('type'=>'post','data'=>$_POST));
});

run();