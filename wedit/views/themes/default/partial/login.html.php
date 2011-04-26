<form action="<?php echo url_for('user','login'); ?>" method="post">
    <table>
        <tr>
            <th><label>Username: </label></th>
            <td>
                <input type="text" name="username">
                <span class="help">The username you registered your account with.</span>
            </td>
        </tr>
        <tr>
            <th><label>Password: </label></th>
            <td>
                <input type="password" name="password">
                <span class="help">The password you registered your account with.</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="actions">
                <button type="submit" class="button good">Login</button>
            </td>
        </tr>
    </table>
</form>