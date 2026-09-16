import { Component, OnInit, Injector } from '@angular/core';
import { YouthTransitionPlanService } from './youth-transition-plan.service';
import { DataStoreService, AlertService, AuthService, CommonHttpService, SessionStorageService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import jsPDF from 'jspdf';
import { YTP_TABS } from './ytp-config';
import { Router, ActivatedRoute } from '@angular/router';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import moment from 'moment';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'youth-transition-plan',
    templateUrl: './youth-transition-plan.component.html',
    styleUrls: ['./youth-transition-plan.component.scss'],
    standalone: false
})
export class YouthTransitionPlanComponent implements OnInit {
  ytpPlanGoalList: any[] = [];
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
  id: any;
  daNumber: any;
  user!: AppUser;
  returnFormGroup!: FormGroup;
  viewReturnReason: any;
  isDeleteDisabled = true;
  followUpOneYearOrNot = false;
  confirmdecisionpopupid = '#confirm-decision';
  tabs = YTP_TABS;
  isReadonly!: boolean;

  private _ytpService: YouthTransitionPlanService;
  private _dataStoreService: DataStoreService;
  private alertService: AlertService;
  private _datastore: DataStoreService;
  private _authService: AuthService;
  private _commonhttp: CommonHttpService;
  private _alertservice: AlertService;
  private _router: Router;
  private route: ActivatedRoute;
  private childRemovalService: ChildRemovalService;
  private formBuilder: FormBuilder;
  private storage: SessionStorageService;

