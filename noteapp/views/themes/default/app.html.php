<!DOCTYPE html>
<html>
    <head>
        <title>Note App</title>
        <link rel="stylesheet" type="text/css" href="/incubator/noteapp/<?php echo $THEMEDIR; ?>/css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
        <!-- START OF SETTINGS -->
        <div id="overlay">&nbsp;</div>
        <div id="settings">
            <div id="sections" class="topbar">
                <ul>
                    <li id="selected-settings">
                        <a href="#">
                            <img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/general.png">
                            General
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/theme.png">
                            Theme
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/account.png">
                            Account
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/info.png">
                            About
                        </a>
                    </li>
                </ul>
            </div>
            <div id="settings-content">
                <div id="general">
                    <table width="100%">
                        <tr>
                            <th>Auto Save<span class="helptext">Automatically save changes to your notes every few seconds.</span></th>
                            <td><input type="checkbox" value="yes" checked="checked" name="autosave-setting" id="autosave-setting"><label for="autosave-setting"> Enable Autosave</label></td>
                        </tr>
                        <tr>
                            <th>Preview Library<span class="helptext">Select the format of text to use while previewing your notes.</span></th>
                            <td>
                                <select name="preview-library-setting" id="preview-library-setting">
                                    <option value="markdown">Markdown</option>
                                    <option value="textile">Textile</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="right">
                                <button type="submit" class="button blue" disabled="disabled">Save</button>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="theme">
                    <form action="<?php echo url_for('/settings/theme'); ?>" method="post" id="theme-form">
                        <table width="100%">
                            <tr>
                                <td width="50%" valign="top">
                                    <select name="theme-selector" id="theme-selector" size="10">
                                        <option value="default">Default</option>
                                    </select>
                                </td>
                                <td valign="top" align="center">
                                    No uploaded screenshot!
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <button type="submit" class="button blue" disabled="disabled">Save</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

                <div id="account">
                    <form action="<?php echo url_for('/settings/account'); ?>" method="post" id="account-form">
                        <table width="100%">
                            <tr>
                                <th>Old Password: </th>
                                <td><input type="text" name="old-password-setting" id="old-password-setting"></td>
                            </tr>
                            <tr>
                                <th>New Password: </th>
                                <td><input type="text" name="new-password-setting" id="new-password-setting"></td>
                            </tr>
                            <tr>
                                <th>Confirm New Password: </th>
                                <td><input type="text" name="new-password-conf-setting" id="old-password-conf-setting"></td>
                            </tr>
                            <tr>
                                <th>Email: </th>
                                <td><input type="text" name="email-setting" id="email-setting"></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <button type="submit" class="button blue" disabled="disabled">Save</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>

                <div id="about">
                    <h2>About NoteApp</h2>
                    <p>NoteApp was created as a way to easily store notes online. I normally end up taking a lot of notes on
                        various projects and I needed a place that I could organize them.</p>
                    <p>If this app doesn't quite cut it for you check out <a href="http://evernote.com">Evernote</a>. I used Evernote
                        for some time before I decided it was overkill for what I wanted.</p>
                    <p>If you want to support NoteApp, spread the word. NoteApp is currently paid for by a little advertisement
                        in the header of the page.</p>
                    <p><b>Thanks! </b> - Angelo Rodrigues
                        <a href="http://xangelo.ca">http://xangelo.ca</a>
                        <a href="http://twitter.com/xangelo">@xangelo</a>
                        <a href="http://twitter.com/noteapp">@noteapp</a>
                    </p>
                </div>
            </div>
        </div>
        

        <!-- START OF APP -->
        <div id="topbar" class="topbar">
            <h1 id="logo"><img src="../views/images/noteapp.png" alt="NoteApp by Angelo" width="64" height="64">NoteApp</h1>
            <div id="search-container">
                <form action="" method="post">
                    <input type="text" name="search" id="search" placeholder="Search">
                </form>
                <ul id="search-results">
                    
                </ul>
            </div>
        </div>
        <div id="sidebar">
            <ul id="nav"></ul>
            <div id="actions">
                <a href="#" id="logout-action"><img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/lock.png"></a>
                <a href="#" id="settings-action"><img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/cog.png"></a><a href="#" id="new-note"><img src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/images/icons/add.png"></a>
            </div>
        </div>
        <div id="content">
            <a href="#" id="preview">Preview</a>
            <form name="note" id="note" action="<?php echo url_for('/notes'); ?>" method="post">
                <input type="hidden" name="note-id" id="note-id" value="">
                <input type="text" name="note-title" id="note-title" placeholder="Title" class="note" tabindex="1">
                <div id="note-display"></div>
                <textarea id="note-text" class="note" name="note-text" rows="40" tabindex="2"></textarea>
                
                <button type="submit" name="save" id="save" class="blue" disabled="disabled" tabindex="3">Save This Note</button>
                <button type="submit" name="delete" id="delete" class="red" disabled="disabled" tabindex="4">Delete This Note</button>
            </form>
            
            <div id="preview-area"></div>
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script src="/incubator/noteapp/views/js/vader.js"></script>
    <script src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/js/init.js"></script>
</html>