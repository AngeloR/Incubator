<div id="sidebar">
    <ul>
        <li class="header">Pages</li>
        <?php foreach($pagelist as $i=>$pagex): ?>
        <li>
            <a href="<?php echo url_for('page',$pagex['internal_name']); ?>"><?php echo $pagex['page_title']; ?>
                <span class="help"><?php echo $pagex['page_description']; ?></span>
            </a>
        </li>
        <?php endforeach; ?>
        <?php if(User('user_id') != '') : ?>
            <li class="header">Actions</li>
            <li>
                <a href="<?php echo url_for('create','page'); ?>">Create
                    <span class="help">Create a new page</span>
                </a>
            </li>
            <?php if(isset($page)): ?>
                <li>
                    <a href="<?php echo url_for('update',  WeditPage::Munge($page['page_title'])); ?>">Edit
                        <span class="help">Edit this page</span>
                    </a>
                </li>
                <?php if(request_uri() != '/') : ?>
                    <li>
                        <a href="<?php echo url_for('page',$page['page_title']); ?>">Delete
                            <span class="help">Delete this page</span>
                        </a>
                    </li>
                <?php endif; ?>
            <?php endif; ?>
                <li class="header">User</li>
                <li>
                    <a href="<?php echo url_for('user','logout'); ?>">Logout
                        <span class="help">Logout of your account.</span>
                    </a>
                </li>
        <?php else: ?>
            <li class="header">User</li>
                <li>
                    <a href="<?php echo url_for('user','login'); ?>">Login
                        <span class="help">Login to your existing account.</span>
                    </a>
                </li>
                <li>
                    <a href="<?php echo url_for('user','register'); ?>">Register
                        <span class="help">Create a new account.</span>
                    </a>
                </li>
        <?php endif; ?>
    </ul>
</div>