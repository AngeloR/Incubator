<?php
/**
 * The base class for every Wedit Page.
 *
 * @author SupportCon
 */
class WeditPage {

    public static $Error_404 = array(
        'internal_name' => '893vn289nvhp',
        'page_title' => 'Homepage',
        'page_content' => 'This is your home page. An administrator can designate any created page as the homepage of the website.',
        'page_creator' => '0',
        'public_page' => 1
    );

    /**
     * Encodes a string for inclusiuon in a url.
     *
     * @param string $page_title
     * @return string
     */
    public static function Munge($page_title) {
        return urlencode(htmlentities($page_title));
    }

    /**
     * Cleans a string that was included in a url
     * 
     * @param string $page_title
     * @return string
     */
    public static function Clean($page_title) {
        return html_entity_decode(urldecode($page_title));
    }

    public static function ListAll() {
        $sql = 'select * from pages where public_page = 1 order by homepage desc, weight desc, page_title asc';
        return db($sql);
    }

    /**
     * Loads a page from the database if it exists.
     * 
     * @param string $page_title
     * @return mixed either false or a resultset
     */
    public static function LoadPage($page_title) {
        $sql = 'select * from pages where internal_name = "'.$page_title.'" limit 1';
        return db($sql);

    }

    /**
     * Loads the homepage
     * 
     * @return mixed Resulset if successful or bool if failed
     */
    public static function LoadHomePage() {
        $sql = 'select * from pages where homepage = 1 limit 1';
        return db($sql);
    }

    /**
     * Set a page as the homepage
     *
     * @param string $page
     * @return bool
     */
    public static function DesignateHomePage($page) {
        $sql = 'update pages set homepage = 0';
        if(db($sql)) {
            $sql2 = 'update pages set homepage = 1 where internal_name = "'.$page.'"';
            return db($sql2);
        }
    }

    /**
     * Creates a page in the database
     * 
     * @param array $page consists of page_title,page_content,page_creator,public_page keys
     * @return bool
     */
    public static function CreatePage(array $page) {
        $page['internal_name'] = self::Munge($page['page_title']);
        $sql = 'insert into pages (internal_name,page_title,page_description,page_content,page_creator,public_page,weight) values ';
        $sql .= '("'.$page['internal_name'].'","'.$page['page_title'].'","'.$page['page_description'].'","'.$page['page_content'].'",'.$page['page_creator'].','.$page['public_page'].','.$page['weight'].')';

        return db($sql);
    }

    /**
     * Updates a page that already exists
     *
     * @param array $page consists of internal_name,page_title,page_content,page_creator,public_page keys
     * @return bool
     */
    public static function UpdatePage(array $page) {
        $page['new_internal_name'] = self::Munge($page['page_title']);
        
        $sql = 'update pages set internal_name = "'.$page['new_internal_name'].'",page_title = "'.$page['page_title'].'", page_content = "'.addslashes($page['page_content']).'",';
        $sql .= 'page_description="'.$page['page_description'].'",page_creator='.$page['page_creator'].',public_page = '.$page['public_page'].',';
        $sql .= 'weight = '.$page['weight'].' where internal_name = "'.$page['internal_name'].'"';

        return db($sql);
    }

    /**
     * Deletes a page from the database
     * @param string $page_title
     * @return bool
     */
    public static function DeletePage($page_title) {
        $sql = 'delete from pages where internal_name = "'.$page_title.'"';
        return db($sql);
    }

    /**
     * Checks to see if a page exists in the database
     * @param string $page_title
     * @return bool
     */
    public static function PageExists($page_title) {
        $sql = 'select count(*) as total_pages from pages where internal_name = "'.$page_title.'"';
        $res = db($sql);

        return ($res[0]['total_pages'] > 0);
    }
}
?>
