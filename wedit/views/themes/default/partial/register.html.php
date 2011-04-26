<?php
if(!isset($user)) {
    $user = array('username'=>'','email'=>'');
}
?>
<form action="<?php echo url_for('user','register'); ?>" method="post">
<input type="hidden" name="_method" value="PUT">
<table>
    <tr>
        <th><label>Username: </label></th>
        <td>
            <input type="text" name="username" value="<?php echo $user['username']; ?>">
            <span class="help">Desired username.</span>
        </td>
    </tr>
    <tr>
        <th><label>Password: </label></th>
        <td>
            <input type="password" name="password" value="">
            <span class="help">The password you'll use to log in.</span>
        </td>
    </tr>
    <tr>
        <th><label>Confirm Password: </label></th>
        <td>
            <input type="password" name="confirm_password" value="">
            <span class="help">Re-enter your password.</span>
        </td>
    </tr>
    <tr>
        <th><label>Email: </label></th>
        <td>
            <input type="text" name="email" value="<?php echo $user['email']; ?>">
            <span class="help">The email address tied to this account.</span>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="actions">
            <button type="submit" class="button good">Register</button>
        </td>
    </tr>
</table>
</form>