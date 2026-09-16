import { Component,Injector , OnInit } from '@angular/core';
import { take } from 'rxjs/operators';
import { forkJoin } from 'rxjs';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DynamicObject, PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { DataStoreService } from '../../../../../../@core/services';
import { ActivatedRoute, Router } from '@angular/router';
import { Getadoptionbreakthelink } from '../_entities/adoption.model';
import { AuthService } from '../../../../../../@core/services/auth.service';
import { AppConstants } from '../../../../../../@core/common/constants';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import _ from 'lodash';
import { CaseWorkerUrlConfig } from '../../../../../case-worker/case-worker-url.config';

const LIVING_ARRANGEMENT = 'LA';
const VOID_PLACEMENT = 1;
const RESPONSE_ACCEPTED_YES = '4612';
const RESPONSE_REJECTED = 'Rejected';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-breaktheline',
    templateUrl: './placement-breaktheline.component.html',
    styleUrls: ['./placement-breaktheline.component.scss'],
    standalone: false
})
export class PlacementBreakthelineComponent implements OnInit {
  adoptionBreakLinkForm!: FormGroup;
  private id: string;
  daNumber: string;
  store: DynamicObject;
  childActorId!: string;
  addEditLabel!: string;
  updateButton!: boolean;
  isSupervisor!: boolean;
  approvalStatus!: string;
  addDisable = true;
  disableBtn = false;
  createAdoptionbtn = false;
  agreement!: string;
  agreementapprovalStatus!: string;
  breakLinkGrid = false;
  savebtn!: string;
  childPlacement: any;
  adoptionBreakLinkList: Getadoptionbreakthelink[] = [];
  newAdoptionCaseId: any;
  existingAdoptionCaseId: any;
  adoptionplanningid!: string;
  adoptionbreakthelinkid!: string;
  breakDlinkPatchObj: any;
  tprListDetails: any;
  isAgreementReview!: boolean;
  currentDate = new Date();
  originalUserList!: any[];
  getUsersList!: any[];
  mergeUsersList!: any[];
  zipCodeIndex!: number;
  selectedPerson: any;
  zipCode!: string;
  isActivePlacement!: boolean;
  hasratecheck = false;
  isEditDisabled = false;
  isCreateDisabled = false;
  adoptionCaseCreationInProgress = false;
  checkrequired= false;
  breaklinkpopupid = '#breakLink';
  adoptionplanstr = 'Adoption Plan ';
  filterCase!: string;
  courtorderdate!: string | number | Date;
  agreementstartdate!: string | number | Date;
  mostRecentDates: any;
  isRemovalOrPlacementNotEndDated!: boolean;
  subsidyStartDate: string | null = null;
  subsidyagreementstartdate: any;
  doesRemovalDateExist!: boolean;
  private readonly _formBuilder: FormBuilder;
  private readonly _commonHttp: CommonHttpService;
  private readonly _alertService: AlertService;
  private readonly _store: DataStoreService;
  private readonly route: ActivatedRoute;
  private readonly _PlacementAdoptionService: PlacementAdoptionService;

