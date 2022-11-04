<html>
<head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Year', '<?=$chart?>'],
                <?php
                foreach ($results as $row) {
                    $value = $chart === 'eur/pln' ? $row['EURbuy'] : $row['USDbuy'];
                    echo "['" . $row['date'] . "', " . $value . "],";
                }
                ?>
            ]);

            var options = {
                title: '<?=$chart?>',
                curveType: 'function',
                legend: { position: 'bottom' }
            };

            var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

            chart.draw(data, options);
        }
    </script>
</head>
<body>
<h1>Projekt</h1>

<form action="/projekt" method="post">
    <?= csrf_field() ?>
    <label for="chart">Select chart</label>
    <select id="chart" name="chart">
        <option value="eur/pln" <?php echo $chart === 'eur/pln' ? 'selected="selected"' : '' ?> >eur/pln</option>
        <option value="usd/pln" <?php echo $chart === 'usd/pln' ? 'selected="selected"' : '' ?> >usd/pln</option>
    </select>
    <input type="submit" name="submit" value="Show" />
</form>


<div id="curve_chart" style="width: 900px; height: 500px"></div>
</body>
</html>