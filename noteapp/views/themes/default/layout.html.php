<!DOCTYPE html>
<html>
    <head>
        <title>Note App</title>
        <link rel="stylesheet" type="text/css" href="<?php echo $THEMEDIR; ?>/css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
        <div id="topbar">
            <div id="search-container">
                <form action="" method="post">
                    <input type="text" name="search" id="search">
                </form>
            </div>
        </div>
        <div id="sidebar">
            <ul id="nav"></ul>
            <div id="actions">
                <a href="#">*</a><a href="#" id="new-note">+</a>
            </div>
        </div>
        <div id="content">
            <h2>Content Area</h2>
            <form name="note" id="note" action="<?php echo url_for('/notes'); ?>" method="post">
                <input type="hidden" name="note-id" id="note-id" value="">
                <input type="text" name="note-title" id="note-title" placeholder="Title" class="note">
                <div id="note-display"></div>
                <textarea id="note-text" class="note" name="note-text" rows="40"></textarea>
                <a href="#" id="preview">Preview</a>
                <button type="submit" name="save" id="save" class="blue" disabled="disabled">Save This Note</button>
                <button type="submit" name="delete" id="delete" class="red" disabled="disabled">Delete This Note</button>
            </form>
            <div id="preview-area"></div>
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/vader.js"></script>
    <script src="<?php echo $THEMEDIR; ?>/js/init.js"></script>
</html>