<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="highchart_export_module_asp_net._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Highchart js export module sample</title>
    <script src="Javascript/jquery-1.5.1.js" type="text/javascript"></script>
    <script src="Javascript/highcharts.js" type="text/javascript"></script>
    <script src="Javascript/exporting.js" type="text/javascript"></script>
</head>
<script language="javascript" type="text/javascript">
    var chart;
    $(document).ready(function () {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                defaultSeriesType: 'column'
                ,
                plotBackgroundColor: {
                    linearGradient: [0, 0, 500, 500],
                    stops: [
                    [0, 'rgb(255, 255, 255)'],
                    [1, 'rgb(200, 200, 255)']]
                }
            },
            credits: {
                enabled: false //不显示推广
            },
            title: {
                text: "" //设置成没有Title
            },
            xAxis: {
                tickPosition: 'inside',
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            },
            yAxis: [{
                //min: 0,
                title: {
                    text: 'Temperature (Â°C)',
                    style: { color: '#000'} //y轴标题设置成黑色
                },
                labels: {
                    formatter: function () {
                        return Highcharts.numberFormat(this.value, 0, ".", ","); //y轴显示千分符
                    }
                },
                lineWidth: 1 //竖线
            }, {
                opposite: true, //第二Y轴
                //min: 0,
                title: {
                    text: 'Temperature (Â°C)',
                    style: { color: '#000'} //y轴标题设置成黑色
                },
                labels: {
                    formatter: function () {
                        return Highcharts.numberFormat(this.value, 0, ".", ","); //y轴显示千分符
                    }
                },
                lineWidth: 1 //竖线                
            }],
            legend: {
                layout: 'horizontal', //水平对齐
                align: 'center', //居中
                verticalAlign: 'bottom', //底部
                borderWidth: 0
            },
            exporting: {
                url: "/highcharts_export.aspx",
                //url: "/SaveChart.aspx",
                enabled: false //不能直接通过页面下载
            },
            series: [{
                name: '广东',
                data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
            }, {
                name: '北京',
                data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
            }, {
                name: 'Tokyo',
                yAxis: 1,
                type: 'spline',
                data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
            }, {
                name: 'New York',
                yAxis: 1,
                type: 'spline',
                data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
            }]
        });
        //Export();
        SaveChart(chart.getSVG());
    });

    function SaveChart(svg) {
        $.ajax({
            url: "SaveChart.aspx",
            data: { unitId: 1, svg: svg },
            type: "post",
            success: function (msg) {
                alert("Success");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("error get highcharts parameter");
            }
        });
    }

    function Export() {
        //chart.exportChart();
        var svgStr = $('<div>').append($("#container svg").clone()).html();
        //alert(svgStr);

        $.ajax({
            url: "SaveChart.aspx",
            data: { unitId: 1, svg: svgStr },
            type: "post",
            //dataType: "json",
            success: function (msg) {
                alert("Success");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                alert("error get highcharts parameter");
            }
        });


    };
    
</script>
<body>
    <form id="form1" runat="server">
    <div id="container" style="width: 600px;">
    </div>
    <br />
    <input type="button" onclick="Export();" value="Export" />
    </form>
</body>
</html>
