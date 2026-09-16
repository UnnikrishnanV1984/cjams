import { Component } from '@angular/core';
import * as Highcharts from 'highcharts';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-myteamoverdue',
    templateUrl: './dashboard-myteamoverdue.component.html',
    styleUrls: ['./dashboard-myteamoverdue.component.scss'],
    standalone: false
})
export class DashboardMyteamoverdueComponent {

    Highcharts: typeof Highcharts = Highcharts; 
    chart: Highcharts.Options = {
        chart: {
            type: 'column',
            height: 300,
            width: 300,
            style: {
                fontFamily: 'Open Sans'
            }
        },
        yAxis: {
            title: {
                text: ''
            },
            lineWidth: 0,
            minorGridLineWidth: 0,
            lineColor: 'transparent',
            gridLineColor: 'transparent',
            labels: {
                enabled: false
            },
            minorTickLength: 0,
            tickLength: 0,
            stackLabels: {
                enabled: true,
                style: {
                    fontWeight: 'bold',
                    color: 'gray'
                }
            }

        },
        xAxis: {
            title: {
                text: 'Days',
                style: {
                    color: '#9db4ce',
                    fontsize: '16px'
                }
            },
            lineWidth: 0,
            minorGridLineWidth: 0,
            lineColor: 'transparent',
            categories: ['<30', '30-60', '>60'],
            minorTickLength: 0,
            tickLength: 0
        },
        title: {
            text: undefined,
            align: 'left',
            style: {
                color: '#00A2FD',
                fontWeight: 'bold',
                fontSize: '14px'
            }
        },
        credits: {
            enabled: false
        },
        exporting: {
            buttons: {
                contextButton: {
                    symbol: 'url(img/dashboard-menu-icon.png)',
                    x: 20,
                    y: 17.5
                }
            }
        },
        legend: {
            align: 'right',
            verticalAlign: 'middle',
            layout: 'vertical',
            title: {
                text: 'Service Type',
                style: {
                    color: '#A0A0A0'
                }
            },
            itemStyle: {
                fontSize: '13px',
                fontFamily: 'Open Sans',
                color: '#A0A0A0'
            }
        },


        tooltip: {
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
            shared: true
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                borderWidth: 0
            }

        },
        series: [{
            type: 'column',
            name: 'ANE',
            data: [8, 4, 7],
            color: '#ff99bb'
        }, {
            type: 'column',
            name: 'Complaint',
            data: [6, 3, 7],
            color: '#c44dff'
        },
        {
            type: 'column',
            name: 'IQC',
            data: [4, 6, 8],
            color: '#80ccff'
        },
        {
            type: 'column',
            name: 'IDC',
            data: [7, 4, 4],
            color: '#1aff8c'
        },
        {
            type: 'column',
            name: 'Joe',
            data: [4, 3, 4],
            color: '#ff8080'
        }
        ]

    };

}
