import { Component, Injector, OnInit } from "@angular/core";
import { FormBuilder, FormGroup } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import moment from "moment";
import { CommonUrlConfig } from "../../../@core/common/URLs/common-url.config";
import { PaginationInfo, PaginationRequest } from "../../../@core/entities/common.entities";
import { AlertService, AuthService, CommonHttpService, SessionStorageService } from "../../../@core/services";
import { CaseWorkerUrlConfig } from "../../case-worker/case-worker-url.config";
import { CASE_STORE_CONSTANTS } from "../../case-worker/_entities/caseworker.data.constants";
import { firstValueFrom } from "rxjs";

@Component({
  selector: 'psychotropicprescription-report',
  templateUrl: './psychotropicprescription-report.component.html',
  styleUrls: ['./psychotropicprescription-report.component.scss'],
  standalone: false
})
export class PsychotropicprescriptionreportComponent implements OnInit {
  psychotropicprescriptionreportForm!: FormGroup;
  private _formBuilder: FormBuilder;
  private authService: AuthService;
  private commonHttpService: CommonHttpService;
  private sessionStorage: SessionStorageService;
  private router: Router;
  private route: ActivatedRoute;
  private alertService: AlertService;

  timeperiodlist = ['Last 7 days', 'Last 30 days', 'Last 60 days', 'Last 90 days', 'Custom'];
  jurisdictionlist: any[] = [];;
  unitlist: any[] = [];
  statuslist: any[] = [];
  isadvancefilter!: boolean;
  clientlist: any;
  medicationlist: any;
  clientagerangelist: any;
  currentDate!: string;
  user: any;
  totalcount!: number;
  psychotropicreportlist: any;
  psychotropicReportData!: any[];
  psychotropicReportColumns!: string[];
  psychotropicReportKeys!: string[];
  searchandsortquery: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  psychotropicreportavglist: any;
  totalrequest: any;
  totalapproved: any;
  totalreturntoworker: any;
  totalrejected: any;
  totalpending: any;
  psychotropicReportdatalist: any;
  gettypesurl = 'referencetype/gettypes';
  teamTypeKey!: string;
  countycount!: number;
  userCounty: any;
  countyname: any;
  teamtypekey: any;
  userInfo: any;
  teamid: any;
  showcustomrange!: boolean;
  suggestions: any;
  suggestedMedicine: any;
  clientsuggestions: any;
  clientid: any;
  selectedCounty: any[] = [];
  currentROle: any;
  psychotropicreviewuser!: boolean;
  countfilter: any;
  status: any;
  unsortablecolumnlist: string[] = [];
  holidaylist: any[] = [];
  currentyear!: number;
  isselectedentry: any;
  widgetelementlist: any[] = [];
  widgetpendingelementlist: any[] = [];
  ispendingentry: any;
  caseworkerlist: any[] = [];
  showConfirmation: boolean = false;
  assignToMe: boolean = false;
  assignToOther: boolean = false;
  displayClientDetails: any = {};
  displayName: string = '';
  unitCaseWorkerList: any[] = [];
  unitname: string = '';
  commentText: any = '';
  medicationClassificationlist: any[] = [];