  // tslint:disable-next-line:max-line-length
  constructor(private readonly injector : Injector,
    public _authService: AuthService,
    private readonly _router: Router) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._store = this.injector.get<DataStoreService>(DataStoreService);
    this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);  
    this.id = this._store.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.store = this._store.getCurrentStore();
  }

  ngOnInit() {
    this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.breakthelink.edit');
    this.isCreateDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.breakthelink.createadoptioncase');
    const userInfo = this._authService.getCurrentUser();
    this.isSupervisor = userInfo.role.name === AppConstants.ROLES.SUPERVISOR;
    this.getPlacementInfoList(1, 10);
    this.getaggreementrateList();
    this.getTprDetails();
    this.loadBreaktheLink();
    this.getAgreementDate();
      this._PlacementAdoptionService.subsidyStartDate$.subscribe((date) => {
        this.subsidyStartDate = date;
      });
      this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
        if (data !== 'TRPList' ) {
          if (this.store['placement_child']) {
            this.childPlacement = this.store['placement_child'];
            this.childActorId = this.store['placement_child'].intakeservicerequestactorid;
        }
        if (data === 'planning') {
        this.checkSubsidy();
         }
        }
      });

    this.adoptionBreakLinkForm = this._formBuilder.group({
      legallyfree: [''],
      adoptiveplacement: [''],
      placementagreement: ['', [Validators.required]],
      agreementsigneddate: [null, [Validators.required]],
      adoptionfinalization: ['', [Validators.required]],
      associatedcourtorderdate: ['', [Validators.required]],
      finalizationdate: ['', [Validators.required]],
      isinPreAdoptivePlacement:  ['', [Validators.required]],
      isLegallyFree:  ['', [Validators.required]],
      adoptionbreakthelinkid: [null],
      adoptionplanbegindate: [''],
      narrativecheckliststatus: [''],
      tprmotherdate: [''],
      tprfatherdate: [''],
      providername: [''],
      placementstructure: [''],
      placementstartdate: [''],
      placementenddate: [''],
      removalstartdate: [''],
      removalenddate: [''],
      placementapprovalstatus: [''],
      status: ['Review']
    });

    this.adoptionBreakLinkForm.get('placementenddate')?.valueChanges
              .pipe(take(1))
              .subscribe((value) => {
                this.isRemovalOrPlacementNotEndDated = (this.getRemovalDates()  || !!this.mostRecentDates?.mostRecentEndDate) && !!value;
                if (this.isRemovalOrPlacementNotEndDated) {
                  this.getBreaklink();
                }
              });

    this.adoptionBreakLinkForm.get("placementagreement")?.valueChanges.subscribe((value)=>{
      if(value === true && typeof value === "boolean"){
        this.adoptionBreakLinkForm.get("placementagreement")?.patchValue(1);
      } else if (value === false && typeof value === "boolean") {
        this.adoptionBreakLinkForm.get("placementagreement")?.patchValue("");
      }
    })

    this.adoptionBreakLinkForm.get("adoptionfinalization")?.valueChanges.subscribe((value)=>{
      if(value === true && typeof value === "boolean"){
        this.adoptionBreakLinkForm.get("adoptionfinalization")?.patchValue(1);
      } else if (value === false && typeof value === "boolean") {
        this.adoptionBreakLinkForm.get("adoptionfinalization")?.patchValue("");
      }
    })
    const doesRemovalDateExist = this.getRemovalDates();
    this.isRemovalOrPlacementNotEndDated = doesRemovalDateExist && !!this.adoptionBreakLinkForm.getRawValue().placementenddate;
  }
  getaggreementrateList() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
  if (!planningid) {
    planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
  }
  if (planningid) {
   this.planningidcheck(planningid);
  }
}

planningidcheck(planningid: any){
  this._PlacementAdoptionService.getAgreementListing(planningid).subscribe(data => {
    if (data && data.length) {
      const adoptionData = data[0];
      if ( adoptionData && adoptionData.getadoptionagreementlist && adoptionData.getadoptionagreementlist.length) {
          const agreementList = adoptionData.getadoptionagreementlist[0];
          if (agreementList.agreementrate && agreementList.agreementrate.length && agreementList.agreementrate[0].typedescription == 'Approved') {
              this.hasratecheck = true;
          }
      }
    }
  })
}

getPlacementInfoList(pageNumber: any, limit: any) {
  const storeData$ = this._store.currentStore.pipe(take(1)); 

  const placementData$ = this._commonHttp
    .getPagedArrayList(
      new PaginationRequest({
        page: pageNumber,
        limit: limit,
        method: 'get',
        where: { servicecaseid: this.id},
      }),
      'placement/getplacementbyservicecase?filter'
    );

  forkJoin([storeData$, placementData$]).subscribe(([storeData, res]) => {
    const childForGAP = storeData?.childforGAP;

      if (res.data) {
        const child = this._store.getData(CASE_STORE_CONSTANTS.PLACED_CHILD);
        const childremoval = res.data;
        let personid = (child && child.personid) ? child.personid : null;
        if (!personid && childForGAP) {
          const matchedChild = childremoval.find(item => item.cjamspid === childForGAP);
          if (matchedChild) {
            personid = matchedChild.personid;
          }
        }
        this.getRemovalHistoryOfPerson(personid);
        const reportedChildPlacement = childremoval.filter(childItem => childItem.personid === personid);

        if (reportedChildPlacement && reportedChildPlacement.length) {
          this.isActivePlacement = this.checkForChildHasActivePlacements(reportedChildPlacement[0].placements);
        }
      }
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
          return;
        }
        const parseDateWithoutTime = (dateStr: any) => {
          if (!dateStr) return null;
          const date = new Date(dateStr);
          return new Date(date.setHours(0, 0, 0, 0));
        };
        
        this.mostRecentDates = {
          mostRecentEndDate: parseDateWithoutTime(data[0].exitdate),
          mostRecentStartDate: parseDateWithoutTime(data[0].removaldate)
        };
        this.doesRemovalDateExist = !!this.mostRecentDates?.mostRecentEndDate;
        this.isRemovalOrPlacementNotEndDated = this.doesRemovalDateExist && !!this.adoptionBreakLinkForm.getRawValue().placementenddate;
    });
  }

