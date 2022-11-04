<h1>LIST</h1>
<?php
foreach ($results as $table_name => $table_data):
    echo "<h2>$table_name</h2>";
    ?>
    <table border="2">
        <tr>
            <th><?php echo implode('</th><th>', array_keys(current($table_data))); ?></th>
        </tr>
        <?php foreach ($table_data as $row): ?>
            <tr>
                <td><?php echo implode('</td><td>', $row); ?></td>
            </tr>
        <?php endforeach ?>
    </table>

    <?php
endforeach
?>

