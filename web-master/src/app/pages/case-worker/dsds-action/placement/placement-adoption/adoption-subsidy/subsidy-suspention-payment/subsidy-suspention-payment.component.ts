import { Component, Injector, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { DynamicObject, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, AuthService, SessionStorageService } from '../../../../../../../@core/services';
import { ActivatedRoute, Router } from '@angular/router';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';
import { AppConstants } from '../../../../../../../@core/common/constants';
import { FinanceService } from '../../../../../../finance/finance.service';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';

declare var $: any;
@Component({
    selector: 'subsidy-suspention-payment',
    templateUrl: './subsidy-suspention-payment.component.html',
    standalone: false
})
export class SubsidySuspentionPaymentComponent implements OnInit {

  subsidySuspensionForm!: FormGroup;
  id!: string;
  daNumber: string;
  store!: DynamicObject;
  permanencyplanid!: string;
  reasonTypeDropDown!: any[];
  suspensionList!: any[];
  agreementData: any;
  isSupervisor: boolean;
  isView!: boolean;
  user: AppUser;
  approvalStatus!: string;
  isAdoptionCase: boolean;
  suspensionMinDate: any;
  mandatoryFields=false;
  suspensionMaxDate: any;
  suspensionpaymentmodal = '#suspensionPaymentModal';
  placementExitDate: any;
  placedPersonId: any;
  isPlacementEndDated!: boolean;
  doesOpenPlacementExist: any;
  _bioClientId: any;
  _oldServiceCaseId: any;
  _oldPersonId: any;
  currCjamsPid: any;
  personid: any;
  openChildRemovalExists: any;
  placementHistory: any;
  child: any = {
    removalList: [],
    placements: []
  };
  filteredReasonTypeDropDown: any[] = [];

  private readonly _commonHttp: CommonHttpService;
  private readonly route: ActivatedRoute;
  private readonly _formBuilder: FormBuilder;
  private readonly _alert: AlertService;
  private readonly _store: DataStoreService;
  private readonly _router: Router;
  private readonly _PlacementAdoptionService: PlacementAdoptionService;
  public _authService: AuthService;

  constructor(
    private readonly injector : Injector,
      private readonly _session: SessionStorageService,
      private readonly _financeService: FinanceService
  ) {
    this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alert = this.injector.get<AlertService>(AlertService);
    this._store = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
    this._authService = this.injector.get<AuthService>(AuthService);

    this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    const caseType = this._store.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
  this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
  if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
      this.isAdoptionCase = true;
  } else {
    this.isAdoptionCase = false;
  }
    this.getStoredValues();
    this.user = this._authService.getCurrentUser();
    if (this.user.role.name === 'apcs') {
      this.isSupervisor = true;
  }
    this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
      this.getStoredValues();
  });  
  }


  ngOnInit() {
    this.suspensionMinDate = new Date();
    this.formInitialize();
      this.loadReasonDropDown();
      //Loading agreement data from the API when store data is reset due to a page refresh
      if(!this.agreementData){
        this.getAgreementListing();
      }
      else{
        this.setSuspensionMinMaxDates();
      }     
      const adoptionplanningid = ( this.store['adoptionEffort'] && this.store['adoptionEffort'].adoptionplanningid ) ? this.store['adoptionEffort'].adoptionplanningid : null;
      if (adoptionplanningid) {
        const BreaktheLink = this._PlacementAdoptionService.getBreaklink(adoptionplanningid);
        if (BreaktheLink) {
          this.ifBreaktheLinkFn(BreaktheLink);
        } else {
          if (!!this.isAdoptionCase) {
          $('#suspensionPaymentAlert').modal('show');
          }
        }
      }
      this.currCjamsPid = this.store?.CHILD?.cjamspid;
      this.personid = this.store?.CHILD?.personid;
      //Loading person information from API when store data is reset due to a page refresh
      if(!this.personid){
        this.getInvolvedPerson();
      }
      else{
        this.loadPlacementAndRemovalHistory(this.personid);
      }    
  }