checkForChildHasActivePlacements(placements: any) {
  let hasActivePlacement = false;
  if (placements && placements.length) {
    const providerPlacement = placements.filter((placement: any) => placement.placementtypekey !== LIVING_ARRANGEMENT
      && placement.enddate === null
      && placement.isvoided !== VOID_PLACEMENT
      && placement.responseacceptedkey === RESPONSE_ACCEPTED_YES
      && placement.routingstatus !== RESPONSE_REJECTED);
    if (providerPlacement && providerPlacement.length) {
      hasActivePlacement = true;
    }
  }
  return hasActivePlacement;
}

  checkSubsidy() {
    let planningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;

    if (!planningid) {
      planningid = this.store[CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID];
    }

    if (planningid) {
      this._PlacementAdoptionService.getAgreementListing(planningid).subscribe(data => {
        if (data && data.length) {
          this.checkGetAgreementListingResponseFn(data);
        } else {
          if (!this.store['adoptionBreakLink']) {
            (<any>$('#ap-break')).modal('show');
          }
        }
      });
    }
    else {
      if (!this.store['adoptionBreakLink']) {
        (<any>$('#ap-break')).modal('show');
      }
    }
  }
  // Assosiated with checkSubsidy function
  private checkGetAgreementListingResponseFn(data: any) {
    const adoptionData = data[0];
    if (adoptionData && adoptionData.getadoptionagreementlist && adoptionData.getadoptionagreementlist.length) {
      const agreementList = adoptionData.getadoptionagreementlist[0];
      if (agreementList && agreementList.routingstatus === 'Approved') {
        this.loadBreaktheLink();
      } else {
        this.loadBreaktheLink();
        if (!this.store['adoptionBreakLink']) {
          this.isAgreementReview = true;
        }
      }
    } else {
      if (!this.store['adoptionBreakLink']) {
        (<any>$('#ap-break')).modal('show');
      }
    }
  }

clearBreakLink() {
    this.adoptionBreakLinkForm.reset();
}
navigateTo() {
  const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/adoption-subsidy/agreement';
  this._router.navigate([redirectUrl]);
}

