import { Component } from '@angular/core';
import * as Highcharts from 'highcharts';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-myclosedcasescount',
    templateUrl: './dashboard-myclosedcasescount.component.html',
    styleUrls: ['./dashboard-myclosedcasescount.component.scss'],
    standalone: false
})
export class DashboardMyclosedcasescountComponent {

    Highcharts: typeof Highcharts = Highcharts; 
    chart: Highcharts.Options = {
        chart: {
            type: 'line'
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
        xAxis: {
            categories: ['2010', '2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018']
        },
        yAxis: {
            title: {
                text: ''
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            type: 'line',
            name: 'ANE',
            data: [0, 20, 30, 40, 50, 80, 110, 90, 120]
        },
        {
            type: 'line',
            name: 'Complaint',
            data: [25, 85, 100, 40, 28, 65, 84, 62, 54]
        },
        {
            type: 'line',
            name: 'IQC',
            data: [340, 420, 730, 140, 50, 952, 65, 254, 62]
        },
        {
            type: 'line',
            name: 'Other',
            data: [250, 20, 130, 440, 350, 65, 156, 516, 45]
        }]
    };

}
