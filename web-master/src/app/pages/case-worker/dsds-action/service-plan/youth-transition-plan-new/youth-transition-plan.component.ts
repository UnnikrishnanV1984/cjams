import { Component, Injector, OnInit, ChangeDetectorRef} from '@angular/core';
import { YouthTransitionPlanService } from './youth-transition-plan.service';
import { DataStoreService, AlertService, AuthService, CommonHttpService, CommonDropdownsService } from '../../../../../@core/services';
import { PaginationRequest, DropdownModel } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import jsPDF from 'jspdf';
import { MatRadioChange } from '@angular/material/radio';
import { addDays } from 'date-fns';
import { YTP_TABS } from './ytp-config';
import { Router, ActivatedRoute } from '@angular/router';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import {Observable } from 'rxjs';
import moment from 'moment';
import {elementToSVG} from 'dom-to-svg';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import _ from 'lodash';
import { map, share } from 'rxjs/operators';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'youth-transition-plan-new',
    templateUrl: './youth-transition-plan.component.html',
    styleUrls: ['./youth-transition-plan.component.scss'],
    standalone: false
})
export class YouthTransitionPlanComponent implements OnInit {
  ytpPlanGoalList?: any[];
  selectedYTPPlan: any;
  ytpData: any;
  selectedClientId!: string;
  approvalProcess!: string;
  selectedItem!: string;
  selectedPlan: any;
  selectedPlanId!: string;
  getUsersList: any[] = [];
  selectedPerson: any;
  selectService: any;
  gradeDropdownItems$!: Observable<DropdownModel[]>;
  gradeDropdownItems!: any[];
  IncomeFrequencyDropDownItem$!: Observable<DropdownModel[]>;
  IncomeFrequencyDropDownItem!: any[];
  id: any;
  daNumber: any;
  ytpPersonData: any;
  user!: AppUser;
  returnFormGroup!: FormGroup;
  viewReturnReason: any;
  isDeleteDisabled = false;
  followUpOneYearOrNot = false;
  isReadonly: boolean = true;
  confirmdecisionpopupid = '#confirm-decision';
  confirmCopypopupid = '#confirm-copy';
  tabs = YTP_TABS;
  showBusy!: boolean;
  personList: any[] = [];
  serviceData1: any = {
  "completed": "Application Completed.",
  "started": "Application Started.",
  "not started": "Application not Started.",
  "not applicable": "Not applicable for youth."
}
serviceData2: any = {
  "eligible": "Eligible.",
  "not eligible": "Not Eligible.",
  "not apply": "Did Not Apply."
}

eligInstitutionData: any = {
  "1": "Trust",
  "0": "ABLE"
}

  dropdownData: any = {
    "1": "Assisted Living",
    "2": "Correctional Facility",
    "3": "DDA Group Home",
    "4": "Family member or friend's home",
    "5": "Own Home",
    "6": "Hospital",
    "7": "Nursing Home",
    "8": "Psychiatric Facility",
    "9": "Respite",
    "10": "Non-DDA Group Home",
    "11": "Other"
  }
  
    private _ytpService: YouthTransitionPlanService;
    private _dataStoreService: DataStoreService;
    private _commonDropdownService: CommonDropdownsService;
    private alertService: AlertService;
    private _datastore: DataStoreService;
    private _authService: AuthService;
    private _commonhttp: CommonHttpService;
    private _alertservice: AlertService;
    private _router: Router;
    private route: ActivatedRoute;
    private childRemovalService: ChildRemovalService;
    private formBuilder: FormBuilder;
    private cdRef: ChangeDetectorRef;

    constructor(private injector:Injector) {
      this._ytpService= this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this._commonDropdownService=this.injector.get<CommonDropdownsService>(CommonDropdownsService);
      this.alertService = this.injector.get<AlertService>(AlertService);
      this._datastore = this.injector.get<DataStoreService>(DataStoreService);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._commonhttp = this.injector.get<CommonHttpService>(CommonHttpService);
      this._alertservice = this.injector.get<AlertService>(AlertService);
      this._router = this.injector.get<Router>(Router);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this.childRemovalService = this.injector.get<ChildRemovalService>(ChildRemovalService);
      this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
      this.cdRef = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
     }

  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  selYouth: any;
  ytpSummary: any = {};
  eduActions: any = [];
  eduResources: any = [];
  transportActions: any = [];
  transportResources: any= [];
  moneyResources: any = [];
  moneyActions: any = [];
  housingResources: any = [];
  housingActions: any = [];
  civicResources: any = [];
  civicActions: any = [];
  civicStrengths: any = [];
  civicAssessments: any = [];
  healthResources: any = [];
  healthActions: any = [];
  ytpRelationship: any = [];
  ytpSupportRoles: any = [];
  communityActions: any = [];
  meetingGoals: any = [];
  meetingActions: any = [];

  summaryAssessments: any = [];
  summaryStrengths: any = [];
  employementActions: any = [];
  employResources: any[] = [];
  employmentActions: any[] = [];
  documentResources: any[] = [];
  documentActions: any[] = [];
  youthDocuments: any[] = [];
  selectedFilterType!: string|null;
  snapshotVersions: any[] = [];
  selectedPeriod: any;
  selectedChild: any;
  selectedChildRemovalDate!: Date;
  selectedVersion: any;
  currentDate!: Date;
  periodList: any[] = [];
  snapshotFilterFormGroup!: FormGroup;  

