import { Component, Injector, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { share, pluck, map } from 'rxjs/operators';
import { firstValueFrom, forkJoin, Observable } from 'rxjs';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService, CommonDropdownsService, CommonHttpService, DataStoreService, LocalStorageService, SessionStorageService, ValidationService } from '../../@core/services';
import { DropdownModel, PaginationInfo } from '../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import {CommonUrlConfig} from '../../@core/common/URLs/common-url.config';
import _ from 'lodash';
import moment from 'moment';
import { AlertService } from '../../@core/services/alert.service';
import { QueryType } from '../../@core/common/models/person-health-summary.model';
import {DocumentUploadListSharedComponent } from '../../shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { RandomIdGeneratorService } from "../../@core/services/random-id-generator.service";
import { CASE_STORE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';
import { MatSelectChange } from '@angular/material/select';

@Component({
    selector: 'psychotropicprescription-review',
    templateUrl: './psychotropicprescription-review.component.html',
    styleUrls: ['./psychotropicprescription-review.component.scss'],
    standalone: false
})
export class PsychotropicprescriptionReviewComponent implements OnInit,OnDestroy {
  uploadNumber = '123434';
  uploadedFiles = [];
  isAddEdit!: boolean;
  cases :any[]= [];
  currentuser: any;
  reviewcoordinatorlist: any
  selectedpsychotropicid: any;
  selectedcasenumbernofi: any;
  showsendforreview: boolean = false;
  iseditable: boolean = false;
  requestPsychiatrist: boolean = false;
  coordinatorbnt: boolean = false;
  statusbasedbuttion: boolean = false;
  selectedclientname: any;
  selectedcjamspid: any;
  disablerouting: boolean = false;
  tosecurityusersid: any;
  toCheckRoutingStatues: boolean = false;
  statustexttype: any;
  clientlist!: any[];
  medicationlist = [];
  curentroletypekey: any;
  toCheckCurentROle: any;
  toCheckCurentStatues: any;
  assignToPsychiatrist: boolean = false;
  assignToPharmacist: boolean = false;
  paginationInfo: PaginationInfo = new PaginationInfo();
  pageInfo: PaginationInfo = new PaginationInfo();
  totalcount!: number;
  tableData = [];
  minwidthstyle = 'min-width-120';
  statusminwidthstyle = 'min-width-140';
  tdminwidthstyle ='td-width-style';
  comments ={"role":String, "name":String, "date":String , "Commentstext":String }
  styles = {
    "Client Name": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "Medication": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "Prescription Date": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "Submitted By": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "Submtted On": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "status": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "PHARMACIST": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "PSYCHIATRIST": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "Review Date": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' },
    "'Actions'": { 'thStyleClassName': this.minwidthstyle, 'tdStyleClassName': this.tdminwidthstyle, 'filterIconClassName': 'top-10' }
  }

  psychotropicprescriptionreviewForm!: FormGroup;
  user: any;
  objectid: any;
  psychotropiclist: any[]=[];
  psychotropicDetailsData: any[]=[];
  psychotropicDetailsFilteredData: any[]=[];
  psychotropicDetailsColumns!: string[];
  psychotropicDetailsKeys!: string[];
  selectedcasenumber: any;
  selectedclient!: any[];
  suggestions: any;
  suggestedMedicine: any;
  teamTypeKey!: string;
  gettypesurl = 'referencetype/gettypes';
  medicationType: any;
  frequency$!: Observable<DropdownModel[]>;
  medicationClassification$!: Observable<DropdownModel[]>;
  targetedsymptoms$!: Observable<DropdownModel[]>;
  methodofdelivery$!: Observable<DropdownModel[]>;
  prescribedduration$!: Observable<DropdownModel[]>;
  diagnosislist$! :Observable<DropdownModel[]>;
  medicationsetting$! :Observable<DropdownModel[]>;
  prescriberspecialitylist$!:Observable<DropdownModel[]>;
  prescriberdegreelist$!:Observable<DropdownModel[]>;
  psychosocialintervention$!:Observable<DropdownModel[]>;
  othermedications$!:Observable<DropdownModel[]>;
  medicationClassification!:DropdownModel[];
  targetedsymptomsList!:DropdownModel[];
  diagnosisList!:DropdownModel[];
  prescriberspeciality!:DropdownModel[];
  prescriberdegree!:DropdownModel[];
  methodofdeliverylist!:DropdownModel[];
  prescribeddurationlist!:DropdownModel[];
  medicationsettinglist!:DropdownModel[];
  psychosocialinterventionlist!:DropdownModel[];
  othermedicationslist !:DropdownModel[];
  frequencydropdown: any[]=[];
  view!: boolean;
  userInfo: any;
  psychotropicreviewuser!: boolean;
  selecttargetedsymptomsList!: string;
  submittedby: any;
  submittedon: any;
  additionalobjectid!: string;
  additionalobjecttypevalidation:boolean =true;
  @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;
  placeholderIDforUploadedFiles!: string;
  updateCompleted =false;
  load = false;
  isupload: boolean = true;
  submissionhistory: any;
  otherMedicalDetails: any;
  latesthistoryname: any;
  commentshistory:any;
  iscaseworker!: boolean;
  objecttypekey: any;
  viewsavebutton = false;
  showothersymptoms: any;
  gender$!: Observable<DropdownModel[]>;
  genderlist!: any[];
  hourList :any[]=[];
  hourSpecifydurationList :any[]=[];
  filterSpecifyHourSugg :any[]=[];
  currentDate!: any;
  caseworkercomments:any = [];
  caseworker: any;
  caseworkersubmittedon: any;
  showrejectcomments!: boolean;
  rejectcomments: any;
  caselist!: any[];
  clients!: any[];
  statusmessage!: string;  
  dtformat = 'MM/DD/YYYY';
  showotherdiagnosis!: boolean;
  showotherprescriberdegree!: boolean;
  showotherprescriberspeciality!: boolean;
  informationincomplete!: boolean;
  casenumber: any;
  psychatristcomments :any;
  pharmacistcomments :any;
  countylistdropdown: any;
  submitdecisionlist:any;
  decisiontext: any;
  rejectreason: any;
  rejectreasoncomments: any;
  peerdecisionlist = ['Approved','Rejected'];
  peerreview!: boolean;
  rejectedcomments: any;
  rejectedreason: any;
  currentothermedications =[];
  currentothermedicationlist:any[]=[];
  indications:any;
  dosage:any;
  viewsubmitbutton!: boolean;
  casenumberhoh='';
  clientandcjamspid ='';
  otherprescduration!: boolean;
  otherfreqreq!: boolean;
  peertopeerreq!: boolean;
  Statusfilterlist:any[] =[];
  statusfilter: any;
  reviewstatusfilter: any;
  isPolicyStaffUser: boolean= false;
  isValue: number = 1;
  assignToMe: boolean = false;
  assignToOther: boolean = false;
  roleNameList: any[] = [];
  displayClientDetails: any = {};
  commentText: any = '';

  private _formBuilder: FormBuilder;
  private route: ActivatedRoute;
  private router: Router;
  private authService: AuthService;
  private alertService: AlertService;
  private dataStoreService: DataStoreService;
  private commonHttpService: CommonHttpService; 
  private randomIdGeneratorService: RandomIdGeneratorService;
  private commonDropDownService :CommonDropdownsService;
  private sessionstorageservice :SessionStorageService;
  private localstore: LocalStorageService;
  
  coordinatorcomments: any;
  othercurrentmedicationid: any;
  showpeerreview!: boolean;
  medicationClassificationlist: any;
  addtext!: string;
  peerreviewmand!: boolean;
  personid: any;
  returnworker!: boolean;
  searchandsortquery: any;
  appendcomment!: boolean;
  caseworkercommenttext: any;
  reviewstatus: any;
  returnedtoworkerentry= false;
  requestid: any;
  showotheraddpsychosocial!: boolean;
  showassigntome =false;
  assignedtocoordinator: boolean = false;
  routetoallcordinator!: boolean;
  showreassign!: boolean;
  showassignreviewer!: boolean;
  assigntootherreviewer:any;
  otherreviewerselected!: boolean;
  otherselectedreviewer: any;
  otherroletypekey: any;
  showresetbutton!: boolean;
  checkforuserassignment!: boolean;
  edituser: any;
  editusername: any;
  backbutton = true;
  showConfirmation: boolean = false;
  filteredCases: any[] = [];
  rejectReasons: string[] = ['Rejection based on clinical review', 'Request submitted in error', 'Duplicate request', 'Prescriber withdrew request', 'Unable to reach prescriber to discuss treatment plan concerns', 'Others'];
  recordAssignedToMe: boolean = false;
  recordStatus: string = '';
  displayRole: any;
  displayName: any;
  statusCheckForCwSP: boolean = false;
  selectedData: any;
  rcrolename : string  = 'Review Coordinator';
  phrolename : string  = 'Pharmacist';
  psrolename : string  = 'Psychiatrist';
  displayrolekey: string = '';


  constructor(private readonly injector : Injector) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.router = this.injector.get<Router>(Router);
    this.authService = this.injector.get<AuthService>(AuthService);
    this.alertService = this.injector.get<AlertService>(AlertService);
    this.dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.randomIdGeneratorService = this.injector.get<RandomIdGeneratorService>(RandomIdGeneratorService);
    this.commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.sessionstorageservice = this.injector.get<SessionStorageService>(SessionStorageService); 
    this.localstore = this.injector.get<LocalStorageService>(LocalStorageService);
  }
  

 

  async  ngOnInit() {
    this.loadDropDowns();
    this.handleHourDurationListFn();
    this.currentDate = moment(new Date()).format('MM/DD/YYYY');
    this.currentuser = this.authService.getCurrentUser();
    this.user = this.authService.getCurrentUser().user.userprofile;
    this.dataStoreService.setData('teamtypekey', 'CW');
    const activeModule = this.sessionstorageservice.getItem('activeModuleNav');
    this.reviewstatusfilter = 'all';
    const condRole = (this.currentuser?.user?.userprofile?.teammemberassignment[0]?.teammember?.roletypekey) ? this.currentuser?.user?.userprofile?.teammemberassignment[0]?.teammember?.roletypekey :this.currentuser?.user?.userprofile?.teammemberassignment?.teammember?.roletypekey;
    this.toCheckCurentROle = this.currentuser?.role?.key ? this.currentuser?.role?.key : condRole;
    this.getCurrentRoletypekey();
    if(this.toCheckCurentROle == 'CWCW'){
      this.iscaseworker  =true;
      this.addtext = 'Add'
      
    }else {
      this.iscaseworker =false;
      this.addtext = ''
    }
   
    this.reloadwithreviewstatus('all');
    this.getstatuslist();
    this.forminitialise();
    this.loadcounty();
   await this.loadclientlist();
    this.loadcasenumber();
    this.filteredCases = this.cases ? [...this.cases] : [];
    this.getpsychotrophicdetails();
    this.suggestMedicine();
    this.getInvolvedPerson();
    if(this.sessionstorageservice.getItem('PSYCHOTRPIC_FROMMEDICATION')=='true'){
       // Call function if parameter exists
       this.psychotropicprescriptionreviewForm.controls['clientname'].setValue(this.sessionstorageservice.getItem('PSYCHOTRPIC_FULLNAME'));
        this.iscaseworker=this.toCheckCurentROle == 'CWCW';
      this.psychotropicprescriptionreviewForm.patchValue({
        casenumber: this.sessionstorageservice.getItem('PSYCHOTRPIC_CASEID'),
        personid :this.sessionstorageservice.getItem('PSYCHOTRPIC_PERSONID'),
        clientname:this.sessionstorageservice.getItem('PSYCHOTRPIC_FULLNAME'),
        cjamspid :this.sessionstorageservice.getItem('PSYCHOTRPIC_CJAMSPID'),
        gender:this.sessionstorageservice.getItem('PSYCHOTRPIC_GENDER'),
        dob:moment(this.sessionstorageservice.getItem('PSYCHOTRPIC_DOB')).format('MM/DD/YYYY'),
        age:this.calculateAge(this.sessionstorageservice.getItem('PSYCHOTRPIC_DOB')),
        race:this.sessionstorageservice.getItem('PSYCHOTRPIC_RACE'),
        countytypekey :this.sessionstorageservice.getItem('PSYCHOTRPIC_COUNTY'),
      })
      this.caseChanged(this.sessionstorageservice.getItem('PSYCHOTRPIC_CASEID'));
      this.clientselected(this.sessionstorageservice.getItem('PSYCHOTRPIC_PERSONID'));
      this.addnewPrescription();
    }
    this.teamTypeKey = this.authService.getAgencyName();
    this.userInfo = this.authService.getCurrentUser();
    if(this.toCheckCurentROle == 'CWPSYPHARM' || this.toCheckCurentROle =='CWPSYPSYCH' ){
      this.showassignreviewer = true;
      this.curentroletypekey = this.toCheckCurentROle
      this.getReviewer();
    }

    if (this.userInfo?.role && (this.userInfo.role.name === 'CJAMS_CW_PSYCH_COORDINATOR'
      || this.userInfo?.role?.name === 'CJAMS_CW_PSYCH_PHARMACIST'
      || this.userInfo?.role?.name === 'CJAMS_CW_PSYCH_PSYCHIARIST')) {
      this.psychotropicreviewuser = true;
    }
    // CIDM-10751 Hide Add button for Policy staff users
    if(activeModule === 'Policy Staff') {
      this.isPolicyStaffUser = true;
    }
    
  }

  getCurrentRoletypekey(){
    if (this.toCheckCurentROle == 'CWCW' || this.toCheckCurentROle == 'CWPSYPHARM') {
      this.curentroletypekey = 'CWPSYCOORD';
    }
    if (this.toCheckCurentROle == 'CWPSYCOORD' && this.assignToPsychiatrist) {
      this.curentroletypekey = 'CWPSYPSYCH';
    }
    if (this.toCheckCurentROle == 'CWPSYCOORD' && this.assignToPharmacist) {
      this.curentroletypekey = 'CWPSYPHARM';
    }
  }
  
  ngOnDestroy(): void {
    this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_ID, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.FROM_REPORT, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_REQUEST_ID, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CASEID,'');
 this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_PERSONID, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_FULLNAME, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CJAMSPID, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_GENDER, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_DOB, '');
 this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CASEID, '');
  this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_RACE, '');
 this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_CASEID, '');
 this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_COUNTY, '');
 this.sessionstorageservice.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_FROMMEDICATION, false);
  }
  // Assosiated to ngOnInit method
  private handleHourDurationListFn() {
    this.hourList = [];
    for (let i = 1; i <= 24; i++) {
      this.hourList.push(i + ((i == 1) ? ' Hr' : ' Hrs'));
    }
    this.hourSpecifydurationList = [];
    for (let i = 1; i <= 1000; i++) {
      this.hourSpecifydurationList.push(i);
    }
  }

  getlist() {
    this.psychotropiclist = [];
    this.psychotropicDetailsData = [];
    this.showresetbutton = false
    const roletypekey = this.otherreviewerselected ? this.otherroletypekey: this.toCheckCurentROle ;
    this.commonHttpService.getArrayList({
      
      where: {
        securityusersid: this.user.securityusersid,
        roletypekey: roletypekey,
        filterdatetype:this.statusfilter,
        pagenumber:this.paginationInfo.pageNumber,
        limit:10,
        sortorder:this.searchandsortquery ? this.searchandsortquery?.sortDirection : '',
         sortcolumn:this.searchandsortquery ?this.searchandsortquery?.sortColumn : '',
         searchobj:this.searchandsortquery ? this.searchandsortquery : {},
         selectedsecurityusersid :this.otherselectedreviewer,
         tabselected: this.isValue === 1 ? '1' : null
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.GetList + '?filter'
    ).subscribe(result => {
      if (result) {
        this.psychotropiclist = [];
        this.psychotropiclist = result[0].psychotropicscreenindashboard;
        if(this.otherreviewerselected){
          this.showresetbutton = true;
        }
        this.loadlistDetails();
        this.totalcount = this.psychotropiclist ? this.psychotropiclist[0]?.count :0;
        this.searchandsortquery  ={};
       this.processNotificationEvt();
        
      }
    })
  }
  processNotificationEvt(){
    let  notificationevent;
    if(this.sessionstorageservice.getItem('FROM_NOTIFICATION') ||(this.sessionstorageservice.getItem('FROM_REPORT')))
    {
      this.selectedpsychotropicid = this.sessionstorageservice.getItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_ID);
     notificationevent = this.psychotropiclist.filter(item=>item.psychotropicid === this.selectedpsychotropicid)
      if(notificationevent ){
        if(this.iscaseworker && this.sessionstorageservice.getItem('FROM_NOTIFICATION')&&(notificationevent[0].reviewstatus === 'Returned to Worker' || notificationevent[0].reviewstatus === 'Draft')){
           notificationevent[0].Action ='edit';
        }
         const datattopatch = JSON.stringify(notificationevent[0]);
          this.navigateToDestination(datattopatch,datattopatch);
          
      }
    }
    notificationevent = this.psychotropiclist?.filter(item=>item.psychotropicid === this.selectedpsychotropicid)
    if(notificationevent && this.sessionstorageservice.getItem('FROM_NOTIFICATION')){
    this.edituser = notificationevent[0]?.edituser
    }
  }
  loadlistDetails(query: QueryType = {}) {
    const columnMapping = {

      'Client Name': 'clientname',
      'Medication': 'medicationname',
      'Prescription Date': 'dateprescribed',
      'Submitted By': 'submittedby',
      'Submitted On': 'submittedon',
      'status': 'reviewstatus',
      'Primary Reviewer': 'submittedby',
      'Secondary Reviewer': 'submittedby',
      'Review Date': 'submittedon',
      'Actions': 'view'

    };
    let sortedList = this.psychotropiclist;
    this.psychotropicDetailsData = this.psychotropiclist;

     this.psychotropicDetailsData = this.returnSortedListDataFn(sortedList)

   
    this.psychotropicDetailsColumns = Object.keys(this.psychotropicDetailsData?.[0] || columnMapping)
    this.psychotropicDetailsKeys = Object.keys(this.psychotropicDetailsData?.[0] || columnMapping)
     }
  // Assosiated to loadlistDetails method
  private returnSortedListDataFn(sortedList: any[]): any[] {
    return sortedList?.map((e: any) => ({
      'Client Name': e.clientname,
      'Medication': e.medicationname,
      'Prescription Date': e.dateprescribed ? moment(e.dateprescribed).format('MM/DD/YYYY') : "",
      'Submitted By': e.reviewstatus !== 'Draft' ? e.submittedby : null,
      'Submitted On': e.submittedon ? moment(e.submittedon).format('MM/DD/YYYY hh:mm a') : "",
      'status': e.reviewstatus,
      'PHARMACIST': e.pharmacist,
      'PSYCHIATRIST': e.psychiatrist,
      'Review Date': e.reviewdate ? moment(e.reviewdate).format('MM/DD/YYYY hh:mm a') : null,
      'Action': e
    }));
  }

  getpsychotrophicdetails() {
    // psycotrophicmedications.getpsycotrophicdetails
  }

  async loadclientlist() {
    this.user = this.authService.getCurrentUser().user.userprofile;

    const result: any = await this.commonHttpService.getArrayList(
        { where: { securityusersid: this.user.securityusersid }, method: 'get' },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getcase + '?filter'
    ).toPromise(); // Converts Observable to Promise

    this.clientlist =result[0]?.getcasenumberpsychotropic;
    this.clients =this.clientlist;
      this.caselist =_.uniqBy(this.clientlist ,"casenumber");
      this.cases = this.caselist;
}

  getInvolvedPerson() {

    let reqObj = {};
    let isExpungementSuperUser= this.authService.isExpungementSuperUser();
    const iscaseexpunged = this.dataStoreService.getData('iscaseexpunged');
     
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }

    reqObj = {
      objectid: this.objectid,
      objecttypekey: 'servicecase',
      isExpungementSuperUser: isExpungementSuperUser,
      'iscaseexpunged': iscaseexpunged
    };

    this.commonHttpService
      .getArrayList(
        {
          page: 1,
          method: 'get',
          where: reqObj
        },
        url + '?filter'
      )
      .subscribe(res => {
        if ((res as any)['data'] && (res as any)['data'].length) {
          this.clientlist = (res as any)['data']
        }
      })
  }
  addnewPrescription() {
    this.recordStatus = '';
    this.otherMedicalDetails = [];
    this.suggestions = [];
    this.isAddEdit = true;
    this.view = false;
    this.showsendforreview = true;
    this.statusbasedbuttion = true;
    this.disableclientdetails();
    this.filteredCases = this.cases ? [...this.cases] : [];
  }
  caseChanged(value:any) {
    const selectedcase = this.cases.filter(c => c.casenumber === value)
    this.objectid = selectedcase[0]?.objectid;
    this.objecttypekey =selectedcase[0]?.objecttypekey;
    this.clientlist = this.clients.filter(item=> item.casenumber === value);
    this.psychotropicprescriptionreviewForm.patchValue({
      countytypekey:selectedcase[0]?.countyid
    })
    
  }

  namereset() {
    this.psychotropicprescriptionreviewForm.patchValue({
      clientname: null,
      cjamspid: null,
      gender: null,
      dob: null,
      age:null,
      countytypekey:null,
      race:null,
      ethnicity:null
    })
  }
  forminitialise() {
    this.psychotropicprescriptionreviewForm = this._formBuilder.group({
      case: [''],
      personid: null,
      clientname: [''],
      cjamspid: [''],
      gender: [''],
      isdraft: null,
      dob: [''],
      medicationname: [''],
      classification: [''],
      dateprescribed: null,
      targetedsymptoms: '',
      dosage: [''],
      frequency: [''],
      diagnosis:'',
      prescribername: [''],
      prescribercontactinfo: [''],
      prescriberemail: ['',ValidationService.mailFormat],
      psychotropiccomments: [''],
      casenumber: [''],
      methodofdelivery: [''],
      prescribedduration: [''],
      psychotropicid: null,
      otherfrequency:null,
      othersymptoms:null,
      specifyhour:null,
      specifyduration :null,
      otherspecifyduration:null,
      age:null,
      countytypekey:null,
      race:null,
      otherdiagnosis :null,
      settingmedicationprescribed:null,
      prescriberdegree:null,
      prescriberspecialty:null,
      otherprescriberdegree:null,
      otherprescriberspecialty:null,
      otheradditionalpsychosocialinterventions :null,
      additionalpsychosocialinterventions :null,
      psychosocialinterventions :null,
      isinfoincomplete:null,
      ethnicity:null,
      othermedications:null,
      peerreview:null,
      revieweddate:null,
      reviewedby:null,
      comments:null,
      decisiontext :null,
      peerdecision:null,
      clientdetails:null,
      casenumberhoh:null,
      caseSearchFilter: null,
      rejectreason: null,
      rejectreasoncomments: null
    });
  }
  clientselected(client:any) {

    this.dataStoreService.setData('personid', client);
    if(this.selectedpsychotropicid) {
      this.additionalobjectid = this.selectedpsychotropicid;
    } else {
      this.additionalobjectid = this.randomIdGeneratorService.generateRandomId();
      this.placeholderIDforUploadedFiles = this.additionalobjectid;
     }
    this.selectedclient = this.clientlist?.filter(cl => cl.personid === client)
    if(this.selectedclient){
      this.personid =this.selectedclient[0]?.personid;
    this.psychotropicprescriptionreviewForm.patchValue({
      clientname: this.selectedclient[0]?.personname,
      cjamspid: this.selectedclient[0]?.cjamspid,
      gender:this.selectgender(this.selectedclient[0]?.gendertypekey),
      dob: moment(this.selectedclient[0]?.dob).format('MM/DD/YYYY'),
      age:this.calculateAge(this.selectedclient[0]?.dob),
      race:this.selectedclient[0]?.race,
      ethnicity :this.selectedclient[0]?.ethnicity
    })
  }
  if(!this.clientlist){
    this.personid = client;

  }
    this.loadcasenumber(client);
    this.viewsavebutton =true;
    if(this.personid){
      this.getothercurrentmedication();
    }
  }
  loadcasenumber(personid?: any) {
    // To display unique case numbers on intial page load
    if(personid == null || personid  == undefined || personid == ''){
     this.caselist =_.uniqBy(this.clientlist ,"casenumber"); 
     this.cases = this.caselist;     
     //To patch the correct case numbers based on client selection dropdown, view and Edit 
    }else {
     this.cases = this.clientlist?.filter(item => item?.personid == personid); 
    }
     
    this.filteredCases = this.cases ? [...this.cases] : [];
   }

  
  

  updateTooltip() {
    
    let selectedValues= this.psychotropicprescriptionreviewForm?.controls['targetedsymptoms']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val :any) => 
      this.targetedsymptomsList?.find(item => item?.value === val)?.text
    ).filter((text:any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }

  psychosocialTooltip() {
    
    let selectedValues= this.psychotropicprescriptionreviewForm?.controls['additionalpsychosocialinterventions']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val:any) => 
      this.psychosocialinterventionlist?.find(item => item?.value === val)?.text
    ).filter((text:any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }
  mentalUpdateTooltip(){
    let selectedValues= this.psychotropicprescriptionreviewForm?.controls['diagnosis']?.value
    if(selectedValues){
    const selectedSymptoms = selectedValues?.map((val:any) => 
    this.diagnosisList?.find(item => item?.value === val)?.text
    ).filter((text:any) => text != null);
    
    return selectedSymptoms.join(', ') ;}
    else{
      return null
    }
  }

  frequencyupdateTooltip(){

    let selectedValues= this.psychotropicprescriptionreviewForm?.controls['frequency']?.value
    if(selectedValues){
      return this.frequencydropdown?.find(item => item?.ref_key === selectedValues)?.description;
    }
    else{
      return null
    }
  }
  goback() {
    this.isAddEdit = false;
    this.statusfilter ='all';
   this.reviewstatusfilter ='all'
    this.psychotropicprescriptionreviewForm?.reset();
    this.psychotropicprescriptionreviewForm?.enable();
    this.rejectreason = '';
    this.rejectreasoncomments = '';
    this.decisiontext = '';
    this.psychotropicprescriptionreviewForm?.patchValue({
      rejectreason: '',
      rejectreasoncomments: ''
    });
    this.uploadedFiles =[];
    this.submissionhistory = [];
     this.otherreviewerselected =false;
     this.assigntootherreviewer='';
     this.otherselectedreviewer='';   
     this.selectedpsychotropicid ='';
     this.paginationInfo.pageNumber = 1;
     this.searchandsortquery= {};
    this.showothersymptoms = false;
    this.loadclientlist();
    this.showotherdiagnosis = false;
    this.showotherprescriberdegree = false;
    this.showotherprescriberspeciality =false;
    this.peerreview  =false;
    this.psychatristcomments ='';
    this.pharmacistcomments = '';
    this.coordinatorcomments ='';
    this.viewsavebutton =false;
    this.currentothermedicationlist = [];
    this.peertopeerreq =false;
    this.otherfreqreq =false;
    this.showpeerreview = false;
    this.peerreviewmand =false;
    this.informationincomplete =false;
    this.caseworkercomments =[]; 
    this.rejectedcomments= '';
    this.statusbasedbuttion = false;
    this.returnedtoworkerentry =false;
    this.sessionstorageservice.setItem('FROM_NOTIFICATION','');
    this.sessionstorageservice.setItem('FROM_REPORT','');
    this.requestid ='';
    this.showotheraddpsychosocial =false;
    this.routetoallcordinator =false;
    this.assignedtocoordinator =false;
    this.showresetbutton = false;
    this.checkforuserassignment =false;
    this.assignToPharmacist = false;
    this.assignToPsychiatrist =false;
    this.returnworker = false;
    this.statusCheckForCwSP = false;
    this.commentshistory =[];
    this.resetFeedback();
    this.getlist();
   
    
    

  }

handleUpdateOperation = async (tempID: string, updatedby:string, newId: string) => {
  try {
    if (tempID && newId)  {
      const res = await this.updateTemporaryId(tempID, updatedby, newId).toPromise();
      if (res === false) {
        console.error('Error: Update operation failed.');
        return false;
      }
      this.updateCompleted = true;
      this.getlist();
      return true; 
    }
    } catch (err) {
      console.error('Error updating temp ID', err);
      throw err; 
      }
    };
   
    updateTemporaryId(temporaryId: string, updatedby:any, newId: string): Observable<any> {
      return this.commonHttpService.create(
        {
          method: 'post',
          temporaryId: temporaryId,
          newId: newId,
          updatedby: updatedby
        },
        'Documentproperties/updateTemporaryId'
      );
    }
    uploadclosed(event:any){
      if(event){
      this.documentuploaded.closeupload();
      this.load = true;
      }
    }
      delete(id: any){
        this.commonHttpService.remove(id, {}, 'psychotropicmedications/psychotropicodreftdelete').subscribe();
      }
  
  saveasdraft(ifdraft?:any) {
    if (ifdraft) {
      this.psychotropicprescriptionreviewForm.patchValue({
        isdraft: ifdraft
      })
    }
    if(this.psychotropicprescriptionreviewForm.controls.psychotropicid.value && this.iscaseworker){
      this.delete(this.psychotropicprescriptionreviewForm.controls.psychotropicid.value)
    }
    let savedata = this.psychotropicprescriptionreviewForm.getRawValue();
    savedata = this.processSaveData(savedata, ifdraft);
    if(this.selectedpsychotropicid){
      savedata.psychotropicid = this.selectedpsychotropicid
    }
    if (!savedata.placeholderIDforUploadedFiles) {
      savedata.placeholderIDforUploadedFiles = this.placeholderIDforUploadedFiles;
    }
    if(this.currentothermedicationlist){
    savedata.psycotrophicothercurrentmedication = this.currentothermedicationlist;
  }

    
  this.commonHttpService
  .create(savedata, 'psychotropicmedications/addpsychotropicmedications')
  .subscribe(async response => {
    this.selectedpsychotropicid = response[0]?.addpsychotropicmedications[0]?.psychotropicid;
    this.othercurrentmedicationid = response[0]?.addpsychotropicmedications[0]?.psycotrophicothercurrentmedicationid;
     await(this.handleUpdateOperation(this.placeholderIDforUploadedFiles,this.user?.securityusersid, this.selectedpsychotropicid));
     if(this.selectedpsychotropicid && this.routetoallcordinator){
       this.updateReviewer();
     }
    if (response && ifdraft) {
      this.alertService.success("Psychotropic Prescription Drafted Successfully");      
   
    }
      

  });        
   
  }

  processSaveData(savedata: any, ifdraft: any){
    if(this.iscaseworker){
      savedata.objectid = this.objectid;
      savedata.objecttypekey = this.objecttypekey;
        if(this.savedatafn(savedata.psychotropiccomments,ifdraft)){
       const  caseworkercomment ={
          'comments' : savedata.psychotropiccomments,
          'displayname' : this.currentuser?.user?.userprofile?.displayname,
          'submittedon' : moment(new Date()).format('MM/DD/YYYY hh:mm a')
  
        }
        
         if(this.appendcomment){
           this.caseworkercomments.push(caseworkercomment);
           savedata.psychotropiccomments = this.caseworkercomments;
          }
          else{
            savedata.psychotropiccomments = [caseworkercomment];
          }
  
      }else{
        if(this.returnedtoworkerentry){
          const  caseworkercomment ={
            'comments' : savedata.psychotropiccomments,
            'displayname' : this.currentuser?.user?.userprofile?.displayname,
            'submittedon' : moment(new Date()).format('MM/DD/YYYY hh:mm a')
    
          }
          this.caseworkercomments.push(caseworkercomment);
           savedata.psychotropiccomments = this.caseworkercomments;
        }
      }
      }
      if (!this.iscaseworker) {
        savedata.objectid = this.objectid;
       savedata.objecttypekey = this.objecttypekey;
        savedata.casenumber = this.casenumber;
      }
      return savedata;
  }


  savedatafn(comments: any,ifdraft: any){
  return comments && !ifdraft;
  }
  sendforpharmacist() {
    this.assignToPharmacist = true;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.informationincomplete =false;
    this.returnworker = false;
    this.curentroletypekey = 'CWPSYPHARM';
    this.peerreview =false;
    this.sendforreview();
  }
  sendforpsychiatrist() {
    this.assignToPsychiatrist = true;
    this.assignToPharmacist = false;
    this.informationincomplete =false;
    this.returnworker = false;
    this.reviewcoordinatorlist = null;
    this.curentroletypekey = 'CWPSYPSYCH';
    this.peerreview = false;
    this.sendforreview();
  }
  peertopeerreview(){
    this.peerreview =true;
    this.informationincomplete =false;
    this.assignToPsychiatrist = false;
    this.assignToPharmacist = false;
    this.reviewcoordinatorlist = false;
    this.returnworker = false;
    this.curentroletypekey = this.toCheckCurentROle;
    this.updateReviewer(); 

  }
  sendforreview() {
    this.reviewcoordinatorlist = null;
    if (this.psychotropicprescriptionreviewForm.status !== 'INVALID' && (this.uploadedFiles?.length != 0)) {
        if(this.toCheckCurentROle =='CWCW'){
        this.routetoallcordinator =true;
        this.saveasdraft();

      } else{
        this.saveasdraft();
      (<any>$('#list-reviewcoordinator')).modal('show');
      this.getReviewer();
      }
    }  else{
      if(!this.uploadedFiles || this.uploadedFiles?.length == 0){
        this.alertService.error("Please upload Section A of the Informed Consent Form");
      }else{
        this.alertService.error("Please fill the required fields");
      }
    }
  }

  updateReviewer() {
     if (!this.selectedpsychotropicid) {
      this.saveasdraft();
    }
    if (this.toCheckCurentROle == 'CWCW') {
     if(this.returnedtoworkerentry){
      this.statustexttype = 'psychotropic_return_reviewcoordinator'
     } else{
     this.statustexttype ='psychotropic_initial_submission';
     }
  
      this.statusmessage ='Successfully sent for review'
    }
    if (this.toCheckCurentROle == 'CWPSYCOORD') {
      this.coordinatorstatusupdate();
   }
   
      this.getstatusTxtMsg();
    if(this.informationincomplete){
    
      this.statustexttype = 'psychotropic_incomplete';//incomplete_to_reviewcordinator
      this.statusmessage ='The review status changed to information incomplete';
      this.saveasdraft();
    
    } else if(this.peerreview){
      this.statustexttype = 'peer_to_peer';
      this.statusmessage ='The review status changed to Peer to Peer Review';
      this.saveasdraft();
    } else if(this.returnworker){
      this.statustexttype = 'psychotropic_return';
      this.statusmessage ='The Psychotropic medication review is returned to worker';
      this.saveasdraft();
    }
    
    if (this.psychotropicprescriptionreviewForm.status !== 'INVALID') {
    const data = {
      psychotropicid: this.selectedpsychotropicid,
       module: 'psychotropicmedications',
      tosecurityusersid: this.tosecurityusersid,
      statustext: this.statustexttype,
      comments:this.psychotropicprescriptionreviewForm.value.comments,
      rejectcomments :this.rejectcomments,
      rejectreason : null
    };
    if (this.psychotropicprescriptionreviewForm.controls['decisiontext'].value === 'Reject') {
      data.rejectreason = this.psychotropicprescriptionreviewForm.controls['rejectreason'].value;
      data.rejectcomments = this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].value;
    }
    this.commonHttpService
      .create(data, 'psychotropicmedications/psychotropicrouting')
      .subscribe(response => {
        this.toCheckRoutingStatues = true;
        
        (<any>$('#list-reviewcoordinator')).modal('hide');
        this.alertService.success(this.statusmessage);
        this.goback();
      });
    }
    else{
        this.alertService.error("Please fill the required fields");
      }
  }

  getstatusTxtMsg(){
    if (this.toCheckCurentROle == 'CWPSYPHARM') {
      if(this.assignToPsychiatrist) {
      this.statustexttype = 'pharmacist_to_psychiatrist';
      this.statusmessage ='Successfully Assigned to Psychiartist';
    } 
    if(this.assignToPharmacist){
      this.statustexttype = 'pharmacist_to_pharmacist';
      this.statusmessage ='Successfully Assigned to Pharmacist';
  
    }
  }
     if(this.toCheckCurentROle == 'CWPSYPSYCH'){
     if(this.assignToPharmacist){
      this.statustexttype = 'psychiatrist_to_pharmacist';
      this.statusmessage ='Successfully Assigned to Pharmacist';
     }  
     if(this.assignToPsychiatrist){
      this.statustexttype = 'psychiatrist_to_psychiatrist';
      this.statusmessage ='Successfully Assigned to Psychiartist';
     }
    }

    if (this.toCheckCurentROle == 'CWPSYCOORD') {
    if(this.assignToPsychiatrist) {
      this.statustexttype = 'reviewcoordinator_to_psychiatrist';
      this.statusmessage ='Successfully Assigned to Psychiartist';
    } else if(this.assignToPharmacist){
      this.statustexttype = 'reviewcoordinator_to_pharmacist';
      this.statusmessage ='Successfully Assigned to Pharmacist';
    } else if (this.statustexttype == 'psychotropic_reject') {
      this.statustexttype = 'psychotropic_reject';
      this.statusmessage = 'The Psychotropic medication review is rejected';
    } else {
      this.statustexttype = 'assign_to_reviewcoordinator';
      this.statusmessage = 'The Psychotropic medication review is assigned to Co-ordinator';
    }
    }

  }

  coordinatorstatusupdate(){
    if(this.assignedtocoordinator){
      this.assignToPharmacist = false;
      this.assignToPsychiatrist = false;
      this.reviewcoordinatorlist = null;
      this.informationincomplete =false;
      this.peerreview =false;
      this.returnworker = false;
      this.statustexttype = 'caseworker_to_reviewcoordinator';
      this.statusmessage ='Successfully Assigned to Co-ordinator';

    }
    else if(this.assignToPsychiatrist) {
      this.statustexttype = 'reviewcoordinator_to_psychiatrist';
      this.statusmessage ='Successfully Assigned to Psychiartist';
    } else if(this.assignToPharmacist){
      this.statustexttype = 'reviewcoordinator_to_pharmacist';
      this.statusmessage ='Successfully Assigned to Pharmacist';
      
    }
  }

  onChangeSupervisor(supervisor:any) {
    if (supervisor) {
      this.disablerouting = true;
      this.tosecurityusersid = supervisor?.securityusersid;
    } else {
      this.disablerouting = false;
      this.tosecurityusersid = null;
    }

  }

  getReviewer() {
    if (!this.reviewcoordinatorlist || (this.reviewcoordinatorlist && this.reviewcoordinatorlist.length == 0)) {
      let reqObj = {};

      reqObj = {
        roletypekey: this.curentroletypekey
      };
      this.commonHttpService
        .getArrayList(
          {
            page: 1,
            method: 'get',
            where: reqObj
          },
          'psychotropicmedications/getpsychotropicroutinguserlist?filter'
        ).subscribe(result => {
          this.reviewcoordinatorlist = result[0].psychotropicroutinguserlist;
          if(this.showassignreviewer){
            this.reviewcoordinatorlist =  this.reviewcoordinatorlist.filter((item:any)=>item.securityusersid !== this.user.securityusersid)
          }
         
        });
    }
  }
  callApi(query:any) {
    const data = JSON.parse(query);
    
      if(data.reset){
        this.otherreviewerselected = false;
        this.assigntootherreviewer='';
        this.searchandsortquery = {};
        this.reloadwithreviewstatus('all', this.isValue);
      } else{
        this.searchandsortquery = data
        this.getlist();
        
      }  
  }
  pageChanged(pageInfo:any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.pageInfo.sortColumn = pageInfo.query.sortColumn;
    this.pageInfo.sortBy = pageInfo.query.sortDirection;
    this.searchandsortquery = pageInfo.query;
    this.getlist();
  }
  pageNumberChanged(pageInfo:any) {
    this.pageInfo.pageNumber = pageInfo.page;
    this.paginationInfo.sortColumn = pageInfo.query.sortColumn;
    this.paginationInfo.sortBy = pageInfo.query.sortDirection;
    this.searchandsortquery = pageInfo.query;
  }
  onSortedlist(event: any) {
    event = JSON.parse(event);
    this.paginationInfo.sortBy = event.sortDirection;
    this.paginationInfo.sortColumn = event.sortColumn;
    this.searchandsortquery = event;
    this.getlist();
  }
  
  handleAuthIdEvent(data:any) {
    // No data or function to add or call
  }
  getDateFormatted(date: any) {
    if (date && moment(date).isValid()) {
      return moment(date).format('MM/DD/YYYY')
    } else {
      return ''
    }
  }
  navigateToDestination(event:any, data:any) {
    this.isAddEdit = true;
    this.commentText = '';
    this.requestid = JSON.parse(event).psychotropicrequestid;
    
    this.vieworeditmedicationform(event);

    if (event) {
      const eventData: any = JSON.parse(event);
      this.selectedData = eventData;
      this.recordAssignedToMe = this.user.securityusersid === eventData.edituser;
      this.recordStatus = eventData.reviewstatus;
      this.statusCheckForCwSP = this.shouldShowAssignMeButtonToCW(eventData);
      this.objectid = eventData.objectid;
      this.objecttypekey =eventData.objecttypekey;
      this.personid= eventData.personid;
      if (eventData.Action == 'view') {
        this.psychotropicprescriptionreviewForm.disable();
        this.submitdecisionlist =[]
        this.viewsubmitbutton = false;
      }
      else if (eventData.Action == 'edit') {
        this.handleIfActionIsEditFn(event);
      } else if(eventData.Action == 'delete'){
        this.handleIdActionIsDeleteFn(event);
      }else{
        this.psychotropicprescriptionreviewForm.disable();
      }
   
      if( (eventData.Action == 'edit') && this.checkAndReturnCheckCurentRoleDataFn(event)){
        this.viewsubmitbutton = true;
      }else{
        this.submitdecisionlist =[]
        this.viewsubmitbutton = false;
        this.reviewstatus =eventData.reviewstatus;
      const review =eventData.reviewstatus;
       this.submitdecisionlist =[review];
        this.psychotropicprescriptionreviewForm.patchValue({
          decisiontext: review
        })
      }
      this.selectedpsychotropicid = eventData?.psychotropicid;
      this.selectedcasenumbernofi = eventData?.casenumber;
      this.selectedclientname = eventData?.clientname;
      this.selectedcjamspid = eventData?.cjamspid;
      this.getothercurrentmedication();
    if(this.viewsubmitbutton){
      this.handleSubmitdecisionlistDataFn(event);
    }
    if(eventData.peerreview){
      this.peertopeerreq = true;
    }
    }

  }
  // Assosiated to navigateToDestination method
  private handleSubmitdecisionlistDataFn(event: any) {
    if (JSON.parse(event).reviewstatus == 'Awaiting Assignment' || ((JSON.parse(event).reviewstatus == 'Information Incomplete' || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review') && this.toCheckCurentROle === 'CWPSYCOORD')) {
      this.submitdecisionlist = ['Assign to Pharmacist', 'Assign to Psychiatrist', 'Information Incomplete', 'Peer to Peer Review','Return to Worker', 'Reject'];
    } else if (JSON.parse(event).reviewstatus == 'Pending Pharmacist Review' || ((JSON.parse(event).reviewstatus == 'Information Incomplete' || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review') && this.toCheckCurentROle === 'CWPSYPHARM')) {
      this.submitdecisionlist = ['Approve', 'Assign to Psychiatrist', 'Peer to Peer Review', 'Reject', 'Return to Co-ordinator', 'Return to Worker', 'Information Incomplete'];
    } else if (JSON.parse(event).reviewstatus == 'Pending CAP Review' || ((JSON.parse(event).reviewstatus == 'Information Incomplete' || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review') && this.toCheckCurentROle === 'CWPSYPSYCH')) {
      this.submitdecisionlist = ['Approve', 'Assign to Pharmacist', 'Peer to Peer Review', 'Reject', 'Return to Co-ordinator', 'Return to Worker', 'Information Incomplete'];
    } else if (JSON.parse(event).reviewstatus == 'Return to Worker') {
      this.submitdecisionlist = '';
    } else if (this.iscaseworker) {
      this.submitdecisionlist = '';
    }
  }
  // Assosiated to navigateToDestination method
  private checkAndReturnCheckCurentRoleDataFn(event: any) {
    return ((this.toCheckCurentROle === 'CWPSYCOORD' && (JSON.parse(event).reviewstatus === 'Awaiting Assignment' || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review' || JSON.parse(event).reviewstatus == 'Information Incomplete'))
      || (this.toCheckCurentROle === 'CWPSYPHARM' && (JSON.parse(event).reviewstatus === 'Pending Pharmacist Review' || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review' || JSON.parse(event).reviewstatus == 'Information Incomplete'))
      || (this.toCheckCurentROle === 'CWPSYPSYCH' && (JSON.parse(event).reviewstatus === 'Pending CAP Review'
       || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review' 
       || JSON.parse(event).reviewstatus == 'Information Incomplete')
       ));
  }
  // Assosiated to navigateToDestination method
  private checkReviewstatusFn(event: any) {
    if (JSON.parse(event).reviewstatus == 'Request Psychiatrist Review') {
      this.requestPsychiatrist = true;
    } else {
      this.requestPsychiatrist = false;
    }
    if (this.iseditable && (JSON.parse(event).reviewstatus == 'Awaiting Assignment' || JSON.parse(event).reviewstatus == 'Request Psychiatrist Review')) {
      this.coordinatorbnt = true;
    } else {
      this.coordinatorbnt = false;
    }
    if ((JSON.parse(event).reviewstatus == 'Draft' || JSON.parse(event).reviewstatus == 'Returned to Worker') && JSON.parse(event).Action == 'edit') {
      this.showsendforreview = true;
    } else {
      this.showsendforreview = false;
    }
    if (JSON.parse(event).reviewstatus == 'Draft' || JSON.parse(event).reviewstatus == null || JSON.parse(event).reviewstatus == undefined || JSON.parse(event).reviewstatus == 'Returned to Worker') {
      this.statusbasedbuttion = true;
    } else {
      this.statusbasedbuttion = false;
    }
  }
  // Assosiated to navigateToDestination method
  private handleIdActionIsDeleteFn(event: any) {
    const data = JSON.parse(event);
    this.iseditable = false;
    this.isAddEdit = false;
    this.deleterecord(data.psychotropicid);
  }
  // Assosiated to navigateToDestination method
  private handleIfActionIsEditFn(event: any) {
    this.iseditable = true;
    this.view = false;
    this.psychotropicprescriptionreviewForm.enable();
    this.disableclientdetails();
    if (JSON.parse(event).reviewstatus !== 'Draft' && JSON.parse(event).reviewstatus !== 'Returned to Worker') {
      this.psychotropicprescriptionreviewForm.disable();
      if (!this.iscaseworker && (JSON.parse(event).reviewstatus !== 'Initial Submission/Coordinator Assignment Pending' ||JSON.parse(event).reviewstatus !== 'Coordinator Assignment Pending' )) {
        this.psychotropicprescriptionreviewForm.controls['isinfoincomplete'].enable();
        this.psychotropicprescriptionreviewForm.controls['decisiontext'].enable();
        this.psychotropicprescriptionreviewForm.controls['peerreview'].enable();
        this.psychotropicprescriptionreviewForm.controls['reviewedby'].enable();
        this.psychotropicprescriptionreviewForm.controls['revieweddate'].enable();
        this.psychotropicprescriptionreviewForm.controls['peerdecision'].enable();
        const data = JSON.parse(event);
        this.objectid = data.objectid;
        this.objecttypekey = data.objecttypekey;
        this.casenumber = data.casenumber;
      }else{
        this.psychotropicprescriptionreviewForm.controls['reviewedby'].disable();
      }
      if ( ((JSON.parse(event).reviewstatus == 'Awaiting Assignment'
       || JSON.parse(event).reviewstatus == 'Information Incomplete' 
       || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review' ) && this.toCheckCurentROle == 'CWPSYCOORD') 
       || ((JSON.parse(event).reviewstatus == 'Pending Pharmacist Review'  || JSON.parse(event).reviewstatus == 'Information Incomplete' 
       || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review') && this.toCheckCurentROle == 'CWPSYPHARM') || ((JSON.parse(event).reviewstatus == 'Pending CAP Review'  || JSON.parse(event).reviewstatus == 'Information Incomplete' 
       || JSON.parse(event).reviewstatus == 'Pending Peer To Peer Review') && this.toCheckCurentROle == 'CWPSYPSYCH')) {
        this.psychotropicprescriptionreviewForm.controls['comments'].enable();
      }
    }

    if(JSON.parse(event).reviewstatus !== 'Draft') {
      this.psychotropicprescriptionreviewForm.controls['personid'].disable();
      this.psychotropicprescriptionreviewForm.controls['casenumber'].disable();
      this.psychotropicprescriptionreviewForm.controls['casenumberhoh'].disable();
      this.psychotropicprescriptionreviewForm.controls['clientdetails'].disable();
    }
  }

  async vieworeditmedicationform(event:any) {
    this.view = true;
    this.otherMedicalDetails = [];
    this.commentshistory = [];
    let data = JSON.parse(event);
    const result: any = await firstValueFrom(this.commonHttpService.getArrayList(
      { where: { securityusersid: data.insertedby }, method: 'get' },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getcase + '?filter'));
    this.clientlist =result[0]?.getcasenumberpsychotropic;
    this.clients =this.clientlist;
    this.caselist =_.uniqBy(this.clientlist ,"casenumber");
    this.cases = this.caselist;
    this.filteredCases = this.cases;
    this.selectedcasenumber = data.casenumber;
    this.selectedclient = data.personid;
    this.selectedpsychotropicid= data.psychotropicid;
    this.checkReviewstatusFn(event);
    this.clientselected(this.selectedclient);
    if(!this.sessionstorageservice.getItem('FROM_REPORT')){
      this.showassigntome =this.toCheckCurentROle ==='CWPSYCOORD' && (data.reviewstatus =='Initial Submission/Coordinator Assignment Pending' || data.reviewstatus =='Coordinator Assignment Pending');
      this.showreassign=this.toCheckCurentROle ==='CWPSYCOORD' && data.reviewstatus =='Awaiting Assignment' && this.user.securityusersid!== data.edituser; 
    }
     
    this.getsubmissionhistory(data?.psychotropicid);
    this.getMedicationPsychotropicList(data?.personid, data?.psychotropicid);
    if(this.toCheckCurentROle == 'CWPSYPHARM'){
this.latesthistoryname=data.pharmacist;
    }
    if(this.toCheckCurentROle == 'CWPSYPSYCH'){
      this.latesthistoryname=data.psychiatrist;
    }
   data = this.processViewEditmedicationform(data);
    if(!event.placeholderIDforUploadedFiles){
    
    this.additionalobjectid = this.randomIdGeneratorService.generateRandomId();
      this.placeholderIDforUploadedFiles = this.additionalobjectid;  
      
    
   } 
   this.additionalobjectid = event ? event.psychotrpoicid : this.getadditionalobjectid(event) ; //Check
    this.psychotropicprescriptionreviewForm.patchValue(data);
    
    this.notcaseworkerroles(data);
    this.submittedby = data.submittedby;
    this.submittedon = data.submittedon;
   this.vieworeditpatchfunction(data);
    if(this.psychotropicprescriptionreviewForm.get('psychotropiccomments')?.value){
    this.caseworkercomments = JSON.parse(this.psychotropicprescriptionreviewForm.get('psychotropiccomments')?.value);
    }
    if( JSON.parse(event).reviewstatus == 'Returned to Worker' && data.psychotropiccomments){
      this.appendcomment = true;
      this.psychotropicprescriptionreviewForm.patchValue({
        psychotropiccomments:null
      })
 }

 if(this.iscaseworker && JSON.parse(event).reviewstatus !== 'Draft'){
  this.psychotropicprescriptionreviewForm.patchValue({
    psychotropiccomments:null
  })
 }
  }

  processViewEditmedicationform(data: any){
    if (data?.targetedsymptoms) {
      const item = JSON.parse(data.targetedsymptoms);
      data.targetedsymptoms =item;

    }
    if (data?.additionalpsychosocialinterventions) {
      const item = JSON.parse(data.additionalpsychosocialinterventions);
      data.additionalpsychosocialinterventions =item;

    }
    if (data?.diagnosis) {
      const item = JSON.parse(data.diagnosis);
      data.diagnosis =item;

    }
    if(data?.othermedications){
      const item =JSON.parse(data.othermedications);
      data.othermedications = item;
    }
    if(data?.dob){
      
      if(this.statusbasedbuttion){
        data.age = this.calculateAge(data.dob)
      }
      
      data.dob = this.getDateFormatted(data.dob);
    }
    if(data?.gender){
      data.gender =this.selectgender(data.gender);
    }  
    return data; 
  }

  private vieworeditpatchfunction(data: any) {
    if (data.psychotropicid) {
      this.additionalobjectid = data.psychotropicid;
    } else {
      this.additionalobjectid = this.randomIdGeneratorService.generateRandomId();
      this.placeholderIDforUploadedFiles = this.additionalobjectid;
    }
    if (data.othersymptoms) {
      this.showothersymptoms = true;
    }
    if (data.otherdiagnosis) {
      this.showotherdiagnosis = true;
    }
    if(data.prescriberspecialty === 'OTH'){
      this.showotherprescriberspeciality =true;
    }
    if(data.otheradditionalpsychosocialinterventions){
      this.showotheraddpsychosocial =true;
    }
    if (data.uploadedfiles) {
      this.uploadedFiles = data.uploadedfiles?.filter((attachment:any) => attachment.additionalobjectid === data.psychotropicid || attachment.additionalobjectid === data.placeholderIDforUploadedFiles);
      this.isupload = true;
    }
    if (data.peerreview) {
      this.showpeerreview = true;
    }
  }

  private notcaseworkerroles(data: any) {
    if (this.recordStatus  !== '' && this.recordStatus !== 'Draft'){
      if(this.psychotropicprescriptionreviewForm?.value?.psychotropiccomments ){
        this.caseworkercomments = JSON.parse(this.psychotropicprescriptionreviewForm?.value?.psychotropiccomments);
        }
      this.caseworker = data.submittedby;
      this.caseworkersubmittedon = moment(data.submittedon).format('MM/DD/YYYY hh:mm a');
      var casenumber = data.casenumber ;
      if(data.objecttypekey !='adoptioncase'){
       casenumber = data.casenumber + '-' + data.hoh;
      }
      const clientdetail = data.clientname + '-' + data.cjamspid;
      this.psychotropicprescriptionreviewForm.patchValue({
        casenumberhoh: casenumber,
        clientdetails: clientdetail
      });
    }
  }

  onCaseSearch() {
    this.filteredCases = this.caselist.filter((caseItem) => {
      const caseSearchFilter = this.psychotropicprescriptionreviewForm.value.caseSearchFilter;
      return caseItem.casenumber.toLowerCase().includes(caseSearchFilter.toLowerCase()) ||
      caseItem.hoh.toLowerCase().includes(caseSearchFilter.toLowerCase());
    });
  }

  private getadditionalobjectid(event: any): string {
    return event?.placeholderIDforUploadedFiles ? event?.placeholderIDforUploadedFiles : this.additionalobjectid;
  }

  getSuggestedmedicine() {


    if (this.psychotropicprescriptionreviewForm.value.medicationname) {

      this.suggestions = this.suggestedMedicine.filter((c:any) => c.description.toLowerCase().startsWith(this.psychotropicprescriptionreviewForm.value.medicationname.toLowerCase()))
    }
  }
  selectedmedicine(item:any) {
    this.psychotropicprescriptionreviewForm.patchValue({
      medicationname: item.description,
      classification:item.parentkey
    })
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
          this.suggestedMedicine.sort((a:any, b:any) => a.description.localeCompare(b.description));
        }
      })

  }
  private loadDropDowns() {
  this.getgenderlist();
  this.getclassification();
    const source = forkJoin([
      this.commonHttpService
        .getArrayList(
          {
            where: { "tablename": "frequencytype", "teamtypekey": this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),

      this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 339, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
      this.commonHttpService
        .getArrayList(
          {
            where: { "tablename": "targetedsymptomspsychotropic", "teamtypekey": this.teamTypeKey, order: 'displayorder ASC' },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
      this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500600, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
      this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500601, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500605, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500604, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500602, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500603, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 500606, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),
        this.commonHttpService
        .getArrayList(
          {
            where: { referencetypeid: 903, teamtypekey: this.teamTypeKey },
            method: 'get'
          },
          this.gettypesurl + '?filter'
        ),

    ]).pipe(
      map((result) => {

        return {
          frequency: this.reusableResultMapFn(result[0]),
          medicalclassification: this.reusableResultMapFn(result[1]),
          targetedsymptoms: this.reusableResultSortAndMapFn(result[2]),
          methodofdelivery: this.reusableResultSortAndMapFn(result[3]),
          prescribedduration: this.reusableResultSortAndMapFn(result[4]),
          diagnosis: this.reusableResultMapFn(result[5]),
          medicationsetting: this.reusableResultMapFn(result[6]),
          prescriberdegree: this.reusableResultMapFn(result[7]),
          prescriberspeciality: this.reusableResultMapFn(result[8]),
          psychosocialintervention: this.reusableResultMapFn(result[9]), 
          othermedications: this.reusableResultMapFn(result[10])
          };
      }),
      share());

    this.frequency$ = source.pipe(pluck('frequency'));
    this.medicationClassification$ = source.pipe(pluck('medicalclassification'));
    this.targetedsymptoms$ = source.pipe(pluck('targetedsymptoms'));
    this.medicationClassification$.subscribe(data => {
      const sorting = _.sortBy(data, 'text');
      this.medicationClassification = sorting;
    });
    
   this.diagnosislist$ =source.pipe(pluck('diagnosis'));
   this.diagnosislist$.subscribe(data => {
    this.diagnosisList = data;
  });

    this.targetedsymptoms$.subscribe(data => {
      this.targetedsymptomsList = data;
    });
    this.methodofdelivery$ = source.pipe(pluck('methodofdelivery'));
    this.methodofdelivery$.subscribe(data => {
      this.methodofdeliverylist = data;
    });
    this.prescribedduration$ = source.pipe(pluck('prescribedduration'));
    this.prescribedduration$.subscribe(data => {
      this.prescribeddurationlist = data;
    });
    this.medicationsetting$ =source.pipe(pluck('medicationsetting'));
    this.medicationsetting$.subscribe(data=>{
      this.medicationsettinglist =data;
    })
    this.prescriberdegreelist$ =source.pipe(pluck('prescriberdegree'));
    this.prescriberdegreelist$.subscribe(data=>{
      this.prescriberdegree =data;
    })

    this.prescriberspecialitylist$ =source.pipe(pluck('prescriberspeciality'));
    this.prescriberspecialitylist$.subscribe(data=>{
      this.prescriberspeciality =data;
    })
    this.psychosocialintervention$ =source.pipe(pluck('psychosocialintervention'));
    this.psychosocialintervention$.subscribe(data=>{
      this.psychosocialinterventionlist =data;
    })
    this.othermedications$ =source.pipe(pluck('othermedications'));
    this.othermedications$.subscribe(data=>{
      this.othermedicationslist =data;
    })
    


    this.commonHttpService.getArrayList({
      where: { "tablename": "frequencytype", "teamtypekey": this.teamTypeKey },
      method: 'get'
    }, this.gettypesurl + '?filter').subscribe(data => {
      this.frequencydropdown = data;
    });


  }
  private reusableResultSortAndMapFn(result: any) {
    const sortedDataTemp = result.sort((a:any, b:any) => (a.displayorder - b.displayorder))
    return this.reusableResultMapFn(sortedDataTemp);
  }

  private reusableResultMapFn(result: any) {
    return result.map(
      (res:any) => new DropdownModel({
        text: res.description,
        value: res.ref_key
      })
    );
  }

  check(value:any) {
    // No data or function to call or add
  }
  approval() {
    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.statustexttype = 'psychotropic_approve';
    this.statusmessage ='Approved Successfully'
    this.updateReviewer();
  }

  reject() {
    this.statustexttype = 'psychotropic_reject';
    this.statusmessage = 'The Psychotropic medication review is rejected';
    if (!this.psychotropicprescriptionreviewForm.controls['rejectreason'].value) {
      this.alertService.error("Please select a reject reason");
      return;
    }
    if (this.psychotropicprescriptionreviewForm.controls['rejectreason'].value === 'Others' && !this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].value) {
      this.alertService.error("Please provide comments for the reject reason 'Others'");
      return;
    }

    (<any>$('#reject-popup')).modal('show');
   
  }
  confirmreject(){
    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.statustexttype = 'psychotropic_reject';
    this.statusmessage = 'The Psychotropic medication review is rejected';
    (<any>$('#reject-popup')).modal('hide');
    this.updateReviewer();
  
  }

  returntoworker() {
    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.informationincomplete =false;
    this.peerreview =false;
    this.returnworker =true;
    this.updateReviewer();
  }
  returntocoordinator(){

    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.returnworker = false;
    this.informationincomplete =false;
    this.statustexttype = 'return_to_reviewcoordinator';
    this.statusmessage ='The Psychotropic medication review is returned to Co-ordinator';
    this.updateReviewer();
  }

  
  needpsychiatristreview() {
    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    this.reviewcoordinatorlist = null;
    this.statustexttype = 'pharmacist_to_reviewcoordinator';
    this.statusmessage ='The Psychotropic medication review is send for Psychiatrist review'
    this.updateReviewer();
  }
  updateLoad() {
    this.load = false;
  }
  getsubmissionhistory(event:any){
    this.commonHttpService.getArrayList({
      where: {
        psychotropicid: event
        
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.GetHistory + '?filter'
    ).subscribe(result => {
      if (result) {
             this.submissionhistory = result[0].getpsychotropichistory;
             if(this.toCheckCurentROle ==='CWPSYCOORD'){
              this.latesthistoryname =result[0]?.getpsychotropichistory[0]?.displayname;
             }
             this.submissionHistoryCheck();

             this.commentshistory = result[0].getpsychotropichistory?.map((item: any) => {
              return {
                  comments: item.comments,  
                 role: item.fromroleid   ,
                 insertedon:item.insertedon,
                 displayname :item.displayname
                };
          });
          this.caseworkercomments = this.caseworkercomments?.map((comment:any) => {
            return {
              comments: comment.comments, 
              insertedon: comment.submittedon?comment.submittedon:comment.insertedon,
              displayname :comment.displayname,
                role: 'CWCW'
            };
        });
        
          this.commentshistory = this.commentshistory?.concat(this.caseworkercomments);

        this.commentshistory= this.commentshistory?.sort((a:any,b:any)=>moment(b.insertedon).valueOf()- moment(a.insertedon).valueOf())

            this.pharmacistcomments  = this.submissionhistory?.filter((item:any)=>item.fromroleid =='CWPSYPHARM')
            this.psychatristcomments = this.submissionhistory?.filter((item:any)=>item.fromroleid =='CWPSYPSYCH')
            this.coordinatorcomments = this.submissionhistory?.filter((item:any)=>item.fromroleid =='CWPSYCOORD') 
            const returnedtoworkerentry = this.submissionhistory?.filter((item:any)=>item.typedescription =='Returned to Worker');
            if(returnedtoworkerentry && returnedtoworkerentry?.length && this.iscaseworker){
              this.returnedtoworkerentry =true;
              if(this.psychotropicprescriptionreviewForm?.value?.psychotropiccomments){
              this.caseworkercomments = JSON.parse(this.psychotropicprescriptionreviewForm?.value?.psychotropiccomments);}
              this.psychotropicprescriptionreviewForm.patchValue({
                psychotropiccomments :null

              })
            }
            const rejected =     this.submissionhistory?.filter((item:any)=>item.typedescription == 'Rejected')
            if(rejected && rejected.length> 0){
            this.rejectreasoncomments =rejected[0].rejectcomments ? rejected[0].rejectcomments : rejected[0].rejectreasoncomments
            this.rejectreason = rejected[0].rejectedreason ? rejected[0].rejectedreason : rejected[0].rejectreason
            }

        // check if the reject is last action then show the rejectreason, rejectreasoncomments formcontrols value to set in the form and i can see it in the html
        const sortedhistory = this.submissionhistory?.sort((a:any,b:any)=>moment(b.insertedon).valueOf()- moment(a.insertedon).valueOf())
        if(sortedhistory && sortedhistory.length >0 && sortedhistory[0].typedescription == 'Rejected'){
          this.rejectreason = sortedhistory[0].rejectreason ? sortedhistory[0].rejectreason : sortedhistory[0].rejectreason;
          this.rejectreasoncomments = sortedhistory[0].rejectcomments ? sortedhistory[0].rejectcomments : sortedhistory[0].rejectreasoncomments;
        }
      }
    })

  }


  getMedicationPsychotropicList(personid: any, psychotropicid: any) {
    this.commonHttpService.getArrayList({
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      method: 'get',
      where: { personid: personid}
    },  CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.GetOtherMedicalList + '?filter').subscribe((result: any) => {
      if(!result || result.length === 0) {
        this.otherMedicalDetails = [];
      } else {
        const medicalDetailsList: any = result?.[0]?.psychotropicpersonmedicallist;
        this.otherMedicalDetails = medicalDetailsList.filter((item:any) => item.psychotropicid !== psychotropicid && item.reviewstatus !== null);
        this.otherMedicalDetails = this.returnSortedListDataFn(this.otherMedicalDetails);
      }
    });
  }

  submissionHistoryCheck(){
    this.edituser=this.submissionhistory?.[0]?.tosecurityusersid
    this.editusername =this.submissionhistory?.[0]?.displayname;
    if(this.assignedtocoordinator){

      if( this.edituser !== null && this.edituser !== this.user.securityusersid){
        this.alertService.error('The submission cannot be made. This request is assigned to ' + this.editusername);
        this.goback();
      }else{
        this.updateReviewer();
      }
    }
    if(this.checkforuserassignment){
      if( this.edituser !== this.user.securityusersid ){
          this.alertService.error('The submission cannot be made. This request is assigned to ' +this.editusername );
        this.goback();
      }else{
        this.checkforuserassignment =false;
        this.submitdecisionafterchecking();
      }
      
    }
  }
  frequencychanged(value: any){
    if(value !== 'EHD'){
      this.psychotropicprescriptionreviewForm.controls['specifyhour'].reset();
        
      this.psychotropicprescriptionreviewForm.controls['specifyhour'].clearValidators();
      this.psychotropicprescriptionreviewForm.controls['specifyhour'].updateValueAndValidity();
      this.psychotropicprescriptionreviewForm.patchValue({
        specifyhour:null
      })
    }  
     if(value !== 'OTH'){
          this.otherfreqreq = false;
      this.psychotropicprescriptionreviewForm.patchValue({
        otherfrequency:null
      })
      this.psychotropicprescriptionreviewForm.controls['otherfrequency'].reset();
        
      this.psychotropicprescriptionreviewForm.controls['otherfrequency'].clearValidators();
      this.psychotropicprescriptionreviewForm.controls['otherfrequency'].updateValueAndValidity();
     

    }else if(value === 'OTH'){
      this.otherfreqreq =true;
    }
  }
  symptomschanged(event:any){
    const targetedsymptoms = this.psychotropicprescriptionreviewForm.controls['targetedsymptoms'].value
   if(targetedsymptoms?.includes('OTH')){
    this.showothersymptoms =true;
   }else{
         this.showothersymptoms = false;
         this.psychotropicprescriptionreviewForm.patchValue({
          othersymptoms :null
         })
   }
     

  }
  psychosocialchange(event:any){
    const psychosocial = this.psychotropicprescriptionreviewForm.controls['additionalpsychosocialinterventions'].value
   if(psychosocial?.includes('OTH')){
    this.showotheraddpsychosocial =true;
   }else{
         this.showotheraddpsychosocial  = false;
         this.psychotropicprescriptionreviewForm.patchValue({
          otheradditionalpsychosocialinterventions :null
         })
   }
     

  }
  psychosocial(event:any){
    if(event == 'false'){
          this.psychotropicprescriptionreviewForm.controls['additionalpsychosocialinterventions'].clearValidators();
    this.psychotropicprescriptionreviewForm.controls['additionalpsychosocialinterventions'].updateValueAndValidity();
    }
    this.showotheraddpsychosocial =false;
    this.psychotropicprescriptionreviewForm.patchValue({
      otheradditionalpsychosocialinterventions :null,
      additionalpsychosocialinterventions:null
     })

  }
  diagnosischanged(event:any){
    const diagnosis = this.psychotropicprescriptionreviewForm.controls['diagnosis'].value
   if(diagnosis?.includes('OTH')){
    this.showotherdiagnosis =true;
   }else{
         this.showotherdiagnosis = false;
            
      this.psychotropicprescriptionreviewForm.controls['otherdiagnosis'].clearValidators();
      this.psychotropicprescriptionreviewForm.controls['otherdiagnosis'].updateValueAndValidity();
         this.psychotropicprescriptionreviewForm.patchValue({
          otherdiagnosis :null
         })
   }

  }
  deleterecord(id:any){
    // No data or function to call or add
  }
  getgenderlist(){
    this.genderlist =[]
    this.commonHttpService
  .getArrayList(
    {
      where: { "tablename": "gender", teamtypekey: this.teamTypeKey },
      method: 'get'
    },
    this.gettypesurl + '?filter'
  )
      .subscribe(res => {
          this.genderlist.push(...res);
      });

  }
 
selectgender(gender:any){
  
  const result: any = this.genderlist.filter(item => item.ref_key == gender);
  if(result==null){
    return result[0]?.description;
  }else{
    return gender=='M'? 'Male' : 'Female';
  }
  
      
}
disableclientdetails(){
        this.psychotropicprescriptionreviewForm.controls['clientname'].disable();
        this.psychotropicprescriptionreviewForm.controls['cjamspid'].disable();
        this.psychotropicprescriptionreviewForm.controls['gender'].disable();
        this.psychotropicprescriptionreviewForm.controls['dob'].disable();
        this.psychotropicprescriptionreviewForm.controls['age'].disable();
        this.psychotropicprescriptionreviewForm.controls['race'].disable();
        this.psychotropicprescriptionreviewForm.controls['ethnicity'].disable();
        this.psychotropicprescriptionreviewForm.controls['countytypekey'].disable();
}  
filterSpecifyHour() {
  if (this.psychotropicprescriptionreviewForm.value.specifyduration) {
  this.filterSpecifyHourSugg = this.hourList.filter(option =>  option.toLowerCase().indexOf(this.psychotropicprescriptionreviewForm.value.specifyduration?.toLowerCase()) === 0);
  }
}
clearOtherSpecifiedvalues(value:any){
  if(value !='OTH'){
  this.psychotropicprescriptionreviewForm.patchValue({ otherspecifyduration: null });
       this.otherprescduration = false;
     
        this.psychotropicprescriptionreviewForm.controls['otherspecifyduration'].reset();
        
        this.psychotropicprescriptionreviewForm.controls['otherspecifyduration'].clearValidators();
        this.psychotropicprescriptionreviewForm.controls['otherspecifyduration'].updateValueAndValidity();
  }else{
    this.otherprescduration = true;
  }
  if(value !== 'XDY' || value !='XWE'){
     this.psychotropicprescriptionreviewForm.controls['specifyduration'].reset();
    this.psychotropicprescriptionreviewForm.controls['specifyduration'].clearValidators();
    this.psychotropicprescriptionreviewForm.controls['specifyduration'].updateValueAndValidity();
  }
}
getrolenameanddescription(item:any){
  let rolename= ''
  if(item.fromroleid === 'CWPSYCOORD'){
  rolename = 'Psychotropic Co-ordinator'
  } else if(item.fromroleid === 'CWPSYPHARM'){
    rolename ='Pharmacist'
  }else if(item.fromroleid === 'CWPSYPSYCH') {
    rolename ='Psychiatrist'
  }
 
  return (rolename + ' : ' + item.displayname);

}
formatphonenumber(phoneNumber:any){
  if(phoneNumber){
return this.commonDropDownService.formatPhoneNumber(phoneNumber);
  }
}
calculateAge(dob:any){
 
  if (dob) {
    const age = { years: 0, months: 0, days: 0, totalMonths: 0, duration: null };
    age.years = this.returnYearFn(dob);
    age.totalMonths = this.returnTotalMonthFn(dob);
    age.months = this.returnMonthFn(age);
    age.days = this.returnDaysFn(dob);
    age.duration = this.returnDurationFn(dob);
    const ddays = this.returnDDaysFn(age);
    const dmonths = this.returnDMonthsFn(age);
    const dyears = this.returnDYearsFn(age);
    return `${dyears} Years ${dmonths} month(s) ${ddays} Day(s)`;
  }
}
// Associated to calculatePersonAge function
private returnDYearsFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
  return (age.duration.years()) ? age.duration.years() : 0;
}
// Associated to calculatePersonAge function
private returnDMonthsFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
  return (age.duration.months()) ? age.duration.months() : 0;
}
// Associated to calculatePersonAge function
private returnDDaysFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }) {
  return (age.duration.days()) ? age.duration.days() : 0;
}
// Associated to calculatePersonAge function
private returnDurationFn(dob: any): any {
  return moment.duration(moment(Date.now()).diff(moment(dob)));
}
// Associated to calculatePersonAge function
private returnDaysFn(dob: any): number {
  return (moment().diff(dob, 'days', false)) ? moment().diff(dob, 'days', false) : 0;
}
// Associated to calculatePersonAge function
private returnMonthFn(age: { years: number; months: number; days: number; totalMonths: number; duration: any; }): number {
  return (age.totalMonths - (age.years * 12)) ? age.totalMonths - (age.years * 12) : 0;
}
// Associated to calculatePersonAge function
private returnTotalMonthFn(dob: any): number {
  return (moment().diff(dob, 'months', false)) ? moment().diff(dob, 'months', false) : 0;
}
// Associated to calculatePersonAge function
private returnYearFn(dob: any): number {
  return (moment().diff(dob, 'years', false)) ? moment().diff(dob, 'years', false) : 0;
}

prescriberdegreechanged(event: any){
  const prescriberdegree = this.psychotropicprescriptionreviewForm.controls['prescriberdegree'].value
 if(prescriberdegree?.includes('OTH')){
  this.showotherprescriberdegree =true;
 }else{
       this.showotherprescriberdegree= false;
       this.psychotropicprescriptionreviewForm.controls['otherprescriberdegree'].clearValidators();
       this.psychotropicprescriptionreviewForm.controls['otherprescriberdegree'].updateValueAndValidity();
            
       this.psychotropicprescriptionreviewForm.patchValue({
        otherprescriberdegree :null
       })
 }
   

}
prescriberspecialitychanged(event:any){
  const prescriberspeciality = this.psychotropicprescriptionreviewForm.controls['prescriberspecialty'].value
 if(prescriberspeciality?.includes('OTH')){
  this.showotherprescriberspeciality =true;

 }else{
  this.showotherprescriberspeciality= false;
  
  this.psychotropicprescriptionreviewForm.controls['otherprescriberspecialty'].reset();
        
  this.psychotropicprescriptionreviewForm.controls['otherprescriberspecialty'].clearValidators();
  this.psychotropicprescriptionreviewForm.controls['otherprescriberspecialty'].updateValueAndValidity();
       this.psychotropicprescriptionreviewForm.patchValue({
        otherprescriberspecialty :null
       })
 }
}

infoincomplete(){
   this.informationincomplete = true;
  this.returnworker = false;
  this.assignToPsychiatrist = false;
  this.assignToPharmacist = false;
  this.reviewcoordinatorlist = null;
  this.curentroletypekey = this.toCheckCurentROle;
  this.peerreview =false;
  this.updateReviewer(); 

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
     
      this.countylistdropdown = response;
  });

}
decisionchanged(event:any){
this.decisiontext =event;
if(event == 'Peer to Peer Review'){
  this.peerreviewmand =true;
  this.psychotropicprescriptionreviewForm.controls['peerreview'].updateValueAndValidity();
  
} else{
  this.peerreviewmand = false;
  this.psychotropicprescriptionreviewForm.controls['rejectreason'].enable();
  this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].enable();
  this.psychotropicprescriptionreviewForm.controls['rejectreason'].updateValueAndValidity();
  this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].updateValueAndValidity();
}
}

  rejectReasonChanged(event: any) {
    this.rejectreason = event;
    // check if the event is present in the rejectReasons array
    if (event && this.rejectReasons.includes(event)) {
      this.psychotropicprescriptionreviewForm.controls['rejectreason'].setValue(event);
      this.psychotropicprescriptionreviewForm.controls['rejectreason'].updateValueAndValidity();
      if (event === 'Others') {
        this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].setValidators([Validators.required]);
      } else {
        this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].clearValidators();
        this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].setValue(null);
      }
      this.psychotropicprescriptionreviewForm.controls['rejectreasoncomments'].updateValueAndValidity();
    } else {
      this.alertService.error("Please select valid reject reason");
    }
  }
  submitdecision() {
    this.checkforuserassignment = true;
    this.getsubmissionhistory(this.selectedpsychotropicid);
}

submitdecisionafterchecking(){
  if (this.decisiontext) {
    if (this.decisiontext === 'Assign to Psychiatrist') {
      this.sendforpsychiatrist();
    } else if (this.decisiontext === 'Assign to Pharmacist') {
      this.sendforpharmacist();
    } else if (this.decisiontext === 'Approve') {
      this.approval();
    }else if(this.decisiontext === 'Reject'){
      this.reject();
    } else if(this.decisiontext === 'Information Incomplete'){
    this.infoincomplete();
  }else if(this.decisiontext === 'Peer to Peer Review'){
   this.peertopeerreview();
  } else if(this.decisiontext === 'Return to Worker'){
    this.returntoworker();

  } else if(this.decisiontext === 'Return to Co-ordinator'){
    this.returntocoordinator();
    
  }
}
  else {
    this.alertService.error("Please select decision status")
  }

}

addothermedications(){
  this.currentMedicationEditAction = false;
 (<any>$('#add-othermedication')).modal('show');
  
}


getothercurrentmedication(){

  this.commonHttpService.getArrayList({
    where: {
      psychotropicid:this.selectedpsychotropicid,
      personid : this.personid
     
    },
    method: 'get'
  }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getcurrentmedications + '?filter'
  ).subscribe(result => {
    if (result) {
      this.currentothermedicationlist = result[0]["getothercurrentmedication"]
     
    }
  })

}

currentMedicationEditAction  : boolean = false;
currentothermedicationlistIdx : number = -1;
deleteOtherMedicationIdx: number = -1;

peertopeerchange(event: any){
if(!event){
  this.psychotropicprescriptionreviewForm.controls['reviewedby'].clearValidators();
  this.psychotropicprescriptionreviewForm.controls['reviewedby'].updateValueAndValidity();
  this.psychotropicprescriptionreviewForm.controls['revieweddate'].clearValidators();
  this.psychotropicprescriptionreviewForm.controls['revieweddate'].updateValueAndValidity();
  this.psychotropicprescriptionreviewForm.controls['peerdecision'].clearValidators();
  this.psychotropicprescriptionreviewForm.controls['peerdecision'].updateValueAndValidity();
  this.psychotropicprescriptionreviewForm.patchValue({
    reviewedby:null,
    revieweddate:null,
    peerdecision:null
   })
   this.peertopeerreq = false;
   
}else if(event){
  this.peertopeerreq = true;
}
}
reloadwithreviewstatus(event:any, tabselected: number = 1){
this.statusfilter = event;
this.reviewstatusfilter= event;
if(this.sessionstorageservice.getItem('FROM_REPORT')){
this.backbutton = false;

this.supervisorviewrecord();
} else{
this.isValue = tabselected;
this.getlist();
}
}
getstatuslist(){
  this.commonHttpService
      .getArrayList(
        {
          where: { referencetypeid: 500608, teamtypekey: this.teamTypeKey },
          method: 'get'
        },
        this.gettypesurl + '?filter'
      ).subscribe((result: any) => {
        if (result.length > 0) {         
         
         this.Statusfilterlist = result;
         if(!this.iscaseworker){
          this.Statusfilterlist = this.Statusfilterlist.filter((item:any)=>item.description !== 'Draft');
         }
         this.Statusfilterlist.sort((a:any, b:any) => a.description.localeCompare(b.description));
        }
      })

}
getclassification(){
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
          this.medicationClassificationlist.sort((a:any, b:any) => a.description.localeCompare(b.description));
        }
        
      })
}
getuserrole(fromroleid:any){
  switch(fromroleid){
    case 'CWPSYCOORD' : return 'Co-ordinator'
    case 'CWPSYPHARM' : return 'Pharmacist'
    case 'CWPSYPSYCH' : return 'Psychiatrist'
    case 'CWCW' : return 'Case Worker'
    case 'CWSP' : return 'Supervisor'
  }

}
reassigntoreviewpop(){
  (<any>$('#reassigntoreview_popup')).modal('show');

}

