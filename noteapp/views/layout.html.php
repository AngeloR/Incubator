<!DOCTYPE html>
<html>
    <head>
        <title>Note App</title>
        <link rel="stylesheet" type="text/css" href="<?php echo $THEMEDIR; ?>/css/site.css">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
        <div id="wrapper">
            <img src="views/images/noteapp.png" alt="Note App" id="logo">
            <h1>Welcome to NoteApp</h1>
            <p>Create an account, write some notes.</p>
            <div id="notifications"></div>
            <form action="<?php echo url_for('login'); ?>" id="login-form" method="post">
                <table>
                    <tr>
                        <th><label for="email">Email Address: </label></th>
                        <td><input type="text" name="email" id="email"></td>
                    </tr>
                    <tr>
                        <th><label for="email">Password: </label></th>
                        <td><input type="text" name="password" id="password"></td>
                    </tr>
                    <tr>
                        <td colspan="2" id="form-actions">
                            <button type="submit" id="login" class="blue">Login</button>
                            <button type="submit" id="signup" class="green">Sign Up!</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div id="footer">
            <a href="<?php echo url_for('contact'); ?>">Contact Us</a>
        </div>
    </body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script src="views/js/vader.js"></script>
    <script src="views/js/caret.js"></script>
    <script src="views/js/jquery.iphone.password.js"></script>
    <script src="views/js/site.js"></script>
    <!-- Simplicity is key -->
</html>