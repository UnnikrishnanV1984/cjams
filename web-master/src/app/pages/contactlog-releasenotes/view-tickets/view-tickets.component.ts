import { Component, Injector, OnInit} from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AlertService, AuthService, CommonHttpService, DataStoreService } from '../../../@core/services';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import _ from 'lodash';
import { AppUser } from '../../../@core/entities/authDataModel';
import { DropdownModel, PaginationInfo,PaginationRequest } from '../../../@core/entities/common.entities';
import moment from 'moment';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AppConfig } from '../../../app.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import * as Highcharts from "highcharts";
import { of, Observable } from 'rxjs';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { HttpClient } from '@angular/common/http';

declare var $: any;
@Component({
    // moduleId: module.id,
    selector: 'view-tickets',
    templateUrl: './view-tickets.component.html',
    styleUrls: ['./view-tickets.component.scss'],
    standalone: false
})

export class ViewTicketsComponent implements OnInit {
    reportscreen: boolean = false;
    teamChart: boolean = false;
    countyChart: boolean = false;

    noTeamReport: boolean = false;
    noCountyReport: boolean = false;
    noCountyJiraReport: boolean = false;
    noCountyteamReport: boolean = false;
    noStateReport: boolean = false;
    updateCountyReport: boolean = false;
    updateCountyFocusCDMReport: boolean = false;
    updateCountyFocusCJAMSReport: boolean = false;
    updateCountyResolutionReport: boolean = false;
    updateCountyFixtypeReport: boolean = false;
    updateCountyJiraReport: boolean = false;
    updateTeamReport: boolean = false;
    updateStateReport: boolean =  false;
    updateCountyCDMReport: boolean = false;
    Highcharts: typeof Highcharts = Highcharts;
    countyticketstatuscounts: any[] = [];
    countyrelatedcounts: any[] = [];
    countyjirastatuscounts: any[] = [];
    teamticketstatuscounts: any[] = [];
    teamrelatedcounts: any[] = [];
    teamjirastatuscounts: any[] = [];
    chartCounty: boolean = true;
    countycount: any = 0;
    fixtypelist: any[] = [];
    totalFocusCJAMSCounts: number = 0;
    totalFocusCDMCounts: number = 0;
    reportsformatopt1 = '<b>{point.y:.0f}</b><b> (</b><b>{point.percentage:.1f}%</b><b>)</b>';
    reportsformatopt2 = '<b>{point.name}</b>: <b>{point.y:.0f}</b><b> (</b><b>{point.percentage:.1f}%</b><b>)</b>';
    ticketcountlabel = 'Ticket Count';
    pendingapprovallabel = 'Pending Approval';
    ticketsbymonthlabel = "Tickets By Month";
    totalincidentscreatedlabel = 'Total Incidents Created';
    totaldefectscreated = 'Total Defects Created';
    dtformat = "MM/DD/YYYY";
    ticketactionpopupid = '#ticket-action-check';
    countyApprovalReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets Approval Status'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyFocusCDMReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'CDM Tickets By Focus Area'
        },
        subtitle: {
            text: '',
            align: 'right',
            verticalAlign: 'top',
            y: 15 // Adjust y position to move it down from the very edge
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyFocusCJAMSReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'CJAMS Tickets By Focus Area'
        },
        subtitle: {
            text: '',
            align: 'right',
            verticalAlign: 'top',
            y: 15 // Adjust y position to move it down from the very edge
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyResolutionReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets By Resolution'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyFixtypeReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets By Fix Type'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyJiraStatusReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'JIRA Incidents By Status'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    countyTeamIncidentCountReport: any = {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Tickets By Team'
        },
        xAxis: {
            categories: ['Team1', 'Team2', 'Team3', 'Team4', 'Team5'],
            title: {
                text: null
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: this.ticketcountlabel,
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [
            {
                name: 'Approved',
                data: []
            },
            {
                name: 'Rejected',
                data: []
            },
            {
                name: this.pendingapprovallabel,
                data: []
            }
        ]
    };

    countyIncidentOpenCloseCountReport: any = {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Incidents (Open/Closed)'
        },
        xAxis: {
            categories: ['Month1', 'Month2', 'Month3', 'Month4', 'Month5'],
            title: {
                text: null
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: this.ticketcountlabel,
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [
            {
                name: 'Open',
                data: []
            },
            {
                name: 'Closed',
                data: []
            }
        ]
    };

    countyIncidentCountReport: any = {
        chart: {
            type: "spline"
        },
        title: {
            text: this.ticketsbymonthlabel
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: this.ticketcountlabel
            }
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        tooltip: {
            valueSuffix: " "
        },
        series: [{
            name: 'Approved',
            data: []
        },
        {
            name: 'Rejected',
            data: []
        },
        {
            name: this.pendingapprovallabel,
            data: []
        },
        {
            name: 'Total',
            data: []
        }]
    };

    countyCDMCountReport: any = {
        chart: {
            type: "spline"
        },
        title: {
            text: "JIRA Incidents By Month"
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: this.ticketcountlabel
            }
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        tooltip: {
            valueSuffix: " "
        },
        series: [{
            name: this.totalincidentscreatedlabel,
            data: []
        },
        {
            name: this.totaldefectscreated,
            data: []
        }]
    };

    teamApprovalReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets Approval Status'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'TeamTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    teamFocusCDMReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'CDM Tickets By Focus Area'
        },
        subtitle: {
            text: '',
            align: 'right',
            verticalAlign: 'top',
            y: 15 // Adjust y position to move it down from the very edge
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'TeamTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    teamFocusCJAMSReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'CDM Tickets By Focus Area'
        },
        subtitle: {
            text: '',
            align: 'right',
            verticalAlign: 'top',
            y: 15 // Adjust y position to move it down from the very edge
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'TeamTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    teamResolutionReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets By Resolution'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };

    teamFixtypeReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'Tickets By Fix Type'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };


    teamJiraStatusReport: any = {
        chart: {
            plotBackgroundColor: undefined,
            plotBorderWidth: undefined,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'JIRA Incidents By Status'
        },
        tooltip: {
            pointFormat: this.reportsformatopt1
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: this.reportsformatopt2
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'CountyTickets',
            colorByPoint: true,
            data: [{}]
        }]
    };
    
    teamWorkerIncidentCountReport: any = {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Worker Incidents'
        },
        xAxis: {
            categories: ['Worker1', 'Worker2', 'Worker3', 'Worker4', 'Worker5'],
            title: {
                text: null
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Incident Count',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [
            {
                name: 'Approved',
                data: []
            },
            {
                name: 'Rejected',
                data: []
            },
            {
                name: this.pendingapprovallabel,
                data: []
            }
        ]
    };

    teamIncidentOpenCloseCountReport: any = {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Incidents (Open/Closed)'
        },
        xAxis: {
            categories: ['Month1', 'Month2', 'Month3', 'Month4', 'Month5'],
            title: {
                text: null
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: this.ticketcountlabel,
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [
            {
                name: 'Open',
                data: []
            },
            {
                name: 'Closed',
                data: []
            }
        ]
    };

    teamIncidentCountReport: any = {
        chart: {
            type: "spline"
        },
        title: {
            text: this.ticketsbymonthlabel
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: this.ticketcountlabel
            }
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        tooltip: {
            valueSuffix: " "
        },
        series: [{
            name: 'Approved',
            data: []
        },
        {
            name: 'Rejected',
            data: []
        },
        {
            name: this.pendingapprovallabel,
            data: []
        },
        {
            name: 'Total',
            data: []
        }]
    };

    teamCDMCountReport: any = {
        chart: {
            type: "spline"
        },
        title: {
            text: "JIRA Incidents By Month"
        },
        xAxis: {
            categories: []
        },
        yAxis: {
            title: {
                text: this.ticketcountlabel
            }
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        tooltip: {
            valueSuffix: " "
        },
        series: [{
            name: this.totalincidentscreatedlabel,
            data: []
        },
        {
            name: this.totaldefectscreated,
            data: []
        }]
    };

    stateReport: any = {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Tickets By County'
        },
        xAxis: {
            categories: [],
            title: {
                text: null
            },
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: this.ticketcountlabel,
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                },
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        credits: {
            enabled: false
        },
        series: [
            {
                name: 'Approved',
                data: []
            },
            {
                name: 'Rejected',
                data: []
            },
            {
                name: this.pendingapprovallabel,
                data: []
            }
        ]
    };

    paginationInfo: PaginationInfo = new PaginationInfo();
    userInfo: AppUser = new AppUser();
    selectTransBulk!: boolean;
    numberoftickets: any;
    dupResponse: any;
    enableBulk!: boolean;
    countiesSource$: any;
    countiesData: any;
    searchcountyid: any;
    downloadAttachments: boolean = false;
    roleName!: string;
    searchForm: any;
    reportForm: any;
    ticketdetails: any;
    query = {};
    ticketsCount!: number;
    maxPageSize = 10;
    showProgress: boolean = true;
    ticketsList: any[] = [];
    downloadMessage!: string;
    isSupervisor: boolean = false;
    isCPStaff: boolean = false;
    pageSource: any;
    jirarequestsent: any;
    jirarequestno: any;
    userCounty: any;
    filter: any;
    searchString: any;
    jiradetails: any;
    releaseForm!: FormGroup;
    inprogress$: Observable<boolean> = of(false);
    effectiveDate: any;
    
    ticketcounts = {
        tickets: 0,
        pendingapproval: 0,
        approved: 0,
        rejected: 0,
        teamtickets: 0,
        countytickets: 0,
        countypendingapproval: 0,
        countyapproved: 0,
        countyrejected: 0,
        waitingonuser: 0,
        waitingonssa: 0
    };
    countyList:any;
    teamList: any;
    selectedCounty: any;
    teamid: any;
    searchFlag: boolean = false;
    pageChange: boolean = false;
    sortChange: boolean = false;
    severityTypes = [
        {
            key: "Critical",
            value: "Critical"
        },
        {
            key: "High",
            value: "High"
        },
        {
            key: "Medium",
            value: "Medium"
        },
        {
            key: "Low",
            value: "Low"
        },
    ];
    issueTypes = [
        {
            key: "531",
            value: "Enhancement"
        },
        {
            key: "528",
            value: "Bug/Issue/Defect"
        },
        {
            key: "531",
            value: "Question/Policy"
        },
        {
            key: "531",
            value: "Gap/Missing from Legacy System"
        },
        {
            key: "524",
            value: "Application Support/Training"
        }
    ];
    vl: any;
    ipaduser!: boolean;
    bulkTicket: any[] = [];
    countyname: any;
    teamtypekey: any;
    caseWorkerList: any;
    focusarealist:any=[];
    identifiedaslist:any=[];
    jirastatuslist:any=[];
    maxDate: any;
    minDate1: any;
    minDate2: any;
    disabledButtons: { [key: string]: boolean } = {};
    isBulkActionInProgress : boolean = false;

    private readonly _http: HttpClient;
    public router: Router;
    private _authService: AuthService;
    private _service: CommonHttpService;
    private _dataStoreService: DataStoreService;
    private _formBuild: FormBuilder;
    private _alert: AlertService;

    constructor(private injector: Injector) {
        this._http = this.injector.get<HttpClient>(HttpClient);
        this.router = this.injector.get<Router>(Router);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._formBuild = this.injector.get<FormBuilder>(FormBuilder);
        this._alert = this.injector.get<AlertService>(AlertService);
     }

    ngOnInit() {
        this.maxDate = new Date();
        this.userInfo = this._authService.getCurrentUser();
        this.teamtypekey = this.userInfo.role.teamtypekey;
        this.roleName = this.userInfo.role.name;
        const tma = this.userInfo.user.userprofile.teammemberassignment;
        const assignments = Array.isArray(tma) ? tma : [tma];
        this.teamid = assignments[0]?.teammember?.teamid;
        if (this.roleName === 'apcs' || this.roleName === 'IV-E Supervisor' || this.roleName === 'FS') {
            this.isSupervisor = true;
        }

        if (this.roleName === 'Central Policy Staff') {
            this.isCPStaff = true;
        }
        this.pageSource = this._dataStoreService.getData('pageSource');
        if (navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
            this.ipaduser = true;
        }
        this.initializeSearchForm();
        this.initializeReleaseForm();

        this.getCounties();
        this.getworkerlist();
        this.getUserCounty();
        this.getfocuslist();
        this.getidentifiedaslist();
        this.getjirastatuslist();
        this.getfixtypelist();

        const today = new Date();
        const yesterday = new Date(today);
        yesterday.setDate(yesterday.getDate() - 1);
        this.effectiveDate = moment(yesterday).format(this.dtformat);

        if (this.pageSource == 'notification') {
            this._dataStoreService.setData('pageSource',null);
            this.searchForm.patchValue({ jirarequestsent:'Pending'});
        } else {
            if (this.isSupervisor){
                this.getcountpendingtickets();
            }
        }
        setTimeout(() => {
            this.searchForm.patchValue({ teamid:this.teamid});
            if (this.isSupervisor) {
                    this.alternateSearch('countypendingapproval');
            } else {
                this.alternateSearch('tickets');
            }
            this.searchForm.patchValue({ ldssregion: null, teamid: null, frommailid: null, jirarequestsent: null });
        }, 1000);
    }

    getIssueType(key: any) {
        return _.get(_.filter(this.issueTypes, { key }), "0.value");
    }
    getFormattedDate(dateValue: string | number | Date) {
        if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY HH:mm:ss', true).isValid()) {
            return moment(new Date(dateValue)).format('MM/DD/YYYY HH:mm:ss');
        } else {
            return '';
        }
    }

    private getCounties() {
        this._service.create(
            {
                nolimit: true,
                order: 'countyname asc',
            },
            NewUrlConfig.EndPoint.Intake.CountryListUrl
        ).subscribe(result => {
            this.countyList = result.map((res: any) => {
                return new DropdownModel({
                    text: res.countyname,
                    value: res.countyid
                });
            });
        });
    }

    private initializeSearchForm() {
        this.downloadMessage = '';
        this.searchForm = this._formBuild.group({
            searchType: [null],
            ldssregion:[null],
            notes:[null],
            fromdate:[null],
            todate:[null],
            clientid:[null],
            supportno:[null],
            subject:[null],
            frommailid:[null],
            jirarequestsent:[null],
            focus:[null],
            teamflag:[null],
            jirastatus:[null],
            severity:[null],
            issuetype:[null],
            teamid:[null],
            advsearchflag:[false],
            fixtype:[null],
            identifiedas:[null]
        });

        this.reportForm = this._formBuild.group({
            chartType:[null],
            ldssregion:[null],
            teamid:[null],
            fromdate:[null],
            todate:[null],
            jirarequestsent:[null],
            identifiedas:[null]
        });

        this.advSearchSelection(false);

    }

    initializeReleaseForm(){
        this.releaseForm=this._formBuild.group({
            releaseversion: null,
            releasedate: null,
			defectid:null,
			title:null,
			description:null,
			supportno:null
		
		});
    }
    clearSearchTickets() {
        this.query = {};
        this.ticketsList = [];
        this.searchForm.reset();
        this.searchFlag = false;
        this.pageChange = false;
        this.sortChange = false;
        this.bulkTicket=[];
        this.ticketsCount = 0;
        if(this.isSupervisor) {
            this.searchString = 'countypendingapproval';
        }else{
            this.searchString = 'tickets';
        }
        this.getSupportTickets(1);
    }
    hideTickets() {
        this.clearSearchTickets();
        $('#user-tickets').modal('hide');
    }
    private getDownloadAccessRole() {
        const cache = Date.now();
        this._service
            .getAll(`Authorizes/getPageProfile?cache=${cache}&arg={"count":-1,"where":{"modulekey":"contact-support"},"method":"get"}`)
            .subscribe(res => {
                const data: any = res;
                this.downloadAttachments = _.includes(_.map(data.resources, 'resourceid'), 'can-download-defects');
            });
    }
    private getJiraStatus() {
        this._service
            .getAll('supportlog/getJiraRequest')
            .subscribe();
    }

    private getfocuslist() {
        this._service
            .getAll('supportlog/getfocuslist')
            .subscribe(res => {
                this.focusarealist = res;
            });
    }

    private getidentifiedaslist() {
        this._service
            .getAll('supportlog/getidentifiedaslist')
            .subscribe(res => {
                this.identifiedaslist = res;
            });
    }

    private getjirastatuslist() {
        this._service
            .getAll('supportlog/getjirastatuslist')
            .subscribe(res => {
                this.jirastatuslist = res;
            });
    }

    getfixtypelist() {
        this._service.getArrayList(
            {
              nolimit: true,
              where: { "referencetypeid": 500500 }, order: 'displayorder ASC', method: 'get'
            },
            'referencevalues?filter'
        ).subscribe(result => {
            this.fixtypelist = result;
        })
    }

    searchTickets() {
        this.ticketsCount = 0;
        this.pageChange = false;
        this.sortChange = false;
        this.bulkTicket =[];
        this.searchString = null;
        this.getSupportTickets(1);
    }

    alternateSearch(searchString: any){
        this.ticketsCount = 0;
        this.searchForm.reset();
        this.searchFlag = false;
        this.sortChange = false;
        this.pageChange = false;
        this.bulkTicket =[];
        this.searchString = searchString;
        this.paginationInfo['sortBy'] = 'desc';
        this.paginationInfo['sortColumn'] = 'supportno';
        this.getSupportTickets(1);
    }

    pageChanged(pageNumber: number) {
        this.pageChange = true;
        this.paginationInfo.pageNumber = pageNumber;
        this.getSupportTickets(pageNumber);
    }

    onSort($event: ColumnSortedEvent) {
        this.paginationInfo['sortBy'] = $event.sortDirection;
        this.paginationInfo['sortColumn'] = $event.sortColumn;
        this.paginationInfo.pageNumber = 1;
        this.sortChange = true;
        this.getSupportTickets(1);
    }

    private getSupportTickets(pageNumber = 1) {
        if (this.pageChange || this.sortChange){
            this.filter.pagenumber = pageNumber;
            if (this.sortChange){
                this.filter.sortcolumn = this.paginationInfo['sortColumn'];
                this.filter.sortorder = this.paginationInfo['sortBy'];
            }
        } else {
            this.filter = {
                pagesize: this.maxPageSize,
                pagenumber: pageNumber,
                input: this.searchForm.getRawValue(),
                sortcolumn:this.paginationInfo['sortColumn'] ? this.paginationInfo['sortColumn']:'effectivedate',
                sortorder:this.paginationInfo['sortBy']? this.paginationInfo['sortBy']:'desc',
                searchString: this.searchString
            };
        }
        this.paginationInfo.pageNumber = pageNumber;
        this.pageChange = false;
        this.showProgress = true;
        this.ticketsList = [];
        this.getTickets(this.filter);

    }
    private getTickets(filter: any) {
        const pagenumber = filter.pagenumber;
        if (pagenumber == 1) {
            this.getsupportlogcounts();
        }
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    where: filter,
                    method: 'post'
                }),
                'supportlog/getsupportlog'
            ).subscribe(response => {
                const res = response.data ? response.data : [];
                if (res && res.length > 0) {
                    this.ticketsCount = res[0].totalcount;
                } else {
                    this.ticketsCount = 0;
                }
                this.showProgress = false;
                this.ticketsList = res;
            }, err => {
                this.showProgress = false;
            });

    }

    getsupportlogcounts() {
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'post'
                }),
                'supportlog/getsupportlogcounts'
            ).subscribe(response => {
                const res = response.data && response.data.length > 0 ? response.data[0] : null;
                this.ticketcounts = res && res.getsupportlogcounts  ? res.getsupportlogcounts : null;
            });
    }
    
    getSeverityType(key: any) {
        return _.get(_.filter(this.severityTypes, { key }), "0.value");
    }
    actions(item: any) {
        this.ticketdetails = item;
        this.jirarequestsent = this.pendingapprovallabel;
        this.jirarequestno = 'Not Applicable';
        if (this.ticketdetails.jirarequestsent && this.ticketdetails.jirarequestsent !== ''){
            this.jirarequestsent = this.ticketdetails.jirarequestsent;
            if (this.ticketdetails.jirarequestsent == 'Approved' || this.ticketdetails.jirarequestsent == 'Jira Ticket'){
                this.jirarequestno = this.ticketdetails.jirarequestno;
            }
        }
        if (item.cdmticketno){
            this.getlatestJiraStatus(item.cdmticketno);
        } else if (item.jirarequestno){
            this.getlatestJiraStatus(item.jirarequestno);
        } else {
            this.ticketdetails['jiraStatus'] = null;
            this.ticketdetails['jiraComments'] = null;
            $(this.ticketactionpopupid).modal('show');
        }

    }
    ticketChanged(event: Event, ticketdata: any) {
        const checked = (event.target as HTMLInputElement).checked;
        if (checked) {
            this.bulkTicket.push(ticketdata);
        } else {
            const isLargeNumber = (ticketdata1: any) => ticketdata1 !== ticketdata
            this.bulkTicket = this.bulkTicket.filter(isLargeNumber);
        }
    }
    approvedorrejected(approvedorrejecteddata: string) {
        if (this.isBulkActionInProgress) {
            return;
        };
        this.isBulkActionInProgress  = true;
            const data = {
                'supportlogid': this.bulkTicket,
                'approveOrReject': approvedorrejecteddata
            };
            this._service.create(data, 'supportlog/approveorrejectall').subscribe(
                res => {
                    if (approvedorrejecteddata === 'Approved') {
                        this._alert.success('Ticket raised has been approved, Jira request has also been sent');
                    } else {
                        this._alert.success('Ticket raised has been rejected');
                    }    
                    this.bulkTicket=[];
                    this.isBulkActionInProgress = false;    
                    setTimeout(() => {
                        this.getSupportTickets(1);
                    }, 4000); 
                },
                err => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.isBulkActionInProgress = false;
                }
            );
        }

    private getlatestJiraStatus(jirano: string) {
        this._service
            .getAll('supportlog/getJiraStatus?jirarequestno=' + jirano)
            .subscribe(res => {
                this.jiradetails = res;
                if (this.jiradetails && this.jiradetails.status){
                    this.ticketdetails['jiraStatus'] = this.jiradetails.status;
                    if (this.jiradetails.status == 'No Access'){
                        this.ticketdetails['jiraComments'] = 'You cannot view this issue. It may have been deleted or you dont have permission to view it.';
                    }
                }
                if (this.jiradetails && this.jiradetails.comments && this.jiradetails.comments.length > 0){
                    this.ticketdetails['jiraComments'] = this.handleJiradetailsFn();
                }
                $(this.ticketactionpopupid).modal('show');
            }, err => {
                $(this.ticketactionpopupid).modal('show');
            });
    }
    // Assosiated with getlatestJiraStatusfunction
    private handleJiradetailsFn() {
        let jiracomments = '';
        const arrlength = this.jiradetails.comments.length;
        let arrindex = 0;
        for (let index = arrlength - 1; index >= 0 && arrindex <= 3; --index) {
            if (!this.jiradetails.comments[index].body.includes('image-')) {
                arrindex = arrindex + 1;
                jiracomments = jiracomments + 'Author: ' + (this.jiradetails.comments[index].author ? (this.jiradetails.comments[index].author.displayName + '\n') : '\n');
                jiracomments = jiracomments + 'Date & Time: ' + (this.jiradetails.comments[index].updated ? (this.jiradetails.comments[index].updated.substring(0, 16) + '\n') : '\n');
                jiracomments = jiracomments + 'Comment: ' + (this.jiradetails.comments[index].body ? this.jiradetails.comments[index].body + '\n\n' : '\n\n');
            }
        }
        return jiracomments;
    }

    private getcountpendingtickets() {
        this._service
            .getAll('supportlog/getcountpendingtickets')
            .subscribe(res => {
                this.numberoftickets = res[0]?.count;
                if ((this.numberoftickets && this.numberoftickets !== '0' ) && this.isSupervisor) {
                    $('#ticket-action-popUp').modal('show');
                }
            }, () => {
                // No data or function to call or add
            } );
    }
    approveOrReject(serviceLogID: any, approveOrReject: string) {
        if (this.disabledButtons[serviceLogID]) {
            return;
        };
        this.disabledButtons[serviceLogID] = true;
        const data = {
            'supportlogid': serviceLogID,
            'approveOrReject': approveOrReject
        };
        this._service.create(data, 'supportlog/approveorreject').subscribe(
            res => {
                if (approveOrReject === 'Approved') {
                    this._alert.success('Contact Support Ticket is approved Successfully! Jira request has also been submitted');
                } else {
                    this._alert.success('The contact support ticket is rejected successfully!');
                }
                this.getSupportTickets(1);
                this.disabledButtons[serviceLogID] = false;
            },
            err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.disabledButtons[serviceLogID] = false;
            }
        );
    }

    forceDownload(fileId: string) {
        const wso2Module = AppConfig.getModuleMapName('supportlogfiles');
        const url = `${AppConfig.baseUrl}/${wso2Module}supportlogfiles/download`;
        
        this._http.get(`${url}?id=${fileId}`, {
                responseType: 'blob'
            }).subscribe( ( response ) => {
            const fileURL = URL.createObjectURL(response);
            window.open(fileURL);
        });
    }

    getUserCounty() {
        this.countycount = 0;
        const filter: any = {};
        this._service
            .getAll('admin/county/getusercounty?data=' + encodeURIComponent(JSON.stringify(filter)))
            .subscribe(res => {
                if (res && res.length > 0) {
                    this.userCounty = res[0];
                    this.countycount = res.length;
                    this.countyname = this.userCounty.countyname;
                    this.searchForm.patchValue({ ldssregion:this.countyname});
                    this.getteams(this.userCounty.countyid);
                }
            });
    }

    getteamlist(countyname: any) {
        if (countyname != 'All') {
            this.selectedCounty = this.countyList.filter((county: { text: any; }) => county.text === countyname);
            const countyid = (this.selectedCounty && this.selectedCounty.length > 0) ? this.selectedCounty[0].value : null;
            this.searchForm.get('teamid').patchValue(null);
            this.searchForm.get('frommailid').patchValue(null);
            this.searchForm.get('teamid').disable();
            this.searchForm.get('frommailid').disable();
            this.reportForm.get('teamid').patchValue(null);
            this.getteams(countyid);
        } else {
            this.searchForm.get('teamid').patchValue(null);
            this.searchForm.get('frommailid').patchValue(null);
            this.searchForm.get('teamid').disable();
            this.searchForm.get('frommailid').disable();
            this.reportForm.get('teamid').patchValue(null);
            this.teamList = null;
            this.caseWorkerList = null;
        }

    }

    getteams(countyid: any) {
        this.searchcountyid = countyid;
        const obj = {
            activeflag: 1,
            countyid: countyid,
            teamtypekey: this.teamtypekey ? this.teamtypekey :'CW'
        }
        this._service.getPagedArrayList(new PaginationRequest({
            where: obj, method: 'get', nolimit: true
        }
        ), 'manage/team/list?filter')
            .subscribe(result => {
                this.teamList = result.data;
                this.searchForm.get('teamid').enable();
                this.loadUnitWorkers();
            });
    }

    loadUnitWorkers() {
        const id = this.searchForm.get('teamid').value;
        this.searchForm.get('frommailid').patchValue('');
        const obj = {
            teamid: id === '' ? null : id,
            filtertypekey: 'worker',
            inactivelist: true,
            countyid: this.searchcountyid
        }
        this._service.getPagedArrayList(new PaginationRequest({
            where: obj,
            method: 'get',
            nolimit: true
        }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
            this.caseWorkerList = result;
            this.searchForm.get('frommailid').enable();
        });
    }

    getworkerlist() {
        this._service.getPagedArrayList(new PaginationRequest({ where: { appevent: 'INVR' }, method: 'post' }), 'Intakedastagings/getroutingusers')
            .subscribe(result => {
                this.caseWorkerList = result.data;
                this.caseWorkerList = this.caseWorkerList.filter((res: { issupervisor: any; agencykey: string; }) => !res.issupervisor && res.agencykey === 'CW');
            });
    }

    advSearchSelection(searchFlag: boolean) {
        this.searchFlag = searchFlag;
        if (this.searchFlag === false){
            this.searchForm.patchValue({
                searchType: null,
                ldssregion:null,
                notes:null,
                fromdate:null,
                todate:null,
                clientid:null,
                subject:null,
                frommailid:null,
                jirarequestsent:null,
                focus:null,
                teamflag:null,
                jirastatus:null,
                severity:null,
                issuetype:null,
                teamid:null});
        } else {
            this.searchForm.patchValue({ ldssregion:this.userCounty.countyname, teamid: null, frommailid:''});
            this.getteams(this.userCounty.countyid);
            if (this.countycount == 1){
                this.searchForm.patchValue({ teamid:this.teamid});
            } else {
                this.searchForm.patchValue({ teamid:null});
            }
        }
    }

    getreleaseversion(ticket: any) {
        if (ticket.releasenotes && ticket.releasenotes.length > 0){
            return ticket.releasenotes[0].releaseversionno;
        } else {
            return '';
        }
    }

    openReleaseDetails(ticket: any) {
        if (ticket.releasenotes && ticket.releasenotes.length > 0){
            const releasenotes = ticket.releasenotes[0];
            this.releaseForm.patchValue({
                releaseversion: releasenotes.releaseversionno ? releasenotes.releaseversionno : '',
                releasedate: releasenotes.releasedate ? this.formatDate(releasenotes.releasedate) : null,
			    defectid:releasenotes.itemid ? releasenotes.itemid : '',
			    title:releasenotes.title ? releasenotes.title : '',
			    description:releasenotes.description ? releasenotes.description : '',
			    supportno:releasenotes.supportid ? releasenotes.supportid : ''});
        }
        $('#release-action-view').modal('show');
    }

    viewReports() {
        this.reportscreen = true;
        this.teamChart = false;
        this.countyChart = true;
        this.reportForm.patchValue({ ldssregion:this.countyname, teamid:this.teamid, chartType: 'county',jirarequestsent:'All', identifiedas:'All' });
        this.getcountyticketcounts();
    }

    closeReports() {
        this.reportscreen = false;
        this.reportForm = this._formBuild.group({
            chartType:[null],
            ldssregion:[null],
            teamid:[null],
            fromdate:[null],
            todate:[null],
            jirarequestsent:[null]
        });
    }

    clearReportInput(){ 
        this.reportForm.reset();
        this.viewReports();
    }

    generateReport(){
        this.inprogress$ = of(true);
        this.updateCountyReport = false;
        this.updateCountyFocusCDMReport = false;
        this.updateCountyFocusCJAMSReport = false;
        this.updateCountyResolutionReport = false;
        this.updateCountyFixtypeReport = false;
        this.updateCountyJiraReport = false;
        this.updateTeamReport = false;
        this.updateStateReport = false;
        this.updateCountyCDMReport = false;
        this.getcountyticketcounts();
    }

    private getcountyticketcounts() {
        const filter = this.reportForm.getRawValue();   
        filter.application = 'CW';
        this.countyticketstatuscounts = [];
        this.countyrelatedcounts = [];
        this.countyjirastatuscounts = [];
        this.teamticketstatuscounts = [];
        this.teamrelatedcounts = [];
        this.teamjirastatuscounts = [];
        this.noCountyteamReport = false;
        this.noCountyReport = false;
        this.noCountyJiraReport = false;
        this.noStateReport = false;
        if (filter.ldssregion == ''){
            this.chartCounty = false;
        } else {
            this.chartCounty = true;
        }
        
        this._service
			.getPagedArrayList(
				new PaginationRequest({
					where: {
						filter: filter,
					},
					method: 'post'
				}),
				'supportlog/getcountyticketcounts'
			)
			.subscribe(response => {
                const res = response.data ? response.data : null;
                if (!res || res.length === 0) {
                    return;
                }

                // if (res && res.length>0){
/////////////////////////***********   COUNTY REPORTS START  ********************/                    
                    const date_diff = res[0].date_diff ? res[0].date_diff : 99;
                    this.getcountyticketcountsCond1Fn(res, filter, date_diff);

/////////////////////////***********   TEAM REPORTS START  ********************/
                    this.getcountyticketcountsCond2Fn(res, filter, date_diff);

                // }
            }, err => {
                // No data or function to call or add
            });
            setTimeout(() => {
                this.inprogress$ = of(false);
            }, 3000);
    }

    // Assosiated with getcountyticketcounts function
    private getcountyticketcountsCond2Fn(res: any[], filter: any, date_diff: any) {
        this.handleTeamticketstatuscountsFn(res);

        this.handleTeamfocusCDMcountsFn(res);

        this.handleTeamfocusCJAMScountsFn(res);

        this.handleTeamresolutioncountsFn(res);

        this.handleTeamfixtypecountsFn(res);

        this.handleTeamjirastatuscountsFn(res);

        this.handleTeamworkerticketcountsFn(res);

        this.handleTeamincidentopenclosecountsFn(res);

        this.checkFromdateFromFilterFn(filter);

        this.handleTeamticketcreatedcountsFn(res);
        if (date_diff > 31) {
            this.teamCDMCountReport.title.text = 'Incidents By Month As Of ' + this.effectiveDate + ' 11:00 PM';
        } else {
            this.teamCDMCountReport.title.text = 'Incidents By Days As Of ' + this.effectiveDate + ' 11:00 PM';
        }

        this.handleTeamincidentcountsFn(res);
        if (date_diff > 31) {
            this.teamIncidentCountReport.title.text = this.ticketsbymonthlabel;
        } else {
            this.teamIncidentCountReport.title.text = 'Tickets By Days';
        }

        this.handleStatecountyticketcountsFn(res);
    }

    private handleStatecountyticketcountsFn(res: any[]) {
        if (res[0].statecountyticketcounts && res[0].statecountyticketcounts.length > 0) {
            const statelist = [];
            const stateApprovedlist = [];
            const statePendinglist = [];
            const stateRejectedlist = [];
            for (const item of res[0].statecountyticketcounts) {
                statelist.push(item.ldssregion);
                stateApprovedlist.push(item.approvedcount);
                statePendinglist.push(item.pendingcount);
                stateRejectedlist.push(item.rejectedcount);
            }
            this.stateReport.xAxis.categories = statelist;
            const series = [];
            let seriesItem = {
                name: 'Approved',
                data: stateApprovedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Rejected',
                data: stateRejectedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.pendingapprovallabel,
                data: statePendinglist
            };
            series.push(seriesItem);
            this.stateReport.series = series;
            this.noStateReport = false;
        } else {
            this.noStateReport = true;
        }
        this.updateStateReport = true;
    }

    private handleTeamincidentcountsFn(res: any[]) {
        if (res[0].teamincidentcounts && res[0].teamincidentcounts.length > 0) {
            const ticketcountlist = [];
            const ticketApprovedCountlist = [];
            const ticketPendingCountlist = [];
            const ticketRejectedCountlist = [];
            const ticketTotalCountlist = [];
            for (const item of res[0].teamincidentcounts) {
                ticketcountlist.push(item.ticketmonth);
                ticketApprovedCountlist.push(item.approvedcount);
                ticketPendingCountlist.push(item.pendingcount);
                ticketRejectedCountlist.push(item.rejectedcount);
                ticketTotalCountlist.push(item.totalcount);
            }
            this.teamIncidentCountReport.xAxis.categories = ticketcountlist;
            const series = [];
            let seriesItem = {
                name: 'Approved',
                data: ticketApprovedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Rejected',
                data: ticketRejectedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.pendingapprovallabel,
                data: ticketPendingCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Total Tickets',
                data: ticketTotalCountlist
            };
            series.push(seriesItem);
            this.teamIncidentCountReport.series = series;
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.updateTeamReport = true;
    }

    private handleTeamticketcreatedcountsFn(res: any[]) {
        if (res[0].teamticketcreatedcounts && res[0].teamticketcreatedcounts.length > 0) {
            const ticketcountlist = [];
            const ticketApprovedCountlist = [];
            const ticketCDMCountlist = [];
            for (const item of res[0].teamticketcreatedcounts) {
                ticketcountlist.push(item.ticketmonth);
                ticketApprovedCountlist.push(item.approvedcount);
                ticketCDMCountlist.push(item.acceptedcount);
            }
            this.teamCDMCountReport.xAxis.categories = ticketcountlist;
            const series = [];
            let seriesItem = {
                name: this.totalincidentscreatedlabel,
                data: ticketApprovedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.totaldefectscreated,
                data: ticketCDMCountlist
            };
            series.push(seriesItem);
            this.teamCDMCountReport.series = series;
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.updateTeamReport = true;
    }

    private handleTeamincidentopenclosecountsFn(res: any[]) {
        if (res[0].teamincidentopenclosecounts && res[0].teamincidentopenclosecounts.length > 0) {
            const timeperiodlist = [];
            const teamWorkerOpenlist = [];
            const teamWorkerClosedlist = [];

            for (const item of res[0].teamincidentopenclosecounts) {
                timeperiodlist.push(item.ticketmonth);
                teamWorkerOpenlist.push(item.opencount);
                teamWorkerClosedlist.push(item.closedcount);
            }
            this.teamIncidentOpenCloseCountReport.xAxis.categories = timeperiodlist;
            const series = [];
            let seriesItem = {
                name: 'Open',
                data: teamWorkerOpenlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Closed',
                data: teamWorkerClosedlist
            };
            series.push(seriesItem);
            this.teamIncidentOpenCloseCountReport.series = series;
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.updateTeamReport = true;
    }

    private handleTeamworkerticketcountsFn(res: any[]) {
        if (res[0].teamworkerticketcounts && res[0].teamworkerticketcounts.length > 0) {
            const teamworkerlist = [];
            const teamWorkerApprovedlist = [];
            const teamWorkerPendinglist = [];
            const teamWorkerRejectedlist = [];

            for (const item of res[0].teamworkerticketcounts) {
                teamworkerlist.push(item.displayname);
                teamWorkerApprovedlist.push(item.approvedcount);
                teamWorkerPendinglist.push(item.pendingcount);
                teamWorkerRejectedlist.push(item.rejectedcount);
            }
            this.teamWorkerIncidentCountReport.xAxis.categories = teamworkerlist;
            const series = [];
            let seriesItem = {
                name: 'Approved',
                data: teamWorkerApprovedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Rejected',
                data: teamWorkerRejectedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.pendingapprovallabel,
                data: teamWorkerPendinglist
            };
            series.push(seriesItem);
            this.teamWorkerIncidentCountReport.series = series;
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.updateTeamReport = true;
        this.teamWorkerIncidentCountReport.title.text = 'Tickets By Worker';
    }

    private handleTeamjirastatuscountsFn(res: any[]) {
        this.teamjirastatuscounts = [];
        if (res[0].teamjirastatuscounts && res[0].teamjirastatuscounts.length > 0) {
            for (const item of res[0].teamjirastatuscounts) {
                const ticket = {
                    name: item.status,
                    y: item.ticketcount
                };
                this.teamjirastatuscounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamJiraStatusReport.series[0].data = JSON.parse(JSON.stringify(this.teamjirastatuscounts));
        this.teamJiraStatusReport.title.text = 'JIRA Incidents By Status As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateTeamReport = true;
    }

    private handleTeamfixtypecountsFn(res: any[]) {
        this.teamrelatedcounts = [];
        if (res[0].teamfixtypecounts && res[0].teamfixtypecounts.length > 0) {
            for (const item of res[0].teamfixtypecounts) {
                const ticket = {
                    name: item.fixtype,
                    y: item.ticketcount
                };
                this.teamrelatedcounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamFixtypeReport.series[0].data = JSON.parse(JSON.stringify(this.teamrelatedcounts));
        this.teamFixtypeReport.title.text = 'Tickets By Fix Type As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateTeamReport = true;
    }

    private handleTeamresolutioncountsFn(res: any[]) {
        this.teamrelatedcounts = [];
        if (res[0].teamresolutioncounts && res[0].teamresolutioncounts.length > 0) {
            for (const item of res[0].teamresolutioncounts) {
                const ticket = {
                    name: item.resolution,
                    y: item.ticketcount
                };
                this.teamrelatedcounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamResolutionReport.series[0].data = JSON.parse(JSON.stringify(this.teamrelatedcounts));
        this.teamResolutionReport.title.text = 'Tickets By Resolution As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateTeamReport = true;
    }

    private handleTeamfocusCDMcountsFn(res: any[]) {
        this.teamrelatedcounts = [];
        this.totalFocusCDMCounts = 0;
        if (res[0].teamfocuscdmcounts && res[0].teamfocuscdmcounts.length > 0) {
            for (const item of res[0].teamfocuscdmcounts) {
                this.totalFocusCDMCounts = this.totalFocusCDMCounts + item.ticketcount;
                const ticket = {
                    name: item.focus,
                    y: item.ticketcount
                };
                this.teamrelatedcounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamFocusCDMReport.series[0].data = JSON.parse(JSON.stringify(this.teamrelatedcounts));
        this.teamFocusCDMReport.subtitle.text = 'Total - ' + this.totalFocusCDMCounts;
        this.updateTeamReport = true;
    }

    private handleTeamfocusCJAMScountsFn(res: any[]) {
        this.totalFocusCJAMSCounts = 0;
        this.teamrelatedcounts = [];
        if (res[0].teamfocuscjamscounts && res[0].teamfocuscjamscounts.length > 0) {
            for (const item of res[0].teamfocuscjamscounts) {
                this.totalFocusCJAMSCounts = this.totalFocusCJAMSCounts + item.ticketcount;
                const ticket = {
                    name: item.focus,
                    y: item.ticketcount
                };
                this.teamrelatedcounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamFocusCJAMSReport.series[0].data = JSON.parse(JSON.stringify(this.teamrelatedcounts));
        this.teamFocusCJAMSReport.subtitle.text = 'Total - ' + this.totalFocusCJAMSCounts;
        this.updateTeamReport = true;
    }

    private handleTeamticketstatuscountsFn(res: any[]) {
        this.teamticketstatuscounts = [];
        if (res[0].teamticketstatuscounts && res[0].teamticketstatuscounts.length > 0) {
            for (const item of res[0].teamticketstatuscounts) {
                const ticket = {
                    name: item.ticketstatus,
                    y: item.ticketcount
                };
                this.teamticketstatuscounts.push(ticket);
            }
            this.noTeamReport = false;
        } else {
            this.noTeamReport = true;
        }
        this.teamApprovalReport.series[0].data = JSON.parse(JSON.stringify(this.teamticketstatuscounts));
        this.updateTeamReport = true;
    }

    // Assosiated with getcountyticketcounts function
    private getcountyticketcountsCond1Fn(res: any[], filter: any, date_diff: any) {
        this.handleCountyticketstatuscountsFn(res);

        this.handleCountyfocusCDMcountsFn(res);

        this.handleCountyfocusCJAMScountsFn(res);

        this.handleCountyresolutioncountsFn(res);

        this.handleCountyfixtypecountsFn(res);

        this.handleCountyjirastatuscountsFn(res);

        this.handleCountyteamticketcountsFn(res);

        this.handleCountyincidentopenclosecountsFn(res, filter);

        this.handleCountyticketcreatedcountsFn(res);

        if (date_diff > 31) {
            this.countyCDMCountReport.title.text = 'JIRA Incidents By Month As Of ' + this.effectiveDate + ' 11:00 PM';
        } else {
            this.countyCDMCountReport.title.text = 'JIRA Incidents By Days As Of ' + this.effectiveDate + ' 11:00 PM';
        }

        this.handleCountyincidentcountsFn(res);

        if (date_diff > 31) {
            this.countyIncidentCountReport.title.text = this.ticketsbymonthlabel;
        } else {
            this.countyIncidentCountReport.title.text = 'Tickets By Days';
        }
    }

    private checkFromdateFromFilterFn(filter: any) {
        if (filter.fromdate) {
            const fromdate = new Date(filter.fromdate);
            const formattedFromdate = moment(fromdate).format(this.dtformat);
            let todate = new Date();
            if (filter.todate) {
                todate = new Date(filter.todate);
            }
            const formattedTodate = moment(todate).format(this.dtformat);
            this.teamIncidentOpenCloseCountReport.title.text = 'Incidents (Open/Closed) Between ' +
                formattedFromdate + ' & ' +
                formattedTodate + ' As Of ' +
                this.effectiveDate + ' 11:00 PM';
        } else {
            this.teamIncidentOpenCloseCountReport.title.text = 'Incidents (Open/Closed) As Of ' + this.effectiveDate + ' 11:00 PM';
        }
    }

    private handleCountyincidentcountsFn(res: any[]) {
        if (res[0].countyincidentcounts && res[0].countyincidentcounts.length > 0) {
            const ticketcountlist = [];
            const ticketApprovedCountlist = [];
            const ticketPendingCountlist = [];
            const ticketRejectedCountlist = [];
            const ticketTotalCountlist = [];
            for (const item of res[0].countyincidentcounts) {
                ticketcountlist.push(item.ticketmonth);
                ticketApprovedCountlist.push(item.approvedcount);
                ticketPendingCountlist.push(item.pendingcount);
                ticketRejectedCountlist.push(item.rejectedcount);
                ticketTotalCountlist.push(item.totalcount);
            }
            this.countyIncidentCountReport.xAxis.categories = ticketcountlist;
            const series = [];
            let seriesItem = {
                name: 'Approved',
                data: ticketApprovedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Rejected',
                data: ticketRejectedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.pendingapprovallabel,
                data: ticketPendingCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Total Tickets',
                data: ticketTotalCountlist
            };
            series.push(seriesItem);
            this.countyIncidentCountReport.series = series;
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.updateCountyReport = true;
    }

    private handleCountyticketcreatedcountsFn(res: any[]) {
        if (res[0].countyticketcreatedcounts && res[0].countyticketcreatedcounts.length > 0) {
            const ticketcountlist = [];
            const ticketApprovedCountlist = [];
            const ticketCDMCountlist = [];
            for (const item of res[0].countyticketcreatedcounts) {
                ticketcountlist.push(item.ticketmonth);
                ticketApprovedCountlist.push(item.approvedcount);
                ticketCDMCountlist.push(item.acceptedcount);
            }
            this.countyCDMCountReport.xAxis.categories = ticketcountlist;
            const series = [];
            let seriesItem = {
                name: this.totalincidentscreatedlabel,
                data: ticketApprovedCountlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.totaldefectscreated,
                data: ticketCDMCountlist
            };
            series.push(seriesItem);
            this.countyCDMCountReport.series = series;
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.updateCountyCDMReport = true;
    }

    private handleCountyincidentopenclosecountsFn(res: any[], filter: any) {
        if (res[0].countyincidentopenclosecounts && res[0].countyincidentopenclosecounts.length > 0) {
            const timeperiodlist = [];
            const teamOpenlist = [];
            const teamClosedlist = [];
            for (const item of res[0].countyincidentopenclosecounts) {
                timeperiodlist.push(item.ticketmonth);
                teamOpenlist.push(item.opencount);
                teamClosedlist.push(item.closedcount);
            }
            this.countyIncidentOpenCloseCountReport.xAxis.categories = timeperiodlist;
            const series = [];
            let seriesItem = {
                name: 'Open',
                data: teamOpenlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Closed',
                data: teamClosedlist
            };
            series.push(seriesItem);
            this.countyIncidentOpenCloseCountReport.series = series;
            if (filter.fromdate) {
                const fromdate = new Date(filter.fromdate);
                const formattedFromdate = moment(fromdate).format(this.dtformat);
                let todate = new Date();
                if (filter.todate) {
                    todate = new Date(filter.todate);
                }
                const formattedTodate = moment(todate).format(this.dtformat);
                this.countyIncidentOpenCloseCountReport.title.text = 'Incidents (Open/Closed) Between ' +
                    formattedFromdate + ' & ' +
                    formattedTodate + ' As Of ' +
                    this.effectiveDate + ' 11:00 PM';
            } else {
                this.countyIncidentOpenCloseCountReport.title.text = 'Incidents (Open/Closed) As Of ' + this.effectiveDate + ' 11:00 PM';
            }


            this.noCountyteamReport = false;
        } else {
            this.noCountyteamReport = true;
        }
        this.updateCountyReport = true;
    }

    private handleCountyteamticketcountsFn(res: any[]) {
        if (res[0].countyteamticketcounts && res[0].countyteamticketcounts.length > 0) {
            const teamlist = [];
            const teamApprovedlist = [];
            const teamPendinglist = [];
            const teamRejectedlist = [];
            for (const item of res[0].countyteamticketcounts) {
                teamlist.push(item.teamname);
                teamApprovedlist.push(item.approvedcount);
                teamPendinglist.push(item.pendingcount);
                teamRejectedlist.push(item.rejectedcount);
            }
            this.countyTeamIncidentCountReport.xAxis.categories = teamlist;
            const series = [];
            let seriesItem = {
                name: 'Approved',
                data: teamApprovedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: 'Rejected',
                data: teamRejectedlist
            };
            series.push(seriesItem);
            seriesItem = {
                name: this.pendingapprovallabel,
                data: teamPendinglist
            };
            series.push(seriesItem);
            this.countyTeamIncidentCountReport.series = series;
            this.noCountyteamReport = false;
        } else {
            this.noCountyteamReport = true;
        }
        this.updateCountyReport = true;
    }

    private handleCountyjirastatuscountsFn(res: any[]) {
        this.countyjirastatuscounts = [];
        if (res[0].countyjirastatuscounts && res[0].countyjirastatuscounts.length > 0) {
            for (const item of res[0].countyjirastatuscounts) {
                const ticket = {
                    name: item.status,
                    y: item.ticketcount
                };
                this.countyjirastatuscounts.push(ticket);
            }
            this.noCountyJiraReport = false;
        } else {
            this.noCountyJiraReport = true;
        }
        this.countyJiraStatusReport.series[0].data = JSON.parse(JSON.stringify(this.countyjirastatuscounts));
        this.countyJiraStatusReport.title.text = 'JIRA Incidents By Status As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateCountyJiraReport = true;
    }

    private handleCountyfixtypecountsFn(res: any[]) {
        this.countyrelatedcounts = [];
        if (res[0].countyfixtypecounts && res[0].countyfixtypecounts.length > 0) {
            for (const item of res[0].countyfixtypecounts) {
                const ticket = {
                    name: item.fixtype,
                    y: item.ticketcount
                };
                this.countyrelatedcounts.push(ticket);
            }
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.countyFixtypeReport.series[0].data = JSON.parse(JSON.stringify(this.countyrelatedcounts));
        this.countyFixtypeReport.title.text = 'Tickets By Fix Type As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateCountyFixtypeReport = true;
    }

    private handleCountyresolutioncountsFn(res: any[]) {
        this.countyrelatedcounts = [];
        if (res[0].countyresolutioncounts && res[0].countyresolutioncounts.length > 0) {
            for (const item of res[0].countyresolutioncounts) {
                const ticket = {
                    name: item.resolution,
                    y: item.ticketcount
                };
                this.countyrelatedcounts.push(ticket);
            }
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.countyResolutionReport.series[0].data = JSON.parse(JSON.stringify(this.countyrelatedcounts));
        this.countyResolutionReport.title.text = 'Tickets By Resolution As Of ' + this.effectiveDate + ' 11:00 PM';
        this.updateCountyResolutionReport = true;
    }

    private handleCountyfocusCDMcountsFn(res: any[]) {
        this.countyrelatedcounts = [];
        this.totalFocusCDMCounts = 0;
        if (res[0].countyfocuscdmcounts && res[0].countyfocuscdmcounts.length > 0) {
            for (const item of res[0].countyfocuscdmcounts) {
                this.totalFocusCDMCounts = this.totalFocusCDMCounts + item.ticketcount;
                const ticket = {
                    name: item.focus,
                    y: item.ticketcount
                };
                this.countyrelatedcounts.push(ticket);
            }
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.countyFocusCDMReport.series[0].data = JSON.parse(JSON.stringify(this.countyrelatedcounts));
        this.countyFocusCDMReport.subtitle.text = 'Total - ' + this.totalFocusCDMCounts;
        this.updateCountyFocusCDMReport = true;
    }

    private handleCountyfocusCJAMScountsFn(res: any[]) {
        this.totalFocusCJAMSCounts = 0;
        this.countyrelatedcounts = [];
        if (res[0].countyfocuscjamscounts && res[0].countyfocuscjamscounts.length > 0) {
            for (const item of res[0].countyfocuscjamscounts) {
                this.totalFocusCJAMSCounts = this.totalFocusCJAMSCounts + item.ticketcount;
                const ticket = {
                    name: item.focus,
                    y: item.ticketcount
                };
                this.countyrelatedcounts.push(ticket);
            }
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.countyFocusCJAMSReport.series[0].data = JSON.parse(JSON.stringify(this.countyrelatedcounts));
        this.countyFocusCJAMSReport.subtitle.text = 'Total - ' + this.totalFocusCJAMSCounts;
        this.updateCountyFocusCJAMSReport = true;
    }

    private handleCountyticketstatuscountsFn(res: any[]) {
        this.countyticketstatuscounts = [];
        if (res[0].countyticketstatuscounts && res[0].countyticketstatuscounts.length > 0) {
            for (const item of res[0].countyticketstatuscounts) {
                const ticket = {
                    name: item.ticketstatus,
                    y: item.ticketcount
                };
                this.countyticketstatuscounts.push(ticket);
            }
            this.noCountyReport = false;
        } else {
            this.noCountyReport = true;
        }
        this.countyApprovalReport.series[0].data = JSON.parse(JSON.stringify(this.countyticketstatuscounts));
        this.updateCountyReport = true;
    }

    chartType(type: any){
        const county = this.reportForm.getRawValue().ldssregion;
        this.reportForm.reset();
        this.reportForm.patchValue({
            ldssregion:county !='' ? county : this.countyname,
            chartType: type
        });
        this.countyChart = false;
        this.teamChart = false;

        if (type == 'county') {
            this.countyChart = true;
        }

        if (type == 'team') {
            this.getteamlist(this.countyname)
            this.reportForm.patchValue({
                ldssregion:this.countyname,
                teamid: this.teamid
            });
            this.teamChart = true;
        }
        this.getcountyticketcounts();
    }

    formatDate(inputdate: any) {
        if (inputdate) {
            const d = new Date(inputdate),
            year = d.getFullYear();
            let month = '' + (d.getMonth() + 1),
            day = '' + d.getDate();
            if (month.length < 2) {month = '0' + month;}
            if (day.length < 2) {day = '0' + day;}
            return [month, day, year].join('/');
        }
        else {
            return '';
        }
    }

    startDateChanged(idx: number){
        if (idx == 1) {
            const startDate = this.searchForm.getRawValue().fromdate;
            if (startDate) {
                this.minDate1 = new Date(startDate);
            }
        }

        if (idx == 2) {
            const startDate = this.reportForm.getRawValue().fromdate;
            if (startDate) {
                this.minDate2 = new Date(startDate);
            }
        }
    }
    generateDocument(doctype: any) {
        this.filter.doctype = doctype;
        this._service.download(CommonUrlConfig.EndPoint.REPORTS.SUPERVISOR.GENERATE + 'contactsupport', JSON.stringify(this.filter)).subscribe(res => {
            const blob = new Blob([new Uint8Array(res)]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = `Contact_Support_Tickets.` + doctype;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    }
}