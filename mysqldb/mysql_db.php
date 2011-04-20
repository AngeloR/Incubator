<?php
/**
 * A quick little function to interact with a MySQL database.
 *
 * When working with Limonade-php a full-fledged MySQL wrapper seems like
 * overkill. This method instead accepts any mysql statement and if it works
 * returns either the result or the number of rows affected. If neither worked,
 * then it returns false
 *
 * @param   string      $sql    the sql statement you want to execute
 * @param   resource    $c      mysql connect link identifier, if multi-connect
 *                              otheriwse, you can leave it blank
 * @return  MIXED       array   the result set if the sql statement was a SELECT
 *                      integer if the sql statement was INSERT|UPDATE|DELETE
 *                      bool    if anything went wrong with executing your statement
 *
 *
 * [update|insert|delete]
 * if(db('update mytable set myrow = 4 where someotherrow = 3') !== false) {
 *  // worked!
 * }
 *
 * [select]
 * $res = db('select * from mytable');
 */
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
    return $res;
}
?>