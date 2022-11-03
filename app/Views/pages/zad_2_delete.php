<h1>Delete</h1>

<?= session()->getFlashdata('error') ?>
<?= service('validation')->listErrors() ?>
<h4>Are you sure you want to delete the user?</h4>

<form action="<?= $action?>" method="post">
    <?= csrf_field() ?>

    <input type="submit" name="submit" value="Yes, please delete the user" />
</form>