loadBreaktheLink() {
  this.setAdoptionPlanningId();
  this.getBreaklink();
}
  setAdoptionPlanningId() {
    if (this.store['adoptionplanningid']) {
      this.adoptionplanningid = this.store['adoptionplanningid'];
    } else if (this.store['adoptionEffort'] && this.store['adoptionEffort'].adoptionplanningid ) {
      this.adoptionplanningid = this.store['adoptionEffort'].adoptionplanningid;
    } else if (this.store['ADOPTION_PLANNING_ID']) {
      this.adoptionplanningid = this.store['ADOPTION_PLANNING_ID'];
    }
  }

  setProviderDetails() {
    this.adoptionBreakLinkForm.patchValue({
      adoptiveplacement: (this.childPlacement && this.childPlacement.providerdetails) ? 1 : 0,
      providername: (this.childPlacement && this.childPlacement.providerdetails) ? this.childPlacement.providerdetails.providername : '',
      placementstructure: (this.childPlacement.placementstructuredesc) ? this.childPlacement.placementstructuredesc : '',
      placementstartdate: (this.childPlacement.startdate) ? this.childPlacement.startdate : '',
      placementenddate: (this.childPlacement.enddate) ? this.childPlacement.enddate : '',
      removalstartdate: (this.mostRecentDates?.mostRecentStartDate) ? this.mostRecentDates?.mostRecentStartDate : '',
      removalenddate: (this.mostRecentDates?.mostRecentEndDate) ? this.mostRecentDates?.mostRecentEndDate : '',
      placementapprovalstatus: (this.childPlacement.routingstatus) ? this.childPlacement.routingstatus : '',
    });
  }

  ValidateCheckBoxes() {
    const placementagreement = this.adoptionBreakLinkForm.getRawValue().placementagreement;
    const adoptionfinalization = this.adoptionBreakLinkForm.getRawValue().adoptionfinalization;
    const isinPreAdoptivePlacement = this.adoptionBreakLinkForm.getRawValue().isinPreAdoptivePlacement;
    const isLegallyFree = this.adoptionBreakLinkForm.getRawValue().isLegallyFree;
    if (placementagreement && adoptionfinalization && isinPreAdoptivePlacement && isLegallyFree ) {
      return true;
    } else {
      return false;
    }
  }

  confirmUpdate() {
    ($('#maintenance-payment-check-dialog-d') as any).modal('show');
  }

  getRemovalDates() {
    const parseDate = (dateStrr: any) => {
      if (!dateStrr) return null;
      const date = new Date(dateStrr);
      return new Date(date.setHours(0, 0, 0, 0));
  };

    const child = this._store.getData(CASE_STORE_CONSTANTS.PLACED_CHILD);
    this.mostRecentDates = child?.removalList
      .map((r: { removaldate: any; exitdate: any; }) => ({
          removalDate: parseDate(r.removaldate), 
          exitDate: parseDate(r.exitdate)
      }))
      .reduce((latest: any, current: any) => {
          return {
              mostRecentStartDate: (current.removalDate && (!latest.mostRecentStartDate || current.removalDate > latest.mostRecentStartDate)) 
                                   ? current.removalDate 
                                   : latest.mostRecentStartDate,
              mostRecentEndDate: (current.exitDate && (!latest.mostRecentEndDate || current.exitDate > latest.mostRecentEndDate)) 
                                 ? current.exitDate 
                                 : latest.mostRecentEndDate
          };
      }, { mostRecentStartDate: null, mostRecentEndDate: null });
      return !!this.mostRecentDates?.mostRecentEndDate;
    }

  saveBreakLink() {
    this.checkrequired =true;
    const { placementenddate, agreementstartdate, mostRecentRemovalEndDate } = this.handleToReturnDateFieldFn();

    if(this.adoptionBreakLinkForm.valid){
    this.disableBtn = true;
    if (this.isActivePlacement) {
      (<any>$('#finalization-validation-popup')).modal('show');
      return;
    }
    if (!this.hasratecheck) {
      (<any>$('#rate-validation-popup')).modal('show');
      return;
    }

    if (placementenddate && agreementstartdate && placementenddate > agreementstartdate ) {
      this.filterCase = "Placement Exit Date is Overlapping with the Adoption Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Adoption Break the Link.";
      this.confirmUpdate();
      return;
    }

    if(!mostRecentRemovalEndDate) {
      this.filterCase = "The Child Removal End Date overlaps with the Adoption Agreement Start Date. Please adjust either the Child Removal date or the Agreement date to ensure there is no overlap before proceeding.";
      this.confirmUpdate();
      return;
    }

    if (mostRecentRemovalEndDate && agreementstartdate && mostRecentRemovalEndDate > agreementstartdate ) {
      this.filterCase = "The Child Removal End Date overlaps with the Adoption Agreement Start Date. Please adjust either the Child Removal date or the Agreement date to ensure there is no overlap before proceeding.";
      this.confirmUpdate();
      return;
    }

    const model = this.returnModelDataFn();
    this._commonHttp.create(model, 'adoptionbreakthelink/addupdate').subscribe(
        result => {
            this._alertService.success('Adoption Break The Link saved successfully!');
            this.adoptionBreakLinkForm.reset();
            (<any>$(this.breaklinkpopupid)).modal('hide');
            this.getBreaklink();
            this.disableBtn = false;
        },
        error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            this.disableBtn = false;
        }
    );
      }
      else{
        this._alertService.error('Please fill all required fields');
      }
}
// Assosiated to saveBreakLink method
  private handleToReturnDateFieldFn() {
    const mostRecentRemovalEndDateRaw = this.mostRecentDates?.mostRecentEndDate;
    const placementEndDateRaw = this.adoptionBreakLinkForm.getRawValue().placementenddate;
    const subsidystartdate = this.subsidyagreementstartdate;

    const placementenddate = placementEndDateRaw ? new Date(placementEndDateRaw) : null;
    const agreementstartdate = subsidystartdate ? new Date(subsidystartdate) : null;
    const mostRecentRemovalEndDate = mostRecentRemovalEndDateRaw ? new Date(mostRecentRemovalEndDateRaw) : null;
    return { placementenddate, agreementstartdate, mostRecentRemovalEndDate };
  }

// Assosiated to saveBreakLink method
  private returnModelDataFn() {
    const model = this.adoptionBreakLinkForm.value;
    model.adoptionplanningid = this.adoptionplanningid ? this.adoptionplanningid : null;
    model.servicecaseid = this.store['CASEUID'] ? this.store['CASEUID'] : null;
    return model;
  }

approveBreakLink(approvalStatus: any) {
  this.disableBtn = true;
  this._commonHttp
      .create(
          {
              objectid: this.adoptionbreakthelinkid ? this.adoptionbreakthelinkid : null,
              eventcode: 'ABLR',
              status: approvalStatus,
              comments: this.adoptionplanstr + approvalStatus,
              notifymsg: this.adoptionplanstr + approvalStatus,
              routeddescription: this.adoptionplanstr + approvalStatus,
              servicecaseid: this.id
          },
          'routing/routingupdate'
      )
      .subscribe(
          res => {
              this._alertService.success('Break The Link is ' + approvalStatus + ' successfully!');
              this.approvalStatus = approvalStatus;
              (<any>$(this.breaklinkpopupid)).modal('hide');
              this.getBreaklink();
              this.disableBtn = false;
          },
          err => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              this.disableBtn = false;
          }
      );
}