  constructor(private readonly injector: Injector) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.authService = this.injector.get<AuthService>(AuthService);
    this.commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    this.router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.alertService = this.injector.get<AlertService>(AlertService);
  }
  ngOnInit(): void {
    this.getholidaylist();
    this.userInfo = this.authService.getCurrentUser();
    this.user = this.authService.getCurrentUser().user.userprofile;
    this.currentROle = this.userInfo?.role?.key ? this.userInfo?.role?.key : this.userInfo?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
    const tma = this.userInfo.user.userprofile.teammemberassignment;
    const assignments = Array.isArray(tma) ? tma : [tma];
    this.teamid = assignments[0]?.teammember?.teamid;
    this.unitname = assignments[0]?.teammember?.team?.name;
    this.currentyear = new Date().getFullYear();
    if (this.userInfo?.role && (this.userInfo.role.name === 'CJAMS_CW_PSYCH_COORDINATOR'
      || this.userInfo?.role?.name === 'CJAMS_CW_PSYCH_PHARMACIST'
      || this.userInfo?.role?.name === 'CJAMS_CW_PSYCH_PSYCHIARIST')) {
      this.psychotropicreviewuser = true;
    }


    this.isadvancefilter = false;
    this.initialiseform();
    this.currentDate = moment(new Date()).format('MM/DD/YYYY');
    this.timeperiodchange('Last 7 days')
    this.getlist();
    this.getstatuslist();
    this.getclassification();
    this.loadclientlist();
    this.getUserCounty();
    this.loadcounty();
    this.teamTypeKey = this.authService.getAgencyName();
    this.clientageloadlist();
  }
  getstatuslist() {
    this.commonHttpService
      .getArrayList(
        {
          where: { referencetypeid: 500608, teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        this.gettypesurl + '?filter'
      ).subscribe((result: any) => {
        if (result.length > 0) {

          this.statuslist = result;
          this.statuslist.sort((a, b) => a.description.localeCompare(b.description));
        }
      })

  }
  loadclientlist() {
    this.user = this.authService.getCurrentUser().user.userprofile;
    this.commonHttpService.getArrayList({
      where: { securityusersid: this.user.securityusersid },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getcase + '?filter'
    ).subscribe(result => {
      this.clientlist = result[0]?.getcasenumberpsychotropic;
    })
  }
  loadcounty() {

    this.commonHttpService.create(
      {
        where: { state: 'MD' },
        order: 'countyname',
        method: 'post',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Listing.CountyListUrl
    ).subscribe(response => {

      this.jurisdictionlist = response;
    });

  }

  initialiseform() {
    this.psychotropicprescriptionreportForm = this._formBuilder.group({
      timeperiod: [],
      jurisdiction: [''],
      unit: [this.teamid],
      status: ['all'],
      clientname: [''],
      medicationname: [''],
      prescribername: [''],
      dateprescribed: [''],
      clientage: [''],
      startdate: [],
      enddate: [],
      calendardays: [true],
      submissiondate: [''],
      caseworkid: this.isadvancefilter ? [this.user.securityusersid] : [null]

    })
    if (this.psychotropicreviewuser) {
      this.psychotropicprescriptionreportForm.patchValue({
        unit: null,
        caseworkid: null
      })
    }
  }
  resetfilter() {
    this.psychotropicprescriptionreportForm.reset();
    this.isadvancefilter = !this.isadvancefilter;
    this.clientid = '';
    this.searchandsortquery = {};
    this.countfilter = {};
    this.isselectedentry = '';
    this.ispendingentry = ''
    this.psychotropicprescriptionreportForm.patchValue({
      timeperiod: 'Last 7 days',
      unit: this.teamid,
      jurisdiction: this.userCounty.countyid,
      status: 'all',
      calendardays: true,
      caseworkid: this.user.securityusersid

    })
    this.timeperiodchange('Last 7 days');
    if (this.psychotropicreviewuser) {
      this.psychotropicprescriptionreportForm.patchValue({
        jurisdiction: 'all',
        unit: 'all',
        caseworkid: null
      })
    }
    this.getlist();



  }
  advancefilter() {
    this.isadvancefilter = !this.isadvancefilter;
    this.suggestMedicine();
    this.paginationInfo.pageNumber = 1;
  }
  getlist() {
    const input = this.psychotropicprescriptionreportForm.getRawValue();
    const sortdirection = 'desc';
    const sortcolumn = 'Submission Date';
    if (input.jurisdiction == 'all') {
      input.jurisdiction = '';
    }
    if (input.unit == 'all') {
      input.unit = '';
    }
    if (input.caseworkid == 'all') {
      input.caseworkid = '';
    }
    const srtDirection = this.searchandsortquery?.sortDirection ? this.searchandsortquery?.sortDirection : sortdirection;
    const srtColumn = this.searchandsortquery?.sortColumn ? this.searchandsortquery?.sortColumn : sortcolumn;
    this.commonHttpService.getArrayList({

      where: {
        securityusersid: this.user.securityusersid,
        pagenumber: this.paginationInfo.pageNumber,
        pagesize: 10,
        clientname: input.clientname,
        timeperiod: input.timeperiod,
        countyid: input.jurisdiction,
        teamid: input.unit,
        filterdatetype: input.status,
        medicationname: input.medicationname,
        prescribername: input.prescribername,
        dateprescribed: input.dateprescribed,
        age: input.clientage,
        startdate: input.startdate,
        enddate: input.enddate,
        sortorder: this.searchandsortquery ? srtDirection : sortdirection,
        sortcolumn: this.searchandsortquery ? srtColumn : sortcolumn,
        searchobj: this.searchandsortquery ? this.searchandsortquery : {},
        countfilter: this.countfilter ? this.countfilter : '',
        calendardays: input.calendardays,
        submissiondate: input.submissiondate,
        caseworkid: input.caseworkid
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReport.GetList + '?filter'
    ).subscribe(result => {
      this.processlistResults(input, result);
    })
  }

  processlistResults(input: any, result: any) {
    if (result) {
      this.psychotropicReportdatalist = input.calendardays ? result[0]?.getpsychotropicmedicationreport?.count[0] : result[0]?.getpsychotropicmedicationreportbusinessdays?.count[0];
      this.psychotropicreportlist = input.calendardays ? result[0].getpsychotropicmedicationreport?.details : result[0].getpsychotropicmedicationreportbusinessdays?.details;
      this.psychotropicReportData = this.psychotropicreportlist;
      this.totalcount = this.psychotropicReportdatalist?.totalrequest;
      this.totalrequest = this.psychotropicReportdatalist?.totalrequest;
      this.totalapproved = this.psychotropicReportdatalist?.totalapproved;
      this.totalreturntoworker = this.psychotropicReportdatalist?.totalreturntoworker;
      this.totalrejected = this.psychotropicReportdatalist?.totalrejected;
      this.totalpending = this.psychotropicReportdatalist?.totalpending;
      this.loadlistdetails();
      this.getaveragetime();
      this.searchandsortquery = {};
    }
  }
  loadlistdetails() {
    const columnMapping = {

      'Client Name': 'clientname',
      'Medication': 'medicationname',
      'Prescription Date': 'dateprescribed',
      'Submission Date': 'submissiondate',
      'Time Taken by Caseworker': 'timetakenbycaseworker',
      'Time Under Coordinator Unassigned': 'timeundercommonpool',
      'Time Taken by Coordinator': 'timetakenbycoordinator',
      'Time Taken by Pharmacist': 'timetakenbypharmacist',
      'Time Taken by Psychiatrist': 'timetakenbypsychiatrist',
      'Total time taken for Review': 'totaltimetakenforreview',
      'Current Status': 'currentstatus',
      'Actions': 'view'

    };
    this.psychotropicReportData = this.returnSortedListDataFn(this.psychotropicReportData);
    this.psychotropicReportColumns = Object.keys(this.psychotropicReportData?.[0] || columnMapping)
    this.psychotropicReportKeys = Object.keys(this.psychotropicReportData?.[0] || columnMapping)
    this.unsortablecolumnlist = ['Time Taken by Coordinator', 'Time Taken by Caseworker', 'Time Under Coordinator Unassigned', 'Time Taken by Pharmacist', 'Time Taken by Psychiatrist', 'Total time taken for Review'];
    this.widgetelementlist = [
      {
        id: 'TR',
        name: 'Total Request',
        value: this.totalrequest

      },
      {
        id: 'APR',
        name: 'Approved',
        value: this.totalapproved
      },
      {
        id: 'REJ',
        name: 'Rejected',
        value: this.totalrejected
      },
      {
        id: 'RET',
        name: 'Returned to Worker',
        value: this.totalreturntoworker
      },
      {
        id: 'TP',
        name: 'Total Pending',
        value: this.totalpending
      },

    ];
    this.widgetpendingelementlist = [
      {
        name: 'Total Pending',
        value: this.totalpending,
        id: 'PTP'
      },
      {
        name: 'Coordinator Assignment Pending',
        value: this.psychotropicReportdatalist?.pendingcommonpool,
        id: 'CAP'
      },
      {
        name: 'Pending-Coordinator',
        value: this.psychotropicReportdatalist?.pendingreviewcoordinator,
        id: 'PC'
      },
      {
        name: 'Pending Pharmacist',
        value: this.psychotropicReportdatalist?.pendingpharmacist,
        id: 'PPH'
      },
      {
        name: 'Pending Psychiatrist',
        value: this.psychotropicReportdatalist?.pendingpsychiatrist,
        id: 'PPSY'
      }
    ]
  }
  private returnSortedListDataFn(sortedList: any[]): any[] {
    return sortedList?.map((e) => ({
      'Client Name': e.clientname,
      'Medication': e.medicationname,
      'Prescription Date': e.dateprescribed ? moment(e.dateprescribed).format('MM/DD/YYYY') : "",
      'Submission Date': e.submissiondate ? moment(e.submissiondate).format('MM/DD/YYYY') : "",
      'Time Taken by Caseworker': e.timetakenbycaseworker,
      'Time Under Coordinator Unassigned': e.timeundercommonpool,
      'Time Taken by Coordinator': e.timetakenbycoordinator,
      'Time Taken by Pharmacist': e.timetakenbypharmacist,
      'Time Taken by Psychiatrist': e.timetakenbypsychiatrist,
      'Total time taken for Review': e.totaltimetakenforreview,
      'Current Status': e.currentstatus,
      'Action': e

    }));
  }
  clientageloadlist() {
    this.clientagerangelist = [];
    for (let i = 1; i <= 100; i++) {
      this.clientagerangelist.push(i);
    }
  }
  onSort(event: any) {

  }
  callApi(query: any) {
    const data = JSON.parse(query)

    if (data.reset) {

      this.searchandsortquery = {};
    } else {
      this.searchandsortquery = data
      this.getlist();

    }

  }
  onSortedlist(event: any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.searchandsortquery.sortDirection = event.sortDirection;
    this.searchandsortquery.sortColumn = event.sortColumn;
    this.getlist();
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.sortColumn = pageInfo.query.sortColumn;
    this.pageInfo.sortBy = pageInfo.query.sortDirection;
    this.searchandsortquery.sortDirection = pageInfo.query.sortDirection;
    this.searchandsortquery.sortColumn = pageInfo.query.sortColumn;
    this.getlist();

  }
  pageNumberChanged(pageInfo: any) {
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn = pageInfo.query.sortColumn;
    this.paginationInfo.sortBy = pageInfo.query.sortDirection;
    this.searchandsortquery.sortDirection = pageInfo.query.sortDirection;
    this.searchandsortquery.sortColumn = pageInfo.query.sortColumn;
  }
  handleAuthIdEvent(data: any) {
    // No data or function to add or call
  }
  navigateToDestination(event: any, data: any) {
    const psychotropicreport = JSON.parse(event);
    this.sessionStorage.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_ID, psychotropicreport?.psychotropicid);
    this.sessionStorage.setItem(CASE_STORE_CONSTANTS.FROM_REPORT, true);
    this.sessionStorage.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_REQUEST_ID, psychotropicreport?.psychotropicrequestid);
    const currenturl = '#/pages/psychotropicprescription-review';
    window.open(currenturl);

  }
  getaveragetime() {
    this.user = this.authService.getCurrentUser().user.userprofile;
    const input = this.psychotropicprescriptionreportForm.getRawValue();
    if (input.jurisdiction == 'all') {
      input.jurisdiction = '';
    }
    if (input.unit == 'all') {
      input.unit = '';
    }
    this.commonHttpService.getArrayList({
      where: {
        securityusersid: this.user.securityusersid,
        pagenumber: this.paginationInfo.pageNumber,
        pagesize: 10,
        clientname: input.clientname,
        timeperiod: input.timeperiod,
        countyid: input.jurisdiction,
        teamid: input.unit,
        filterdatetype: input.status,
        medicationname: input.medicationname,
        prescribername: input.prescribername,
        dateprescribed: input.dateprescribed,
        age: input.clientage,
        startdate: input.startdate,
        enddate: input.enddate,
        calendardays: input.calendardays,
        submissiondate: input.submissiondate,
        caseworkid: input.caseworkid

      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReport.GetAveragetimeList + '?filter'
    ).subscribe(result => {
      if (result) {
        this.psychotropicreportavglist = input.calendardays ? result[0].getpsychotropiccalculateavgtime : result[0].getpsychotropiccalculateavgtimebusinessdays;


      }
    })

  }
  getUserCounty() {
    this.countycount = 0;
    const filter: any = {};
    this.commonHttpService
      .getAll('admin/county/getusercounty?data=' + encodeURIComponent(JSON.stringify(filter)))
      .subscribe(res => {
        if (res && res.length > 0) {
          this.userCounty = res[0];
          this.countycount = res.length;
          this.countyname = this.userCounty.countyname;
          this.psychotropicprescriptionreportForm.patchValue({ jurisdiction: this.userCounty.countyid });
          this.getteams(this.userCounty.countyid);
          this.getcaseworkerlist(this.userCounty.countyid, this.teamid);
          if (this.psychotropicreviewuser) {
            this.psychotropicprescriptionreportForm.patchValue({
              jurisdiction: 'all',
              unit: 'all',
              caseworkid: null
            })
          }
        }
      });
  }
  getteams(countyid: any) {
    const obj = {
      activeflag: 1,
      countyid: countyid,
      teamtypekey: this.teamtypekey ? this.teamtypekey : 'CW'
    }
    this.commonHttpService.getPagedArrayList(new PaginationRequest({
      where: obj, method: 'get', nolimit: true
    }
    ), 'manage/team/list?filter')
      .subscribe(result => {
        this.unitlist = result.data;

      });
  }
  getteamlist(countyid: any) {
    this.getcaseworkerlist(countyid, 'all');
    if (countyid == 'all') {
      this.psychotropicprescriptionreportForm.get('unit')?.disable();


    } else {
      this.psychotropicprescriptionreportForm.get('unit')?.enable();
      this.getteams(countyid);

    }
    this.psychotropicprescriptionreportForm.patchValue({
      unit: null,
      caseworkid: ''
    });


  }


  timeperiodchange(value: any) {
    this.showcustomrange = false;
    this.psychotropicprescriptionreportForm.patchValue({
      startdate: null,
      enddate: null,
      timeperiod: value
    });
    switch (value) {
      case 'Last 30 days': this.calculatestartandenddate(30);
        break;
      case 'Last 90 days': this.calculatestartandenddate(90);
        break;
      case 'Last 60 days': this.calculatestartandenddate(60);
        break;
      case 'Last 7 days': this.calculatestartandenddate(7);
        break;
      case 'Custom': this.showcustomdatewindow();
        break;

    }

  }
  calculatestartandenddate(value: any) {
    const startdate = new Date();
    const enddate = new Date();
    startdate.setDate(enddate.getDate() - value);
    this.psychotropicprescriptionreportForm.patchValue({
      startdate: startdate,
      enddate: enddate
    });

  }
  showcustomdatewindow() {
    this.showcustomrange = true;
  }
  suggestMedicine() {

    this.commonHttpService
      .getArrayList(
        {
          where: { referencetypeid: 903, teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        this.gettypesurl + '?filter'
      ).subscribe((result: any) => {
        if (result.length > 0) {
          this.suggestedMedicine = result;
          this.suggestedMedicine.sort((a: any, b: any) => a.description.localeCompare(b.description));
        }
      })

  }
  getSuggestedmedicine() {


    if (this.psychotropicprescriptionreportForm.value.medicationname) {

      this.suggestions = this.suggestedMedicine.filter((c: { description: string; }) => c.description.toLowerCase().startsWith(this.psychotropicprescriptionreportForm.value.medicationname.toLowerCase()))
    }
  }
  selectedmedicine(item: any) {
    this.psychotropicprescriptionreportForm.patchValue({
      medicationname: item.description,
    })
  }
  getSuggestedclient() {
    this.clientid = '';
    if (this.psychotropicprescriptionreportForm.value.clientname && this.psychotropicprescriptionreportForm.value.clientname.length >= 4) {

      this.clientsuggestions = this.clientlist.filter((c: { personname: string; }) => c.personname.toLowerCase().startsWith(this.psychotropicprescriptionreportForm.value.clientname.toLowerCase()))
    }
  }
  selectedclient(item: any) {
    this.psychotropicprescriptionreportForm.patchValue({
      clientname: item.personname,
    })
    this.clientid = item.personid;
  }
  widgetclicked(value: any, index: any) {
    const reqvalues = ['TR', 'TP', 'APR', 'REJ', 'RET'];
    if (reqvalues.includes(value)) {
      this.isselectedentry = index;
      this.ispendingentry = ''
    }
    else {
      this.isselectedentry = '';
      this.ispendingentry = index;
    }
    switch (value) {

      case 'TR': this.countfilter = 'all';
        break;
      case 'APR': this.countfilter = 'approved';
        break;
      case 'REJ': this.countfilter = 'rejected';
        break;
      case 'RET': this.countfilter = 'return_worker';
        break;
      case 'TP': this.countfilter = 'totalpending';
        break;
      case 'PPH': this.countfilter = 'pendingpharmacist';
        break;
      case 'PPSY': this.countfilter = 'pendingpsychiatrist';
        break;
      case 'PC': this.countfilter = 'pendingreviewcoordinator';
        break;
      case 'CAP': this.countfilter = 'pendingcommonpool';
        break;
    }
    this.getlist();
  }
  changecalendardays(event: any) {
    this.getlist();

  }
  getColumncolorclass(data: any) {
    switch (data) {
      case 'Rejected': return 'rejected-class';
      case 'Approved': return 'approved-class';
      default: return 'default-class';
    }

  }
  getholidaylist() {
    this.commonHttpService.getArrayList({

      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReport.GetHolidaylist + '?filter'
    ).subscribe(result => {
      this.holidaylist = [];
      if (result && result[0] && result[0]?.getholidayslist != null) {
        this.holidaylist.push(...result[0]?.getholidayslist);



      }
    })
  }
  getcaseworkerlist(countyid: any, teamid: any) {
    if (countyid == 'all') {
      countyid = ''
    }
    if (teamid == 'all') {
      teamid = '';
    }

    const obj = {
      activeflag: 1,
      countyid: countyid,
      teamid: teamid,
      teamtypekey: this.teamtypekey ? this.teamtypekey : 'CW'
    }
    this.commonHttpService.getArrayList({
      where: obj, method: 'get', nolimit: true
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReport.GetCaseworker + '?filter'
    ).subscribe(result => {
      this.caseworkerlist = result[0].getpsychotropiccwlistbycounty;

    });
  }
  unitchanged(teamid: any) {
    const countyid = this.psychotropicprescriptionreportForm.value.jurisdiction
    this.psychotropicprescriptionreportForm.patchValue({
      caseworkid: ''
    });
    this.getcaseworkerlist(countyid, teamid);

  }

  // start CIDM-10987 psychotropic all requests dashboard
  async onSelect(openPopup: { id: string, selectedData: any }) {
    this.supervisorviewrecord(openPopup?.selectedData?.Action?.psychotropicrequestid);
    const listbycounty: any = await this.getCaseworkerListOnIdFn();
    const roleNameListData = listbycounty?.[0].getpsychotropiccwlistbycounty ?? [];
    this.unitCaseWorkerList = roleNameListData.filter((item: any) => item.securityusersid !== this.displayClientDetails.edituser)
    if (openPopup.id === '3') {
      this.assignToMe = true;
    } else if (openPopup.id === '4') {
      this.assignToOther = true;
    }
  }

  async getCaseworkerListOnIdFn() {
    return await firstValueFrom(this.commonHttpService.getArrayList(
      {
        where: {
          activeflag: 1, countyid: this.userCounty.countyid, teamid: this.teamid, teamtypekey: this.teamtypekey ? this.teamtypekey : 'CW'
        }, method: 'get', nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReport.GetCaseworker + '?filter'));
  }

  onSelectionChange(id: string) {
    const selectedRole: any = this.unitCaseWorkerList.find((role: any) => role.securityusersid === id);
    this.displayClientDetails.selectedName = selectedRole.displayname;
    this.displayClientDetails.selectedId = selectedRole.securityusersid;
  }

  backToAssignForm() {
    this.showConfirmation = false;
  }

  assign(data: any) {
    this.showConfirmation = true;
    this.commentText = data;
  }

  resetFeedback() {
    this.assignToMe = false;
    this.assignToOther = false;
    this.showConfirmation = false;
  }

  assignIdtoSelectedRole(modalcommentsdata?: any) {
    if (modalcommentsdata) {
      this.commentText = modalcommentsdata;
    }
    const data = {
      psychotropicid: this.displayClientDetails.psychotropicid,
      module: 'psychotropicmedications',
      tosecurityusersid: this.displayClientDetails.selectedId ?? this.user.securityusersid,
      statustext: 'sp_cw_assign',
      comments: this.commentText
    };
    this.commonHttpService
      .create(data, 'psychotropicmedications/psychotropicrouting')
      .subscribe(() => {
        this.alertService.success('The Psychotropic medication review is assigned to Caseworker');
        this.goback();
      });
  }

  goback() {
    this.assignToMe = false;
    this.assignToOther = false;
    this.showConfirmation = false;
    this.getlist();
  }

  getclassification() {
    this.commonHttpService
      .getArrayList(
        {
          where: { referencetypeid: 500609, teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        this.gettypesurl + '?filter'
      ).subscribe((result: any) => {
        if (result.length > 0) {
          this.medicationClassificationlist = result;
          this.medicationClassificationlist.sort((a: any, b: any) => a.description.localeCompare(b.description));
        }

      })
  }

  supervisorviewrecord(psychotropicrequestid: any) {
    this.commonHttpService.getArrayList({

      where: {
        securityusersid: this.user.securityusersid,
        psychotropicrequestid: psychotropicrequestid

      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getsupervisorviewrecord + '?filter'
    ).subscribe(result => {
      if (result) {
        const psychotropiclist = result?.[0]?.getpsychotropiclistbyrequestid?.[0];
        const classificationdes: any = this.medicationClassificationlist.find((e: any) => e.ref_key === psychotropiclist.classification);
        this.displayClientDetails = {
          clientname: psychotropiclist.clientname,
          psychotropicid: psychotropiclist.psychotropicid,
          cjamspid: psychotropiclist.cjamspid,
          casenumber: psychotropiclist.casenumber,
          gender: psychotropiclist.gender,
          medicationname: psychotropiclist.medicationname,
          classification: classificationdes.description,
          dateprescribed: psychotropiclist.dateprescribed,
          edituser: psychotropiclist.edituser
        }
        this.getEditUserDetails(psychotropiclist.edituser);
      }
    });
  }

  getEditUserDetails(id: string) {
    this.commonHttpService.getArrayList({

      where: {
        id: id
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.GetEditUserDetails + '?filter'
    ).subscribe(result => {
      if (result && result.length > 0) {
        this.displayName = `${result[0].firstname} ${result[0].lastname}`;
      }
    });
  }
  //End CIDM-10987 psychotropic all requests dashboard
}