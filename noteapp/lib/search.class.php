<?php
/**
 * Allows for advanced searching through search terms
 *
 * @author SupportCon
 */
class Search {

    /**
     * This takes the unparsed string that may or may not define
     * "advanced" queries. It then parses it and returns an
     * appropriate "where" clause for an sql statement.
     *
     * Samples:
     * my terms
     * before:11
     * before:11 sometext
     *
     * @param string $text
     */
    public static function create_sql($text) {

        if(strpos($text,':')=== false) { // ooh it's just a standard query!
            return 'note_text like "%'.$text.'%" or note_title like "%'.$text.'%"';
        }

        $terms = explode(' ',$text);
        $plain_text = array();
        $search = array();

        foreach($terms as $term) {
            if(strpos($term,':') !== false) {
                $t = explode(':',$term);
                $func = strtolower($t[0]);
                $res = call_user_func(array('Search',$func),$t[1]);
                if(isset($res)) {
                    $search[] = $res;
                }
            }
            else {
                $plain_text[] = $term;
            }
        }

        $text = array();
        if(count($plain_text) > 0) {
            $plain_text = implode(' ',$plain_text);
            $text[] = 'note_text like "%'.$plain_text.'%" or note_title like "%'.$plain_text.'%"';
        }

        if(count($search) > 0) {
            $terms = array_merge($text,$search);
        }

        return implode(' and ',$terms);
    }

    /**
     * The untampered string to perform a search on
     *
     * Samples:
     * before:11       - before the 1st of the 11th month of this year
     * before:11/3     - before the 3rd of the 11th month of this year
     * before:11/3/10  - before the 3rd of the 11th month of 2010
     *
     * @param string $text
     * @return mixed null or a search clause
     */
    public static function before($search_date) {
        $time = self::date_parse($search_date);

        if(isset($time)) {
            return 'created_time < '.$time;
        }

        return null;
    }

    /**
     * The untampered string to perform a search on
     *
     * Samples:
     * after:11       - after the 1st of the 11th month of this year
     * after:11/3     - after the 3rd of the 11th month of this year
     * after:11/3/10  - after the 3rd of the 11th month of 2010
     *
     * @param string $text
     * @return mixed null or a search clause
     */
    public static function after($search_date) {
        $time = self::date_parse($search_date);

        if(isset($time)) {
            return 'created_time > '.$time;
        }

        return null;
    }

    /**
     * Parses the before/after date that was sent.
     * @param string $search_date
     * @return mixed
     */
    public static function date_parse($search_date) {
        $search_date = explode('/',$search_date);
        $time = null;
        switch(count($search_date)) {
            case 1:
                if(self::valid_month($search_date[0])) {
                    $date = date('y-d');
                    $date = explode('-',$date);
                    $time = strtotime($date[0].'-'.intval($search_date[0]).'-'.$date[1]);
                }
                break;
            case 2:
                if(self::valid_month($search_date[0])) {
                    $date = date('y');
                    $time = strtotime($date.'-'.intval($search_date[0]).'-'.intval($search_date[1]));
                }
                break;
            case 3:
                if(self::valid_month($search_date[0])) {
                    $time = strtotime(intval($search_date[2]).'-'.intval($search_date[0]).'-'.intval($search_date[1]));
                }
                break;
        }

        return $time;
    }

    public static function valid_month($nameOrInt) {
        if(is_numeric($nameOrInt)) {
            $val = intval($nameOrInt);
            return ($val > 0 && $val < 13);
        }
        else {
            return (in_array(strtolower($nameOrInt), array(
                'jan','feb','mar','apr','may','jun','jul','aug','sep','sept','oct','nov','dec'
            )));
        }
    }
}
?>
