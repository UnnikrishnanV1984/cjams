import { Component, Injector, OnInit } from '@angular/core';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DataStoreService, CommonHttpService, CommonDropdownsService, AuthService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import jsPDF from 'jspdf';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CasePlanService } from '../case-plan.service';
import { Observable } from 'rxjs';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    selector: 'case-plan-five',
    templateUrl: './case-plan-five.component.html',
    styleUrls: ['./case-plan-five.component.scss'],
    standalone: false
})
export class CasePlanFiveComponent implements OnInit {

  store: any;
  cp1Data: any;
  selectedVersion: any;
  ytpPlanGoalList: any[] = [];
  selectedYTPPlan: any;
  ytpData: any;
  intakeserviceid = '';
  selectedClientId!: string;
  approvalProcess!: string;
  selectedItem!: string;
  selectedPlan: any;
  selectedPlanId!: string;
  getUsersList = [];
  selectedPerson: any;
  selectService: any;
  id: any;
  daNumber: any;
  user!: AppUser;
  ytpList: any;
  
  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  selYouth: any;
  ytpSummary: any = {};
  pdfBlobUrl: any;
  blobPdf!: Blob;
  blobPdf1: any = 'asd';
  isWithinCustomRange = true;
  gradeDropdownItems$!: Observable<DropdownModel[]>;
  gradeDropdownItems!: any[];
  IncomeFrequencyDropDownItem$!: Observable<DropdownModel[]>;
  IncomeFrequencyDropDownItem!: any[];
  
  eduActions: any[] = [];
  eduResources: any[] = [];
  transportActions: any[] = [];
  transportResources: any= [];
  moneyResources: any[] = [];
  moneyActions: any[] = [];
  housingResources: any[] = [];
  housingActions: any[] = [];
  civicResources: any[] = [];
  civicActions: any[] = [];
  civicStrengths: any[] = [];
  civicAssessments: any[] = [];
  healthResources: any[] = [];
  healthActions: any[] = [];
  ytpRelationship: any[] = [];
  ytpSupportRoles: any[] = [];
  communityActions: any[] = [];
  meetingGoals: any[] = [];
  meetingActions: any[] = [];

  summaryAssessments: any[] = [];
  summaryStrengths: any[] = [];
  employementActions: any[] = [];
  employResources: any[] = [];
  employmentActions: any[] = [];
  documentResources: any[] = [];
  documentActions: any[] = [];
  caseWorkerName: any;
  supervisorName: any;
  private html2canvas:Html2CanvasService;
  private authService: AuthService;

  constructor(
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _commonDropdownService: CommonDropdownsService,
    private _caseplanService: CasePlanService,
    private readonly injector : Injector
  ) {
    this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
    this.authService = this.injector.get<AuthService>(AuthService);
    this.store = this._dataStoreService.getCurrentStore();
    this.cp1Data = this.store['SELECTED_CHILD_DATA'];
    this.selectedVersion = this.store['SELECTED_VERSION'];
    this.supervisorName = this._dataStoreService.getData('da_assignedby');
    this.caseWorkerName = this.authService.getCurrentUser().user.userprofile.fullname;
   }

  ngOnInit() {
    if(this.cp1Data) {
      this.getYTPPlanList(this.cp1Data.personid, this.selectedVersion);
    }
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
  }
  ngAfterViewInit() {
    this.scroll('versions-table');
  }

  scroll(id: any) {
    const el: any = document.getElementById(id);
    el.scrollIntoView({behavior: 'smooth', block: 'start', inline: 'nearest'});
  }

  selectPlan(item: any) {
    this.selectedYTPPlan = item;
    this.selYouth = item;
    this.ytpSummary = item;
    this.selYouth.new_summary_json = item.new_summary_json;
     


    this.setOnTrackDegree();
    this.setLastgradetypekey();

    this.setallowanceWeekly();

    this.setpartTimeWeekly();

    this.setbenefitsWeekly();

    this.setsilaWeekly();

    this.setinheritanceWeekly();

    this.setotherWeekly();
    



    this.checkytpSummary1();
    this.checkytpSummary2();
    this.sethavingDL();
  }

