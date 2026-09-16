import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { HomeDashboardUrlConfig } from '../home-dashbaord.url.config';
import * as Highcharts from 'highcharts';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dashboard-restorewidgets',
    templateUrl: './dashboard-restorewidgets.component.html',
    styleUrls: ['./dashboard-restorewidgets.component.scss'],
    standalone: false
})
export class DashboardRestorewidgetsComponent implements OnInit {
    Highcharts: typeof Highcharts = Highcharts;
    caseCloseureChart: any;
    taskClosurechart: any;
    closedCasesToday!: number;
    closedCasesWeek!: number;
    averageclosurerate!: number;
    closedCompliance!: number;
    openCompliance!: number;
    irRatio!: number;
    arRatio!: number;

    closedCases!: number;
    openCases!: number;
    totalCases!: number;
    irCase!: number;
    arCase!: number;

    taskclosed!: number;
    taskCompliance!: number;
    totaltask!: number;
    opentask!: number;
    showCaseChart!: boolean;
    showTaskChart: boolean = false;

    constructor(private _commonService: CommonHttpService) {}

    ngOnInit() {
        this.getCaseWidgetData();
        this.getTaskWidgetDAta();
    }

    getCaseWidgetData() {
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.restoreWidget.caseworkerDashboardURL}`;
        this._commonService.getSingle({}).subscribe((data) => {
            this.closedCasesToday = +data.closedtoday;
            this.closedCasesWeek = +data.closedthisweek;
            this.averageclosurerate = +data.averageclosurerate;
            this.closedCases = +data.closed;
            this.openCases = +data.open;
            this.totalCases = +data.totalcount;
            this.irCase = +data.ir;
            this.arCase = +data.ar;
            this.closedCompliance = 0;
            this.openCompliance = 0;
            if (this.totalCases !== 0) {
                this.irRatio = +((data.ir / data.totalcount) * 100).toFixed(2);
                this.arRatio = +((data.ar / data.totalcount) * 100).toFixed(2);
                this.showCaseChart = true;
            } else {
                this.showCaseChart = false;
            }

            this.caseCloseureChart = {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false,
                    height: 180,
                    width: 150
                },
                colors: [],
                exporting: {
                    enabled: false
                },
                title: {
                    text: null
                },
                tooltip: {
                    enabled: true
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false
                        },
                        startAngle: -90,
                        endAngle: 90,
                        center: ['40%', '35%']
                    }
                },
                series: [
                    {
                        type: 'pie',
                        name: 'Cases',
                        innerSize: '50%',
                        data: [
                            ['IR', +data.ir],
                            ['AR', +data.ar],
                            ['Closed', +data.closed],
                            ['Opened', +data.open],
                            {
                                dataLabels: {
                                    enabled: false
                                }
                            }
                        ],
                        states: {
                            hover: {
                                enabled: false
                            }
                        }
                    }
                ]
            };
            if (this.closedCompliance <= 100) {
              this.setCaseCloseureChart();
            } 
        });
    }

    setCaseCloseureChart(){
        this.caseCloseureChart.colors = ['#fa0', '#6d5cae', '#0aa89e', '#eee'];
    }

    getTaskWidgetDAta() {
        this._commonService.endpointUrl = `${HomeDashboardUrlConfig.EndPoint.restoreWidget.taskCloseureURL}`;

        this._commonService.getSingle({}).subscribe((data) => {
            this.taskCompliance = 0;
            this.totaltask = data.totalcount;
            this.opentask = data.opened;
            this.taskclosed = data.closed;
            // tslint:disable-next-line:triple-equals
            if (data.totalcount != 0) {
                this.taskCompliance = +((data.closed / data.totalcount) * 100).toFixed(2);
                this.showTaskChart = true;
            } else {
                this.showTaskChart = false;
            }
            this.taskClosurechart = {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: 0,
                    plotShadow: false,
                    height: 180,
                    width: 150
                },
                colors: [],
                exporting: {
                    enabled: false
                },
                title: {
                    text: null
                },
                tooltip: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                plotOptions: {
                    pie: {
                        dataLabels: {
                            enabled: false
                        },
                        startAngle: -90,
                        endAngle: 90,
                        center: ['40%', '35%']
                    }
                },
                series: [
                    {
                        type: 'pie',
                        name: 'Cases',
                        innerSize: '50%',
                        data: [
                            ['Closed', +data.closed],
                            ['Opened', +data.opened],
                            {
                                dataLabels: {
                                    enabled: false
                                }
                            }
                        ],
                        states: {
                            hover: {
                                enabled: false
                            }
                        }
                    }
                ]
            };

            if (this.taskCompliance <= 25) {
                this.taskClosurechart.colors = ['#DF5353', '#EEE'];
            } else if (this.taskCompliance > 25 && this.taskCompliance <= 75) {
                this.taskClosurechart.colors = ['#f4e404', '#EEE'];
            } else if (this.taskCompliance > 75 && this.taskCompliance <= 100) {
                this.taskClosurechart.colors = ['#55BF3B', '#EEE'];
            }
        });
    }
}
