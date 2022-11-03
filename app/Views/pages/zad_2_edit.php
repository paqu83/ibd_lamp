add/edit

<?= session()->getFlashdata('error') ?>
<?= service('validation')->listErrors() ?>

<form action="<?= $action?>" method="post">
    <?= csrf_field() ?>

    <label for="fname">Fname</label>
    <input type="input" name="fname" value="<?= esc($subscriber['fname'] ?? '') ?>"/><br />

    <label for="email">Email</label>
    <input type="input" name="email" value="<?= esc($subscriber['email'] ?? '') ?>"/><br />

    <input type="submit" name="submit" value="update" />
</form>