manageBreakLink(type: any, item?: any) {
  this.adoptionBreakLinkForm.patchValue({
    isinPreAdoptivePlacement: this.isRemovalOrPlacementNotEndDated && !!item?.providername ? true : false
  });
  
  if (type === 'add') {
      this.addEditLabel = 'Add';
      this.savebtn = 'Save & Submit For Approval';
      this.adoptionBreakLinkForm.patchValue({ adoptionbreakthelinkid: null });
       this.adoptionBreakLinkForm.reset();
       if (this.breakDlinkPatchObj) {
       this.adoptionBreakLinkForm.patchValue(this.breakDlinkPatchObj);
       }
  } else {
      this.adoptionBreakLinkForm.patchValue(item);
      this.approvalStatus = item.status;
      if (type === 'view') {
          this.addEditLabel = 'View';
          this.updateButton = true;
          this.savebtn = 'Update & Submit For Approval';
          this.adoptionBreakLinkForm.disable();
      } else if (type === 'edit') {
          this.addEditLabel = 'Edit';
          this.updateButton = true;
          this.adoptionBreakLinkForm.enable();
          this.savebtn = 'Update & Submit For Approval';
      }
  }
  (<any>$(this.breaklinkpopupid)).modal('show');
}

getFormValue(fieldName: any) {
  const FormData = this.adoptionBreakLinkForm.getRawValue();
  return FormData[fieldName] ? FormData[fieldName] : null ;
}

