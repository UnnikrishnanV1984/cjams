import { Component } from '@angular/core';
import * as Highcharts from 'highcharts';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-closedoverdue',
    templateUrl: './dashboard-closedoverdue.component.html',
    styleUrls: ['./dashboard-closedoverdue.component.scss'],
    standalone: false
})
export class DashboardClosedoverdueComponent {

    Highcharts: typeof Highcharts = Highcharts; 
    chart: Highcharts.Options = {
        chart: {
          type: 'area',
          width: 400,
          height: 300,
          style: {
            fontFamily: 'Open Sans'
          }
        },
        yAxis: {
          title: {
            text: ''
          }
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
        tooltip: {
          pointFormat: '{series.name} produced <b>{point.y:,.0f}</b><br/>warheads in {point.x}'
        },
        plotOptions: {
          area: {
            pointStart: 1990,
            marker: {
              enabled: false,
              symbol: 'circle',
              radius: 2,
              states: {
                hover: {
                  enabled: true
                }
              }
            }
          }
        },
        series: [
          {
            type: 'area',
            name: 'Closed',
            data: [20434, 24126, 27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342, 26662, 26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605, 24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586, 22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950, 10871, 10824, 10577],
            color: '#e8012e'
          },
          {
            type: 'area',
            name: 'Overdue',
            data: [27935, 30062, 32049, 30952, 30804, 30431, 30197, 25000, 23000, 25000, 26000, 26700, 27800, 26900, 28000, 29000, 27000, 25000, 24000, 23000, 22000, 21000, 20000, 19000, 18000, 18000, 17000, 16000, 20000, 19000, 18000, 18000, 17000, 16000, 16000, 20000, 19000, 18000, 18000, 17000, 16000],
            color: '#9ff8be'
          }
        ],
        legend: {
          itemStyle: {
            fontSize: '13px',
            fontFamily: 'Open Sans',
            color: '#A0A0A0'
          }
        }
      };

}

