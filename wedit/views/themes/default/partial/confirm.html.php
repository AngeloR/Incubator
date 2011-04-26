<p>Are you sure you want to delete the page: <?php echo $page['page_title']; ?>?</p>
<p>Once deleted, there is no way to retrieve it.</p>
<form action="<?php echo url_for('page',$page['internal_name']); ?>" method="post">
<input type="hidden" name="_method" value="delete">
<button type="submit" class="button bad">Delete This Page!</button>
</form>