getAgreementDate() {
  let url = 'adoptionagreement/list?filter';
  let obj = { adoptionplanningid: this.adoptionplanningid };

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
        this.subsidyagreementstartdate = res[0]?.getadoptionagreementlist?.[0]?.startdate;
      }
    });
}

  private getBreaklink() {
    this._commonHttp
      .getArrayList({
        method: 'get', where: {
          adoptionplanningid: this.adoptionplanningid ? this.adoptionplanningid : null
        }
      }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
      .subscribe(res => {
        if (res && res.length) {
          this.handleIfAdoptionbreakthelinkApiRespCondFn(res);
        } else if (this.isAgreementReview) {
          (<any>$('#ap-break')).modal('show');
        }
      });
  }
  // Assosiated with getBreaklink function
  private handleIfAdoptionbreakthelinkApiRespCondFn(res: any[]) {
    res.forEach((item) => {
      this.adoptionBreakLinkList = item && item.getadoptionbreakthelink ? item.getadoptionbreakthelink.map((breaklink: any) => {
        if (breaklink.adoptionbreakthelinkid) {
          this.breakLinkGrid = true;
          this.addDisable = false;
        }
        if (breaklink.status === 'Approved') {
          this.createAdoptionbtn = true;
        }
        if (breaklink.adoptioncasenumber) {
          this.createAdoptionbtn = false;
        }
        this._store.setData('adoptionBreakLink', breaklink);
        this.breakDlinkPatchObj = breaklink;
        this.adoptionbreakthelinkid = breaklink.adoptionbreakthelinkid;

        this.handleIfTprdatesFn(breaklink);
        //@TM: null-checks in below block are not required but work as a fail-safe so leaving as-is
        this.handleIfProviderdetailsFn();
        this.adoptionBreakLinkForm.patchValue(this.breakDlinkPatchObj);
        return breaklink;
      }) : [];
    });
  }
  // Assosiated with getBreaklink function
  private handleIfProviderdetailsFn() {
    if (this.breakDlinkPatchObj && this.breakDlinkPatchObj.providerdetails && this.breakDlinkPatchObj.providerdetails.length > 0) {
      this.handleIfBreakDlinkPatchObjFn();
    } else {
      this.breakDlinkPatchObj.isinPreAdoptivePlacement = false;
      this.breakDlinkPatchObj.providername = '';
      this.breakDlinkPatchObj.placementstructure = '';
      this.breakDlinkPatchObj.placementstartdate = '';
      this.breakDlinkPatchObj.placementenddate = '';
      this.breakDlinkPatchObj.removalstartdate = '';
      this.breakDlinkPatchObj.removalenddate = '';
      this.breakDlinkPatchObj.placementapprovalstatus = '';
    }
  }
  // Assosiated to handleIfProviderdetailsFn method
  private handleIfBreakDlinkPatchObjFn() {
    this.breakDlinkPatchObj.providername = (this.breakDlinkPatchObj.providerdetails[0].providername) ? this.breakDlinkPatchObj.providerdetails[0].providername : '';
    this.breakDlinkPatchObj.isinPreAdoptivePlacement = (this.breakDlinkPatchObj.providerdetails[0].providername && this.isRemovalOrPlacementNotEndDated) ? true : false;
    this.breakDlinkPatchObj.placementstructure = (this.breakDlinkPatchObj.providerdetails[0].placementstructureid === 500) ? 'Pre-Finalized Adoptive Home' : '';
    this.breakDlinkPatchObj.placementstartdate = (this.breakDlinkPatchObj.providerdetails[0].startdatetime) ? this.breakDlinkPatchObj.providerdetails[0].startdatetime : '';
    this.breakDlinkPatchObj.placementenddate = (this.breakDlinkPatchObj.providerdetails[0].enddatetime) ? this.breakDlinkPatchObj.providerdetails[0].enddatetime : '';
    this.breakDlinkPatchObj.removalstartdate = (this.mostRecentDates?.mostRecentStartDate) ? this.mostRecentDates?.mostRecentStartDate : '';
    this.breakDlinkPatchObj.removalenddate = (this.mostRecentDates?.mostRecentEndDate) ? this.mostRecentDates?.mostRecentEndDate : '';
    this.breakDlinkPatchObj.placementapprovalstatus = (this.breakDlinkPatchObj.providerdetails[0].approvalstatus) ? this.breakDlinkPatchObj.providerdetails[0].approvalstatus : '';
  }

  // Assosiated with getBreaklink function
  private handleIfTprdatesFn(breaklink: any) {
    if (this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length) {
      breaklink.tprmotherdate = this.breakDlinkPatchObj.tprdates[0];
      if (this.breakDlinkPatchObj.tprdates.length > 1) {
        breaklink.tprfatherdate = this.breakDlinkPatchObj.tprdates[0];
      }
    } else if (this.tprListDetails && this.tprListDetails.length) {

      this.handleTprListDetailsIfConFn(breaklink);
    } else {
      this.handleTprListDetailsRlseCondFn(breaklink);
    }

    if (breaklink.tprmotherdate || breaklink.tprfatherdate) {
      this.breakDlinkPatchObj.isLegallyFree = true;
    }
    if (breaklink.providerdetails && breaklink.providerdetails.length && breaklink.providerdetails[0].placementstructureid === 500
      && breaklink.providerdetails[0].enddatetime) {
      breaklink.adoptiveplacement = 1;
    }
    this.handleFinalizationandParentCondFn();
  }
  // Assosiated with getBreaklink function
  private handleFinalizationandParentCondFn() {
    this.breakDlinkPatchObj.adoptionfinalization = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.finalizationdate) ? 1 : null;
    this.breakDlinkPatchObj.finalizationdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.finalizationdate) ? this.breakDlinkPatchObj.finalizationdate : null;
    this.breakDlinkPatchObj.placementagreement = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.parent1signdate) ? 1 : null;
    this.breakDlinkPatchObj.agreementsigneddate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.parent1signdate) ? this.breakDlinkPatchObj.parent1signdate : null;
  }
  // Assosiated with getBreaklink function
  private handleTprListDetailsIfConFn(breaklink: any) {
    breaklink.tprmotherdate = this.tprListDetails[0].tprdecisiondate;
    this.breakDlinkPatchObj.tprmotherdate = this.tprListDetails[0].tprdecisiondate;
    if (this.tprListDetails.length > 1) {
      breaklink.tprfatherdate = this.tprListDetails[1].tprdecisiondate;
      this.breakDlinkPatchObj.tprfatherdate = this.tprListDetails[1].tprdecisiondate;
    }
  }
  // Assosiated with getBreaklink function
  private handleTprListDetailsRlseCondFn(breaklink: any) {
    breaklink.tprmotherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length) ? this.breakDlinkPatchObj.tprdates[0] : null;
    breaklink.tprfatherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length && this.breakDlinkPatchObj.tprdates.length > 1) ?
      this.breakDlinkPatchObj.tprdates[1] : null;
    this.breakDlinkPatchObj.tprmotherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length) ?
      this.breakDlinkPatchObj.tprdates[0] : null;
    this.breakDlinkPatchObj.tprfatherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length &&
      this.breakDlinkPatchObj.tprdates.length > 1) ? this.breakDlinkPatchObj.tprdates[1] : null;
  }


private processBreakLinkItems(breaklinkItems: any[]) {
  return breaklinkItems.map((breaklink) => {
      this.updateBreaklinkStatus(breaklink);
      this.updateBreaklinkDates(breaklink);
      this.updateProviderDetails(breaklink);
      this.adoptionBreakLinkForm.patchValue(this.breakDlinkPatchObj);
      return breaklink;
  });
}

private updateBreaklinkStatus(breaklink: any) {
  if (breaklink.adoptionbreakthelinkid) {
      this.breakLinkGrid = true;
      this.addDisable = false;
  }
  if (breaklink.status === 'Approved') {
      this.createAdoptionbtn = true;
  }
  if (breaklink.adoptioncasenumber) {
      this.createAdoptionbtn = false;
  }
  this._store.setData('adoptionBreakLink', breaklink);
  this.breakDlinkPatchObj = breaklink;
  this.adoptionbreakthelinkid = breaklink.adoptionbreakthelinkid;
}

