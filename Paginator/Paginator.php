<?php
/**
 * Generates pagination based on the total number of items, the number of items
 * per page and what page the user is currently on. Allows for two different
 * view modes.
 *
 * @author Angelo Rodrigues
 * @version 1
 */
class Paginator {

    /**
     * There are two possible view modes. Either you are viewing it as "center"
     * or you are viewing "all". Center will try and keep the current selected
     * page in the center showing a certain number of pages on either side as
     * defined in $total_displayed_pages.
     *
     * @var int
     */
    public static $CENTER_MODE = 1;

    /**
     * There are two possible view modes. Either you are viewing it as "center"
     * or you are viewing "all". All will display all the pages that can
     * possible be viewed.
     *
     * @var int
     */
    public static $ALL_MODE = 2;

    /**
     * This is the basic url that will be used for all pagination links. If you
     * are using any kind of framework this will need to be set.
     *
     * @var string
     */
    public $url_base;

    /**
     * Displays the pagination in one of two modes. Either "center" which tries
     * to display the current page in the center, flanked by links on either
     * side. All displays all pages.
     *
     * @var string one of center|all
     */
    public $view_mode;

    /**
     * Only affects center, this is the total number of links that should be
     * displayed.
     *
     * @var int
     */
    public $total_displayed_pages = 7;

    /**
     * The current page
     *
     * @var int
     */
    private $current_page;

    /**
     * The total number of pages to be rendered.
     *
     * @var int
     */
    private $total_pages;

    /**
     * Creates and sets up the Paginator. You can configure it after creation, but
     * the values passed to it are set.
     *
     * @param int $current_page         The current page the user is on ($_GET['page'])
     * @param <type> $total_items       The total number of items that can be displayed
     * @param <type> $items_per_page    The number of items displayed per page
     */
    public function __construct($current_page,$total_items,$items_per_page = 30) {
        $this->force_bounds($total_items,1,1);
        $this->force_bounds($items_per_page,1,30);
        $this->force_bounds($current_page,1,1);

        $this->total_pages = ceil($total_items/$items_per_page);
        $this->current_page = $current_page;

        $this->url_base = $_SERVER['PHP_SELF'];

        $this->view_mode = self::$CENTER_MODE;
    }

    /**
     * Sets the view mode to either center or all, depending on how you want the
     * pagination to be displayed.
     *
     * @param string $mode
     */
    public function view_mode($mode) {
        $this->view_mode = $this->force_bounds($mode,1,2);
    }

    /**
     * Renders the pagination.
     *
     * @return string The HTML representation of the pagination
     */
    public function build() {
        $output = '';
        if($this->total_pages != 1) {
            $output = '<div class="paginator">';
            $output .= $this->create_first_link();
            switch($this->view_mode) {
                case 2:
                    for($i = 1; $i < $this->total_pages; $i++) {
                        $selected = ($this->current_page == $i);
                        $output .= $this->create_link($i,$selected);
                    }
                    break;
                default:
                    $total = $this->total_displayed_pages-1;
                    $total = ($total > $this->total_pages)?$this->total_pages:$total;

                    if($this->current_page == 1) {
                        for($i = 1; $i <= $total; $i++) {
                            $selected = ($this->current_page == $i);
                            $output .= $this->create_link($i,$selected);
                        }
                    }
                    else if($this->current_page >= $this->total_pages) {
                        for($i = 1; $i <= $total; $i++) {
                            $selected = ($i >= $this->total_pages);
                            $output .= $this->create_link($i,$selected);
                        }
                    }
                    else {
                        $left = $this->force_bounds($this->current_page - 3,1,$this->total_pages);
                        $right = $this->force_bounds($this->current_page + 3,null,$this->total_pages);
                        $right_start = $this->force_bounds($this->current_page+1,null,$this->total_pages);
                        for($i = $left; $i < $this->current_page; $i++) {
                            $output .= $this->create_link($i);
                        }
                        $output .= $this->create_link($this->current_page,true);
                        for($i = $right_start; $i <= $this->total_pages; $i++) {
                            $output .= $this->create_link($i);
                        }
                    }
                    break;
            }
            $output .= $this->create_last_link();
            $output .= '</div>';
        }
        return $output;
    }

    /**
     * Forces any value to a lower and upper bound.
     *
     * @param int $value        optional the value to force
     * @param int $lower_limit  optional a minimum value
     * @param int $upper_limit  optional a maximum value
     * @return mixed            the forced value
     */
    public function force_bounds($value,$lower_limit,$upper_limit) {
        if(!is_null($lower_limit)) {
           if($value < $lower_limit) {
               $value = $lower_limit;
           }
        }
        if(!is_null($upper_limit)) {
            if($value > $upper_limit) {
                $value = $upper_limit;
            }
        }
        return $value;
    }

    /**
     * Parses the url and figures out if we need to use a ? or a & to modify
     * the url.
     *
     * @return string
     */
    private function query_string_separator() {
        return (parse_url($this->url_base, PHP_URL_QUERY) == NULL) ? '?' : '&';
    }

    /**
     * Creates the url based for the pagination links. $key and $value are
     * the new query string values to append to the url.
     *
     * @param string $key
     * @param string $value
     * @return string
     */
    private function append_query_string($key,$value) {
        return $this->url_base.$this->query_string_separator().$key.'='.$value;
    }

    /**
     * Creates the first link in the pagination
     *
     * @return string
     */
    private function create_first_link() {
        $output = '<span class="selected">Prev</span>';
        if($this->current_page > 1) {
            $prev_page = (($this->current_page-1) > $this->total_pages)?$this->total_pages-1:$this->current_page-1;
            $output = '<a href="'.$this->append_query_string('page',$prev_page).'">Prev</a>';
        }
        return $output;
    }

    /**
     * Creates the last link in the pagination
     *
     * @return string
     */
    private function create_last_link() {
        $output = '<span class="selected">Next</span>';
        if($this->current_page < $this->total_pages) {
            $next_page = ($this->current_page+1);
            $output = '<a href="'.$this->append_query_string('page',$next_page).'">Next</a>';
        }
        return $output;
    }

    /**
     * Creates each of the links.
     *
     * @param string $value
     * @param bool $selected
     * @return string
     */
    private function create_link($value,$selected = false) {
        if($selected) {
            return '<span class="selected">'.$value.'</span>';
        }
        return '<a href="'.$this->append_query_string('page',$value).'">'.$value.'</a>';
    }
}
#
# Example pagination
#
/*
$items_per_page = 10;
$page = (empty($_GET['page']))?1:$_GET['page'];

$offset = $items_per_page*$page;
$sql_get_total = 'select count(*) as total_results from PLUGINS';
$sql_get_results = 'select * from PLUGINS limit '.$offset.','.$items_per_page;

$c = mysql_connect('localhost','root','') or die(mysql_error());
$s = mysql_select_db('information_schema',$c) or die(mysql_error());

$q = mysql_query($sql_get_total) or die(mysql_error());
$r = mysql_fetch_assoc($q);
$total_items = $r['total_results'];

$q = mysql_query($sql_get_results) or die(mysql_error());
$res = array();
while($r = mysql_fetch_assoc($q)) {
    $res[] = $r;
}


$total_pages = ceil($total_items/$items_per_page);


$pg = new Paginator($page,$total_pages,$items_per_page);

echo '<pre>';
var_dump($pg);
echo '</pre>';

echo $pg->build();
*/
?>