  setOnTrackDegree(){
    let onTrackDegree = ' ';

    if (this.selYouth?.new_education_json?.highSchool) {
      onTrackDegree += 'High School Diploma, '
    } 
    if (this.selYouth?.new_education_json?.isGED) {
      onTrackDegree += 'GED, '
    } 
    if (this.selYouth?.new_education_json?.alternateProgram) {
      onTrackDegree += 'Non-traditional/Alternative Program, '
    } 
    if (this.selYouth?.new_education_json?.isOther) {
      onTrackDegree += 'Other, '
    }
    if(this.selYouth.new_education_json) {
      if(onTrackDegree) {
        this.selYouth.new_education_json.onTrackDegree = onTrackDegree;
      } else {
        this.selYouth.new_education_json.onTrackDegree = '';
      }
    }
  }
  setLastgradetypekey(){
    if(this.ytpSummary.new_education_json?.lastgradetypekey) { 
      const filterItem = this.gradeDropdownItems.filter(item => item.ref_key == this.ytpSummary.new_education_json.lastgradetypekey);
      if (filterItem && filterItem.length) {
         this.ytpSummary.new_education_json.lastgradetypekey = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setallowanceWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.allowanceWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.allowanceWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.allowanceWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setpartTimeWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.partTimeWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.partTimeWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.partTimeWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setbenefitsWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.benefitsWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.benefitsWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.benefitsWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setsilaWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.silaWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.silaWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.silaWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setinheritanceWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.inheritanceWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.inheritanceWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.inheritanceWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }
  setotherWeekly(){
    if(this.ytpSummary.new_financial_empowerment_json?.otherWeekly) { 
      const filterItem = this.IncomeFrequencyDropDownItem.filter(item => item.ref_key == this.ytpSummary.new_financial_empowerment_json.otherWeekly);
      if (filterItem && filterItem.length) {
        this.ytpSummary.new_financial_empowerment_json.otherWeekly = filterItem[0].description ? filterItem[0].description : null;
      }
    }
  }

  checkytpSummary1(){
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

    if (this.ytpSummary.new_employ_json?.assessments) {
      this.employementActions = this.ytpSummary.new_employ_json.assessments;
    }

    if (this.ytpSummary.new_employ_json?.goals) {
      this.employResources = this.ytpSummary.new_employ_json.goals;
    }
    if (this.ytpSummary.new_employ_json?.employmentActions) {
      this.employmentActions = this.ytpSummary.new_employ_json.employmentActions;
    }

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

  checkytpSummary2(){
    if (this.ytpSummary.new_community_json?.actions) {
      this.civicActions = this.ytpSummary.new_community_json.actions;
    }  
    if (this.ytpSummary.new_community_json?.goals) {
      this.civicResources = this.ytpSummary.new_community_json.goals;
    }
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

    if (this.ytpSummary.new_connections_json?.communityActions) {
      this.communityActions = this.ytpSummary.new_connections_json.communityActions;
    }  
    if (this.ytpSummary.new_connections_json?.relationship) {
      this.ytpRelationship = this.ytpSummary.new_connections_json.relationship;
    }
    if (this.ytpSummary.new_connections_json?.supportiveRelations) {
      this.ytpSupportRoles = this.ytpSummary.new_connections_json.supportiveRelations;
    }


    if (this.ytpSummary.new_community_json?.strengths) {
      this.civicAssessments = this.ytpSummary.new_community_json.strengths;
    }  
    if (this.ytpSummary.new_community_json?.assessments) {
      this.civicStrengths = this.ytpSummary.new_community_json.assessments;
    }

    if (this.ytpSummary.new_financial_empowerment_json?.actionToDoItems) {
      this.moneyActions = this.ytpSummary.new_financial_empowerment_json.actionToDoItems;
    }  
    if (this.ytpSummary.new_financial_empowerment_json?.goals) {
      this.moneyResources = this.ytpSummary.new_financial_empowerment_json.goals;
    }
  }

  sethavingDL(){
    if (this.selYouth.new_transportation_json) {
      if (this.selYouth.new_transportation_json.havingDL == '1') {
        this.selYouth.new_transportation_json.havingDL = 'Have License'
      } else if (this.selYouth.new_transportation_json.havingDL == '0') {
        this.selYouth.new_transportation_json.havingDL = 'Do not have'
      } else if (this.selYouth.new_transportation_json.havingDL == '2') {
        this.selYouth.new_transportation_json.havingDL = 'Have Permit'
      }
    }
  }
  yesOrNoCheck(val: string) {
    let returnValue = '';
    if(val == 'Y' || val == '1'  ) {
      returnValue = 'Yes'
    } else if (val == 'N' || val == '0' ) {
      returnValue = 'No'
    }
  
  return returnValue;
  }

  getEduStatus(val: string) {
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

  getYTPPlanList(clientID: any, version: any) {
    const fromdate = version && version.fromdate ? version.fromdate: null;
    const todate = version && version.todate ? version.todate: null;
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.getArrayList(
      {
        page: 1,
        limit: 20,
        method: 'get',
        where: {
          clientid: clientID,
          intakeserviceid: this.intakeserviceid,
          approvalstatuskey: 'Approved',
          fromdate: fromdate,
          todate: todate
        },
        order: 'insertedon desc'
      },'youthtransitionplan' + '?filter'
    ).subscribe(
      (response) => {
        let ytpListData: any = [];
        if (response && response.length > 0) {
          ytpListData = response.filter(i => !i.summary_json);
          this.ytpList = ytpListData.filter((ver: any) => this.inDateRange(this.selectedVersion.fromdate, this.selectedVersion.todate, ver));
      }
    });
  }
  
  inDateRange(
  fromDate: string | Date,
  toDate: string | Date,
  ver: any
): boolean {

  const from = new Date(fromDate);
  const to = toDate ? new Date(toDate) : new Date();

  const sDate = ver?.startdate?.split('T')[0];
  const eDate = ver?.enddate?.split('T')[0];

  // If YTP has a start & end date → check range overlap
  if (sDate && eDate) {
    const start = new Date(sDate);
    const end = new Date(eDate);

    // Overlap check
    return start <= to && end >= from;
  }

  // Fallback to insertedon
  if (ver?.insertedon) {
    const insertedOn = new Date(ver.insertedon);
    return insertedOn >= from && insertedOn <= to;
  }

  return false;
}

  closeView() {
    this.selectedYTPPlan = null;
    this.getYTPPlanList(this.cp1Data.personid, this.selectedVersion);
  }

  async downloadYTPPdf() {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    for (let i = 0; i < pages.length; i++) {
      const pageName = pages.item(i).getAttribute('data-page-name');
      if (pageName === 'Youth Transitional Plan') {
        await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas) => {
          const img = canvas.toDataURL('image/png');
          pageImages.push(img);
        });
      }
    }

    this.pdfFiles.push({ fileName: 'Youth Transitional Plan', images: pageImages });
    pageImages = [];
    this.convertImageToPdf();
  }

  convertImageToPdf() {
    this.pdfFiles.forEach((pdfFile) => {
      var doc: any = null;
      doc = new jsPDF();
      var width = doc.internal.pageSize.getWidth() - 10;
      var heigth = doc.internal.pageSize.getHeight() - 10;

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
}