private updateBreaklinkDates(breaklink: any) {
  this.assignTprDates(breaklink);

  if (breaklink.tprmotherdate || breaklink.tprfatherdate) {
      this.breakDlinkPatchObj.isLegallyFree = true;
  }
}

private assignTprDates(breaklink: any) {
  if (this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length) {
      breaklink.tprmotherdate = this.breakDlinkPatchObj.tprdates[0];
      if (this.breakDlinkPatchObj.tprdates.length > 1) {
          breaklink.tprfatherdate = this.breakDlinkPatchObj.tprdates[1];
      }
  } else if (this.tprListDetails && this.tprListDetails.length) {
      breaklink.tprmotherdate = this.tprListDetails[0].tprdecisiondate;
      this.breakDlinkPatchObj.tprmotherdate = this.tprListDetails[0].tprdecisiondate;
      if (this.tprListDetails.length > 1) {
          breaklink.tprfatherdate = this.tprListDetails[1].tprdecisiondate;
          this.breakDlinkPatchObj.tprfatherdate = this.tprListDetails[1].tprdecisiondate;
      }
  } else {
      breaklink.tprmotherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length) 
          ? this.breakDlinkPatchObj.tprdates[0] 
          : null;
      breaklink.tprfatherdate = (this.breakDlinkPatchObj && this.breakDlinkPatchObj.tprdates && this.breakDlinkPatchObj.tprdates.length > 1) 
          ? this.breakDlinkPatchObj.tprdates[1] 
          : null;
      this.breakDlinkPatchObj.tprmotherdate = breaklink.tprmotherdate;
      this.breakDlinkPatchObj.tprfatherdate = breaklink.tprfatherdate;
  }
}


private updateProviderDetails(breaklink: any) {
  if (this.isValidProviderDetails(breaklink)) {
      breaklink.adoptiveplacement = 1;
  }

  this.breakDlinkPatchObj.adoptionfinalization = this.getFinalizationStatus();
  this.breakDlinkPatchObj.finalizationdate = this.breakDlinkPatchObj.finalizationdate || null;
  this.breakDlinkPatchObj.placementagreement = this.getPlacementAgreementStatus();
  this.breakDlinkPatchObj.agreementsigneddate = this.breakDlinkPatchObj.parent1signdate || null;

  if (this.hasProviderDetails()) {
      this.updateBreakLinkPatchWithProviderDetails();
  } else {
      this.resetProviderDetails();
  }
}

private isValidProviderDetails(breaklink: any): boolean {
  return breaklink.providerdetails && breaklink.providerdetails.length &&
         breaklink.providerdetails[0].placementstructureid === 500 &&
         breaklink.providerdetails[0].enddatetime;
}

private getFinalizationStatus(): number | null {
  return this.breakDlinkPatchObj?.finalizationdate ? 1 : null;
}

private getPlacementAgreementStatus(): number | null {
  return this.breakDlinkPatchObj?.parent1signdate ? 1 : null;
}

private hasProviderDetails(): boolean {
  return this.breakDlinkPatchObj?.providerdetails && this.breakDlinkPatchObj.providerdetails.length > 0;
}

private updateBreakLinkPatchWithProviderDetails(): void {
  const providerDetails = this.breakDlinkPatchObj.providerdetails[0];
  this.breakDlinkPatchObj.providername = providerDetails.providername || '';
  this.breakDlinkPatchObj.isinPreAdoptivePlacement = !!providerDetails.providername;
  this.breakDlinkPatchObj.placementstructure = providerDetails.placementstructureid === 500 ? 'Pre-Finalized Adoptive Home' : '';
  this.breakDlinkPatchObj.placementstartdate = providerDetails.startdatetime || '';
  this.breakDlinkPatchObj.placementenddate = providerDetails.enddatetime || '';
  this.breakDlinkPatchObj.removalstartdate = (this.mostRecentDates?.mostRecentStartDate) ? this.mostRecentDates?.mostRecentStartDate : '';
  this.breakDlinkPatchObj.removalenddate = providerDetails.enddatetime || '';
  this.breakDlinkPatchObj.placementapprovalstatus = providerDetails.approvalstatus || '';
}

private resetProviderDetails(): void {
  this.breakDlinkPatchObj.isinPreAdoptivePlacement = false;
  this.breakDlinkPatchObj.providername = '';
  this.breakDlinkPatchObj.placementstructure = '';
  this.breakDlinkPatchObj.placementstartdate = '';
  this.breakDlinkPatchObj.placementenddate = '';
  this.breakDlinkPatchObj.removalstartdate = '';
  this.breakDlinkPatchObj.removalenddate = '';
  this.breakDlinkPatchObj.placementapprovalstatus = '';
}



