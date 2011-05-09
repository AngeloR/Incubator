<!DOCTYPE html>
<html>
    <head>
        <title>SimplePie Tests</title>
        <link rel="stylesheet" type="text/css" href="<?php echo $THEMEDIR; ?>/css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
        <div id="topbar">
            <h2>River</h2>
            <ul id="nav">
                <li><a href="#!add_feed">+ Add Feed</a></li>
            </ul>
        </div>
        <div id="wrapper">
            <div id="update">
                <h2>Update</h2>
                <textarea id="status-update"></textarea>
            </div>

            <div id="river">
                <h2>River</h2>
                <div id="entries">
                    <?php echo $content; ?>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/vader.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/init.js"></script>
</html>