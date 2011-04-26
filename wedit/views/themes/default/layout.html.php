<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
    <head>
        <title>Wedit Wiki</title>
        <link rel="stylesheet" type="text/css" href="<?php echo $THEMEDIR; ?>/css/style.css">
    </head>
    <body>
        <div id="header">
            <div id="app_switcher">
                <ul>
                    <li><a href="/incubator/wedit" class="selected">Wiki</a></li>
                </ul>
            </div>
            Wedit
        </div>

        <div id="wrapper">
            <?php echo partial('partial/sidebar.html.php'); ?>
            <div id="main">
                <div id="heading">
                    <h1><?php echo $page_title; ?></h1>
                </div>
                <div id="content">
                    <?php echo render_app_notifications(); ?>
                    <?php echo $content; ?>
                </div>
            </div>
        </div>
        <div id="footer">
            Wedit - Wiki for the masses. &copy; 2011
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/tiny_mce/jquery.tinymce.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/init.js"></script>

</html>