confirmcoordinator(value:any){
  (<any>$('#assigntocoordinator_popup')).modal('show');

}

assigntocoordinatorpop(value:any){
  if(value=='reassign'){
    this.assigntocoordinator(value);
    (<any>$('#assigntocoordinator_popup')).modal('hide');
  }else{
    (<any>$('#assigntocoordinator_popup')).modal('hide');
  }

}

assigntocoordinator(value:any){
  
  this.assignedtocoordinator = true;
  this.assignToPharmacist = false;
    this.assignToPsychiatrist =false;
  if(value ==='assign'){
    this.getsubmissionhistory(this.selectedpsychotropicid);
  }
  
 if(value === 'reassign'){
  this.updateReviewer();
 }
}
reassigntoreview(){
  (<any>$('#reassigntoreview_popup')).modal('hide');
  if (this.toCheckCurentROle == 'CWPSYPHARM') {
  this.assignToPharmacist = true; 
  this.assignedtocoordinator = false;
  this.assignToPsychiatrist =false;
  }
  else if (this.toCheckCurentROle == 'CWPSYPSYCH') {
    this.assignToPsychiatrist =true;
    this.assignToPharmacist = false; 
    this.assignedtocoordinator = false;
  }
  this.tosecurityusersid =this.otherselectedreviewer;
  this.updateReviewer();
}
  showotherreviewerlist(event:any) {
    this.otherreviewerselected = true;
    this.paginationInfo.pageNumber = 1;
    this.otherselectedreviewer = event;
    this.getotherroletypekey();
    this.getlist();

  }
  getotherroletypekey() {

    if (this.toCheckCurentROle == 'CWPSYPHARM') {
      this.otherroletypekey = 'OTHCWPSYPHARM';
    }
    else if (this.toCheckCurentROle == 'CWPSYPSYCH') {
      this.otherroletypekey = 'OTHCWPSYPSYCH';
    }
  }
  supervisorviewrecord(){
    this.commonHttpService.getArrayList({
      
      where: {
        securityusersid: this.user.securityusersid,
        psychotropicrequestid :this.sessionstorageservice.getItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_REQUEST_ID)
        
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.Getsupervisorviewrecord + '?filter'
    ).subscribe(result => {
      if (result) {
      const psychotropiclist = result?.[0]?.getpsychotropiclistbyrequestid?.[0];
       const datattopatch =JSON.stringify(psychotropiclist);
       this.navigateToDestination(datattopatch,datattopatch);
      }
    });
  }

  selectedSpecifyDuration(event:any){

  }
  // CIDM-10987 psychotropic all requests dashboard
  onTabChange(tabId: number) {
    this.isValue = tabId;
    this.goback();
  }
  // CIDM-10987 psychotropic all requests dashboard
  onSelect(openPopup: {id: string, selectedData: any}) {
    this.displayRole = '';
    this.displayrolekey = '';
    this.displayClientDetails.selectedRole = '';
    if (typeof openPopup.selectedData === 'string') {
      openPopup.selectedData = {Action: this.selectedData};
    }
    this.assignedtocoordinator = false;
    this.assignToPharmacist = false;
    this.assignToPsychiatrist = false;
    const openPopupActionData: any = openPopup.selectedData?.Action;
    const edituserData: any = openPopup.selectedData?.Action?.edituser;
    this.recordAssignedToMe = this.user.securityusersid === edituserData;
    this.recordStatus = openPopupActionData.reviewstatus;
    if(openPopupActionData.edituser) {
      this.getEditUserDetails(openPopupActionData.edituser);
    }
    const classificationdes: any = this.medicationClassificationlist.find((e: any) => e.ref_key === openPopupActionData.classification)
    this.displayClientDetails = {
      clientname: openPopupActionData.clientname,
      medicationname: openPopupActionData.medicationname,
      dateprescribed: openPopupActionData.dateprescribed,
      pharmacist: openPopupActionData.pharmacist,
      psychiatrist: openPopupActionData.psychiatrist,
      classification: classificationdes.description,
      gender: openPopupActionData.gender,
      casenumber: openPopupActionData.casenumber,
      cjamspid: openPopupActionData.cjamspid,
      psychotropicid: openPopupActionData.psychotropicid,
      edituser: openPopupActionData.edituser
    }
    this.resetFeedback();
    if(openPopup.id === '1') {
      this.assignToMe = true;
    } else if(openPopup.id === '2') {
      this.assignToOther = true;
    }
  }

  getEditUserDetails(id: string){
    this.commonHttpService.getArrayList({
      
      where: {
        id: id
      },
      method: 'get'
    }, CaseWorkerUrlConfig.EndPoint.DSDSAction.PsychotropicPrescriptionReview.GetEditUserDetails + '?filter'
    ).subscribe(result => {
      if(result && result.length > 0) {
          this.displayName = `${result[0].firstname} ${result[0].lastname}`;
          this.displayRole = this.returnRoleName(result);
      }
    });
  }

  private returnRoleName(result: any[]) {
    this.displayrolekey = result[0].roletypekey;
    if (this.displayrolekey === 'CWPSYPHARM') {
      return this.phrolename;
    } else if (this.displayrolekey === 'CWPSYPSYCH') {
      return this.psrolename;
    } else if (this.displayrolekey === 'CWCW' || this.displayrolekey === 'CWSP') {
      return 'Worker';
    } else {
      return this.rcrolename;
    }
  }

  onSelectionChange(event: any): void {
    const selectedRole: any = this.roleNameList.find((role: any) => role.securityusersid === event.value);
    this.displayClientDetails.selectedName = selectedRole.displayname;
    this.displayClientDetails.selectedId = selectedRole.securityusersid;
  }

  resetFeedback() {
    this.assignToMe = false;
    this.assignToOther = false;
    this.showConfirmation = false;
  }

  assign(data: any) {
    this.showConfirmation = true;
    this.commentText = data;
  }

  backToAssignForm() {
    this.showConfirmation = false;
  }
  // CIDM-10987 psychotropic all requests dashboard
  selectedRole(id: MatSelectChange) {
    this.roleNameList = [];
    this.displayClientDetails.selectedRole = '';
    this.assignedtocoordinator = false;
    this.assignToPharmacist = false;
    this.assignToPsychiatrist =false;
    if(id.value === '3') {
      this.getUserDetailsUsongRoleFn('CWPSYCOORD');
      this.displayClientDetails.selectedRole = this.rcrolename;
      this.assignedtocoordinator = true;
    } else if(id.value === '1') {
      this.getUserDetailsUsongRoleFn('CWPSYPHARM');
      this.displayClientDetails.selectedRole = this.phrolename;
      this.assignToPharmacist = true;
    } else if(id.value === '2') {
      this.getUserDetailsUsongRoleFn('CWPSYPSYCH');
      this.displayClientDetails.selectedRole = this.psrolename;
      this.assignToPsychiatrist =true;
    }
  }
  // CIDM-10987 psychotropic all requests dashboard
  getUserDetailsUsongRoleFn(rolekey: string) {
    this.commonHttpService
      .getArrayList(
        {
          page: 1,
          method: 'get',
          where: { roletypekey: rolekey }
        },
        'psychotropicmedications/getpsychotropicroutinguserlist?filter'
      ).subscribe((result: any) => {
        if(!result || result.length === 0) {
          return;
        }
        const roleNameListData = result[0].psychotropicroutinguserlist;
        this.roleNameList =  roleNameListData.filter((item:any)=>item.securityusersid !== this.user.securityusersid)
        
      });
  }
  // CIDM-10987 psychotropic all requests dashboard
  assignIdtoSelectedRole(modalcommentsdata?: any) {
    if(modalcommentsdata){
      this.commentText = modalcommentsdata;
    }
    this.statustexttype = '';
    this.getCurrentRoletypekey();
    if(!this.displayClientDetails.edituser) {
      this.ifNotassignedToAnyOneFn();
    } else {
      this.ifAlreadyAssignedFn();
    } 

    const data = {
      psychotropicid: this.displayClientDetails.psychotropicid,
      module: 'psychotropicmedications',
      tosecurityusersid: this.displayClientDetails.selectedId ?? this.user.securityusersid,
      statustext: this.statustexttype,
      comments: this.commentText
    };
    this.commonHttpService
      .create(data, 'psychotropicmedications/psychotropicrouting')
      .subscribe(() => {
        this.toCheckRoutingStatues = true;
        this.alertService.success(this.statusmessage);
        this.goback();
      });
  }
  // CIDM-10987 psychotropic all requests dashboard
  assignedRole(selectedData: string) {
    switch (selectedData) {
      case 'CWPSYCOORD_Review Coordinators':
      case 'CWPSYPSYCH_Review Coordinators':
      case 'CWPSYPHARM_Review Coordinators':
      case 'CWPSYCOORD_null':
        this.applyDefaultStatusFn();
        break;
      case 'CWPSYCOORD_Pharmacist':
        this.displayClientDetails.selectedRole = this.phrolename;
        this.statustexttype = 'reviewcoordinator_to_pharmacist';
        this.statusmessage = 'Successfully Assigned to Pharmacist';
        break;
      case 'CWPSYPSYCH_Pharmacist':
        this.displayClientDetails.selectedRole = this.phrolename;
        this.statustexttype = 'psychiatrist_to_pharmacist';
        this.statusmessage = 'Successfully Assigned to Pharmacist';
        break;
      case 'CWPSYPHARM_Pharmacist':
      case 'CWPSYPHARM_null':
        this.displayClientDetails.selectedRole = this.phrolename;
        this.statustexttype = 'pharmacist_to_pharmacist';
        this.statusmessage = 'Successfully Assigned to Pharmacist';
        break;
      case 'CWPSYCOORD_Psychiatrist':
        this.displayClientDetails.selectedRole = this.psrolename;
        this.statustexttype = 'reviewcoordinator_to_psychiatrist';
        this.statusmessage = 'Successfully Assigned to Psychiartist';
        break;
      case 'CWPSYPSYCH_Psychiatrist':
      case 'CWPSYPSYCH_null':
        this.displayClientDetails.selectedRole = this.psrolename;
        this.statustexttype = 'psychiatrist_to_psychiatrist';
        this.statusmessage = 'Successfully Assigned to Psychiartist';
        break;
      case 'CWPSYPHARM_Psychiatrist':
        this.displayClientDetails.selectedRole = this.psrolename;
        this.statustexttype = 'pharmacist_to_psychiatrist';
        this.statusmessage = 'Successfully Assigned to Psychiartist';
        break;
      case 'CWCW_Worker':
      case 'CWSP_Worker':
          this.displayClientDetails.selectedRole = 'Worker';
          this.statustexttype = 'sp_cw_assign';
          this.statusmessage ='The Psychotropic medication review is assigned to Caseworker';
          break;
      default:
        this.applyDefaultStatusFn();
        break;
    }
  }
  // CIDM-10987 psychotropic all requests dashboard
  applyDefaultStatusFn() {
    this.displayClientDetails.selectedRole = this.rcrolename;
    this.statustexttype = 'assign_to_reviewcoordinator';
    this.statusmessage = 'The Psychotropic medication review is assigned to Co-ordinator';
  }
  // CIDM-10987 psychotropic all requests dashboard
  currentUserRoleName() {
    if(this.toCheckCurentROle === 'CWPSYPHARM') {
      return this.phrolename;
    } else if(this.toCheckCurentROle === 'CWPSYPSYCH'){
      return this.psrolename;
    } else if (this.toCheckCurentROle === 'CWCW' || this.toCheckCurentROle === 'CWSP') {
      return 'Worker';
    } else {
      return this.rcrolename
    }
  }
  // CIDM-10987 psychotropic all requests dashboard
  private ifAlreadyAssignedFn() {
    const sRole: any = this.displayClientDetails.selectedRole ?? this.currentUserRoleName();
    this.assignedRole(`${this.toCheckCurentROle}_${sRole}`);
  }
  // CIDM-10987 psychotropic all requests dashboard
  private ifNotassignedToAnyOneFn() {
      const sRole: any = this.displayClientDetails.selectedRole ?? null;
      this.assignedRole(`${this.toCheckCurentROle}_${sRole}`);
  }

  shouldShowAssignMeButtonToCW(data: any): boolean {
        const status: any = data['reviewstatus'];
        let statusCheck: boolean = ['Returned to Worker'].includes(status);
        const checkname = this.currentuser?.user?.securityusersid === data.edituser;
        return !checkname && statusCheck;
    }

    shouldShowAssignButton(status: string): boolean {
        const statusCheck: any = ['Approved', 'Rejected', 'Returned to Worker'].includes(status);
        return !statusCheck;
    }

    handleView(data: any, action: string) {
      data.Action.Action = action;
      this.navigateToDestination(JSON.stringify(data.Action),'');
    }
}