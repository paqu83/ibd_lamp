<h1>LIST</h1>
<p>
    <a href="/zadanie_2/add">ADD NEW</a>
</p>
<table border="2">
    <tr>
        <td>id</td><td>fname</td><td>email</td><td>actions</td>
    </tr>
    <?php foreach ($list as $item) : ?>
        <tr>
            <td><?= $item['id']; ?></td>
            <td><?= $item['fname']; ?></td>
            <td><?= $item['email']; ?></td>
            <td><a href="/zadanie_2/edit/<?= $item['id']?>">EDIT</a> | <a href="/zadanie_2/delete/<?= $item['id']?>">DELETE</a></td>
        </tr>
    <?php endforeach ?>
</table>