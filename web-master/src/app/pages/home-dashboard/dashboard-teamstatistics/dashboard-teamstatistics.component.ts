import { Component, Input, OnInit } from '@angular/core';
import { Subject } from 'rxjs';
import { CommonHttpService } from '../../../@core/services';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { TeamStatisticsData } from '../_entities/home-dash-entities';
import { HighchartsChartModule } from 'highcharts-angular';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-teamstatistics',
    templateUrl: './dashboard-teamstatistics.component.html',
    styleUrls: ['./dashboard-teamstatistics.component.scss'],
    imports:[MatSortModule,HighchartsChartModule,CommonModule],
    standalone: true
})

export class DashboardTeamstatisticsComponent implements OnInit {
    Highcharts: any; 
    noData: boolean;
    @Input()
    eventSubject$!: Subject<string>;

    chart!: Highcharts.Options;
    dataFor!: string;

    constructor(private _commonService: CommonHttpService) {
        this.noData = false;
    }

    async ngOnInit() {
        const hc = await import('highcharts');
        this.Highcharts = hc.default;
        this.eventSubject$.subscribe(data => {
            // No content to add or call
        });
        this.dataFor = 'month';
        this.getWidgetData(this.dataFor);
    }

    getWidgetData(dataFor: string) {
        this.dataFor = dataFor;
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.teamStatistics.teamStatisticsURL}`;
        const body = new PaginationRequest({
            where: { source: dataFor },
            limit: 10,
            method: 'post',
            count: -1,
        });
        this._commonService.getSingle(body).subscribe((data: TeamStatisticsData) => {
            if (data.totalcount === '0') {
                this.noData = true;
            } else {
                this.noData = false;
                this.chart = {
                    chart: {
                        type: 'pie',
                        style: {
                            fontFamily: 'Open Sans'
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
                        enabled: false,
                        buttons: {
                            contextButton: {
                                symbol: 'url(assets/images/dashboard-menu-icon.png)',
                                x: 20,
                                y: 17.5
                            }
                        }
                    },
                    yAxis: {
                        title: {
                            text: ''
                        }
                    },
                    plotOptions: {
                        pie: {
                            borderWidth: 0,
                            shadow: true,
                            center: ['50%', '50%'],
                            dataLabels: {
                                enabled: false,
                            },
                            showInLegend: true
                        }
                    },
                    tooltip: {

                        enabled: true
                    },
                    series: [{
                        type: 'pie',
                        name: 'Cases',
                        size: '80%',
                        innerSize: '68%',
                        showInLegend: true,
                        dataLabels: {
                            formatter: function (): string | null {
                                return null;
                                // return this.y > 5 ? this.point.name : null;
                            },
                            color: '#ffffff',
                            distance: -30
                        },
                        data: [
                            { name: 'Closed', y: +data.closed, color: '#A674E4' },
                            {
                                name: 'Open',
                                y: +data.open,
                                sliced: false,
                                selected: true,
                                color: '#ff8080'
                            },

                            { name: 'Unknowledged', y: +data.unacknowledged, color: '#d9a7ff' },
                            { name: 'Overdue', y: +data.overdue, color: '#4298de' }
                        ]
                    }, {
                        type: 'pie',
                        name: 'Versions',
                        data: [
                            { name: 'Unallocated', y: +data.unallocated, color: '#ffb3b3' },
                            { name: 'Allocated', y: +data.allocated, color: '#63eaef' },
                            { name: 'Cancelled', y: +data.cancelled, color: '#b5f8d8' },
                        ],
                        size: '50%',
                        innerSize: '50%',
                        showInLegend: true,
                        dataLabels: {
                            formatter: function (): string | null {
                                return null;
                                // // display only if larger than 1
                                // return this.y > 5 ? this.point.name : null;
                            }
                        }
                    }],

                    legend: {
                        itemStyle: {
                            fontSize: '14px',
                            fontFamily: 'Open Sans',
                            color: '#A0A0A0',
                            fontWeight: 'normal',

                        },
                        align: 'right',
                        verticalAlign: 'middle',
                        layout: 'vertical',
                        useHTML: true,
                        width: 200,

                    }
                };
            }
        });
    }

}
