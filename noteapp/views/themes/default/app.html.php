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
            </div>
        </div>
        

        <!-- START OF APP -->
        <div id="topbar" class="topbar">
            <div id="search-container">
                <form action="" method="post">
                    <input type="text" name="search" id="search">
                </form>
            </div>
        </div>
        <div id="sidebar">
            <ul id="nav"></ul>
            <div id="actions">
                <a href="#" id="settings-action"><img src="<?php echo $THEMEDIR; ?>/images/icons/cog.png"></a><a href="#" id="new-note"><img src="<?php echo $THEMEDIR; ?>/images/icons/add.png"></a>
            </div>
        </div>
        <div id="content">
            <a href="#" id="preview">Preview</a>
            <form name="note" id="note" action="<?php echo url_for('/notes'); ?>" method="post">
                <input type="hidden" name="note-id" id="note-id" value="">
                <input type="text" name="note-title" id="note-title" placeholder="Title" class="note">
                <div id="note-display"></div>
                <textarea id="note-text" class="note" name="note-text" rows="40"></textarea>
                
                <button type="submit" name="save" id="save" class="blue" disabled="disabled">Save This Note</button>
                <button type="submit" name="delete" id="delete" class="red" disabled="disabled">Delete This Note</button>
            </form>
            
            <div id="preview-area"></div>
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script src="/incubator/noteapp/views/js/vader.js"></script>
    <script src="/incubator/noteapp/<?php echo $THEMEDIR; ?>/js/init.js"></script>
</html>