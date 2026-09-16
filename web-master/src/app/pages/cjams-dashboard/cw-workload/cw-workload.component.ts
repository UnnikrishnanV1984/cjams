
import {map} from 'rxjs/operators';
import { Component, OnInit, OnDestroy, Injector } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { Workload } from './workload.data.model';
import { FormGroup, FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DataStoreService } from '../../../@core/services/data-store.service';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { SessionStorageService, LocalStorageService } from '../../../@core/services/storage.service';
import { PaginationInfo, PaginationRequest, DropdownModel } from '../../../@core/entities/common.entities';
// Highcharts imports
// import * as Highcharts from 'highcharts';
// import Highcharts from 'highcharts';
// import 'highcharts/modules/exporting';
import { HighchartsChartModule } from 'highcharts-angular';

import { AppUser } from '../../../@core/entities/authDataModel';
import { AuthService } from '../../../@core/services';
import { Observable } from 'rxjs';
import { ExcelService } from '../../home-dashboard/excel.service';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import moment from 'moment';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';
declare var require: any;

@Component({
    selector: 'cw-workload',
    templateUrl: './cw-workload.component.html',
    styleUrls: ['./cw-workload.component.scss'],
    imports:[SortTableModule, MatSortModule,HighchartsChartModule,PaginationModule,FormsModule,CommonModule,MatDatepickerModule,MatFormFieldModule,MatInputModule,MatSelectModule,ReactiveFormsModule],
    providers:[ExcelService],
    standalone: true
})