private getTprDetails() {
  this.tprListDetails = [];

  this._commonHttp.getArrayList(
      {
          where: { 
              servicecaseid: this.id ? this.id : null
           },
          method: 'get',
          nolimit: true
      }, 'tprdetails/gettprdetails' + '?filter'
      ).subscribe((res) => {
      if (res && res.length) {
        const sorting = _.sortBy(res,'tprdecisiondate').reverse();          
        const filterUnique = _.uniqBy(sorting, 'intakeservicerequestactorid');
        
        if(filterUnique && filterUnique.length) {
            this.tprListDetails = filterUnique;
        } else {
            this.tprListDetails = res;
        }
      }

  });

 
}

  createadoptioncase() {
    this.adoptionCaseCreationInProgress = true;
    const provider = this._store.getData(CASE_STORE_CONSTANTS.PLACEMENT_CHILD);
    const child = this._store.getData(CASE_STORE_CONSTANTS.PLACED_CHILD);
    const req = this.prepareadoptioncasereq(child, provider);
    this._PlacementAdoptionService.createadoptioncase(req).subscribe(data => {
      this.adoptionCaseCreationInProgress = false;
      if (data && data.length) {
        const res = data[0];
        //failed
        if(res.message == 'Failed') {
          this.existingAdoptionCaseId = res.caseid;
          setTimeout(() => {
            (<any>$('#failed-to-create')).modal('show');
          }, 1000);
        } else {
          this.newAdoptionCaseId = res.servicecaseno;
          this.assignCaseToUser();
          this.getBreaklink();
          setTimeout(() => {
            (<any>$('#mdchessis-info')).modal('show');
          }, 1000);
        }
      } else if (data.length == 0){
        setTimeout(() => {
          (<any>$('#issue-ac-create')).modal('show');
        }, 1000);
      }
     });
  }

  prepareadoptioncasereq(child: any, provider: any) {
    return {
      'adoptionplanningid': this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null,
      'servicecaseid': this.id,
      'assigntoid': this.selectedPerson?this.selectedPerson.userid:null,
      'person': [{
        'personid': child.personid, //@Simar- THIS IS NEEDED to transfer data from old person id to the new person id
        // All else is completely wrong as being hardcoded for the new adopted person child
        'firstname': child.firstname ? child.firstname : '',
        'lastname': ( provider.providerdetails && provider.providerdetails.providername ) ? provider.providerdetails.providername : null,
        'middlename': child.middlename ? child.middlename : '',
        'dob': child.dob,
        'gendertypekey': (child.gender === 'Female') ? 'F' : 'M',
        'role': 'RC', // ROLE to be changed as -> CHILD 
        'address': [{
          'address': '906 Valley St',
          'address2': 'Newcomb',
          'personaddresstypekey': 'C',
          'zipcode': '99999',
          'city': 'albaniya',
          'state': 'AR',
          'country': 'USA',
          'county': 'MD'
        }],
        'contact': [{
          'personphonetypekey': 'P',
          'phonenumber': '199999949',
          'phoneextension': ''
        }]
      },
      ]
    };
  }

  getRoutingUser() {
    this._commonHttp
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'INVR'},
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result) => {
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser();
      });
  }

  listUser() {
    this.selectedPerson = null;
    this.getUsersList = [];
    this.mergeUsersList = [];
    this.getUsersList = this.originalUserList;
      this.getUsersList = this.getUsersList.filter((res) => {
        if (res.issupervisor === false) {
          this.isSupervisor = false;
          return res;
        }
      });
      this.getUsersList.forEach((data) => {
        if (data.homelocationcode === this.zipCode || data.worklocationcode === this.zipCode) {
          this.mergeUsersList.push(data);
          this.zipCodeIndex = this.getUsersList.indexOf(data);
          this.getUsersList.splice(this.zipCodeIndex, 1);
        }
      });
      if (this.mergeUsersList !== undefined) {
        this.getUsersList = this.mergeUsersList.concat(this.getUsersList);
      }
  }

  selectPerson(person: any) {
    this.selectedPerson = person;
}

  assignUser() {
    if (this.selectedPerson) {
      (<any>$('#createAdoption')).modal('hide');
      (<any>$('#adoption-caseassign')).modal('hide');
      this.createadoptioncase();
    } else {
        this._alertService.warn('Please select a person');
    }
}

closePopup() {
    (<any>$('#adoption-caseassign')).modal('hide');
}

assignCaseToUser() {
  const model = {
    appeventcode: 'ADPC',
    adoptioncaseid: this.newAdoptionCaseId,
    assignedusers: this.selectedPerson.userid
};
this._commonHttp
.create(model,
    'adoptioncase/assigncase'
)
.subscribe((result) => {
    this._alertService.success('Adoption Case assigned successfully!');
     this.closePopup();
  });
}

}