  constructor(private injector : Injector,private html2canvas:Html2CanvasService){
    this._ytpService = this.injector.get<YouthTransitionPlanService>(YouthTransitionPlanService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.alertService = this.injector.get<AlertService>(AlertService);
    this._datastore = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._commonhttp = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertservice = this.injector.get<AlertService>(AlertService);
    this._router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.childRemovalService = this.injector.get<ChildRemovalService>(ChildRemovalService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    }

  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  selYouth: any;
  ytpSummary: any = {};

  ngOnInit() {
    this.isDeleteDisabled = this._authService.isDisabled('services','services.youthtransitionplan.delete');
    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID); // '9725f731-43db-456d-bc82-7b4270218bc3'; test id
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.user = this._authService.getCurrentUser();
    this.initForms();
    this._ytpService.onGetPerson.subscribe(data => {
      if (data) {
        this.selectedClientId = data;
        this._ytpService.getYTPPlanList(data).subscribe((item) => {
          this.ytpPlanGoalList = item.filter(i => i.summary_json);
          this.selectedYTPPlan = null;
          this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        });
      }
    });
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','readonly-youthTransistionPlan');}
  }

  initForms() {
    this.returnFormGroup = this.formBuilder.group({
      returnreason: [null, Validators.required],
    });
  }

  getPersonName(id: any) {
    return this._ytpService.getPersonName(id);
  }

  selectPlan(item: any) {
    this.selectedYTPPlan = item;
    this.getYTPSummary(item);
    this.selectedYTPPlan.summary_json = this.ytpSummary;
    this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
    this._ytpService.youthtransitionplanid = this.selectedYTPPlan.youthtransitionplanid;
    this.tabs = this._ytpService.processTabState(this.tabs, item);
    this._ytpService.onGetYTPData.emit(this.selectedYTPPlan);
    this._router.navigate(['ytp-summary'], { relativeTo: this.route });
  }

  getYTPSummary(item: any) {
    this.ytpSummary.clientName = this._dataStoreService.getData('YTP_SEL_CHILD').personname;
    this.ytpSummary.dob = this._dataStoreService.getData('YTP_SEL_CHILD').dob;
    this.ytpSummary.caseno = this.childRemovalService.daNumber;
    this.ytpSummary.transplancompleted = item.completiondate ? item.completiondate : '';
    this.ytpSummary.planfollowupdate = item.nextduedate ? item.nextduedate : '';
    this.ytpSummary.effectivedate =this._dataStoreService.getData('YTP_SEL_CHILD').removalInfo.removaldate;
    if(item.summary_json){        //@TM: Show data from DB once the plan is created and saved
      this.ytpSummary.participants = item.summary_json.participants ? item.summary_json.participants : [];   
      this.ytpSummary.caseworkername = item.summary_json.caseworkername;
      this.ytpSummary.primarypermanencytype = item.summary_json.primarypermanencytype;
      this.ytpSummary.assessments = item.summary_json.assessments ? item.summary_json.assessments : [];
      const participants = this.ytpSummary.participants ?  this.ytpSummary.participants : [];
      const dsstaff = participants.filter((participant: { type: string; }) =>{  return participant.type === 'LDSS Staff'});
  
    	if(dsstaff.length >0){
      	  this.ytpSummary.caseworkername = `${dsstaff[0].firstname} ${dsstaff[0].lastname}`
    	}
    }
    this.getYTPSummaryApiFn(item);
  }
  // Associated with getYTPSummary function
  private getYTPSummaryApiFn(item: any) {
    this._ytpService.getYTPSummary(item.clientid).subscribe(
      response => {
        if (response && Array.isArray(response) && response.length) {
          this.ytpSummary.primarypermanencytype = response[0].primarypermanencytype ? response[0].primarypermanencytype : '';
        }
      }
    );
  }

  async downloadYTPPdf() {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any = [];
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

  youthTransPlanPrint(modal:any) {
    this.selYouth = modal;
    this.selYouth.summary_json = this.ytpSummary;

    if (this.selYouth.summary_json && this.selYouth.summary_json.planfollowupdate && this.selYouth.summary_json.transplancompleted){
      const followUpDateCheck = moment(this.selYouth.summary_json.planfollowupdate);
      const caseCreationDate = moment(this.selYouth.summary_json.transplancompleted);
      const currentCheck = followUpDateCheck.diff(caseCreationDate, 'days');
      if (currentCheck > 181) {
        this.followUpOneYearOrNot = false;
      } else {
        this.followUpOneYearOrNot = true;
      }
    }

    if (this.selYouth.summary_json && this.selYouth.summary_json.documentation_json 
      && this.selYouth.summary_json.documentation_json.youthSign) {
      setTimeout(() => {
      this.createImage(this.selYouth.documentation_json.youthSign)
      }, 1000);
    }
    (<any>$('#youthTransPlan')).modal('show');
  }

  createImage(data: any) {
    var image = new Image();
    var blob = new Blob([data], { type: 'image/png' });
    image.src = URL.createObjectURL(blob);
    document.body.appendChild(image);
  }

  createPlan(clientId: any) {
    this._ytpService.createYTP(clientId).subscribe((_reswult: any) => {
      this.alertService.success('YTP created successfully!');
      this._ytpService.getYTPPlanList(clientId).subscribe((item1) => {
        this.ytpPlanGoalList = item1.filter(i => i.summary_json);
        this.selectedYTPPlan = null;
        this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
      });

    });
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
   ).subscribe((_result: any) => {
        this._ytpService.getYTPPlanList(this.selectedClientId).subscribe((item2) => {
          this.ytpPlanGoalList = item2.filter(i => i.summary_json);
          this.selectedYTPPlan = null;
          this._dataStoreService.setData('YTPDATA', this.selectedYTPPlan);
        });
      this._alertservice.success('YTP deleted successfully');
    },
    (error) => {
      this._alertservice.error('Could not delete YTP');
  })
    
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
          this.getUsersList = this.getUsersList.filter((users: any) => users.userid !== this._authService.getCurrentUser().user.securityusersid);
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
        this.alertService.success('Submitted successful!');
        this._ytpService.getYTPPlanList(this.selectedClientId).subscribe((item3) => {
          this.ytpPlanGoalList = item3.filter(i => i.summary_json);
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


}