export class CwWorkloadComponent implements OnInit, OnDestroy {
  subscriber: any = [];
  endpointUrl!: string;
  currentUrl!: string;
  paginationInfo: PaginationInfo = new PaginationInfo();
  casepaginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  workloadList: Workload[] = [];
  workloadForm!: FormGroup;
  Highcharts: any;
  roleDetails!: AppUser;
  workloadsearch!: boolean
  unitdropdownValue!: boolean;
  workerdropdownValue!: boolean;
  caseType$!: Observable<DropdownModel[]>;
  statisticsrequest!: Object;
  inputRequestXLDoc!: Object;
  showXLIcon!: boolean;
  isShowPiChart!: boolean | undefined;
  showWorkLoadTable: boolean = true;
  showPagination: boolean = true;
  chartCallback = function () {
    // No content or data to add or call
  };
  user: any;
  caseWorkerList: any;
  teamList: any;
  departmentList: any;
  chart: any;
  chart1: any;
  chartPreset: any = {
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      type: 'pie',
      backgroundColor: 'rgba(255, 255, 255, 0.0)'
    },
    title: {
      text: 'Case Statistics',
      style: {
        color: '#330325'
      }
    },
    credits: {
      enabled: false
    },
    subtitle: {
      text: '',
      style: {
        color: '#3e99cc',
        fontWeight: 'bold',
        letterSpacing: '0.3px'
      }
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.y}</b>'
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '<b>{point.name}</b>: {point.percentage:.1f} %',
          style: {
            color: 'black'
          }
        },
        colors: undefined,
        showInLegend: true
      }
    },
    series: [{
      name: 'Cases',
      colorByPoint: true,
      data: []
    }]
  };
  chartPreset1: any = {
    chart: {
      // type: 'variablepie',
      type: 'pie',
      backgroundColor: 'rgba(255, 255, 255, 0.0)'
    },
    title: {
      text: '',
      style: {
        color: '#330325'
      }
    },
    credits: {
      enabled: false
    },
    tooltip: {
      headerFormat: '',
      pointFormat: '<span style="color:{point.color}">\u25CF</span> <b> {point.name}</b><br/>' +
        'Opened: <b>{point.y}</b><br/>' +
        'Closed: <b>{point.z}</b><br/>'
    },
    plotOptions: {
      pie: {
      // variablepie: {
        colors: undefined,
        showInLegend: true
      }
    },
    series: [{
      minPointSize: 10,
      innerSize: '20%',
      zMin: 0,
      name: 'Cases',
      data: []
    }]
  }
  drilldowndata: any = {
    departmentList: undefined,
    teamList: undefined,
    workerList: undefined,
    caseList: undefined,
    activeids: {
      department: undefined,
      team: undefined,
      worker: undefined
    },
    activenames: {
      department: undefined,
      team: undefined
    }
  };
  casetotalRecords: any;
  workerName: string | null | undefined = null;
  parentteamid: string | null | undefined = null;
  teamtypekey: any;
  ipaduser: boolean = false;

  private _commonService: CommonHttpService;
    private _formBuilder: FormBuilder;
    private _dataStoreService: DataStoreService;
    private _session: SessionStorageService;
    private _localstorage: LocalStorageService;
    private _authService: AuthService;
    private excelService: ExcelService;
    private _intakeUtils: IntakeUtils;

  constructor(private injector: Injector){
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._localstorage = this.injector.get<LocalStorageService>(LocalStorageService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.excelService = this.injector.get<ExcelService>(ExcelService);
    this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
   }

  getworkloadassignmentsurl = 'Caseassignments/getworkloadassignments?filter';
  servicecase = 'service case';
  caseworkerpageurl = '#/pages/case-worker/';
  async ngOnInit() {
    const hc = await import('highcharts');
    this.Highcharts = hc.default;
    const user = this._authService.getCurrentUser();
    this.parentteamid = '';
    const actualuser = user.user;
    if (actualuser.userprofile
            && actualuser.userprofile.teammemberassignment
            && actualuser.userprofile.teammemberassignment.teammember.team
            &&  actualuser.userprofile.teammemberassignment.teammember.team.countyid ) {
            this.parentteamid = actualuser.userprofile.teammemberassignment.teammember.team.parentteamid;
    }
    this.paginationInfo.sortColumn = 'startdate';
    this.paginationInfo.sortBy = 'desc';
    this.roleDetails = this._authService.getCurrentUser();
    if(this.roleDetails && this.roleDetails.role && this.roleDetails.role.teamtypekey){
      this.teamtypekey = this.roleDetails.role.teamtypekey;
    }
    if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
      this.ipaduser = true;
    }
    this.user = this._localstorage.getObj('userProfile');
    this.casepaginationInfo.pageSize = 50;
    this.workloadForm = this._formBuilder.group({
      servicecasenumber: null,
      localdeptid: [''],
      teamid: [null],
      toworkerid: [null],
      startdate: [null],
      enddate: [null],
      statuscode: [null],
      casetype: [null]
    });
    this.getworkerlist();
    this.getDrilldownData(null, 'getAllDepartment');
    this.getchartready();
    this.getCaseTypeList();
    this.getCountyList();
  }
  getchartready() {

    const color1 = ['#C70039', '#581845', '#eeac99', '#5E4AEB', '#57FEFF', '#EB926C', '#6EF4FF', '#67EB50', '#FFE989', '#F87DFF'];
    const brightcolor1 = this.increasebrightness(color1, 50);
    this.chartPreset.plotOptions.pie.colors = color1.map((col, i) => {
      return {
        radialGradient: { cx: 0.5, cy: 0.5, r: 0.2 },
        stops: [
          [0, brightcolor1[i]],
          [1, col] // darken
        ]
      };
    });
    const color2 = ['#c94c4c', '#eea29a', '#b1cbbb', '#deeaee', '#FF9655', '#FFF263', '#6AF9C4', '#ED561B'];
    const brightcolor2 = this.increasebrightness(color2, 50);
    // this.chartPreset1.plotOptions.variablepie.colors = color2.map((col, i) => {
    this.chartPreset1.plotOptions.pie.colors = color2.map((col, i) => {

      return {
        radialGradient: { cx: 0.5, cy: 0.5, r: 0.2 },
        stops: [
          [0, brightcolor2[i]],
          [1, col] // darken
        ]
      };
    });
  }
  getCaseTypeList() {
    this.caseType$ = this._commonService.getArrayList({
      where: { referencetypeid: '752', teamtypekey: 'CW'},
      method: 'get'
    }, 'referencetype/gettypes?filter').pipe(map((item) => {
      return item.map((res) =>
      new DropdownModel({
        text: res.description,
        value: res.value_text
      }));
    }));
  }
  increasebrightness(hex: any, percent: number) {
    return hex.map((v: string) => {
      // strip the leading # if it's there
      v = v.replace(/^\s*#|\s*$/g, '');

      // convert 3 char codes --> 6, e.g. `E0F` --> `EE00FF`
      if (v.length == 3) {
        v = v.replace(/(.)/g, '$1$1');
      }

      var r = parseInt(v.substr(0, 2), 16),
        g = parseInt(v.substr(2, 2), 16),
        b = parseInt(v.substr(4, 2), 16);

      return '#' +
        ((0 | (1 << 8) + r + (256 - r) * percent / 100).toString(16)).substr(1) +
        ((0 | (1 << 8) + g + (256 - g) * percent / 100).toString(16)).substr(1) +
        ((0 | (1 << 8) + b + (256 - b) * percent / 100).toString(16)).substr(1);
    });
  }

  getWorkloadList(selectPage: number, type: boolean, showChart?: boolean) {
    this.paginationInfo.pageNumber = selectPage;
    if (!type) {
      this.casepaginationInfo.pageNumber = selectPage;
    }
    const request = Object.assign({
      sortcolumn: this.paginationInfo.sortColumn,
      sortorder: this.paginationInfo.sortBy,
      casetype: this.workloadForm.value.casetype === '' ? null : this.workloadForm.value.casetype,
      userid: this.roleDetails.user.userprofile.securityusersid
    }, this.workloadForm.value);
  
    this.subscriber[0] = this._commonService.getPagedArrayList({
      where: type ? request : Object.assign({
        sortcolumn: this.paginationInfo.sortColumn,
      sortorder: this.paginationInfo.sortBy,
      userid: this.roleDetails.user.userprofile.securityusersid
      }, this.statisticsrequest),
      method: 'get',
      limit: 20,
      page: selectPage,
    },
      this.getworkloadassignmentsurl
    ).subscribe((result) => {
      if (!showChart) {
        this.isShowPiChart = !type;
      }
      this.workloadList = result.data;
      this.workloadList.forEach((v: any) => {
        if (v.legalguardian && v.legalguardian.length) {   // NOSONAR
          v.legalguardian = v.legalguardian.map((x: { personname: any; }) => x.personname).join(', ');    
        } else {
          v.legalguardian = '';
        }
      });
      if (this.paginationInfo.pageNumber === 1) {
        this.totalRecords = result.count;
        this.casetotalRecords = result.count;
      }
    });
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.getWorkloadList(this.paginationInfo.pageNumber, true);
  }

  routeToCaseWorker(item: any) {
    this.clearStoreValue();
    this._session.setItem('cpsSkipApproval', 'false');
    this._session.setTabKeyKey(item.servicecasenumber);
    if (item.casetype.toLowerCase() === 'intake') {
      this._intakeUtils.redirectIntake(item.servicecasenumber);
    } else {
        if (item.casetype.toLowerCase()==='servicecase' || item.actiontype.toLowerCase() === this.servicecase) {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
      } else {
        this._session.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, false);
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
      }
      if (item.casetype.toLowerCase() === 'servicecase'  || item.actiontype.toLowerCase() === this.servicecase) {
        this.endpointUrl = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecaseid + '/casetype';
      } else {
        this.endpointUrl = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecasenumber;
      }
      if (item.casetype.toLowerCase() ===  'adoptioncase') {
            this._session.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, CASE_TYPE_CONSTANTS.ADOPTION);
            this._session.setItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID, item.adoptionplanningid);
            this._session.setItem(CASE_STORE_CONSTANTS.Adoption_START_DATE, item.startdate);
            this._session.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
            this.endpointUrl = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.servicecasenumber;
    }
      this.getServicecaseDataApiFn(item);
    }
  }
  // Associated with routeToCaseWorker function
  private getServicecaseDataApiFn(item: any) {
    this.subscriber[1] = this._commonService.getAll(this.endpointUrl).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
        if (dsdsActionsSummary.teamtypekey) {
          this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
        } else {
          this._dataStoreService.setData('teamtypekey', 'CW');
        }
        if (item.casetype.toLowerCase() === 'servicecase' || item.actiontype.toLowerCase() === this.servicecase) {
          this.currentUrl = this.caseworkerpageurl + item.servicecaseid + '/' + item.servicecasenumber + '/dsds-action/cw-assignments';
        } else if (item.casetype.toLowerCase() === 'adoptioncase') {
          this.currentUrl = this.caseworkerpageurl + item.servicecaseid + '/' + item.servicecasenumber + '/dsds-action/adoption-persons';
        } else {
          this.currentUrl = this.caseworkerpageurl + item.servicecaseid + '/' + item.servicecasenumber + '/dsds-action/cw-assignments';
        }
        window.open(this.currentUrl);
      }
    });
  }

  getworkerlist() {
    this.subscriber[2] = this._commonService.getPagedArrayList(new PaginationRequest({ where: { appevent: 'INVR' }, method: 'post' }), 'Intakedastagings/getroutingusers')
      .subscribe(result => {
        this.caseWorkerList = result.data;
        this.caseWorkerList = this.caseWorkerList.filter((res: { issupervisor: any; agencykey: string; }) => !res.issupervisor && res.agencykey === 'CW');
      });
  }
  getdepartmentlist() {
    this.subscriber[6] = this._commonService.getPagedArrayList(new PaginationRequest({
      where: { activeflag: 1, teamtypekey: 'LDSS' },
      method: 'get', nolimit: true
    }), 'manage/team/list?filter').subscribe((result) => {
      this.departmentList = result.data;
      if (!this.unitdropdownValue) {
        this.workloadForm.controls['statuscode'].patchValue('open');
        if (this.roleDetails.user.userprofile.teammemberassignment.teammember.team.teamtypekey !== 'LDSS') {
          const parentteamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.parentteamid;
          this.workloadForm.controls['localdeptid'].patchValue(parentteamid);
        } else {
          const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
          this.workloadForm.controls['localdeptid'].patchValue(teamid);
        }
      }
      this.getteamlist();
    });
  }
  getCountyList() {
    this._commonService.create({ where: {},
      order: 'countyname',
      nolimit: true,
    }, 'admin/county/countylist').subscribe((item) => {
      this.departmentList = item;
      if (!this.unitdropdownValue) {
        this.workloadForm.controls['statuscode'].patchValue('open');
        if (this.roleDetails.user.userprofile.teammemberassignment.teammember.team.teamtypekey !== 'LDSS') {
          const parentteamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.countyid;
          this.workloadForm.controls['localdeptid'].patchValue(parentteamid);
        } else {
          const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
          this.workloadForm.controls['localdeptid'].patchValue(teamid);
        }
      }
      this.getteamlist();
    });
  }
  getteamlist() {
    const id = this.workloadForm.get('localdeptid')?.value;
    this.workloadForm.get('teamid')?.patchValue('');
    this.workloadForm.get('toworkerid')?.patchValue('');
    this.workloadForm.get('teamid')?.disable();
    this.workloadForm.get('toworkerid')?.disable();
    
    const obj: any = {
      activeflag: 1
    }
    if (id !== '' && id !== undefined && id !== null) {
      obj['countyid'] = id;
    } else {
      obj['countyid'] = null;
    }
    const typekey = (typeof this.roleDetails.role.teamtypekey === 'string') ? this.user.teamtypekey.toUpperCase() : this.user.teamtypekey;
    obj['teamtypekey'] = this.teamtypekey ? this.teamtypekey : typekey;
    this.subscriber[3] = this._commonService.getPagedArrayList(new PaginationRequest({
      where: obj, method: 'get', nolimit: true
    }
    ), 'manage/team/list?filter')
      .subscribe(result => {
        this.teamList = result.data;
        this.workloadForm.get('teamid')?.enable();
        if (!this.workloadsearch) {
          const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
          this.workloadForm.controls['teamid'].patchValue(teamid);
        }
        this.loadUnitWorkers();
      });
  }
  onSorted(event: any, sortType: boolean) {
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.getWorkloadList(1, sortType);
  }
  loadUnitWorkers() {
    const id = this.workloadForm.get('teamid')?.value;
    this.workloadForm.get('toworkerid')?.patchValue('');
    this.workloadForm.controls['casetype'].patchValue('');
    const obj = {
      teamid: id === '' ? null : id,
      filtertypekey: 'worker',
      inactiveuseractivecaselist : true
    }
    this.subscriber[7] = this._commonService.getPagedArrayList(new PaginationRequest({
      where: obj,
      method: 'get',
      nolimit: true
    }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
      this.caseWorkerList = result;
      this.workloadForm.get('toworkerid')?.enable();
      if (!this.workloadsearch) {
        this.getWorkloadList(1, true);
      }
      this.workloadsearch = true;
      this.unitdropdownValue = true;
      this.workerdropdownValue = true;
    });
  }

  getDrilldownData(data: any, type: any, status?: string) {
    this.chart = undefined;
    this.chart1 = undefined;
    const obj: any = {
    };
    if (type === 'getAllDepartment') {
      this.chartPreset.title.text = 'State wide - case status';
      this.chartPreset.subtitle.text = null;
      this.chartPreset1.title.text = 'Local department wide count';
      obj['filtertype'] = 'ldss';
    } else if (type === 'getDepartmentDetails') {
      this.chartPreset.title.text = 'Local department wide status';
      this.chartPreset.subtitle.text = data.teamname;

      this.chartPreset1.title.text = 'Unit wide count';
      obj['teamid'] = data.teamid;
      obj['filtertype'] = 'team';
      this.drilldowndata.activenames.department = data.teamname;
      this.drilldowndata.activeids.department = data.teamid;
    } else if (type === 'getTeamDetails') {
      this.chartPreset.title.text = 'Unit wide status';
      this.chartPreset.subtitle.text = data.teamname;
      this.chartPreset1.title.text = 'Workers wide count';
      obj['teamid'] = data.toteamid;
      obj['filtertype'] = 'user';
      this.drilldowndata.activenames.team = data.teamname;
      this.drilldowndata.activeids.team = data.toteamid;
    } else if (type === 'getWorkerDetails') {
      const objone = {
        toworkerid: data.toworkeridno,
        teamid: this.drilldowndata.activeids.team,
        statuscode: status
      }
      this.showXLIcon = true;
      this.workerName = data.displayname;
      this.inputRequestXLDoc = Object.assign({ isexport: 1 }, objone);
      this.statisticsrequest = objone;
      this.drilldowndata.activeids.worker = data.toworkeridno;
      this.getWorkloadList(1, false);
    }
    if (type !== 'getWorkerDetails') {
      this.renderDeptTeamUser(obj, type);
    }
  }
  ExportTOExcel(isRequestShow: any) {
    const request = Object.assign({
      sortcolumn: this.paginationInfo.sortColumn,
      sortorder: this.paginationInfo.sortBy,
      casetype: this.workloadForm.value.casetype === '' ? null : this.workloadForm.value.casetype,
      isexport: 1,
    }, this.workloadForm.value);
    this._commonService.getArrayList({
      where: isRequestShow ? request : this.inputRequestXLDoc,
      method: 'get',
    }, this.getworkloadassignmentsurl).subscribe((res: any) => {
      const data= [];
      let index = 0;
      for(const record of res['data']){
        data[index] = {
          'CASE NUMBER' : record.servicecasenumber,
          'CASE TYPE' : record.actiontype,
          'HEAD OF HOUSEHOLD'	 : (record.legalguardian && record.legalguardian.length >0 ? record.legalguardian[0].personname : ''),
          'LOCAL DEPARTMENT' : 	record.localdepartment,
          'UNIT' : 	record.teamname,
          'ASSIGNED BY'	 : record.assignedby,
          'ASSIGNED TO'	 : record.assignedto + ' (' + record.cjamspid + ')',
          'RESPONSIBILITY' : 	record.responsibilitytypekey,
          'START DATE' : 	this.getDateFormatted(record.startdate),
          'END DATE'	 : this.getDateFormatted(record.enddate),
          'STATUS' : record.statustypekey,
        };
        index++;
       }
      this.excelService.exportAsExcelFile(data, 'Reports');
    });
  }
  renderDeptTeamUser(obj: any, type: any) {
    this.subscriber[4] = this._commonService.getArrayList({
      where: obj,
      nolimit: true,
      method: "get",
      limit: 10,
      page: 1
    }, 'Caseassignments/getworkloadassignmentsummary?filter').subscribe((res: any) => {
      if (res.details && res.details.length) {
        const chartdata = [];
        chartdata.push({
          name: 'Closed',
          y: res.summary.closedcnt,
          selected: true,
          sliced: true
        });
        chartdata.push({
          name: 'Opened',
          y: res.summary.opencnt
        });
        if (res.summary.ytscnt) {
          chartdata.push({
            name: 'Pending',
            y: res.summary.ytscnt
          });
        }
        this.chartPreset.series[0].data = [...chartdata];
        this.chart = JSON.parse(JSON.stringify(this.chartPreset));
        this.chartPreset1.series[0].data = res.details.map((x: any) => {
          return {
            name: (x.teamname) ? x.teamname : x.displayname,
            y: x.opencnt,
            z: x.closedcnt
          }
        });
        this.chart1 = JSON.parse(JSON.stringify(this.chartPreset1));
      }
      if (type === 'getAllDepartment') {
        const details = res.details.filter(
          (data: any) => data.teamid === this.parentteamid
        );
        this.drilldowndata.departmentList = details;
      } else if (type === 'getDepartmentDetails') {
        this.drilldowndata.teamList = res.details;
      } else if (type === 'getTeamDetails') {
        this.drilldowndata.workerList = res.details;
      }
    });

  }
  workloadTable(item: boolean) {
    this.showWorkLoadTable = item;
    this.showPagination = item;
    if (item) {
      this.getWorkloadList(1, true, true);
    } else if (!item && this.showXLIcon) {
      this.getWorkloadList(1, false, true);
    }
  }
  renderWorkerCases(param: any, pageno: any) {
    this.isShowPiChart = false;
    this.subscriber[5] = this._commonService.getArrayList({
      where: param,
      method: "get",
      limit: 50,
      page: pageno
    }, this.getworkloadassignmentsurl).subscribe((res: any) => {
      this.isShowPiChart = true;
      this.drilldowndata.caseList = res.data;
      this.drilldowndata.caseList.forEach((v: any) => { // NOSONAR
        if (v.legalguardian && v.legalguardian.length) {
          v.legalguardian = v.legalguardian.map((x: { personname: any; }) => x.personname).join(', ');
        } else {
          v.legalguardian = '';
        }
      });
      if (this.casepaginationInfo.pageNumber === 1) {
        this.casetotalRecords = res.count;
      }
    });
  }

  casepageChanged(pageInfo: any) {
    this.casepaginationInfo.pageNumber = pageInfo.page;
    this.casepaginationInfo.pageSize = pageInfo.itemsPerPage;
    this.statisticsrequest = {
      toworkerid: this.drilldowndata.activeids.worker,
      teamid: this.drilldowndata.activeids.team
    };
    this.getWorkloadList(this.casepaginationInfo.pageNumber, false);
  }
  goback() {
    this.showXLIcon = false;
    this.chart = undefined;
    this.chart1 = undefined;
    this.workerName = null;
    const obj: any = {};
    if (this.isShowPiChart) {
      this.chartPreset.title.text = 'Unit wide status';
      this.chartPreset1.title.text = 'Workers wide count';
      this.chartPreset.subtitle.text = this.drilldowndata.activenames.team;
      obj['teamid'] = this.drilldowndata.activeids.team;
      obj['filtertype'] = 'user';
      this.drilldowndata.activeids.worker = undefined;
      this.isShowPiChart = undefined;
      this.renderDeptTeamUser(obj, 'getTeamDetails');
    } else if (this.drilldowndata.workerList) {
      this.chartPreset.title.text = 'Local department wide status';
      this.chartPreset1.title.text = 'Unit wide count';
      this.chartPreset.subtitle.text = this.drilldowndata.activenames.department;
      obj['teamid'] = this.drilldowndata.activeids.department;
      obj['filtertype'] = 'team';
      this.drilldowndata.activeids.team = undefined;
      this.drilldowndata.activenames.team = undefined;
      this.drilldowndata.workerList = undefined;
      this.renderDeptTeamUser(obj, 'getDepartmentDetails');
    } else if (this.drilldowndata.teamList) {
      this.chartPreset.title.text = 'State wide - case status';
      this.chartPreset.subtitle.text = null;
      this.chartPreset1.title.text = 'Local department wide count';
      obj['filtertype'] = 'ldss';
      this.drilldowndata.activeids.department = undefined;
      this.drilldowndata.activenames.department = undefined;
      this.drilldowndata.teamList = undefined;
      this.renderDeptTeamUser(obj, 'getAllDepartment');
    }


  }
  clearStoreValue() {
    this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
    this._session.removeItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    this._session.removeItem(CASE_STORE_CONSTANTS.Adoption_START_DATE);
    this._session.removeItem(CASE_STORE_CONSTANTS.CASE_DASHBOARD);
  }
  ngOnDestroy(): void {
    this.subscriber.forEach((v: any) => v.unsubscribe());
  }

  getDateFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format('MM/DD/YYYY');
    }else{
      return '';}
  }
}

