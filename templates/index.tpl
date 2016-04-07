<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <title>Weather</title>
</head>

<body>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<h1>{time}</h1>
<div>Temperature: {temperature} °{temperature_unit}</div>
<div>Pressure: {pressure} {pressure_unit}</div>
<div>Humidity: {humidity} %</div>


<h1>Last 24 hours</h1>

<div id="chart_divTemperature24h" width="400"></div>
<div id="chart_divPressure24h" width="400"></div>
<div id="chart_divHumidity24h" width="400"></div>


<h1>Last week</h1>

<div id="chart_divTemperature7d" width="400"></div>
<div id="chart_divPressure7d" width="400"></div>
<div id="chart_divHumidity7d" width="400"></div>


<script>
google.charts.load('current', {packages: ['corechart', 'line']});


function drawTemperature24() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Temperature, °{temperature_unit}');

      data.addRows([
{temperature24h}
      ]);

      var options = {
        title: 'Temperature. Last 24h',
        hAxis: {
          //format: 'dd.MM.yyyy hh:mm',
          format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Temperature, °{temperature_unit}',
          logScale: false
        },
        colors: ['#F40000', '#F40000'],
        height: 450
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_divTemperature24h'));
      chart.draw(data, options);
    }

function drawPressure24() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Pressure, {pressure_unit}');

      data.addRows([
{pressure24h}
      ]);

      var options = {
        title: 'Pressure. Last 24h',
        hAxis: {
          //format: 'dd.MM.yyyy hh:mm',
          format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Pressure, {pressure_unit}',
          logScale: false
        },
        colors: ['#008040', '#008040'],
        height: 450
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_divPressure24h'));
      chart.draw(data, options);
    }

function drawHumidity24() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Humidity, %');

      data.addRows([
{humidity24h}
      ]);

      var options = {
        title: 'Humidity. Last 24h',
        hAxis: {
          //format: 'dd.MM.yyyy hh:mm',
          format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Humidity, %',
          logScale: false
        },
        colors: ['#0000FF', '#0000FF'],
        height: 450
      };

      var chartH = new google.visualization.LineChart(document.getElementById('chart_divHumidity24h'));
      chartH.draw(data, options);
    }

//------------------------------------------------------------------------------

function drawTemperature7d() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Temperature, °{temperature_unit}');

      data.addRows([
{temperature7d}
      ]);

      var options = {
        title: 'Temperature. Last week',
        hAxis: {
          format: 'dd.MM.yyyy',
          //format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Temperature, °{temperature_unit}',
          logScale: false
        },
        colors: ['#F40000', '#F40000'],
        height: 450
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_divTemperature7d'));
      chart.draw(data, options);
    }

function drawPressure7d() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Pressure, {pressure_unit}');

      data.addRows([
{pressure7d}
      ]);

      var options = {
        title: 'Pressure. Last week',
        hAxis: {
          format: 'dd.MM.yyyy',
          //format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Pressure, {pressure_unit}',
          logScale: false
        },
        colors: ['#008040', '#008040'],
        height: 450
      };

      var chart = new google.visualization.LineChart(document.getElementById('chart_divPressure7d'));
      chart.draw(data, options);
    }

function drawHumidity7d() {
      var data = new google.visualization.DataTable();
      data.addColumn('datetime', 'X');
      data.addColumn('number', 'Humidity, %');

      data.addRows([
{humidity7d}
      ]);

      var options = {
        title: 'Humidity. Last week',
        hAxis: {
          format: 'dd.MM.yyyy',
          //format: 'hh:mm',
          //title: 'Time',
          logScale: false
        },
        vAxis: {
          title: 'Humidity, %',
          logScale: false
        },
        colors: ['#0000FF', '#0000FF'],
        height: 450
      };

      var chartH = new google.visualization.LineChart(document.getElementById('chart_divHumidity7d'));
      chartH.draw(data, options);
    }
</script>

<script>
  google.charts.setOnLoadCallback(drawTemperature24);
  google.charts.setOnLoadCallback(drawPressure24);
  google.charts.setOnLoadCallback(drawHumidity24);

  google.charts.setOnLoadCallback(drawTemperature7d);
  google.charts.setOnLoadCallback(drawPressure7d);
  google.charts.setOnLoadCallback(drawHumidity7d);
</script>


</body>

</html>
