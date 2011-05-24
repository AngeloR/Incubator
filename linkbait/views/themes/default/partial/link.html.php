<?php
if(count($links) > 0) :
    foreach($links as $link) {
        switch($link->type) {
            case 'video':?>
                Video!
                <?php break;
            case 'image': ?>
                Image!
                <?php break;
            case 'link': ?>
                Link!
                <?php break;
            case 'snippet': ?>
                Snippet!
                <?php break;
        }
    }
else :
    echo markdown(file_get_contents('readme.md'));
endif; ?>