  ngOnInit() {
    this.isDeleteDisabled = this._authService.isDisabled('services','services.youthtransitionplan.delete');
    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID); // '9725f731-43db-456d-bc82-7b4270218bc3'; test id
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.user = this._authService.getCurrentUser();
    if (this._dataStoreService.getData('YTP_SEL_CHILD')) {
       this.ytpPersonData = this._dataStoreService.getData('YTP_SEL_CHILD');
    }
    this.initForms();
    this.getInvolvedPerson();
    this.gradeDropdownItems$ = this._commonDropdownService.getPickListByName('gradelevel');
    this.IncomeFrequencyDropDownItem$ = this._commonDropdownService.getPickListByName('frequencyofincomereceipt');
    this.IncomeFrequencyDropDownItem$.subscribe((data: any) => {
      this.IncomeFrequencyDropDownItem = data;
    });
    this.gradeDropdownItems$.subscribe((data: any) => {
      const list = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
        'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'KDGN',
        'NIS', 'PSET', 'PSHS', 'UNK'];
      this.gradeDropdownItems = [];
      list.forEach(item => {
        const obj = data.find((ele: { ref_key: string; }) => ele.ref_key === item);
        this.gradeDropdownItems.push(obj);
      });
    });
    this._ytpService.onGetPerson.subscribe(data => {
      if (data) {
        this.selectedClientId = data;
        this.fetchRemovalHistoryAndInitializePeriods(this.selectedClientId);
        this._ytpService.getYTPPlanList(data).subscribe((item) => {
          this.ytpPlanGoalList = item.filter(i => !i.summary_json);
          this.selectedYTPPlan = null;
          this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        });
      }
    });
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-youthTransistionPlan');
    this.currentDate = new Date();
    this.initSnapshotFilterFormGroup();
  }

  initForms() {
    this.returnFormGroup = this.formBuilder.group({
      returnreason: [null, Validators.required],
    });
  }
  async fetchRemovalHistoryAndInitializePeriods(clientId: any) {
    if (!clientId) {
      this._alertservice.error('Failed to get removal history:');
      this.selectedChildRemovalDate = new Date();
      this.initPeriodList();
      this.setDefaultSnapshotFilterValues();
      return;
    }
    
    try {
      const removalData = await this.getRemovalHistoryOfPerson(clientId);
      if (removalData) {
        this.selectedChildRemovalDate = new Date(this._dataStoreService.getData('YTP_SEL_CHILD').removalInfo?.removaldate);
      } else {
        this._alertservice.error('Failed to get removal history:');      }
    } catch (error: any) {
      this._alertservice.error('Failed to get removal history:', error);
    }
    
    this.initPeriodList();
    this.setDefaultSnapshotFilterValues();
  }

  async getRemovalHistoryOfPerson(personid: any) {
    return new Promise((resolve, reject) => {
      this._commonhttp
        .getSingle(
          {
            where: { objectid: personid, 'objecttypekey': 'personid'},
            method: 'get'
          },
          `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
        ).subscribe({
          next: (data) => {
            console.log('Removal history data:', data);
            resolve(data || null);
          },
          error: (error) => {
            console.error('Error fetching removal history:', error);
            reject(error);
          }
        });
    });
  }
  createSnapshot() {
    // Here you would implement the logic to create a snapshot with the selected filter
    console.log('Creating snapshot with:', {
      filterType: this.selectedFilterType,
      period: this.selectedPeriod,
      dateRange: this.selectedFilterType === 'DATE_RANGE' ? {
        startDate: this.snapshotFilterFormGroup.get('startdate')?.value,
        endDate: this.snapshotFilterFormGroup.get('enddate')?.value
      } : null
    });
  }

  getPersonName(id: any) {
    return this._ytpService.getPersonName(id);
  }

  resetSelectedFilterType(): void {
    this.selectedFilterType = null;
  }

  setDefaultSnapshotFilterValues() {
    this.selectedFilterType = 'PERIOD_RANGE';
    this.snapshotFilterFormGroup.patchValue({
      startdate: new Date(),
      enddate: new Date()
    });
    if(this.periodList?.length>0){
      this.selectPeriod(this.periodList[0]);
    }
  }
  getVersionFilterStartDate() {
    if (this.selectedFilterType === 'DATE_RANGE') {
      return this.snapshotFilterFormGroup.get('startdate')?.value;
    } else 
    if (this.selectedFilterType === 'PERIOD_RANGE') {
      return this.selectedPeriod['fromdate'];
    }
    return this.selectedPeriod['fromdate'];
  }
  resetSelectedChild() {
    this.selectedChild = null;
    }

    selectChild(child: any) {
      this.selectedVersion = null;
      this.viewChildInfo(child);
      this.getChildRemovalDate();
      this._dataStoreService.setData('SELECTED_CHILD_DATA', this.selectedChild);
    }

  viewChildInfo(child: any) {
    this.selectedChild = child;
  }

  getVersionFilterEndDate() {
    if (this.selectedFilterType === 'DATE_RANGE') {
      return this.snapshotFilterFormGroup.get('enddate')?.value;
    } else 
    if (this.selectedFilterType === 'PERIOD_RANGE') {
      return this.selectedPeriod['todate'];
    }
    return this.selectedPeriod['todate'];
  }
  getChildRemovalDate() {
    this.selectedChildRemovalDate = new Date(this.selectedChild.removaldate);
  }
  changeSelectedFilterType(event: MatRadioChange): void {
    // No content to add or call
   }
  selectPeriod(item: any): void {
    this.selectedPeriod = item;
  }
  addDaysToRemovalDate(days: any){
    if(days == null){
      return null;
    }
    return addDays(this.selectedChildRemovalDate, days)
  }
  initPeriodList() {
    this.selectedPeriod = null;
    this.periodList = [
      this.initPeriod(1, 0, 60, '0-2', 60),
      this.initPeriod(2, 60, 180, '2-6', 120),
      this.initPeriod(3, 180, 360, '6-12', 180),
      this.initPeriod(4, 360, 540, '12-18', 180),
      this.initPeriod(5, 540, 720, '18-24', 180),
      this.initPeriod(6, 720, 900, '24-30', 180),
      this.initPeriod(7, 900, null, '30+', null)
    ];
  }
  initPeriod(key: any, periodstart: any, periodend: any, timeframe: any, numdays: any) {
    const _fromdate: any = this.addDaysToRemovalDate(periodstart);
    let _todate: any = this.addDaysToRemovalDate(periodend);
    if(!_todate && 
      ((this.currentDate >_fromdate && this.currentDate <=_todate) ||(this.currentDate >_fromdate && this.currentDate >=_todate)) && 
      _fromdate<=this.currentDate){
      _todate = this.currentDate; 
    }
    return {
      'fromdate': _fromdate,
      'todate': _todate,
      'key': key,
      'periodstart': periodstart,
      'periodend': periodend,
      'numdays': numdays,
      'timeframe': timeframe,
      'isPeriodPending': this.isPeriodPending(_fromdate, _todate) 
    };
  }
  initSnapshotFilterFormGroup() {
    this.snapshotFilterFormGroup = this.formBuilder.group({
      personlist: [null],
      startdate: [null],
      enddate: [null]
    });
  }
  isPeriodPending(fromdate: any, todate: any){
    const f = this.snapshotVersions?.find(version=>
      new Date(version.fromdate).setHours(0,0,0,0) == new Date(fromdate).setHours(0,0,0,0) &&
      (todate == version.todate || new Date(version.todate).setHours(0,0,0,0) == new Date(todate).setHours(0,0,0,0)) &&
      (version.approvalstatus == 'Pending' || version.approvalstatus== 'Draft' || version.approvalstatus == 'Approved')
    ) ;
    return f ? true : false;
  }
  checkforfuturedate(item: any){
    if((this.currentDate >item.fromdate && this.currentDate <=item.todate) ||(this.currentDate >item.fromdate && this.currentDate >=item.todate) ){
      return;
    } else {return 'disabledfield';}
   }


  selectPlan(item: any) {
    if (item['new_summary_json']) {
      item['new_summary_json'].ytpdropdownvalue = '';
    }
    const startdate = item?.startdate ? new Date(item.startdate).toLocaleDateString() : '';
    const enddate = item?.enddate ? new Date(item?.enddate).toLocaleDateString() : '';
    if (item['new_summary_json']) {
      item['new_summary_json'].ytpdropdownvalue = `${startdate} - ${enddate}`;
    }
    this.selectedYTPPlan = item;
    this.getYTPSummary(item);
    if(this.selectedYTPPlan.new_summary_json){
      this.selectedYTPPlan.new_summary_json = Object.assign(this.selectedYTPPlan.new_summary_json, this.ytpSummary);
    }
    this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
    this._ytpService.youthtransitionplanid = this.selectedYTPPlan.youthtransitionplanid;
    this.tabs = this._ytpService.processTabState(this.tabs, item);
    this.cdRef.detectChanges();
    this._ytpService.onGetYTPData.emit(this.selectedYTPPlan);
    this._router.navigate(['ytp-summary'], { relativeTo: this.route });
  }

  getYTPSummary(item: any) {
    this.ytpSummary.ytpdropdownvalue = item?.new_summary_json?.['ytpdropdownvalue'] ?? 
    `${item?.startdate ? new Date(item.startdate).toLocaleDateString() : ''} - ${item?.enddate ? new Date(item.enddate).toLocaleDateString() : ''}`;      this.ytpSummary.clientName = this._dataStoreService.getData('YTP_SEL_CHILD').personname;
    this.ytpSummary.dob = this._dataStoreService.getData('YTP_SEL_CHILD').dob;
    this.ytpSummary.caseno = this.childRemovalService.daNumber;
    this.ytpSummary.transplancompleted = item.completiondate ? item.completiondate : '';
    this.ytpSummary.planfollowupdate = item.nextduedate ? item.nextduedate : '';
    this.ytpSummary.effectivedate =this._dataStoreService.getData('YTP_SEL_CHILD').removalInfo?.removaldate;
    if(item.new_summary_json){        //@TM: Show data from DB once the plan is created and saved
      this.ytpSummary.participants = item.new_summary_json.participants ? item.new_summary_json.participants : [];
      this.ytpSummary.caseworkername = item.new_summary_json.caseworkername;
      this.ytpSummary.primarypermanencytype = item.new_summary_json.primarypermanencytype;
      this.ytpSummary.assessments = item.new_summary_json.assessments ? item.new_summary_json.assessments : [];
      const participants = this.ytpSummary.participants ?  this.ytpSummary.participants : [];
      const dsstaff = participants.filter((participant: { type: string; }) =>{  return participant.type === 'LDSS Staff'});

    	if(dsstaff.length >0){
      	  this.ytpSummary.caseworkername = `${dsstaff[0].firstname} ${dsstaff[0].lastname}`
    	}
    }
    this.getYTPSummaryApiFn(item);
  }

  private getYTPSummaryApiFn(item: any) {
    this._ytpService.getYTPSummary(item.clientid).subscribe(
      response => {
        if (response && Array.isArray(response) && response.length) {
          this.ytpSummary.primarypermanencytype = response[0].primarypermanencytype ? response[0].primarypermanencytype : '';
        }
      }
    );
  }

  private getpersonattachment() {
    const inputreq = {
      personid: this.selectedClientId,
      intakenumber: null,
      servicerequestid: null,
      servicecaseid: null,
      adoptioncaseid: null,
      objecttypekey: 'Person',
      category: ['Ready by 21'],
      subcategory: ['My Youth Transition Plan and Meeting Summary'],
      worker: null,
      title: null,
      sortcolumn: 'updatedon',
      sortby: 'desc',
      actualdocumentdate: null,
      activeflag: 1
    };

    this._commonhttp
      .getPagedArrayList(
        new PaginationRequest({
          where: inputreq,
          method: 'get',
          page: 0,
          limit: 1000
          // nolimit : true
        }),
        'Documentproperties/getcaseworkerattachments' + '?filter').subscribe((response: any) => {
          if (response && Array.isArray(response) && response.length) {
            this.getcaseworkerattachmentsApiResponseFn(response);
          } else {
            this.youthDocuments = [];
          }
        });
  }
  // Associate with getpersonattachment function
  private getcaseworkerattachmentsApiResponseFn(response: any[]) {
    let result = response[0].searchcaseworkerattachments;
    if (result) {
      const documnt = Array.isArray(this.selectedYTPPlan.new_meeting_json?.youthSignedDocument) ? this.selectedYTPPlan.new_meeting_json?.youthSignedDocument : [];
      result = result.map((item: any) => {
        if (documnt.includes(item.documentpropertiesid)) {
          item.documentattachment = (item.documentattachment && Array.isArray(item.documentattachment) && item.documentattachment.length > 0)
            ? item.documentattachment[0] : item.documentattachment;
          return item;
        }
      });
      result = result.filter((x: any) => !!x);
      this.youthDocuments = result;
    } else {
      this.youthDocuments = [];
    }
  }

  private convertSvgToPng(svgString: string, width: number, height: number): Promise<string> {
    return new Promise((resolve) => {
      const img = new Image();
      const svgBlob = new Blob([svgString], { type: 'image/svg+xml;charset=utf-8' });
      const url = URL.createObjectURL(svgBlob);

      img.onload = () => {
        const canvas = document.createElement('canvas');
        canvas.width = width;
        canvas.height = height;
        const ctx = canvas.getContext('2d')!;
        ctx.drawImage(img, 0, 0);
        URL.revokeObjectURL(url);
        resolve(canvas.toDataURL('image/png'));
      };

      img.onerror = (e) => {
        resolve('');
      };

      img.src = url;
    });
  }

  async downloadYTPPdf() {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    this.showBusy= true;
    for (let i = 0; i < pages.length; i++) {
      const pageElement = pages.item(i) as HTMLElement;
      const pageName = pageElement.getAttribute('data-page-name');
      if (pageName === 'Youth Transitional Plan') {
        const svgDoc = elementToSVG(pageElement);
        svgDoc.documentElement.querySelectorAll('image').forEach((image: Element) => {
          const xlinkHref =
            image.getAttribute('xlink:href') ||
            image.getAttributeNS('http://www.w3.org/1999/xlink', 'href');

          if (xlinkHref) {
            image.setAttribute('href', xlinkHref);
          }
        });
         // Skipping inlineResources() to avoid font MIME type errors on staging
        // Fonts are already rendered in the SVG, so inlining is not necessary
        const svgString = new XMLSerializer().serializeToString(svgDoc);
        const img = await this.convertSvgToPng(
          svgString,
          pageElement.offsetWidth,
          pageElement.offsetHeight
        );
        if (img && img.startsWith('data:image/png')) {
          pageImages.push(img);
        } else {
          console.warn('Skipped invalid image:', img);
        }
      }
    }
    if (pageImages.length > 0) {
      this.pdfFiles.push({ fileName: 'Youth Transitional Plan', images: pageImages });
    } else {
      console.warn('No valid page images to convert');
    }
    this.convertImageToPdf();
    this.showBusy=false;
  }

  convertImageToPdf() {
    this.pdfFiles.forEach((pdfFile) => {
      let doc: any = null;
      doc = new jsPDF();
      const width = doc.internal.pageSize.getWidth() - 10;
      const heigth = doc.internal.pageSize.getHeight() - 10;

      pdfFile.images.forEach((image, index) => {

        doc.addImage(image, 'PNG', 3, 5, width, heigth);
        if (pdfFile.images.length > index + 1) {
          doc.addPage();
        }
      });
      doc.save(pdfFile.fileName);
    });
    (<any>$('#youthTransPlan')).modal('hide');
    this.pdfFiles = [];
  }


private async prefillEducationFields(): Promise<boolean> {
  return new Promise<boolean>((resolve) => {
    this._ytpService.getYTPPlanEduList(this.selYouth.clientid).subscribe((data: any) => {
      let educationArray = [];
      
      if (data && typeof data === 'object' && 'personEducation' in data) {
        educationArray = data.personEducation;
        
        if (Array.isArray(educationArray) && educationArray.length) {
          const eduDetails = _.sortBy(educationArray, 'startdate').reverse();
          const latestEdu = eduDetails[0];
          
          this.selYouth.new_education_json = {
            ...this.selYouth.new_education_json,
            lastgradetypekey: latestEdu.highestgradetypekey,
            mostRecentSchool: latestEdu.educationname
          };
        }
      }
      
      resolve(true);
    }, error => {
      console.error('Error fetching education data:', error);
      resolve(false);
    });
  });
}
private async prefillHealthFields(): Promise<boolean> {
  return new Promise<boolean>((resolve) => {
    this._ytpService.getYTPPlanHealtList(this.selYouth.clientid).subscribe((response: any) => {
      let healthRecords = [];
      
      if (response && typeof response === 'object' && 'data' in response) {
        healthRecords = response.data;
        
        if (Array.isArray(healthRecords) && healthRecords.length) {
          const medicalData = healthRecords.filter(menu => menu.insurancetype !== 'VC' && menu.insurancetype !== 'DEN');
          const dentalList = healthRecords.filter(menu => menu.insurancetype === 'DEN');
          const visionList = healthRecords.filter(menu => menu.insurancetype === 'VC');
          
          this.selYouth.new_health_json = {
            ...this.selYouth.new_health_json,
            insuranceCompany: this.emptyStr(medicalData?.[0]?.medicalinsuranceprovider),
            policyNumber: this.emptyStr(medicalData?.[0]?.policynumber),
            coverageEndDate: this.emptyStr(medicalData?.[0]?.expirationdate),
            dentalInsurance: this.emptyStr(dentalList?.[0]?.medicalinsuranceprovider),
            dentalpolicyNumber: this.emptyStr(dentalList?.[0]?.policynumber),
            dentalCoverageEndDate: this.emptyStr(dentalList?.[0]?.expirationdate),
            visionInsurance: this.emptyStr(visionList?.[0]?.medicalinsuranceprovider),
            visionpolicyNumber: this.emptyStr(visionList?.[0]?.policynumber),
            visionCoverageEndDate: this.emptyStr(visionList?.[0]?.expirationdate)
          };
        }
      }
      
      resolve(true);
    }, error => {
      console.error('Error fetching health data:', error);
      resolve(false);
    });
  });
}

private async prefillEmploymentFields() {
  return new Promise(resolve => {
    this._ytpService.getYTPPlanEmploymentList(this.selYouth.clientid).subscribe(data => {
      data = data?.filter(e => !e.enddate || e.enddate > new Date());
      if (data?.length) {
        const sorted = _.sortBy(data, 'startdate').reverse();
        const latest = sorted[0];
        const address = this._ytpService.getYTPAddress(latest.address1, latest.address2, latest.cityname, latest.statetypekey, latest.zip5no);

        this.selYouth.new_employ_json = {
          ...this.selYouth.new_employ_json,
          employerName: latest.employername,
          position: latest.clienttitle,
          employerPay: latest.income,
          hoursPerWeek: latest.noofhours,
          employerPhone: latest.workphone?.[0]?.phonenumber ?? '',
          employerAddress: address,
          isFullTime: latest.emplymenttypekey === '1',
          isPartTime: latest.emplymenttypekey === '0',
        };

      }
      resolve(true);
    });
  });
}

private async prefillPermanencyPlanFields(): Promise<boolean> {
  return new Promise<boolean>((resolve) => {
    this._ytpService.getPermanencyPlanList().subscribe((data: any[]) => {
      if (Array.isArray(data) && data.length) {
        const personId = this.selYouth?.clientid || this.ytpData?.clientid;
        const permanencyplanList = data.filter(item => item.personid === personId);
        
        if (permanencyplanList?.length) {
          const approvedPlans = permanencyplanList[0].permanencyplans?.filter((p: { status: string; }) => p.status === 'Approved');
          
          if (approvedPlans && approvedPlans.length) {
            this.setnewconnectionsJson(approvedPlans);
          }
        }
      }
      
      resolve(true);
    }, error => {
      console.error('Error fetching permanency plan data:', error);
      resolve(false);
    });
  });
}

setnewconnectionsJson(approvedPlans: any){
  const latestRecord = _.sortBy(approvedPlans, 'establisheddate').reverse();
    if (latestRecord?.length) {
      const primary = latestRecord[0]?.primarypermanency?.[0];
      const concurrent = latestRecord[0]?.concurrentpermanency?.[0];
      
      this.selYouth.new_connections_json = {
        ...this.selYouth.new_connections_json,
        permanencyPlanId: this.emptyStr(primary?.permanencyplanid),
        primaryPermanencyType: this.emptyStr(primary?.permanencyplantypekey),
        concurrentPlanDesc: this.emptyStr(concurrent?.concurrentplandescription),
        renunification: primary?.permanencyplantypekey === 'Reunification',
        adoption: primary?.permanencyplantypekey === 'ADOPTR' || primary?.permanencyplantypekey === 'ADOPTNR',
        guardianShip: primary?.permanencyplantypekey === 'GUARDR' || primary?.permanencyplantypekey === 'Guardianship',
        plannedPermanent: primary?.permanencyplantypekey === 'APPLA',
        concurrentPlan: this.emptyStr(concurrent?.concurrentplandescription)
      };
    }
}

emptyStr(value: any){
  return value ? value : '';
}

async youthTransPlanPrint(modal: any) {
    this.selectedYTPPlan = modal;
    this.getpersonattachment();
    this.selYouth = modal;
    this.ytpPersonData = this._dataStoreService.getData('YTP_SEL_CHILD');
    this.ytpSummary = modal;
    this.selYouth.new_summary_json = modal.new_summary_json;
    await this.prefillEducationFields();
    await this.prefillEmploymentFields();
    await this.prefillHealthFields();
    await this.prefillPermanencyPlanFields();

    this.ytpEducationDetailsFn();

    this.ytpCurrentCheckFn();

    this.checkYtpLastgradetypekeyFn();

    this.checkYtpAllowanceWeeklyFn();

    this.checkYtpPartTimeWeeklyFn();

    this.checkYtpBenefitsWeeklyFn();

    this.checkYtpSilaWeeklyFn();

    this.checkYtpInheritanceWeeklyFn();

    this.checkYtpOtherWeeklyFn();


    if (this.ytpSummary.new_education_json?.eduActions) {
      this.eduActions = this.ytpSummary.new_education_json.eduActions;
    }
    if (this.ytpSummary.new_education_json?.goals) {
      this.eduResources = this.ytpSummary.new_education_json.goals;
    }
    if (this.ytpSummary.new_summary_json?.assessments) {
      this.summaryAssessments = this.ytpSummary.new_summary_json.assessments;
    }
    if (this.ytpSummary.new_summary_json?.strengths) {
      this.summaryStrengths = this.ytpSummary.new_summary_json.strengths;
    }

    this.ytpNewEmployJsonFn();

    this.ytpResourcesFn();

    this.ytpNewCommunityJsonFn();

    if (this.ytpSummary.new_meeting_json?.actions) {
      this.meetingActions = this.ytpSummary.new_meeting_json.actions;
    }
    if (this.ytpSummary.new_meeting_json?.goals) {
      this.meetingGoals = this.ytpSummary.new_meeting_json.goals;
    }

     if (this.ytpSummary.new_health_json?.actions) {
      this.healthActions = this.ytpSummary.new_health_json.actions;
    }
    if (this.ytpSummary.new_health_json?.goals) {
      this.healthResources = this.ytpSummary.new_health_json.goals;
    }

    this.ytpNewConnectionsJsonFn();

    if (this.ytpSummary.new_financial_empowerment_json?.actionToDoItems) {
      this.moneyActions = this.ytpSummary.new_financial_empowerment_json.actionToDoItems;
    }
    if (this.ytpSummary.new_financial_empowerment_json?.goals) {
      this.moneyResources = this.ytpSummary.new_financial_empowerment_json.goals;
    }

    this.checkYtpHavingDLFn();
    this.checkYtpYouthSignFn();

    (<any>$('#youthTransPlan')).modal('show');
  }
  // Associated with youthTransPlanPrint function
  private ytpEducationDetailsFn() {
    let onTrackDegree = '';

    if (this.selYouth?.new_education_json?.highSchool) {
      onTrackDegree += 'High School Diploma, ';
    }
    if (this.selYouth?.new_education_json?.isGED) {
      onTrackDegree += 'GED, ';
    }
    if (this.selYouth?.new_education_json?.alternateProgram) {
      onTrackDegree += 'Non-traditional/Alternative Program, ';
    }
    if (this.selYouth?.new_education_json?.isOther) {
      onTrackDegree += 'Other, ';
    }

    if (onTrackDegree) {
      this.selYouth.new_education_json.onTrackDegree = onTrackDegree;
    } else {
      if (this.selYouth.new_education_json?.onTrackDegree) {
        this.selYouth.new_education_json.onTrackDegree = '';
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private ytpResourcesFn() {
    if (this.ytpSummary.new_transportation_json?.actions) {
      this.transportActions = this.ytpSummary.new_transportation_json.actions;
    }
    if (this.ytpSummary.new_transportation_json?.goals) {
      this.transportResources = this.ytpSummary.new_transportation_json.goals;
    }
    if (this.ytpSummary.new_documentation_json?.actions) {
      this.documentActions = this.ytpSummary.new_documentation_json.actions;
    }
    if (this.ytpSummary.new_documentation_json?.goals) {
      this.documentResources = this.ytpSummary.new_documentation_json.goals;
    }
    if (this.ytpSummary.new_housing_json?.actions) {
      this.housingActions = this.ytpSummary.new_housing_json.actions;
    }
    if (this.ytpSummary.new_housing_json?.goals) {
      this.housingResources = this.ytpSummary.new_housing_json.goals;
    }
  }
  // Associated with youthTransPlanPrint function
  private ytpNewConnectionsJsonFn() {
    if (this.ytpSummary.new_connections_json?.communityActions) {
      this.communityActions = this.ytpSummary.new_connections_json.communityActions;
    }
    if (this.ytpSummary.new_connections_json?.relationship) {
      this.ytpRelationship = this.ytpSummary.new_connections_json.relationship;
    }
    if (this.ytpSummary.new_connections_json?.supportiveRelations) {
      this.ytpSupportRoles = this.ytpSummary.new_connections_json.supportiveRelations;
    }
  }
  // Associated with youthTransPlanPrint function
  private ytpNewCommunityJsonFn() {
    if (this.ytpSummary.new_community_json?.actions) {
      this.civicActions = this.ytpSummary.new_community_json.actions;
    }
    if (this.ytpSummary.new_community_json?.goals) {
      this.civicResources = this.ytpSummary.new_community_json.goals;
    }

    if (this.ytpSummary.new_community_json?.strengths) {
      this.civicAssessments = this.ytpSummary.new_community_json.strengths;
    }
    if (this.ytpSummary.new_community_json?.assessments) {
      this.civicStrengths = this.ytpSummary.new_community_json.assessments;
    }
  }
  // Associated with youthTransPlanPrint function
  private ytpNewEmployJsonFn() {
    if (this.ytpSummary.new_employ_json?.assessments) {
      this.employementActions = this.ytpSummary.new_employ_json.assessments;
    }

    if (this.ytpSummary.new_employ_json?.goals) {
      this.employResources = this.ytpSummary.new_employ_json.goals;
    }
    if (this.ytpSummary.new_employ_json?.employmentActions) {
      this.employmentActions = this.ytpSummary.new_employ_json.employmentActions;
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpYouthSignFn() {
    if (this.selYouth.new_summary_json && this.selYouth.new_summary_json.documentation_json
      && this.selYouth.new_summary_json.documentation_json.youthSign) {
      setTimeout(() => {
        this.createImage(this.selYouth.documentation_json.youthSign);
      }, 1000);
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpHavingDLFn() {
    if (this.selYouth.new_transportation_json?.havingDL == '1') {
      this.selYouth.new_transportation_json.havingDL = 'Have License';
    } else if (this.selYouth.new_transportation_json?.havingDL == '0') {
      this.selYouth.new_transportation_json.havingDL = 'Do not have';
    } else if (this.selYouth.new_transportation_json?.havingDL == '2') {
      this.selYouth.new_transportation_json.havingDL = 'Have Permit';
    }
  }
  // Associated with youthTransPlanPrint function
  private ytpCurrentCheckFn() {
    if (this.selYouth.new_summary_json && this.selYouth.new_summary_json.planfollowupdate && this.selYouth.new_summary_json.transplancompleted) {
      const followUpDateCheck = moment(this.selYouth.new_summary_json.planfollowupdate);
      const caseCreationDate = moment(this.selYouth.new_summary_json.transplancompleted);
      const currentCheck = followUpDateCheck.diff(caseCreationDate, 'days');
      if (currentCheck > 181) {
        this.followUpOneYearOrNot = false;
      } else {
        this.followUpOneYearOrNot = true;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpLastgradetypekeyFn() {
    if (this.ytpSummary.new_education_json?.lastgradetypekey) {
      const filterItem = this.gradeDropdownItems.filter(item => item.ref_key == this.ytpSummary.new_education_json.lastgradetypekey);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_education_json.lastgradetypekey = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpAllowanceWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.allowanceWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.allowanceWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.allowanceWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpPartTimeWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.partTimeWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.partTimeWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.partTimeWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpBenefitsWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.benefitsWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.benefitsWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.benefitsWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpSilaWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.silaWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.silaWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.silaWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpInheritanceWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.inheritanceWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.inheritanceWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.inheritanceWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  // Associated with youthTransPlanPrint function
  private checkYtpOtherWeeklyFn() {
    if (this.ytpSummary.new_financial_empowerment_json?.otherWeekly) {
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.otherWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.otherWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }

  createImage(data: any) {
    let image = new Image();
    let blob = new Blob([data], { type: 'image/png' });
    image.src = URL.createObjectURL(blob);
    document.body.appendChild(image);
  }

  createPlan(clientId: any, startdate = null, enddate = null, data: any = {}) {  
    if (startdate && enddate) {
      const start = new Date(startdate);
      const end = new Date(enddate);
  
      const formattedStart = `${start.getMonth() + 1}/${start.getDate()}/${start.getFullYear()}`;
      const formattedEnd = `${end.getMonth() + 1}/${end.getDate()}/${end.getFullYear()}`;
  
      data['new_summary_json'] = {
        ytpdropdownvalue: `${formattedStart} - ${formattedEnd}`
      };
    }
  
    this._ytpService.createYTP(clientId, startdate, enddate, data).subscribe((item2) => {
      this.alertService.success('YTP created successfully!');
      this._ytpService.getYTPPlanList(clientId).subscribe((item) => {
        this.ytpPlanGoalList = item.filter(i => !i.summary_json);
        this.selectedYTPPlan = null;
        this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        this.ytpPlanGoalList    .sort((a, b) => new Date(b.insertedon).getTime() - new Date(a.insertedon).getTime());
        if (this.ytpPlanGoalList[0].caseworkername == null || !this.ytpPlanGoalList[0].caseworkername) {
            this.ytpPlanGoalList[0].caseworkername = this.user.user.userprofile.fullname;
        }
      });
    });
  }
  

  
  copyPlan(clientId: any, data = {}) {
    this._ytpService.copyYTP(clientId, data).subscribe((item2) => {
      this.alertService.success('YTP copied successfully!');
      this._ytpService.getYTPPlanList(clientId).subscribe((_item) => {
        this.ytpPlanGoalList = _item.filter(i => !i.summary_json);
        this.selectedYTPPlan = null;
        this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
      });
    });
  }


  yesOrNoCheck(val:any) {
    let returnValue = '';
    if(val == 'Y' || val == '1'  ) {
      returnValue = 'Yes'
    } else if (val == 'N' || val == '0' ) {
      returnValue = 'No'
    } else if (val == '2') {
    returnValue = 'Not Eligible'
  }

  return returnValue;
  }

  getEduStatus(val: any) {
    let returnValue = '';
    if(val == '1') {
      returnValue = 'Attending Full Time'
    } else if (val == '2') {
      returnValue = 'Attending Part Time'
    } else if(val == '3') {
      returnValue = 'Not Attending'
    } else if (val == '4') {
      returnValue = 'Other'
    }

  return returnValue;
  }
  formatAddress(address: any) {
    return this._ytpService.getYTPAddress(address.address1, address.address2, address.cityname, address.statetypekey, address.zip5no);
  }
  deleteServicePlan(data: any) {
    const payload: any = {};
    payload['youthtransitionplanid'] = data.youthtransitionplanid;
       this._commonhttp.getPagedArrayList(
     new PaginationRequest({
      where: {
        id: data.youthtransitionplanid
      },
     method: 'get',
   }), 'youthtransitionplan/youthtransitionplandelete?filter'
   ).subscribe((result: any) => {
        this._ytpService.getYTPPlanList(this.selectedClientId).subscribe((item3) => {
          this.ytpPlanGoalList = item3.filter(i => !i.summary_json);
          this.selectedYTPPlan = null;
          this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        });
      this._alertservice.success('YTP deleted successfully');
    },
    (error) => {
      this._alertservice.error('Could not delete YTP');
  })

  }


  copiedData: any;
  confirmCopy(){
    (<any>$(this.confirmCopypopupid)).modal('hide');
    const data = this.copiedData;
    const alteredCopyofplan_json = { copyofplanjson: { youthtransitionplanid: data?.youthtransitionplanid } }
    if (data?.new_meeting_json) {
      data.new_meeting_json.caseworkerSign = "";
      data.new_meeting_json.caseworkerSignDate = "";
      data.new_meeting_json.youthsign = "";
      data.new_meeting_json.youthsignDate = "";
      data.new_meeting_json.youthSignedDocument="";
    }
    this.copyPlan(this.selectedClientId,{
      startdate:data?.startdate, enddate:data?.enddate,
      new_summary_json: data.new_summary_json, new_employ_json: data.new_employ_json, new_community_json: data.new_community_json,
      new_connections_json: data.new_connections_json, new_documentation_json: data.new_documentation_json, new_education_json: data.new_education_json, new_financial_empowerment_json: data.new_financial_empowerment_json,
      new_health_json: data.new_health_json, new_housing_json: data.new_housing_json, new_meeting_json: data.new_meeting_json, new_transportation_json: data.new_transportation_json,
      ...alteredCopyofplan_json
    });
  }
  copyServicePlan(data: any) {
    this.copiedData =  data;
    (<any>$(this.confirmCopypopupid)).modal('show');
  }
  cancelCopy(){
    (<any>$(this.confirmCopypopupid)).modal('hide');
  }
  /**
   * Public provider assignment & Routing
   */
  getRoutingUser(approval: any, selectedYTP: any) {
    this.approvalProcess = approval;
    this.selectedPlan = selectedYTP;
    this.selectedPlanId = selectedYTP.youthtransitionplanid;
    this.selectService = selectedYTP;
    this.getUsersList = [];
    if (approval === 'Pending') {
      if(!this.isSelectedYTPValid(selectedYTP)){
       this._alertservice.error('Please fill all mandatory YTP information before sending for approval');
        return;
    }
      (<any>$('#intake-caseassignnewX')).modal('show');
      this._commonhttp
        .getPagedArrayList(
          new PaginationRequest({
            where: { appevent: 'YTP' },
            method: 'post'
          }),
          'Intakedastagings/getroutingusers'
        )
        .subscribe((result: any) => {
          this.getUsersList = result.data;
          this.getUsersList = this.getUsersList.filter((users: any) => users.userid !== this._authService.getCurrentUser().user.securityusersid
          );
        });
    } else {
      (<any>$(this.confirmdecisionpopupid)).modal('show');
    }
  }

  confirmDecision() {
    this.assignNewUser();
    (<any>$(this.confirmdecisionpopupid)).modal('hide');
  }

  cancelDecision() {
    this.returnFormGroup.reset();
    (<any>$(this.confirmdecisionpopupid)).modal('hide');
  }

  showReturnReason(item: any) {
    this.viewReturnReason = item.returnreason ? item.returnreason : 'No return reason found!';
  }

  resetReturnReason() {
    this.viewReturnReason = null;
  }


  selectPerson(row: any) {
    this.selectedPerson = row;
  }

  assignNewUser() {
    const payload = {
      eventcode: 'YTP',
      tosecurityusersid: this.selectedPerson ? this.selectedPerson.userid : '',
      objectid: this.id, // This is the intakeserviceid
      serviceNumber: this.daNumber,
      approvalstatustypekey: this.approvalProcess,
      serviceplanid: this.selectedPlanId,
      returnreason: this.returnFormGroup.get('returnreason')?.value
    };

    this._commonhttp.create(
      payload,
      'youthtransitionplan/youthTransitionPlanRouting'
    ).subscribe(
      (response) => {
        if (response.action === 'approved') {
            this.alertService.success('YTP approved successfully!');
        } else if (response.action === 'return') {
            this.alertService.success('YTP returned successfully!');
        } else {
            this.alertService.success('YTP submitted successfully!');
        }
        this._ytpService.getYTPPlanList(this.selectedClientId).subscribe((item4) => {
          this.ytpPlanGoalList = item4.filter(i => !i.summary_json);
          this.selectedYTPPlan = null;
          this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        });
        this.selectedPlan.approvalstatuskey = this.approvalProcess;
        if (this.approvalProcess === 'Return') {
          this.selectedPlan.returnreason = this.returnFormGroup.get('returnreason')?.value;
        }
        (<any>$('#intake-caseassignnewX')).modal('hide');
      },
      (error) => {
        this.alertService.error('Unable to submit!');
      });
  }
  onTabClick(tabItem: any, contentElement: HTMLElement) {
    contentElement.scrollIntoView();
    this.tabs = this._ytpService.processTabState(this.tabs, this._dataStoreService.getData('YTPDATA'));
  }
    getInvolvedPerson() {
    let reqObj: any = {
        objectid: this.id,
        objecttypekey: 'servicecase'
    };
    const personsList = this._commonhttp
        .getPagedArrayList(
            new PaginationRequest({
                page: 1,
                limit: 100,
                nolimit: true,
                method: 'get',
                where: reqObj
            }),
            `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl}?filter`
        ).pipe(
        share(),
        map((res: any) => res?.data));
        personsList.subscribe((items: any) => {
            this.personList = items;
      });
}

  getNameByPersonId(value: any) {
    const persondetails = this.personList.find((x: any) => x.personid === value);
    return persondetails?.fullname;
  }
  
 isSelectedYTPValid(selectedYTP: any) {
  const requiredFields = [
    "new_education_json",
    "new_employ_json",
    "new_financial_empowerment_json",
    "new_housing_json",
    "new_health_json",
    "new_connections_json",
    "new_meeting_json",
    "newfcgschecklistjson"
  ];

  for (const field of requiredFields) {
    const value = selectedYTP[field];

    const isMissing =
      value === null ||
      value === undefined ||
      typeof value !== "object" ||
      Object.keys(value).length === 0;

    if (isMissing) {
      return false;   
    }
  }

  return true;        
}



}