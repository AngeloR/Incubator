<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

include('SimplePie/SimplePieAutoloader.php');

$feed_list = array(
    'http://xangelo.ca/rss.xml',
    'http://questionablecontent.net/QCRSS.xml',
);

$feeds = new SimplePie();
$feeds->set_feed_url($feed_list);
$feeds->init();

echo '<pre>'.print_r(sort_feeds($feeds,true),true).'</pre>';





function sort_feeds(SimplePie $feeds) {
    $now = 1304035200;
    $tmp = array();;
    foreach($feeds->get_items() as $item) {
        $time = strtotime($item->get_date());
        if($time <= $now) {
            break;
        }
        $parent = $item->get_feed();
        $tmp[] = array(
            'site_title' => $parent->get_title(),
            'entry_title' => $item->get_title(),
            'pub_date' => $item->get_date(),
            'permalink' => $item->get_link(),
            'favicon' => 'http://www.google.com/s2/favicons?domain='.$parent->get_link()
        );
    }
    return $tmp;
}
?>