// Assosiated with ngOnInit function
  private ifBreaktheLinkFn(BreaktheLink: any) {
    BreaktheLink.subscribe((res: any[]) => {
      if (res && res.length) {
        res.forEach((item) => {
          if (item && item.getadoptionbreakthelink) {
            item.getadoptionbreakthelink.forEach((breaklink: { status: string; }) => {
              if (breaklink.status !== 'Approved' && !this.isAdoptionCase) {
                $('#suspensionPaymentAlert').modal('show');
              }
            });
          }
        });
      }
    });
  }

  redirectToSubsidy() {
    // (<any>$('#subsidy_agreement')).click();
    const currentUrl = '/pages/case-worker/' + this.daNumber  + '/' + this.id + '/dsds-action/sc-permanency-plan/placement/adoption/adoption-subsidy/agreement';
    this._router.navigate([currentUrl]);
  }

  formInitialize() {
      this.subsidySuspensionForm = this._formBuilder.group({
        adoptionsuspensionid: [null],
        adoptionagreementid: [null],
        adoptionplanningid: [null],
        suspensionreasontypekey: [null],
        suspensionbegindate: [null],
        suspensionenddate: [null],
        suspensionremarks: [null],
        servicecaseid: [null]
      });

  }

  getStoredValues() {
    this.store = this._store.getCurrentStore();

    const placement = this.store['placement_child'];
    this.permanencyplanid = (placement) ? placement.permanencyplanid : null;
    this.agreementData = this.store['adoptionAgreement'] ? this.store['adoptionAgreement']  : null;
    this.id = this.store['CASEUID'];
    this.daNumber = this.store['DANUMBER'];
    this.getSuspensionListing();
  }

  loadReasonDropDown() {
    this._commonHttp
    .getArrayList(
        {
            where: { referencetypeid: 107, teamtypekey: 'CW' },
            method: 'get'
        },
        'referencetype/gettypes' + '?filter'
    ).subscribe( data => {
        this.reasonTypeDropDown = data;
    });
  }

  async getPlacementHistoryByPerson(person: any){
    this._commonHttp
    .getSingle(
      {
        where: { personid: person},
        method: 'get'
      },

      'placement/getplacementbyperson?filter'
    ).subscribe(result => {

      if (!result) {
        this.doesOpenPlacementExist = false;
        return;
      }          
      const targetPlacements = result?.filter((placement: { placementtypekey: string; isvoided: number; }) =>
          placement.placementtypekey === 'PRPL' 
          && placement.isvoided === 0 
        );
      this.child.placements = targetPlacements;
        
      this.doesOpenPlacementExist =  targetPlacements.some((e: { enddate: any; }) => e.enddate === null);
    });
  }

   getRemovalHistoryOfPerson(personid: any){
    this._commonHttp
    .getSingle(
      {
        where: { objectid: personid, 'objecttypekey': 'personid'},
        method: 'get'
      },
      `${CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetChildRemovalList}?filter`
    ).subscribe(data => {
        if (!data) {
          this.openChildRemovalExists = false
          return;
        }
        this.child.removalList = data;
        this.openChildRemovalExists=data.some((e: { exitdate: any; }) => e.exitdate === null);
    });
  }

  confirmUpdate() {
    $('#maintenance-payment-check-dialog-f').modal('show');
    $(this.suspensionpaymentmodal).modal('hide');
  }

  isSuspensionValid(suspensionEndDate: any, child: any) {
    const parseDate = (dateStr: any) => dateStr ? new Date(dateStr) : null;
  
    const mostRecentPlacementEndDate = child.placements
      .map((p: { enddate: any; }) => parseDate(p.enddate))
      .filter((date: any) => date !== null)
      .reduce((latest: any, current: any) => current > latest ? current : latest, null);
  
    const mostRecentRemovalEndDate = child.removalList
      .map((r: { exitdate: any; }) => parseDate(r.exitdate))
      .filter((date: any) => date !== null)
      .reduce((latest: any, current: any) => current > latest ? current : latest, null);

      if (!mostRecentPlacementEndDate && !mostRecentRemovalEndDate) {
        return false; 
      }
  
    const mostRecentDate: any = (mostRecentPlacementEndDate && mostRecentPlacementEndDate > mostRecentRemovalEndDate) 
      ? mostRecentPlacementEndDate 
      : mostRecentRemovalEndDate;
  
    const suspensionEnd: any = parseDate(suspensionEndDate);
    const recentDateData: any = this.toMidnight(mostRecentDate);
    
    if (suspensionEnd && recentDateData && suspensionEnd >= recentDateData) {
      return false;
    } else {
      return true;
    }
  }

  saveSuspension() {
      
    //Checking for open placement or removal Exists when it is a system generated Payment.
    if ((this.doesOpenPlacementExist || this.openChildRemovalExists) && this.subsidySuspensionForm.get('suspensionreasontypekey')?.value === 'COHP') {
      this.confirmUpdate();
      return;
    }


    if (this.subsidySuspensionForm.get('suspensionreasontypekey')?.value === 'COHP' && this.subsidySuspensionForm.get('suspensionenddate')?.value) {
      const suspensionDateValidity = this.isSuspensionValid(
      this.subsidySuspensionForm.get('suspensionenddate')?.value,
      this.child
    );
    
    if (suspensionDateValidity) {
        this.confirmUpdate();
        return;
    }
  }
        
    this.mandatoryFields= true;
    if(this.subsidySuspensionForm.status=='INVALID'){
      return null;
    }
    if (!this._authService.hasSupervisor()) {
      return false;
  }
    this.handleAdoptionSuspensionApiFn();
  }
  // Assosiated with saveSuspension method
  private handleAdoptionSuspensionApiFn() {
    let planningid = this.getPlanningidFn();
    const SuspensionInput = Object.assign(this.subsidySuspensionForm.getRawValue());
    SuspensionInput.intakeserviceid = null;
    SuspensionInput.adoptionagreementid = null;
    SuspensionInput.servicecaseid = this.id ? this.id : null;
    SuspensionInput.adoptionagreementid = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionagreementid : null;
    let url;
    if (this.isAdoptionCase) {
      SuspensionInput.adoptioncaseid = this.id;
      url = 'adoptioncasesuspension/addupdate';
    } else {
      SuspensionInput.adoptionplanningid = planningid;
      url = 'adoptionsuspension/addupdate';
    }
    this._commonHttp
      .create(
        SuspensionInput,
        url
      )
      .subscribe(
        res => {
          this._alert.success('Subsidy Suspension saved successfully');
          $(this.suspensionpaymentmodal).modal('hide');
          this.getSuspensionListing();
        },
        err => {
          this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }
  // Assosiated with saveSuspension method
  private getPlanningidFn() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
    if (this.isSupervisor && this.isAdoptionCase) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }
    if (!planningid) {
      planningid = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionplanningid : null;
    }
    if (!this.isSupervisor && this.isAdoptionCase) {
      planningid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    return planningid;
  }

  patchForm(data: any, mode: any) {
    //  Hiding system generated suspension type for manual suspension entry
    this.filteredReasonTypeDropDown= this.reasonTypeDropDown.filter(dropDownItems => dropDownItems.ref_key !== 'COHP');
    if(data.suspensionreasontypekey === 'COHP'){
      this.filteredReasonTypeDropDown = this.reasonTypeDropDown;
    }
    this.approvalStatus = data.approvalstatus;
    this.subsidySuspensionForm.patchValue(data);
    this.isView = mode;
    if (mode) {
      this.subsidySuspensionForm.disable();
    } else {
      this.subsidySuspensionForm.disable();
      this.subsidySuspensionForm.controls['suspensionenddate'].enable();
    }
  }

  clearForm() {
    this.isView = false;
    this.subsidySuspensionForm.enable();
    this.subsidySuspensionForm.reset();
  }

  getSuspensionListing() {
    let agreementId = null;
    if (this.store['adoptionAgreement']) {
     agreementId = this.store['adoptionAgreement'] ? this.store['adoptionAgreement'].adoptionagreementid : null;
    }
    if (this.store['ADOPTION_AGREEMENT_ID']) {
      agreementId =  this.store['ADOPTION_AGREEMENT_ID'] ? this.store['ADOPTION_AGREEMENT_ID'] : null;
    }
    let url = '';
    let obj;
    if (this.isAdoptionCase) {
      url = 'adoptioncasesuspensionrevision/getsuspensionhistory?filter';
      obj = {
        adoptioncaseid: this.id
      };
    } else {
      url = 'adoptionsuspensionrevision/getsuspensionhistory?filter';
      obj = {
        adoptionagreementid: agreementId
      };
    }
      this._commonHttp
          .getSingle(
              new PaginationRequest({
                  where: obj,
                  method: 'get',
                  page : 1,
                  limit: 10
              }),
              url
          )
          .subscribe(res => {
              if (res && res.length) {
                this.suspensionList = res;

              }
          });

  }

  routingUpdate(status: any) {
    const suspensionId = this.subsidySuspensionForm.getRawValue().adoptionsuspensionid;
    const comment = 'Adoption Suspension ' + status ;

    const submitStatus = Object.assign({
        objectid: suspensionId,
        eventcode: 'ADSR',
        status: status,
        comments: comment,
        notifymsg: comment,
        routeddescription: comment,
        servicecaseid: this.id
    });
    this._commonHttp.create(submitStatus, 'routing/routingupdate').subscribe(
        res => {
            this._alert.success(comment + '  successfully');
            $(this.suspensionpaymentmodal).modal('hide');
            this.clearForm();
            this.getSuspensionListing();
            this.approvalStatus = status;
        },
        err => {
          // No data or function to add or call
        }
    );
}
  fiscalAudit() {
    this._financeService.getChangeHistory(1, this._store.getData('adoptionAlternateID'), 'adoptionsuspension');
  }

  addSuspension() {
    //  Hiding system generated suspension type for manual suspension entry
    this.filteredReasonTypeDropDown= this.reasonTypeDropDown.filter(dropDownItems => dropDownItems.ref_key !== 'COHP');
    this.clearForm();
    if (!this._authService.hasSupervisor()) {
      return false;
    }
    $(this.suspensionpaymentmodal).modal('show');


  }

  // Get all the persons involved in adoption and filter the adopted child information
  getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._store.getData('iscaseexpunged');
    
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }

    this._commonHttp
        .getArrayList(
            {
                page: 1,
                method: 'get',
                where: {intakeserviceid : this.id,isExpungementSuperUser:isExpungementSuperUser,'iscaseexpunged':iscaseexpunged}
            },
            url + '?filter'
        )
        .subscribe((res: any) => {
            if (res['data'] && res['data'].length) {
                res['data'].map((item: { rolename: any; personid: any; }) => {
                  const rolename = item.rolename ? item.rolename : '';
                  const child = ['CHILD', 'AV', 'OTHERCHILD', 'RC'].includes(rolename);
                  if(child) {
                      this.personid = item.personid
                      if(this.personid){
                        this.loadPlacementAndRemovalHistory(this.personid);
                      }
                  }
                });
            }
         });
  }

  //Load agreement list information
  getAgreementListing() {
    let url = 'adoptioncaseagreement/list?filter';
    let obj =  { adoptioncaseid: this.id };
    this._commonHttp
      .getSingle(
        new PaginationRequest({
          where: obj,
          method: 'get',
          page: 1,
          limit: 10
        }),
        url
      )
      .subscribe(res => {
        if (res && res.length && Array.isArray(res)) {
          const obcj = res[0];
          const agreementList = this.isAdoptionCase ? obcj.getadoptioncaseagreementlist : obcj.getadoptionagreementlist;
          if (agreementList && agreementList.length) {
            const length = agreementList.length - 1;
            this.agreementData = agreementList[length];
            this.setSuspensionMinMaxDates();
          }
        }
      });
  }

  //Setting Min and Max Dates for suspension dates
  setSuspensionMinMaxDates(){
    if (this.agreementData && this.agreementData.enddate) {
      this.suspensionMaxDate = new Date(this.agreementData.enddate);
    }
    if (this.agreementData && this.agreementData.startdate) {
      this.suspensionMinDate = new Date(this.agreementData.startdate);
    }
  }

  loadPlacementAndRemovalHistory(personid: any){
    this.getPlacementHistoryByPerson(personid);
    this.getRemovalHistoryOfPerson(personid);
  }

  toMidnight(date: any) {
    if (!date) return null;
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
  }
  
}
  
