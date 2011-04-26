<?php
if(!isset($page)) {
    $page = array(
        'page_title' => '',
        'page_content' => '',
        'page_description' => ''
    );

    $url = url_for('page');
}
else {
    $url = url_for('page',  WeditPage::Munge($page['page_title']));
}
?>
<form action="<?php echo $url; ?>" method="post">
    <?php if(isset($type)): ?>
    <input type="hidden" name="_method" value="PUT" id="_method">
    <?php else: ?>
    <input type="hidden" name="internal_name" value="<?php echo $page['internal_name']; ?>">
    <?php endif; ?>
    <table>
        <tr>
            <th><label>Page Title:</label></th>
            <td><input type="text" name="page_title" value="<?php echo $page['page_title']; ?>">
                <span class="help">The name of the page. This value must be unique for every page.</span>
            </td>
        </tr>
        <tr>
            <th><label>Page Description:</label></th>
            <td><input type="text" name="page_description" value="<?php echo $page['page_description']; ?>">
                <span class="help">A short description of the page.</span>
            </td>
        </tr>
        <tr>
            <th><label>Content: </label></th>
            <td>
                <textarea name="page_content" class="markdown"><?php echo $page['page_content']; ?></textarea>
                <span class="help">The content of the page</span>
            </td>
        </tr>
        <tr>
            <th><label>Make this page public: </label></th>
            <td>
                <input type="checkbox" name="public_page" value="1" checked="checked">
                <span class="help">Check this to let to let people see this page.</span>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="actions">
                <button type="submit" class="button good">Save</button> 
            </td>
        </tr>
    </table>
</form>