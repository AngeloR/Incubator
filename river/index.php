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
    app_connect();
}

function home() {
    return html('');
}

function river() {
    $sql = 'select * from feed_list order by site_title asc';

    $res = db($sql);
    $urls = massage_feed_list_from_db($res);  

    $feeds = get_feed($urls);
    $feeds = sort_feeds($feeds,$res);
    return json($feeds);
}

function massage_feed_list_from_db($urls) {
    $tmp = array();

    foreach($urls as $i=>$s) {
        $tmp[] = $s['feed_url'];
    }
    return $tmp;
}

function get_feed($urls) {
    include('SimplePie/SimplePieAutoloader.php');
    $feeds = new SimplePie();
    $feeds->set_feed_url($urls);
    $feeds->init();

    return $feeds;
}

function add_feed() {

    $feed_url = mysql_real_escape_string($_POST['feed']);

    // get the feed
    $feed = get_feed($feed_url);
    
    $title = $feed->get_item(0)->get_feed()->get_title();
    $title = (empty($title))?$feed_url:$title;
    
    $site_url = parse_url($feed_url);
    $site_url = $site_url['host'];

    $sql = 'insert into feed_list (site_title, site_url, feed_url) values ("'.$title.'","'.$site_url.'","'.$feed_url.'")';

    if(db($sql)) {
        // sort the feeds and return json
        $sql = 'select * from feed_list where site_title = "'.$title.'"';

        return json(sort_feeds($feed,db($sql)));
    }
    else {
        return json('failed');
    }
}

function sort_feeds(SimplePie $feeds,$data) {
    $tmp = array();
    $store = array();
    $site_info = array();

    foreach($data as $i => $row) {
        $site_info[$row['site_url']] = array (
            'most_recent_update' => $row['most_recent_update'],
            'feed_id' => $row['feed_id']
        );
    }

    foreach($feeds->get_items() as $item) {
        // get most recent permalink from feed
        $link = parse_url($item->get_link());
        $site_url = $link['host'];


        // find the corresponding stored url
        if($item->get_date('U') >= $site_info[$site_url]['most_recent_update']) {
            $parent = $item->get_feed();
            $tmp[] = array(
                'site_title' => $parent->get_title(),
                'entry_title' => $item->get_title(),
                'pub_date' => $item->get_date(),
                'permalink' => $item->get_link(),
                'favicon' => 'http://www.google.com/s2/favicons?domain='.$parent->get_link()
            );

            // store feed_id + most_recent_update in url.
            if(!array_key_exists($site_info[$site_url],$store)) {
                $store[$site_info[$site_url]['feed_id']] = $item->get_date('U');
            }
        }
    }

    update_db($store);
    return $tmp;
}

function update_db($data) {
    $sql = 'update feed_list set most_recent_update = CASE';
    foreach($data as $id=>$time) {
        $sql .= ' WHEN feed_id = '.$id.' THEN '.$time.';';
    }
    $sql = substr($sql,0,strlen($sql)-1);
    $sql .=  'ELSE most_recent_update';
    db($sql);
}

dispatch_get('/','home');
dispatch_get('/river','river');
dispatch_post('/river','add_feed');

run();
?>
