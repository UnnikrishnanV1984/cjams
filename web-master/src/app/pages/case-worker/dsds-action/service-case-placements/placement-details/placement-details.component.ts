import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { ServiceCasePlacementsService } from '../service-case-placements.service';
import { AuthService, AlertService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { ActivatedRoute, Router } from '@angular/router';
import { PlacementConstants } from '../constants';
import { ExitPlacementService } from '../exit-placements/exit-placement.service';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS  } from '../../../_entities/caseworker.data.constants';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import moment from 'moment';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { LivingArrangmentEditComponent } from './living-arrangement-edit/living-arrangment-edit.component';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { HospitalizationService } from "../../../../../shared/services/hospitalization.service"
import { GlobalPopupComponent } from '../../../../../shared/shared-components/global-popup/global-popup.component';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { map, pluck, share } from 'rxjs/operators';
import { NavigationUtils } from '../../../../_utils/navigation-utils.service';
@Component({
    selector: 'placement-details',
    templateUrl: './placement-details.component.html',
    styleUrls: ['./placement-details.component.scss'],
    standalone: false
})
export class PlacementDetailsComponent implements OnInit {
  @ViewChild('noEndDateEmailPhonModal') private noEndDateEmailPhonModal!: GlobalPopupComponent;
  @ViewChild(LivingArrangmentEditComponent)
  placementEditDetails!: LivingArrangmentEditComponent;

  children: any = [];
  cpaHomesHistory: any = [];
  isSupervisor = false;
  action: string | null;
  Reason: any = '';
  updateButton = false;
  exiting = false;
  updateId: any = '';
  approval = true;
  CPAHomeList: any = [];
  ActiveCPAHome: any = [];
  exitTypeCodeList: any = [];
  exitReasonCodeList: any = [];
  cpaExitReasonRequired = false;
  addCPAHomeFormGroup!: FormGroup;
  editApprovedPlacement!: FormGroup;
  cpaProviderAddress = '';
  cpaProviderId = '';
  providerDetailsShow = false;
  onExitPlacement = false;
  isSubmitting: boolean;
  onEditPlacement = false;
  onVoidPlacement = false;
  placementhasExitdate = false;
  placementHistoryValidation: any = [];
  activePlacementCheck = false;
  hideExitReasonType = false;
  onReview = false;
  ApproveorReturntowork = 'Yes';
  startDate = '';
  startTime = '';
  enddate = '';
  endtime: any  = '';
  allowPlacementEdit!: boolean;
  isCompleted = false;

  isLivingArrangement = false;
  isFormalKinshipPlacement = false;

  placementCheck: any[] = [];
  minDate!: Date;
  maxDate!: Date;
  
  kinshipmaxStartDate!: Date;
  minEntryDate!: Date;
  placementid!: string;
  alternatePlacementId!: string;
  contractprogramid!: string;

  inHome = false;
  updating = false;
  currentHome: any;
  isExitAvailable: any;
  exitFields = true;
  isDOCExit = false;
  autoValidation!: boolean;
  editComments = "";
  editleastrestrictiveplacement = "";
  justification = "";
  placementStrType!: any[];
  validplacementStrType!: any[];
  exitTypes: any[] = [];
  reasonsForExit: any[] = [];

  legalinfoform!: FormGroup;
  //Pre-finalized adoptive home
  changePreAdoptiveRequired = true;
  ischangepreadoptive!: boolean;
  disableProvider = false;
  private userInfo: AppUser;
  id: any;
  daNumber: any;
  reasonforexit: any;
  transferagencies: any;
  start_time!: Date;
  startPlacementTime!: Date;
  errorMessage: any;
  isEmptyDates = false;
  getpersondetail_res: any;
  placementdetailspopupid = '#placementDetails';
  legalpagepopupid = '#legalpage';
  plccconfirmpopup = '#plccconfirmpopup';
  listpagepath = '../../list';
  dtformat = "YYYY-MM-DD";
  dtformat1 = 'MM-DD-YYYY';
  mandatorymsg = 'Please fill required fields';
  loggermsg = 'void inserted';

  personId: any;
  isProceedExitValidation = false;
  placementluggage!: boolean;
  plluggagepurchased!: boolean | null;
  plluggagecomments: any;
  placementdisposableortrashbag!: boolean | null;
  courtorderdate: any;
  agreementstartdate: any;
  filterCase!: string;
  isAdoptionCase!: boolean;
  permanancyPlanExist!: boolean;
  activeGapDoesExist!: boolean;
  activeAdoptionIdDoesExist: any;
  activeAdoptionDateWithActiveSuspension: any;
  activeGapWithActiveSuspension!: boolean;
  courtOrderDate!: string | null;
  dateRanges: any;
  hospitalizationFormValues: any = {};
  hospitalizationEditValues: any;
  exitFormValues: any = {}
  plccConfirmData : any;
  hospitalizationFormStatus = true;
  invalidDateString = 'Invalid date';
  isExitFormValid = true;
  adoptioncaseid: any;
  suspensionBeginDate: any;
  store: any;
  placementstructure: any;
  KRD_startdate: any;
  KRD_enddate: any;
  private _service: ServiceCasePlacementsService;
  private readonly _authService: AuthService;
  private readonly _alertService: AlertService;
  private readonly router: Router;
  private readonly route: ActivatedRoute;
  private readonly _exitPlacementService: ExitPlacementService;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _datastore: DataStoreService;
  private readonly _session!: SessionStorageService;
  private readonly _ServiceCasePlacementsService: ServiceCasePlacementsService;
  private readonly formBuilder: FormBuilder;
  private _hospitalizationService: HospitalizationService;
  isExitPermntLeavngCustod: boolean = false;
  noEndDateEmailPhonMessage: string = "";
  isNulEndDatPhonNumb: any = false;
  isNulEndDatEmail: any = false;
  childAge: number = -1;
  phoneNumbers: any[] = [];
  emailIds: any[] = [];
  dod: string = "";

  constructor(private injector: Injector,
    private _navigationUtils: NavigationUtils) {
    this._service = this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._exitPlacementService = this.injector.get<ExitPlacementService>(ExitPlacementService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._datastore = this.injector.get<DataStoreService>(DataStoreService);
    this._ServiceCasePlacementsService = this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._hospitalizationService = this.injector.get<HospitalizationService>(HospitalizationService);

    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.action = this.route.snapshot.paramMap.get('action');
    this.isSubmitting = false;
    if (this.action === PlacementConstants.ACTIONS.EXIT) {
      this.onExitPlacement = true;
    } else {
      this.onExitPlacement = false;
    }

    if (this.action === PlacementConstants.ACTIONS.REVIEW) {
      this.onReview = true;
    } else {
      this.onReview = false;
    }

    if (this.action === PlacementConstants.ACTIONS.EDIT) {
      this.onEditPlacement = true;
    } else {
      this.onEditPlacement = false;
    }

    if (this.action === PlacementConstants.ACTIONS.VOID) {
      this.onVoidPlacement = true;
    } else {
      this.onVoidPlacement = false;
    }
    this.userInfo = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.children = this._service.placementDetails;
    this.hospitalizationFormValues = this.children?.[0]?.['placement']?.['placementrevision']?.[0]?.['hospitalizationdetails'] ?? {};
    this.getPlacementExitReasonType();
    this.getPlacementInfoList();
    this.initializeCPAHomeFormGroup();
    this.addCPAHomeFormGroup.valueChanges.subscribe(val => {
      if (this.addCPAHomeFormGroup?.controls['entryDate']?.errors && this.addCPAHomeFormGroup?.controls['entryDate']?.errors['matDatepickerMin']) {
        this.errorMessage = 'CPA Home Entry Date can not be prior to Placement Start Date ';
      } else {
        this.errorMessage = '';
      }
    })
    this.initlegalinfoform();
    this.ApproveorReturntowork = 'Yes';
    this.getPlacementExitType();
    this.initializeEditPlacementFormGroup();
    if (!this.children || !this.children.length) {
      this.goBack();
    }
    else {
      this.checkChildPlacement();
    }

    this.getpersondetail();
    this.updatePersonId(this.children);
    this.getCourtDetails();
    this.getAdoptionData();
    this.getPermanencyPlanList();
    this.getProgramAssignmentList();
    this.getDates();
    this.getPhoneNumber(this.personId);
    this.getEmailPage(this.personId);
    this.childAge = this.getAgeFromDOB(this.children[0]?.dob);
    this.dod = this.children[0]?.dateofdeath || "";
    this.updatePersonInfo(this.personId);
  }

  updatePersonId(child: any) {
    this.personId = child?.[0]?.personid
  }
  nullCheck(inputData: any) {
    return inputData ? inputData : null;
  }
  initlegalinfoform() {
    this.legalinfoform = this.formBuilder.group({
      legalinfovalue: ['']
    });
  }
  closelegalPopup() {
    ($(this.legalpagepopupid) as any).modal('hide');
    this.legalinfoform.reset();
  }
  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm', true).isValid()) {
      return moment(strtime, 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm:ss', true).isValid()) {
      return moment(strtime, 'HH:mm:ss', true).toDate();
    }
  }

  initializeCPAHomeFormGroup() {
    if (Array.isArray(this.children) && this.children.length) {
      this.minEntryDate = this.children[0].placement.startdate;
    }
    this.addCPAHomeFormGroup = this.formBuilder.group({
      providerName: [null, Validators.required],
      entryDate: [null, Validators.required],
      entryTime: [],
      exitDate: [],
      exitTime: [],
      exitTypeCode: [],
      exitReasonCode: [],
    });

  }


  initializeEditPlacementFormGroup() {
    this.editApprovedPlacement = this.formBuilder.group({
      exittypekeycheck: [],
      exitreasonchecktypekey: [],
      transferagency: [],
      otherpublicagency: [],
      exitluggage: [], 
     exitluggageprovided :[],
     exitluggagecomments :[],
     exitdisposableortrashbag: [],
    });

  }


  cancel() {
    this.action = PlacementConstants.ACTIONS.CANCEL;
    this.goBack();
  }

  goBack() {

    this._service.getChildRemovalInfoAndPlacements().subscribe(response => {
      this._service.broadCastPageRefresh();
      if (this.action === PlacementConstants.ACTIONS.ADD) {
        ($('#addCPAHome') as any).modal('hide');
      }
      else {
        ($(this.placementdetailspopupid) as any).modal('hide');
      }
      this.isSubmitting = false;
      if (this.isDOCExit) {
        ($('#docalert') as any).modal('show');
      } else if (this.isSupervisor && (this.action === PlacementConstants.ACTIONS.EDIT || this.action === PlacementConstants.ACTIONS.EXIT)) {

        if (this.action === PlacementConstants.ACTIONS.EDIT) {
          const formData = this.placementEditDetails?.placementEditForm?.getRawValue();
          this._datastore.setData('editedChildId', formData?.personid);
          this._datastore.setData('editedPlacementId', formData?.placementid);
        }

        this.router.navigate([this.listpagepath], { relativeTo: this.route });


      } else {
        this._datastore.setData('editedChildId', null);
        this._datastore.setData('editedPlacementId', null);
        this.checkExitAction();
      }

    });

    this.handleExitEndDate("");
    this.handleExitEndTime("")
  }

  checkChildPlacement() {
    if (this.children[0].placementType === 'LA') {
      this.autoValidation = false;
    } else {
      this.autoValidation = true;
    }
    if (this.action === PlacementConstants.ACTIONS.ADD) {
      if (this.children && this.children.length && this.children[0].placement) {
        this.placementid = this.children[0].placement.placementid;
        this.placementstructure = this.children[0].placement.placementstructuredesc
        this.contractprogramid = this.children[0].placement.contractprogramid;
        this.start_time = this.children[0].placement.starttime;
      }
      ($('#addCPAHome') as any).modal('show');
      this.getProviderList();
      this.getCodes();
      this.getCPAHomesHistory();
      this.disableProvider = false;
      this.currentHome = this.cpaHomesHistory.find((prevHome: { exit_dt: null; }) => prevHome.exit_dt == null);
      if (this.currentHome) {
        this.inHome = true;
        this.exitFields = true;
        this.viewCpaHome(this.currentHome);
      }
      else {
        this.inHome = false; //add new
        this.exitFields = false;
        this.addCPAHomeFormGroup.reset();
      }
    }
    else {
      ($(this.placementdetailspopupid) as any).modal('show');
      this.checkEditAction();
      this.checkPlacementInfo()
      this.checkForAllActions();

      this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
      this._service.placementApprovalQueue$.subscribe(data => {
        this._alertService.success(data, true);
        if (this.returnAndCheckIfLivingArrTypeKeyFn()) {
          ($(this.placementdetailspopupid) as any).modal('hide');
          ($('#hospitalization-info') as any).modal('show');
        }
        else if (data === 'Permanency Plan Approved Successfully' || data === 'Permanency Plan Rejected Successfully' || data === 'Placement approved successfully' ||
          data === 'Placement returned to the worker successfully.') {
          this.cancel();
        }
      });
      const childplacementobj = this.children[0];
      const childremovalobj = this._service.removedChildList.find(item => item.personid === childplacementobj.personid);
      this.validatePlacementDates(childremovalobj);
    }
  }
  // Assosiated with checkChildPlacement method
  private returnAndCheckIfLivingArrTypeKeyFn() {
    return (this.isSupervisor && this.ApproveorReturntowork == 'Yes' && (this.children[0].placement?.livingarrangementtypekey == 'ERP' || this.children[0].placement?.livingarrangementtypekey == 'ERM' || this.children[0].placement?.livingarrangementtypekey == 'IMC' || this.children[0].placement?.livingarrangementtypekey == 'PSYH'));
  }

  checkExitAction() {
    if (this.action === PlacementConstants.ACTIONS.EXIT) {
      const exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue();
      if (this.action === PlacementConstants.ACTIONS.EXIT && exitFormData.exittypekey === 'PLCC') {
        ($(this.legalpagepopupid) as any).modal('show');
      } else {
        this.router.navigate([this.listpagepath], { relativeTo: this.route });
      }
    } else {
      this.router.navigate([this.listpagepath], { relativeTo: this.route });
    }
    setTimeout(() => {
      $('body').removeAttr("style");
    },500);
  }
  checkEditAction() {
    this.getDates();
    if (this.action === PlacementConstants.ACTIONS.EDIT) {
      if (this.children && this.children.length && this.children[0].placement && this.children[0].placement.startdate) {
        this.isLivingArrangement = this.children[0].placement.placementtypekey === 'LA';
        this.startDate = this.children[0].placement.startdate;
      }
      if (this.children && this.children.length && this.children[0].placement && this.children[0].placement.starttime) {
        this.startTime = moment(this.children[0].placement.starttime).format('HH:mm');
      }
    }

    if (this.children && this.children.length
      && this.children[0].placement
      && this.children[0].placement.providerdetails
      && this.children[0].placement.providerdetails.provider_id) {
      this.getPlacementStrType(this.children[0].placement.providerdetails.provider_id, this.children[0].placement.service_id);
    }
    if (this.children && this.children.length && this.children[0].placement) {
      this._exitPlacementService.minExitDate = this.children[0].placement.startdate;
    }
  }

  checkPlacementInfo() {
    if (this.children[0].placement
      && this.children[0].placement.placementrevision
      && this.children[0].placement.placementrevision.length
      && this.children[0].placement.placementtypekey === 'PRPL') {
      this.justification = this.children[0].placement.placementrevision[0].justification
      this.editComments = this.children[0].placement.placementrevision[0].remarks;
      this.editleastrestrictiveplacement = this.children[0].placement.placementrevision[0].leastrestrictiveplacement;
      this.startDate = this.children[0].placement.placementrevision[0].entrydate;
      this.startTime = moment(this.children[0].placement.placementrevision[0].entrytime).format('HH:mm');
      this.placementluggage = this.children[0].placement.placementrevision[0].placementluggage;
      this.plluggagepurchased = this.children[0].placement.placementrevision[0].plluggagepurchased;
      this.plluggagecomments = this.children[0].placement.placementrevision[0].plluggagecomments;
      this.placementdisposableortrashbag = this.children[0].placement.placementrevision[0].placementdisposableortrashbag;
    }
    if (this.children && this.children.length && this.children[0].placement && this.children[0].placement.enddate) {
      this.enddate = this.children[0].placement.enddate;
      this.endtime = moment(this.children[0].placement.endtime).format('HH:mm');
      this.placementhasExitdate = true;
      if (this.children[0].placement.placementrevision && this.children[0].placement.placementrevision.length) {
        this.enddate = this.children[0].placement.placementrevision[0].exitdate;
        this.endtime = moment(this.children[0].placement.placementrevision[0].exittime).format('HH:mm');
      }

      if (this.children[0].placement.exittypekey) {
        this.editApprovedPlacement.patchValue({
          exittypekeycheck: this.children[0].placement.exittypekey
        })
         const exitTypeKey = this.children[0].placement.exittypekey;
        if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
          this.hideExitReasonType = true;
        }
        this.patchPlacementRevision();
      }
    }
  }

  private patchPlacementRevision(){
    if (this.children[0].placement.exittypekey === 'PLCC'){
      const placementRevision = this.children[0].placement?.placementrevision ? this.children[0].placement?.placementrevision[0] :  null;
      this.editApprovedPlacement.patchValue({
        exitluggage: placementRevision?.exitluggage,
        exitluggageprovided: placementRevision?.exitluggageprovided,
        exitluggagecomments: placementRevision?.exitluggagecomments,
        exitdisposableortrashbag: placementRevision?.exitdisposableortrashbag
      })
    }
  }

  checkForAllActions() {
    if (this.action === PlacementConstants.ACTIONS.REVIEW
      || this.action === PlacementConstants.ACTIONS.EDIT
      || this.action === PlacementConstants.ACTIONS.EXIT
      || this.action === PlacementConstants.ACTIONS.VIEW) {
      this.children.forEach((child: any) => {
        if (child.placement && !child.placement.enddate && child.placement.revisionupdate) {
          child.placement.exittypedescription = child.placement.revisionupdate.exittypekeydescription
          child.placement.exitreasontypedescription = child.placement.revisionupdate.exitreasontypedescription
        }

        if (child.placement.revisionupdate != null) {
          child.placement.etime = this.settimein12hr(this.nullCheck(child.placement.revisionupdate.endtime));
          child.placement.stime = this.settimein12hr(this.nullCheck(child.placement.revisionupdate.entrytime));
          child.placement.enddate = this.nullCheck(child.placement.revisionupdate.enddate);
          child.placement.startdate = this.getChildPlacementStartDate(child);

        }
        else {
          child.placement.stime = this.getChildPlacementStartTime(child);
          child.placement.etime = this.settimein12hr(this.nullCheck(child.placement.endtime));
          child.placement.startdate = this.nullCheck(child.placement.startdate);
          child.placement.enddate = this.nullCheck(child.placement.enddate);
        }
      })
    }
  }

  getChildPlacementStartDate(child: any) {
    return (child.placement.revisionupdate.entrydate) ? child.placement.revisionupdate.entrydate : this.nullCheck(child.placement.startdate);
  }

  getChildPlacementStartTime(child: any) {
    return this.settimein12hr((child.placement.starttime) ? child.placement.starttime : this.nullCheck(child.placement.startdate));
  }

  reviewPlacement(child: any, placement: any) {
    this._service.resetValues();
    const placementDetails = child;
    child.placementType = placement.placementtypekey;
    placementDetails.placement = placement;
    this._service.placementDetails = [placementDetails];
    this.router.navigate(['../../details/' + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });
  }

  getPlacementInfoList() {
    this._commonHttpService
      .getPagedArrayList({
        nolimit: true,
        method: 'get',
        where: { servicecaseid: this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID) },
      },
        'placement/getplacementbyservicecase?filter'

      ).subscribe(response => {
        const history = response.data;
        history.forEach(item => {
          const placementshistory = item.placements;
          placementshistory.forEach((element: { placementtypekey: string; isvoided: number; enddate: null; }) => {
            if (element.placementtypekey === 'PRPL' && element.isvoided !== 1) {
              this.placementHistoryValidation.push(element);
              if (element.enddate == null) {
                this.activePlacementCheck = true;
              }
            }
          });
        })
      });
  }

  acknowledgeDOC() {
    this.isDOCExit = false;
    ($('#docalert') as any).modal('hide');
    this.router.navigate([this.listpagepath], { relativeTo: this.route });
  }

  getCodes() {
    this._exitPlacementService.getExitTypes().subscribe(result => {
      if (result && result.length) {
        this.exitTypeCodeList = result;
      }
    });
  }

  onExitTypeChange() {
  const exitTypeKey = this.addCPAHomeFormGroup.getRawValue().exitTypeCode;

  const selectedExitType = this.exitTypeCodeList.find(
    (item: any) => item.ref_key === exitTypeKey
  );

  this.addCPAHomeFormGroup.patchValue({
    exitReasonCode: null
  });

  if (selectedExitType?.description === 'Change in Placement Structure') {
    this.cpaExitReasonRequired = false;
    this.exitReasonCodeList = [];
    return;
  }

  this.cpaExitReasonRequired = true;

    this._exitPlacementService.getReasonForExit(exitTypeKey).subscribe(result => {
      if (result && result.length) {
        this.exitReasonCodeList = result;
      }
    });
  }

  getProviderList() {
    this._commonHttpService.getArrayList(
      {
        where: {
          program_id: this.contractprogramid
        },
        method: 'get'
      },
      'programfacility/getprogramfacilitydetials?filter'
    ).subscribe(response => {
      if (response && Array.isArray(response) && response.length) {
        if (response[0].getprogramfacilitydetials && Array.isArray(response[0].getprogramfacilitydetials) && response[0].getprogramfacilitydetials.length)
        // tslint:disable-next-line: one-line
        {
          this.CPAHomeList = response[0].getprogramfacilitydetials;
          if (this.CPAHomeList !== null && this.CPAHomeList !== undefined) {
            this.ActiveCPAHome = this.CPAHomeList.filter((item: { end_dt: string | number | Date; }) => !item.end_dt || (item.end_dt && new Date(item.end_dt) >= new Date()))
          }
        }
      }
    });
  }

  timechange() {

    const currentTime: any = moment(new Date()).format("HH:mm");
    const currentDate: any = moment(new Date()).format(this.dtformat);
    const givenDate: any = moment(this.enddate).format(this.dtformat);
    const givenTime: any = this.endtime;

    if (givenTime !== null && currentTime < givenTime && currentDate === givenDate) {
      this._alertService.error('End date & time should be less than the current time');
      this.endtime = null;
    } else if (givenTime !== null && this.startTime > givenTime && this.startDate === givenDate) {
      this._alertService.error('Exit date & time should be greater than the start date & time');
      this.endtime = null;
    }

    const childremovalobj = this._service.removedChildList.find(item => item.personid === this.children[0]?.personid);
    if (!this.isLivingArrangement && childremovalobj?.childremoval?.length > 0) {
        const { cEndDate, cEndTime } = this.returnIfChildRemovalDateFn(childremovalobj);
        if (cEndDate !== null && givenTime !== null && cEndTime < givenTime  && cEndDate === givenDate) {
          this._alertService.error('Exit date & time should be same as the child removal episode');
          this.endtime = null;
        }
    }

  }

  private returnIfChildRemovalDateFn(childremovalobj: any) {
    const childData = childremovalobj.childremoval.filter((childD: { intakeservreqchildremovalid: any; }) => childD.intakeservreqchildremovalid === this.children[0]?.placement?.intakeservreqchildremovalid);
    const childRemoval = childData;
    const cEndTime = childRemoval[0]?.exitdate ? moment(childRemoval[0].exitdate).format('HH:mm') : '';
    const cEndDate = childRemoval[0]?.exitdate ? moment(childRemoval[0].exitdate).format(this.dtformat) : '';
    return { cEndDate, cEndTime };
  }

  getCPAHomesHistory() {
    this.alternatePlacementId = this.children[0].placement.alternateid;
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: {
          placement_id: this.alternatePlacementId
        }
      },
      'tb_placement_cpa_homes?filter'
    ).subscribe(response => {
      if (response && Array.isArray(response) && response.length) {
        this.cpaHomesHistory = response;
        this.isExitAvailable = this.cpaHomesHistory.find((prevHome: { exit_dt: null; }) => prevHome.exit_dt !== null);
        response.forEach(cpahome => {
          if (cpahome.provider_id) {
            this._commonHttpService.getArrayList(
              {
                method: 'get',
                where: { provider_id: cpahome.provider_id }
              },
              'tb_provider?filter'
            ).subscribe(responseValue => {
              if (responseValue && responseValue.length) {
                cpahome['providername'] = this.getProviderFullName(responseValue[0]);
              }
            });
          }
        }
        )
        this.setIsEmptyDates();
      } else {
        this.isExitAvailable = 'new'; // No any cpa homes so far.
      }
    }
    );
  }

  setIsEmptyDates() {
    const getEmptyDates = this.cpaHomesHistory.find((prevHome: { exit_dt: null; }) => prevHome.exit_dt === null);
    if (getEmptyDates !== undefined) {
      if (getEmptyDates.length !== 0 && this.cpaHomesHistory.length !== 0) {
        this.isEmptyDates = true;
      }
    }
  }

  getProviderFullName(providerInfo: any) {

    let providerName = ''

    if (providerInfo) {
      providerName = providerInfo.provider_nm ? providerInfo.provider_nm : ''
    }

    if (providerInfo && providerName === '') {
      providerName = '' +
        (providerInfo.provider_prefix_cd ? providerInfo.provider_prefix_cd + ' ' : '') +
        (providerInfo.provider_first_nm ? providerInfo.provider_first_nm + ' ' : '') +
        (providerInfo.provider_middle_nm ? providerInfo.provider_middle_nm + ' ' : '') +
        (providerInfo.provider_last_nm ? providerInfo.provider_last_nm + ' ' : '') +
        (providerInfo.provider_suffix_cd ? providerInfo.provider_suffix_cd + ' ' : '');
    }

    return providerName;

  }
  approve() {
    this._service.startPlacementApprovalInQueue();
    ($(this.placementdetailspopupid) as any).modal('hide');
    ($('#placement-approval-request') as any).modal('hide');
  }

  placementCheckError() {
    if (this.children[0].placement.revisionupdate &&
      (this.children[0].placement.revisionupdate.voidreasontypekey === null ||
        this.children[0].placement.revisionupdate.voidreasontypekey === 'null')
      && (this.children[0].placement.revisionupdate.isvoided !== 1)) {
      this._commonHttpService.endpointUrl = 'placement/placementAutoValidation';
      const placement = this.children[0].placement;
      const revisionupdate = (placement) ? placement.revisionupdate : null;
      const model = {
        placementid: placement.alternateid,
        startdate: (revisionupdate) ? revisionupdate.entrydate : this.getPlacementStartDate(placement),
        enddate: (revisionupdate) ? revisionupdate.enddate : null,
        update_sw: 'P',
        fromscreen: 'other', // other-- Other screen. Not from placement validation screen
        isbefore: false
      };
      this._commonHttpService.create(model).subscribe(
        (response) => {
          // No data or function to add or call
        });
    }
  }

  cpaSelect(cpaHomeSelected: any) {
    const home = this.ActiveCPAHome.find((elem: { provider_id: any; }) => elem.provider_id == cpaHomeSelected);
    this.cpaProviderId = home.provider_id;
    this.cpaProviderAddress = home.provideraddress;
    this.providerDetailsShow = true;
    this.currentHome = home;
    this.commonValidatorFn('entryTime');
  }

  // Date and time
  convertDateTimeToTimestamp(date: any, time: any) {
    if (moment(date).isValid() && time) {
      return moment(moment(date).format('MM/DD/YYYY') + ' ' + time).format();
    }
    else {
      return null;
    }
  }

  calculateNewDuration() {
    const entryTime = this.addCPAHomeFormGroup.controls['entryTime'].value;

    const entryDate = this.addCPAHomeFormGroup.controls['entryDate'].value;
    const exitTime = this.addCPAHomeFormGroup.controls['exitTime'].value;
    const exitDate = this.addCPAHomeFormGroup.controls['exitDate'].value;

    if (entryTime && exitTime) {
      const formatStartDate = moment(entryDate).format(this.dtformat1);
      const formatEndDate = moment(exitDate).format(this.dtformat1);
      const _endTime = moment(formatEndDate + ' ' + exitTime + ':00');
      const _startTime = moment(formatStartDate + ' ' + entryTime + ':00');
      if (exitTime != this.invalidDateString && _endTime < _startTime) {
        this._alertService.error('End time must be greater than Start time.');
        return false;
      }

    }
    if (entryDate && entryTime) {
      if (this.cpaHomesHistory && this.cpaHomesHistory.length && this.cpaHomesHistory.length >= 1) {
        const isexist = this.getIsExists(entryDate, exitDate, entryTime, exitTime);
        if (isexist) {
          this._alertService.warn('CPA Home already exist between this date range');
          return false;
        }
      }
    }
    return true;
  }
  getIsExists(entryDate: any, exitDate: any, entryTime: any, exitTime: any) {
    return this.cpaHomesHistory.find((cpaHomes: any) => {
      const cpaentryDate = cpaHomes.entry_dt;
      const cpaexitDate = cpaHomes.exit_dt;
      const cpaentryTime = moment(cpaHomes.entry_tm).format("HH:mm:ss");
      const cpaexitTime = moment(cpaHomes.exit_tm).format("HH:mm:ss");
      const formatcpaStartDate = moment(cpaentryDate).format(this.dtformat1);
      const formatcpaEndDate = moment(cpaexitDate).format(this.dtformat1);
      const _startTime1 = moment(formatcpaStartDate + ' ' + cpaentryTime + ':00');
      const _endTime1 = moment((formatcpaEndDate ? formatcpaEndDate : formatcpaStartDate) + ' ' + cpaexitTime + ':00');

      const cpaentryDate1 = entryDate;
      const cpaexitDate1 = exitDate;
      const cpaentryTime1 = entryTime;
      const cpaexitTime1 = exitTime;
      const formatcpaStartDate1 = moment(cpaentryDate1).format(this.dtformat1);
      const formatcpaEndDate1 = moment(cpaexitDate1).format(this.dtformat1);
      const _startTime2 = moment(formatcpaStartDate1 + ' ' + cpaentryTime1 + ':00');
      const _endTime2 = moment((formatcpaEndDate1 ? formatcpaEndDate1 : formatcpaStartDate1) + ' ' + cpaexitTime1 + ':00');

      return ((cpaHomes.placement_cpa_home_id != this.updateId)
        && !((_startTime2 >= _startTime1 && _startTime2 >= _endTime1) &&
          ((!exitDate || exitTime == this.invalidDateString) ? true : (_endTime2 >= _endTime1 && _endTime2 >= _startTime1)))
      );
    })
  }

  calculateDuration() {
    const entryDate = this.addCPAHomeFormGroup.controls['entryDate'].value;
    const exitDate = this.addCPAHomeFormGroup.controls['exitDate'].value;
    const entryTime = this.addCPAHomeFormGroup.controls['entryTime'].value;
    const exitTime = this.addCPAHomeFormGroup.controls['exitTime'].value;
    const formatStartDate = moment(entryDate).format(this.dtformat1);
    const formatEndDate = moment(exitDate).format(this.dtformat1);

    if (entryTime && exitTime) {
      const _startTime = moment(formatStartDate + ' ' + entryTime + ':00');
      const _endTime = moment((formatEndDate ? formatEndDate : formatStartDate) + ' ' + exitTime + ':00');
      if (exitTime != this.invalidDateString && _endTime < _startTime) {
        this._alertService.error('End time must be greater than Start time.');
        return false;
      }
      if (this.cpaHomesHistory && this.cpaHomesHistory.length && this.cpaHomesHistory.length >= 1) {
        const isexist = this.getIsExists(entryDate, exitDate, entryTime, exitTime);
        if (isexist) {

          this._alertService.warn('CPA Home already exist between this date range');
          return false;
        }
      }
    }
    return true;
  }

  cpaHomeSave() {
    // validate the entry exit time if exitFields
    const currentUser = this._authService.getCurrentUser();
    const userid = currentUser && currentUser.user ? currentUser.user.securityusersid : '';
    if (this.exitFields) {
      if (!this.calculateDuration()) {
        return;
      }
    }

    if (!this.calculateNewDuration()) {
      return;
    }

    if (!this.inHome && !this.updating) { //new
      this._commonHttpService.create(
        {
          placement_uuid: this.placementid,
          placement_id: this.alternatePlacementId,
          //provider_id: this.addCPAHomeFormGroup.controls['providerId'].value,
          provider_id: this.cpaProviderId,
          entry_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          entry_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          exit_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_type_cd: this.addCPAHomeFormGroup.controls['exitTypeCode'].value,
          exit_reason_cd: this.addCPAHomeFormGroup.controls['exitReasonCode'].value
        },
        'tb_placement_cpa_homes/cpahomeplacementadd'
      ).subscribe(
        (result) => {
          this.addCPAHomeFormGroup.reset();
          this.getCPAHomesHistory();
          this._alertService.success('CPA Home Saved Successfully');
          this.inHome = true;
          this.updating = false;
          this.exitFields = true;
          this.viewCpaHome(this.currentHome);
        },
        (error) => {
          // No data or function to add or call
        }
      );
    }
    else if (this.inHome && this.updating) { //exiting ready= exit options on and others disabled.
      this._commonHttpService.patch(this.updateId,
        {
          placement_uuid: this.placementid,
          placement_id: this.alternatePlacementId,
          //provider_id: this.addCPAHomeFormGroup.controls['providerId'].value,
          provider_id: this.cpaProviderId,

          entry_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          entry_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          exit_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_type_cd: this.addCPAHomeFormGroup.controls['exitTypeCode'].value,
          exit_reason_cd: this.addCPAHomeFormGroup.controls['exitReasonCode'].value,
          update_ts: moment(new Date()).format('MM/DD/YYYY hh:mm:ss A'),
          update_user_id: userid

        },
        'tb_placement_cpa_homes'
      ).subscribe(
        (result) => {
          this.addCPAHomeFormGroup.reset();
          this.getCPAHomesHistory();
          this._alertService.success('CPA Home Exited Successfully');
          this.inHome = false;
          this.updating = false;
          this.exitFields = this.currentHome.exit_dt ? true : false;
        },
        (error) => {
          // No data or function to add or call
        }
      );
    }
    else if (this.updating) {// updating existing
      this._commonHttpService.patch(this.updateId,
        {
          placement_uuid: this.placementid,
          placement_id: this.alternatePlacementId,
          provider_id: this.cpaProviderId,
          entry_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          entry_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['entryDate'].value, this.addCPAHomeFormGroup.controls['entryTime'].value),
          exit_dt: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_tm: this.convertDateTimeToTimestamp(this.addCPAHomeFormGroup.controls['exitDate'].value, this.addCPAHomeFormGroup.controls['exitTime'].value),
          exit_type_cd: this.addCPAHomeFormGroup.controls['exitTypeCode'].value,
          exit_reason_cd: this.addCPAHomeFormGroup.controls['exitReasonCode'].value,
          update_ts: moment(new Date()).format('MM/DD/YYYY hh:mm:ss A'),
          update_user_id: userid
        },
        'tb_placement_cpa_homes'
      ).subscribe(
        (result) => {
          this.addCPAHomeFormGroup.reset();
          this.getCPAHomesHistory();
          this.updating = false;
          this._alertService.success('CPA Home Updated Successfully');

        },
        (error) => {
          // No data or function to add or call
        }
      );
    }
  }

  viewCpaHome(cpaHome: any) {
    this.updating = false;
    this.updateId = cpaHome.placement_cpa_home_id;
    if (cpaHome.exit_dt) {
      this.exitFields = true;
    }
    else {
      this.exitFields = false;
    }
    this.patchCPAHome(cpaHome);

  }

  editCpaHome(cpaHome: any) {
    this.updating = true;
    this.updateId = cpaHome.placement_cpa_home_id;
    if (cpaHome.exit_dt) {
      this.exitFields = true;
    }
    else {
      this.exitFields = false;
    }
    this.patchCPAHome(cpaHome);
  }

  patchCPAHome(cpaHome: any) {
    this.ActiveCPAHome = this.CPAHomeList;
    const home = this.ActiveCPAHome.find((elem: { provider_id: any; }) => elem.provider_id == cpaHome.provider_id);
    this.disableProvider = true;
    this.addCPAHomeFormGroup.patchValue({

      providerName: home.provider_id,
      entryDate: cpaHome.entry_dt,
      entryTime: moment(cpaHome.entry_tm).format("HH:mm:ss"),
      exitDate: cpaHome.exit_dt,
      exitTime: moment(cpaHome.exit_tm).format("HH:mm:ss"),
      exitTypeCode: cpaHome.exit_type_cd,
      exitReasonCode: cpaHome.exit_reason_cd
    });
    this.cpaProviderId = cpaHome.provider_id;
    this.cpaProviderAddress = home.provideraddress;
    this.providerDetailsShow = true;
    this.commonValidatorFn('entryTime');
  }
  exitCpaHome(cpaHome: any) {
    this.updating = true;
    this.exitFields = true;
    this.updateId = cpaHome.placement_cpa_home_id;
    this.currentHome = cpaHome;

    this.patchCPAHome(cpaHome);
  }

  approveRequest() {
    if (this.autoValidation) {
      if (this.children[0].placement.revisionupdate &&
        (this.children[0].placement.revisionupdate.voidreasontypekey === null ||
          this.children[0].placement.revisionupdate.voidreasontypekey === 'null')
        && (this.children[0].placement.revisionupdate.isvoided !== 1)) {
        this.sendApproveRequest();
      } else {
        ($(this.placementdetailspopupid) as any).modal('hide');
        this._service.startPlacementApprovalInQueue();
        this.placementCheckError();
      }
    } else {
      this._service.approveorRejectPlacementasSupervisor(this.children[0]?.placement?.placementid, 'Approved', this.Reason, this.children[0]);
    }
  }
  
  sendApproveRequest() {
    this._commonHttpService.endpointUrl = 'placement/placementAutoValidation';
    const placement = this.children[0].placement;
    const revisionupdate = (placement) ? placement.revisionupdate : null;
    const revisionstartdate = revisionupdate ? this.getEntryDate(revisionupdate) : null;
    const model = {
      placementid: placement.alternateid,
      startdate: (revisionstartdate) ? revisionstartdate : this.getPlacementStartDate(placement),
      enddate: (revisionupdate) ? revisionupdate.enddate : null,
      update_sw: 'P',
      fromscreen: 'other', // other-- Other screen. Not from placement validation screen
      isbefore: true,
      servicecaseid: this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID)
    };
    this._commonHttpService.create(model).subscribe(
      (response) => {
        if (response && response.length > 0) {
          this.placementCheck = response;
          ($(this.placementdetailspopupid) as any).modal('hide');
          ($('#placement-approval-check') as any).modal('show');
        } else {
          this._service.approveorRejectPlacementasSupervisor(this.children[0].placement.placementid, 'Approved', this.Reason, this.children[0]);
        }
      });
  }

  getEntryDate(revisionupdate: any) {
    return revisionupdate.entrydate ? revisionupdate.entrydate : null;
  }
  getPlacementStartDate(placement: any) {
    return placement ? placement.startdate : null;
  }


  // Trigger to pass the CJAMS information to CSMS
  sendApprovalInfomation(clientid: any, removalid: any) {
    this._commonHttpService.create(
      {
        'where': {
          'clientId': clientid,
          'removalId': removalid,
          'reviewperiod': null
        },
      },
      'titleive/ive/ivecsms-data'
    ).subscribe(response => {
      return true;
    },
      (error) => {
        return false;
      });
  }


  changePreAdoptivePlacement() {
    const plcmnt = this.children[0].placement;
    const plcmntrev = this.children[0].placement.revisionupdate;
    const formData = {
      "providersentdate": new Date(),
      "providerdesc": null,
      "responseacceptedkey": "4612",
      "rejectreasonkey": null,
      "service_id": "500", //Pre-finalized adoptive home
      "ratestructureid": "500",
      "startdate": plcmntrev.enddate,
      "starttime": "08:00",
      "isssaapproval": 0,
      "ifcapprovaldate": null,
      "remarks": " ",
      "placementtypekey": "PRPL",
      "ischildplacedoutside": null,
      "casecounty": null,
      "providerid": plcmnt.provider_id,
      "contractprogramid": null,
      "providerorganizationid": null,
      "servicecaseid": plcmnt.servicecaseid,
      "personid": plcmnt.personid,
      "intakeservreqchildremovalid": plcmnt.intakeservreqchildremovalid,
      "placementid": null,
      "livingid": null,
      "intakeservicerequestactorid": plcmnt.intakeservicerequestactorid,
      "userid": "d44eb3ee-9b1d-4271-8295-2587d010977"
      //The 'userid' of original caseworker can be sent as part of the call and on the api use it to replace
      //and on the api make changes to use it to replace app.currentuser.securityuserid
    }

    this._commonHttpService
      .create(formData, 'placement/addupdate')
      .subscribe(response => {
        // No data or function to add or call
      });
  }

  approveOrReturn() {
    if (this.ApproveorReturntowork === 'No') {
      this.reject();
    } else {
      this.approveRequest();
    }
  }

  reject() {
    if (!this.Reason) {
      this._alertService.error('Please update the reason for return to worker.');
      return;
    }
    this._service.approveorRejectPlacementasSupervisor(this.children[0].placement.placementid, 'Rejected', this.Reason, this.children[0]);
  }

  private getCourtDetails() {
    this._commonHttpService.getArrayList(
        {
            method: 'get',
            where: {
              objectid: this.id,
              objecttype:'servicecase'
          }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
    ).subscribe((res) => {
      this.courtorderdate = res.filter(e => e.personid == this.personId).map(e => e.courtorderdate)?.[0]
    });
}

  confirmUpdate() {
    (<any>$('#maintenance-payment-check-dialog-a')).modal('show');
  }

  private async getAgreementDate(permanencyplanid: any) {
    this.store = this._datastore.getCurrentStore()
    const placement = this.store['placement_child'];
    const planid = (placement) ? placement.permanencyplanid : null;
    this._commonHttpService
        .getSingle(
            new PaginationRequest({
                where: {
                    permanencyplanid: permanencyplanid || planid
                },
                method: 'get',
                page : 1,
                limit: 10
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
        )
        .subscribe(async res => {
          if (res && res.length && Array.isArray(res)) {
            const adoptionplanningid = res[0].getadoptionplanning?.[0]?.adoptionplanningid;
            await this.getAdoptionData(adoptionplanningid);
          }
        });
    }
  private async getAdoptionData(planid: string | null = null) {
    const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

    this.isAdoptionCase = caseType === CASE_TYPE_CONSTANTS.ADOPTION;
    let planningid: any;
    this._datastore.currentStore.subscribe(storeValue => {
      planningid = storeValue?.['adoptionEffort']?.adoptionplanningid;
    });

    if (this.isSupervisor && this.isAdoptionCase) {
      planningid = this._datastore.getData(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    if (!planningid) {
      planningid = this._datastore.getData(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    if (!planningid) {
      planningid = this._datastore.getData('adoptionAgreement') ? this._datastore.getData('adoptionAgreement').adoptionplanningid : null;
    }
    if (!this.isSupervisor && this.isAdoptionCase) {
      planningid = this._session.getItem(CASE_STORE_CONSTANTS.ADOPTION_PLANNING_ID);
    }
    const res = await this._commonHttpService
        .getSingle(
            new PaginationRequest({
                where: { adoptionplanningid: planningid || planid },
                method: 'get',
                page: 1,
                limit: 1
            }),
            'adoptionagreement/list?filter'
        ).toPromise();

        if (res && res.length && Array.isArray(res)) {
            this.agreementstartdate = res[0].getadoptionagreementlist?.[0]?.startdate;
        } else {
          this.agreementstartdate = !!this.agreementstartdate ? this.agreementstartdate : null;
        }
}


  proceedExitDateValidation() {
    this.isProceedExitValidation = true;
    this.exit()
  }

  dateCheck(value: any){
    return value ? new Date(value) : null;
  }

  async exit() {

    const endDateLimit: any = this.dateCheck(this.KRD_enddate);
    const startDateLimit: any = this.dateCheck(this.KRD_startdate);
    let placementstartDate: any = this.dateCheck(this.startDate);
    let placementendDate: any = this.dateCheck(this.enddate);

    this.placementstructure = this.placementstructure ?? this.children[0].placement.placementstructuredesc;
    
    if (this.placementstructure === "Restricted (Relative) Foster Care" && placementendDate > endDateLimit) {
      this.filterCase = 'Restricted Relative placements are not valid later than ' +  moment(this.KRD_enddate).format('MM-DD-YYYY') + ' Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + ' in order for the kinship caregiver to continue to receive payment.'
      this.confirmUpdate();
      return;
    }

    if ((this.placementstructure === 'Kinship' || this.placementstructure === 'Non-Kinship') && placementstartDate < startDateLimit) {
      this.filterCase = 'This placement structure is only valid starting on '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + '. A different placement or living arrangement must be used for any time prior to this date.'
      this.confirmUpdate();
      return;    
    }
  
    const livingarrangementtypekey = this.children[0]?.placement?.livingarrangementtypekey;
    if (['ERM','IMC','ERP','PSYH'].includes(livingarrangementtypekey)) {
      if ((this.exitEndDate && this.exitEndDate != this.dischargeDate) && !this.isProceedExitValidation ) {
        this.invalidExitEndDate = true;
        this.isProceedExitValidation = false;
        ($('#alert-end-date')as any).modal('show'); 
        this.invalidExitEndDate = false;
        return;
      }
      const exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue();

      if(this.exitValidation()){
        return;
      }
      const { formData } = this.returnDischargeDateAndFormDataFn(exitFormData);
      this._ServiceCasePlacementsService.sendApprovalInQueue(formData);
      setTimeout(() => {
        this.goBack();
      }, 3000);
      return;
    }


    
    this.isProceedExitValidation = false;
    const exitdateentered = this._exitPlacementService.exitPlacementForm.value.enddate
    const exitDate = this.toMidnight(exitdateentered);
    if (this.checkDateOverlaps(exitDate)) {
      return;
    }

    if (this._exitPlacementService.exitPlacementForm.invalid) {
      this._exitPlacementService.exitPlacementForm.markAllAsTouched();
      this._alertService.error(this.mandatorymsg);
      return;
    }
    if (this.getApprovalConfirm()) {
      this.exitPlacement();
    }
  }

  // Assosiated with exit method
  private exitValidation(){
    const exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue();
      if( this._exitPlacementService.exitPlacementForm.invalid) {
        this._alertService.error("Please fill mandatory values");
        return true;
      }
     
      const { dischargeDate, startDate } = this.returnDischargeDateAndFormDataFn(exitFormData);

      if (dischargeDate && dischargeDate <= startDate) {
        this._alertService.error("Discharge / Exit date & time should be greater than the start date & time");
        return true;
      }
      if ( !this.hospitalizationFormStatus ) {
        this._alertService.error("Please fill mandatory values");
        return true;
      } 
      return false;
  }
  // Assosiated with exit method
  private returnDischargeDateAndFormDataFn(exitFormData: any) {
    if (this.hospitalizationFormValues && this.hospitalizationFormValues['Hospital_Discharged']) {
      this.hospitalizationFormValues['Hospital_DischargedDate_starttime'] = exitFormData.endtime; //? this.formatTime(dischargeEndDate):null;
      this.hospitalizationFormValues['Hospital_DischargedDate'] = exitFormData.enddate ? moment(new Date(exitFormData.enddate)).format("MM-DD-YYYY") : null;
    }
    this.hospitalizationFormValues['Hospital_DischargedDate'] = this.returnHospitalDischargedDateDataFn();

    const startTime = this.getPlacementStartTime();
    if (typeof this.children[0].placement.startdate != "string") {
      if (this.children[0].placement.startdate) {
        this.children[0].placement.startdate = moment(this.children[0].placement.startdate).format("MM-DD-YYYY");
      }
    }
    if (typeof exitFormData.enddate != "string") {
      if (exitFormData.enddate) {
        exitFormData.enddate = moment(exitFormData.enddate).format("MM-DD-YYYY");
      }
    }
    let startDate = this.children[0].placement.startdate && startTime ? this.children[0].placement.startdate.split("T")[0] + 'T' + startTime : this.children[0].placement.startdate;
    const formData = {
      add1: this.children[0].placement.address1,
      add2: this.children[0].placement.address2,
      caregiverclientid: this.children[0].placement?.personid,
      casenumber: this.daNumber,
      cityname: this.hospitalizationFormValues["Hospital_city"],
      countytypekey: this.hospitalizationFormValues["Hospital_country"],
      enddate: exitFormData.enddate,
      endtime: exitFormData.endtime,
      exitreasontypekey: exitFormData.exitreasontypekey,
      exittypekey: exitFormData.exittypekey,
      health: this.hospitalizationFormValues,
      isSupervisor: false,
      laluggagepurchased: this.children[0].placement.laluggagepurchased,
      laluggagecomments: this.children[0].placement.laluggagecomments,
      leastrestrictiveplacement: exitFormData.leastrestrictiveplacement,
      livingarrangementluggage: this.children[0].placement.livingarrangementluggage,
      livingarrangementtypekey: this.children[0]?.placement?.livingarrangementtypekey,
      personid: this.children[0].placement?.personid,
      placementid: this.children[0].placement.placementid,
      placementtypekey: this.children[0].placement.placementtypekey,
      primarycaregiver: this.hospitalizationFormValues["Hospital_name"],
      startdate: startDate,
      starttime: startTime,
      statetypekey: this.hospitalizationFormValues["Hospital_state"],
      zipcode: this.hospitalizationFormValues["Hospital_zipcode"],
      placementdisposableortrashbag :this.children[0]?.placement?.placementdisposableortrashbag ? this.children[0]?.placement?.placementdisposableortrashbag : exitFormData.placementdisposableortrashbag,
      ladisposableortrashbag :this.children[0]?.placement?.ladisposableortrashbag ? this.children[0]?.placement?.ladisposableortrashbag : exitFormData.ladisposableortrashbag
    };
  


    startDate = moment(formData["startdate"]).valueOf();

    const dischargeDate = this.returnDischargeDateDataFn();
    return { dischargeDate, startDate, formData };
  }

  private getPlacementStartTime(){
    return this.children[0].placement.starttime && this.children[0].placement.starttime.split(" ")[1] ? this.children[0].placement.starttime.split(" ")[1] : this.children[0].placement.starttime;
  }
  // Assosiated with exit method// Assosiated with exit method
  private returnDischargeDateDataFn() {
    return (this.hospitalizationFormValues["Hospital_DischargedDate"]
      ? moment(this.hospitalizationFormValues["Hospital_DischargedDate"], "MM-DD-YYYYTHH:mm").valueOf()
      : null);
  }
  // Assosiated with exit method
  private returnHospitalDischargedDateDataFn(): any {
    return (this.hospitalizationFormValues['Hospital_DischargedDate'] ? (this.hospitalizationFormValues['Hospital_DischargedDate'].split("T")[0] + 'T' + this.hospitalizationFormValues['Hospital_DischargedDate_starttime']) : this.hospitalizationFormValues['Hospital_DischargedDate']);
  }

  private exitPlacementLugageCheck(exitFormData: any) {
    if (this.children?.[0]?.['placement']?.['placementtypekey'] === 'LA') {
      exitFormData.placementluggage = this.children?.[0]?.['placement']?.['livingarrangementluggage'] ?? null;
      exitFormData.plluggagepurchased = this.children?.[0]?.['placement']?.['laluggagepurchased'] ?? null;
      exitFormData.plluggagecomments = this.children?.[0]?.['placement']?.['laluggagecomments'] ?? null;
      exitFormData.placementdisposableortrashbag = (exitFormData.ladisposableortrashbag === true || exitFormData.ladisposableortrashbag === false) ? exitFormData.ladisposableortrashbag : this.children?.[0]?.['placement']?.['ladisposableortrashbag'];

    } else {
      exitFormData.placementluggage = this.children?.[0]?.['placement']?.['placementluggage'] ?? null;
      exitFormData.plluggagepurchased = this.children?.[0]?.['placement']?.['plluggagepurchased'] ?? null;
      exitFormData.plluggagecomments = this.children?.[0]?.['placement']?.['plluggagecomments'] ?? null;
      exitFormData.placementdisposableortrashbag = (exitFormData.placementdisposableortrashbag === true || exitFormData.placementdisposableortrashbag === false) ? exitFormData.placementdisposableortrashbag : this.children?.[0]?.['placement']?.['placementdisposableortrashbag'];
    }
    return exitFormData;
  }

  exitPlacement() {
    let exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue();
    if (exitFormData.exitreasontypekey === 'PLCCCORH' && exitFormData.exittypekey === 'PLCC') {
      exitFormData = this.exitPlacementLugageCheck(exitFormData);
      exitFormData.v_securityusersid = this.userInfo.user.userprofile.securityusersid;
      this._datastore.setData('showexitchecklist', true);
      this._datastore.setData('exitFormData', exitFormData);
      this.goBack();
    } else {
      if (this.children && this.children.length && this.children[0].placement) {
        exitFormData.placementid = this.children[0].placement.placementid;
        exitFormData.servicecaseid = this.returnServicecaseidDataFn();
        if (this.children[0].placement.providerdetails) {
          exitFormData.providerid = this.children[0].placement.providerdetails.provider_id;
        }
        this._datastore.setData('editedChildId', this.children[0].placement.personid);
        this._datastore.setData('editedPlacementId', this.children[0].placement.placementid);
      }
      exitFormData.v_securityusersid = this.userInfo.user.userprofile.securityusersid;
      exitFormData.objectId = this.children?.[0]?.['placement']?.['placementrevision']?.[0]?.['hospitalizationdetails']?.['hospitalizationid'] || null;
      this.isSubmitting = true;
      exitFormData = this.exitPlacementLugageCheck(exitFormData);
      
      if(exitFormData.exittypekey === 'PLCC'){
        this.plccConfirmData = exitFormData;
        ($(this.plccconfirmpopup) as any).modal('show');
      }else{
      this.serviceFnctn(exitFormData);
      }
    }
  }

  private serviceFnctn(exitFormData: any){
  this._commonHttpService
        .create(exitFormData, 'placement/exitplacement')
        .subscribe(response => {
          this._alertService.success('Placement exit recorded successfully', true);
          if (exitFormData.exitreasontypekey === 'PLCCDOC') {
            this.isDOCExit = true;
          }
          setTimeout(() => {
            this.goBack();
          }, 3000);
        });
  }

  plccconfirmPopup() {
    ($(this.plccconfirmpopup) as any).modal('hide');
    this.serviceFnctn(this.plccConfirmData);
  }

  closeplccconfirmPopup(){
    ($(this.plccconfirmpopup) as any).modal('hide');
    this.plccConfirmData = null;
    this.isSubmitting = false;
  }
  
  // Assosiated with exitPlacement method
  private returnServicecaseidDataFn(): any {
    return this.children[0].placement.servicecaseid ? this.children[0].placement.servicecaseid : this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  handleExitEndTime(value: any) {
    this._hospitalizationService.setExitPlacementEndTime(value);
  }
  placementExitEndDate = "";
  handleExitEndDate(value: any) {
    if(!this.isLivingArrangement) {
      this.timechange();
    }
    this._hospitalizationService.setExitPlacementEndDate(value);
    this.placementExitEndDate = value;
  }


  private checkDateOverlaps(exitDate: any): boolean {
    const courtorderdate = this.courtOrderDate === 'No Date' ? this.toMidnight(this.courtorderdate) : this.toMidnight(this.courtOrderDate);
    const agreementstartdateformatted = this.toMidnight(this.agreementstartdate);

    if (agreementstartdateformatted && agreementstartdateformatted < exitDate) {
      this.filterCase = 'Placement Exit Date is Overlapping with the Adoption Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Adoption Break the Link.';
      this.confirmUpdate();
      return true;
  }

    if (courtorderdate && courtorderdate < exitDate && this.activeGapDoesExist) {
      this.filterCase = 'Placement Exit Date is Overlapping with the GAP Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Guardianship Subsidy Rate.';
      this.confirmUpdate();
      return true;
      }

    return false;
  }

  getProgramAssignmentList() {
    const personid = this._ServiceCasePlacementsService.selectedChildren?.map(e => e.personid)[0]
    const servicecaseid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID)

    this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest({
                where: { objectid: servicecaseid, personid: personid },
                method: 'get',
                nolimit: true
            }),
            'Personprogramareas/getpersonprogramarea?filter'
        )
        .subscribe(async (result) => {
            if (result && Array.isArray(result) && result.length) {
              this.adoptioncaseid = result?.map(e => e.personprogramarea)?.[0]?.filter((e: { objecttypekey: string; }) => e?.objecttypekey === 'adoptioncase')?.[0]?.objectid || null;
            }
            this.suspensionBeginDate = await this.getSuspensionListing(this.adoptioncaseid);
          });
  }

  async getPermanencyPlanList() {
    this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: { objectid: this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'permanencyplan/list?filter'
      ).subscribe(async result => {
        this.permanancyPlanExist = result.length > 0;
        const currPlacementId = this.children?.[0]?.placement?.placementid
        this.activeGapDoesExist = result
                  .filter(e => e.personid === this.personId)
                  .some(e => e.permanencyplans?.some((plan: { childhasactivegap: any; placementid: any; }) => plan.childhasactivegap && (plan.placementid && plan.placementid === currPlacementId) )); 
                  // If there is active suspension then make this variable false
                  // if end date is nul then active suspension
        const permanencyPlanId = result.filter(e => e.personid === this.personId).map(e => e.permanencyplans)?.[0]?.filter((e: { childhasactivegap: boolean; }) => e.childhasactivegap === true).map((e: { permanencyplanid: any; }) => e.permanencyplanid)[0];
        const adoptedPermanencyPlanId = result.filter(e => e.personid === this.personId).map(e => e.permanencyplans)?.[0]?.map((e: { permanencyplanid: any; }) => e.permanencyplanid)[0];
        await this.getAgreementDate(adoptedPermanencyPlanId);
        this.activeAdoptionIdDoesExist = result.find(e => e.personid === this.personId)?.permanencyplans?.[0]?.casedetails?.[0].adoptioncaseid;
        if(this.activeAdoptionIdDoesExist) {
          this.activeAdoptionDateWithActiveSuspension = await this.getSuspensionListing(this.activeAdoptionIdDoesExist)
        }
        if (this.activeGapDoesExist) {
          this.activeGapWithActiveSuspension = await this.getActiveSuspensionStatus(permanencyPlanId, this.personId);
        } else {
            this.activeGapWithActiveSuspension = false;
        }
        const personid = this._ServiceCasePlacementsService.selectedChildren?.map(e => e.personid)[0] || this.personId
        this.courtOrderDate = this.activeGapDoesExist ? await this.getCourtOrderDate(personid) : 'No Date';
      });
  }

  async getSuspensionListing(id = null) {
      if (!id) {
        return;
      }
      const res = await this._commonHttpService
          .getSingle(
              new PaginationRequest({
                  where: { adoptioncaseid: id },
                  method: 'get',
                  page : 1,
                  limit: 10
              }),
              `adoptioncasesuspensionrevision/getsuspensionhistory?filter`
          ).toPromise();

          if (res && res.length) {
            const suspensionRecords = res.filter((item: any) => item.approvalstatus === "Approved")
                           ?.reduce((latest: any, current: any) =>
                             new Date(current.suspensionbegindate) > new Date(latest.suspensionbegindate)
                               ? current : latest
                           );
            return suspensionRecords ? suspensionRecords.suspensionbegindate : null;
          }
  }

  toMidnight(date: any) {
    if (!date) return null;
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
  }

  async getActiveSuspensionStatus(id: any, pid: any): Promise<boolean> {
    try {
        const res:any = await this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
                where: {
                    permanencyplanid: id
                },
                method: 'get'
            }),
            'gapdisclosure/getguardianship' + '?filter'
        ).toPromise();

        const items = res.data || [];

        const gapSuspensions = res.data.filter((e:any) => e.personid === pid)?.[0]?.gapsuspension;

        this.dateRanges = gapSuspensions?.map((suspension: { startdate: any; enddate: any; }) => ({
          startdate: this.toMidnight(suspension.startdate),
          enddate: this.toMidnight(suspension.enddate)
        }));

      return items.length > 0 && items[0]?.gapsuspension?.length > 0 
            ? items[0].gapsuspension[0].enddate === null 
            : false;
    } catch (error) {
        return false;
    }
  }


  private async getCourtOrderDate(_pid: any): Promise<string | null> {
    try {
        const res:any = await this._commonHttpService.getArrayList(
            {
                method: 'get',
                where: {
                    objectid: this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID),
                    objecttype: 'servicecase'
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
        ).toPromise();

        return res.filter((e:any) => e.personid == this.personId && e.hearingoutcome.some((o: { hearingoutcometypekey: string; }) => o.hearingoutcometypekey === 'CUSGUA')).map((e:any) => e.courtorderdate)?.sort((a:any, b:any) => new Date(b).getTime() - new Date(a).getTime()).shift() || null; //CDM-42883 - code was not taking the latest courtorderdate. NEW: outcome must have 'custody and 'guardianship'

    } catch (error) {
        return null;
    }
  }

  isWithinRange = (date: Date, startDate: Date, endDate: Date | null) => {
    const end = endDate || new Date();
    return date >= startDate && date <= end;
  };

  isDateInRange(
    placementstartDate: Date, 
    placementendDate: Date, 
    ranges: { startdate: Date, enddate: Date | null }[]
  ): boolean {
    if (!placementstartDate) {
      return false;
    }
    
    if (!ranges || ranges.length === 0) {
      return false;
    }
    if (placementendDate) {
      const validStartDateArray = ranges?.filter(e => this.isWithinRange(placementstartDate, e.startdate, e.enddate));
      if (!validStartDateArray) {
        return false
      }
      return validStartDateArray.some(e => this.isWithinRange(placementendDate, e.startdate, e.enddate));
    }

    return ranges?.some(e => this.isWithinRange(placementstartDate, e.startdate, e.enddate));
  }

  private handlePlacementExitDateCheckFn() {
    const activeGapCheck = this.activeGapDoesExist && this.activeGapWithActiveSuspension;
    let placementstartDate = this.startDate 
                                  ? new Date(this.startDate) 
                                  : null;
    let placementendDate =this.enddate 
                                  ? new Date(this.enddate) 
                                  : null;

    if(!activeGapCheck) {
      //Set the courtorder date to the latest courtorderdate created 
      const courtorderdateformatted = this.courtOrderDate === 'No Date' ? this.toMidnight(this.courtorderdate) : this.toMidnight(this.courtOrderDate);

      if(this.activeGapDoesExist && !!courtorderdateformatted && !!placementendDate) {
        if (courtorderdateformatted < placementendDate) {
          this.filterCase = 'Placement Exit Date is Overlapping with the GAP Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Guardianship Subsidy Rate.';
          this.confirmUpdate();
          return true;
        } 
      }
    }

    if(this.handlePlacementExitDateCheckCond1Fn(placementstartDate, placementendDate, activeGapCheck)) {
      return true;
    }
    return false;
  }

  private handlePlacementExitDateCheckCond1Fn(placementstartDate: any, placementendDate: any, activeGapCheck: any) {
    const activeAdoptionCheck = this.activeAdoptionIdDoesExist && this.activeAdoptionDateWithActiveSuspension;
    const isInRange = activeGapCheck 
                          ? !this.isDateInRange(placementstartDate, placementendDate, this.dateRanges) 
                          : this.isWithinRange(
                            new Date(this.agreementstartdate), 
                            new Date(placementstartDate), 
                            new Date(placementendDate)
                          );
    if (activeGapCheck || activeAdoptionCheck) {
      if (isInRange) {
        this.filterCase = 'Placement Date is Overlapping with the GAP Agreement Date. Please check and correct the Placement Date or GAP Suspension accordingly to proceed with the Provider Placement.';
        this.confirmUpdate();
        return true;
      }
    }
    
    let suspensionBeginDateFormatted = this.toMidnight(this.suspensionBeginDate);

    if (suspensionBeginDateFormatted && placementstartDate && suspensionBeginDateFormatted > placementstartDate) {
      this.filterCase = 'Placement Date is Overlapping with the Adoption Agreement Date. Please check and correct the Placement Date or  Adoption Suspension accordingly to proceed with the Provider Placement.';
      this.confirmUpdate();
      return true;
    }
    
    let agreementStartDateFormatted = this.toMidnight(this.agreementstartdate);
    
    if (agreementStartDateFormatted && agreementStartDateFormatted < placementendDate) {
      this.filterCase = 'Placement Exit Date is Overlapping with the Adoption Agreement Start Date. Please Check and correct the Placement Exit Date accordingly to proceed with the Adoption Break the Link.';
      this.confirmUpdate();
      return true;
    }
    return false;
  }
  

  
  update() {

    this.placementstructure = this.placementstructure ?? this.children[0].placement.placementstructuredesc;

    if(this.updatePlacementValidation()){
      return;
    }

    let placementType = 'PRPL';

    if (this.livingArrangement()) {
      const placement = this.getPlacement();
      let placements = false;
      let islaoverlap = false;

      const startDate = this.placementEditDetails.placementEditForm.getRawValue().startdate;
      const startTime = this.placementEditDetails.placementEditForm.getRawValue().starttime;
      const { enddate, endtime } = this.returnEndDateAndTimeFn();
      const placementStartDt = this.getplacementStartDt(startDate, startTime);
      const placementEndDt = this.getplacementStartDt(enddate, endtime);

      const obj = this.isLAOverlapCheck(placementStartDt, placementEndDt, placements, islaoverlap);
      placementType = 'LA';
      if(this.CheckPlacementBackDated(obj, placementStartDt, placementEndDt, placement)){
        return;
      }
      this.startDate = this.placementEditDetails.placementEditForm.value.startdate;
      this.startTime = this.placementEditDetails.placementEditForm.value.starttime;

      this.placementEditDetails.placementEditForm.patchValue({
        ischangepreadoptive: this.booleanCheck(this.ischangepreadoptive)
      });

      if(this.placementEditDetails.placementEditForm.value.livingarrangementtypekey === 'FCNFHS' && this.placementEditDetails.placementEditForm.value.fostercarenonfoster === 'HOTEL' && this.placementEditDetails.placementEditForm.value.dailyrate == '0.00') {
        this._alertService.error('Daily rate should be greater than 0');
        return;
      }
    }

    if (this.mandatoryNotFilled(placementType)){
      this._alertService.error(this.mandatorymsg);
      return;
    }

    if (this.startDate || this.enddate) {
      if(!this.handleStartAndEndDateFn(placementType)){
        return false
      }
    }

    let dischargeEndDate = null;
    let dischargeEndTime = null;

    if(this.hospitalizationFormValues && this.hospitalizationFormValues['Hospital_Discharged']) {
      dischargeEndDate = this.returnDischargeEndDateFn();
      dischargeEndTime = this.hospitalizationFormValues['Hospital_DischargedDate_starttime'] //? this.formatTime(dischargeEndDate):null;
    }

    const editData = this.returnEditDataFn(dischargeEndDate, dischargeEndTime);
  
  this.isSubmitting = true;
  this.savePlacementEditData(editData, placementType);
}

  private CheckPlacementBackDated(obj: any, placementStartDt: any, placementEndDt: any, placement: any) {
    let placements = false;
    let islaoverlap = false;
    let isOpenRFKHExists = false;
    placements = obj.placements;
    islaoverlap = obj.islaoverlap;
    isOpenRFKHExists = obj.isOpenRFKHExists;
    const isBackDate = this.checkAndReturnIsBackDateFn(obj, placementStartDt, placementEndDt);
    if (isOpenRFKHExists) {
      this._alertService.error('The user must end the older Living Arrangement before the user can leave the screen');
      return true;
    }
    if (isBackDate) {
      this._alertService.error('Please enter the discharge/exit date as this open exit date overlaps with other existing Hospitalization Living Arrangement record');
      return true;
    } else if (this.isError(islaoverlap, placement, placements)) {
      return true;
    }
    return false;
  }

  private updatePlacementValidation() {
    let placementstartDate: any = this.startDate ? new Date(this.startDate) : null;
    let placementendDate: any = this.enddate ? new Date(this.enddate) : null;

    const endDateLimit: any = this.KRD_enddate ? new Date(this.KRD_enddate) : null;
    const startDateLimit: any = this.KRD_startdate ? new Date(this.KRD_startdate) : null;
    const referalDetails: any = { startdate: this.startDate, starttime: this.startTime, enddate: this.enddate, endtime: this.endtime };
    const placementDates: any = this._ServiceCasePlacementsService.formatPlacementDates(referalDetails);

    if (this.children[0]?.placementType !== "LA") {
      // validating placement dates with removal date
      if (!this._ServiceCasePlacementsService?.checkChildRemovalFn(placementDates, this.children[0]?.childremoval)) {
        this._alertService.error('Please enter the dates correctly as Removal is not Available for selected dates');
        return true;
      }
    }

    if (this.placementstructure === "Restricted (Relative) Foster Care" && placementendDate > endDateLimit) {
      this.filterCase = 'Restricted Relative placements are not valid later than ' + moment(this.KRD_enddate).format('MM-DD-YYYY') + ' Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after ' + moment(this.KRD_startdate).format('MM-DD-YYYY') + ' in order for the kinship caregiver to continue to receive payment.'
      this.confirmUpdate();
      return true;
    }

    if ((this.placementstructure === 'Kinship' || this.placementstructure === 'Non-Kinship') && placementstartDate < startDateLimit) {
      this.filterCase = 'This placement structure is only valid starting on ' + moment(this.KRD_startdate).format('MM-DD-YYYY') + '. A different placement or living arrangement must be used for any time prior to this date.'
      this.confirmUpdate();
      return true;
    }

    if (this.handlePlacementExitDateCheckFn()) {
      return true;
    }
    return false;
  }

  // Assosiated with update method
  private returnDischargeEndDateFn(): any {
    return (this.hospitalizationFormValues['Hospital_DischargedDate'] ? moment(new Date(this.hospitalizationFormValues['Hospital_DischargedDate'])).format("MM-DD-YYYY") : null);
  }
  // Assosiated with update method
  private handleStartAndEndDateFn(placementType: any) {
    let placementIdforEdit;
    let placementPersonid;
    let placementCfeCheck;
    let childDOBforCFE;

    if (this.children && this.children.length && this.children[0].placement) {
      placementIdforEdit = this.children[0].placement.placementid;
      placementCfeCheck = this.children[0].placement.service_id;
      placementPersonid = this.children[0].personid;
      childDOBforCFE = this.children[0].dob;
    }

    const placementStartDt = this.getPlcmntStartDt();
    const placementEndDt = this.getPlcmntEndDt();

    const placementHistory = this.placementHistoryValidation;
    for (let i = 0; i < placementHistory.length; i++) {
      let placStatDt = placementHistory[i].startdate;
      let placEndDt = placementHistory[i].enddate;
      const placStatTime = placementHistory[i].starttime;
      const placEndTime = placementHistory[i].endtime;
      placStatDt = this.getPlacStatDtTime(placStatDt, placStatTime);
      placEndDt = this.getPlaceEndDtTime(placEndDt, placEndTime);

      const inputObj = {
        placementHistory: placementHistory,
        i: i,
        placementStartDt: placementStartDt,
        placementEndDt: placementEndDt,
        placStatDt: placStatDt,
        placEndDt: placEndDt,
        placementIdforEdit: placementIdforEdit,
        placementPersonid: placementPersonid,
        placementType: placementType,
        placementCfeCheck: placementCfeCheck,
        childDOBforCFE: childDOBforCFE
      }

      if (this.placementErrorCheck(inputObj)) {
        return false;
      }
    }
    return true;
  }
  // Assosiated with update method
  private checkAndReturnIsBackDateFn(obj: any, placementStartDt: any, placementEndDt: any) {
    let placementEndDtF = placementEndDt ? placementEndDt : obj.lastEndDate;
    return (obj.firstStartDate != null && Object.keys(this.hospitalizationFormValues).length && !this.hospitalizationFormValues['Hospital_DischargedDate'] && ((new Date(placementStartDt).getTime() < new Date(obj.firstStartDate).getTime()) || (new Date(placementEndDtF).getTime() < new Date(obj.lastEndDate).getTime())));
  }

  // Assosiated with update method
  private returnEditDataFn(dischargeEndDate: any, dischargeEndTime: any) {
    return this.updatedEditData({
      startdate: this.startDate,
      starttime: this.startTime,
      enddate: this.nullCheck(this.enddate) ? this.enddate : dischargeEndDate,
      endtime: this.nullCheck(this.endtime) ? this.endtime : dischargeEndTime,
      ischangepreadoptive: this.ischangepreadoptive,
      placementid: '',
      servicecaseid: '',
      providerid: '',
      contractprogramid: '',
      remarks: this.editComments ? this.editComments : this.exitFormValues['remarks'],
      leastrestrictiveplacement: this.editleastrestrictiveplacement ? this.editleastrestrictiveplacement : this.exitFormValues['leastrestrictiveplacement'],
      exittypekey: this.editApprovedPlacement.controls['exittypekeycheck'].value ? this.editApprovedPlacement.controls['exittypekeycheck'].value : this.exitFormValues['exittypekey'],
      exitreasontypekey: this.editApprovedPlacement.controls['exitreasonchecktypekey'].value ? this.editApprovedPlacement.controls['exitreasonchecktypekey'].value : this.exitFormValues['exitreasontypekey'],
      transferagency: this.editApprovedPlacement.controls['transferagency'].value,
      otherpublicagency: this.editApprovedPlacement.controls['otherpublicagency'].value,
      justification: this.justification,
      v_securityusersid: this.userInfo.user.userprofile.securityusersid,
      placementtypekey: '',
      intakeservicerequestactorid: '',
      intakeservreqchildremovalid: '',
      responseacceptedkey: '',
      activereviewcheck: '',
      placementluggage: this.placementluggage,
      plluggagepurchased: this.plluggagepurchased,
      plluggagecomments: this.plluggagecomments,
      casenumber: this.daNumber,
      placementdisposableortrashbag :this.placementdisposableortrashbag,
      exitluggage :  this.editApprovedPlacement.controls['exitluggage'].value,
      exitluggageprovided :  this.editApprovedPlacement.controls['exitluggageprovided'].value,
      exitluggagecomments :  this.editApprovedPlacement.controls['exitluggagecomments'].value,
      exitdisposableortrashbag :this.editApprovedPlacement.controls['exitdisposableortrashbag'].value,
    });
  }
  // Assosiated with update method
  private returnEndDateAndTimeFn() {
    let enddate = this.enddate ? this.enddate: this.placementEditDetails.placementEditForm.getRawValue().enddate;
    let endtime;
    if (this.hospitalizationFormValues && this.hospitalizationFormValues['Hospital_DischargedDate']) {
      enddate = this.hospitalizationFormValues['Hospital_DischargedDate'] = this.placementExitEndDate ? moment(new Date(this.placementExitEndDate)).format("MM/DD/YYYY") : this.hospitalizationFormValues['Hospital_DischargedDate'];
      endtime = this.hospitalizationFormValues['Hospital_DischargedDate_starttime'];
    } else if (enddate) {
      endtime = this.endtime ? this.endtime:this.placementEditDetails.placementEditForm.getRawValue().endtime;
    } else {
      enddate = this.placementEditDetails.placementEditForm.getRawValue().startdate;
      endtime = this.placementEditDetails.placementEditForm.getRawValue().starttime;
    }
    return { enddate, endtime };
  }

  formatTime(time: any) {
    time = moment(new Date(time)).format('HH:mm');
    return time;
  }

  livingArrangement() {
    if (this.children && this.children.length && this.children[0].placement && this.children[0].placement.placementtypekey === 'LA') {
      return true;
    } else {
      return false;
    }
  }

  getServiceCaseId() {
    return this.children[0].placement.servicecaseid ? this.children[0].placement.servicecaseid : this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  getPlacement() {
    const livingArrangementKey = this.placementEditDetails.placementEditForm.getRawValue().livingarrangementtypekey.trim();
    return this.children?.filter((child: any) => child?.placement?.enddate === null && ((livingArrangementKey === 'RFKH' && child?.placement?.livingarrangementtypekey === 'RFKH') || (livingArrangementKey !== 'RFKH' && (child?.placement?.livingarrangementtypekey === 'ERM' || child?.placement?.livingarrangementtypekey === 'ERP' || child?.placement?.livingarrangementtypekey === 'IMC' || child?.placement?.livingarrangementtypekey === 'PSYH'))));
  }

  updatedEditData(editData: any) {
    if (this.children && this.children.length && this.children[0].placement) {
      editData.placementid = this.children[0].placement.placementid;
      editData.servicecaseid = this.getServiceCaseId();
      if (this.children[0].placement.providerdetails) {
        editData.providerid = this.children[0].placement.providerdetails.provider_id;
      }
    }
    return editData;
  }

  booleanCheck(inputData: any) {
    return inputData ? inputData : false;
  }

  getplacementStartDt(startDate: any, startTime: any) {
    let placementStartDt = startDate;

    if (startDate && startTime) {
      const formatStDt = moment(startDate).format(this.dtformat);
      placementStartDt = formatStDt + 'T' + startTime + ':00';
    }
    return placementStartDt;

  }

  getPlcmntStartDt() {
    let placementStartDt = this.startDate;

    if (this.startDate && this.startTime) {
      const formatStDt = moment(this.startDate).format(this.dtformat);
      placementStartDt = formatStDt + 'T' + this.startTime + ':00';
    }
    return placementStartDt;
  }

  getplacementEndDt(enddate: any, endtime: any) {
    let placementEndDt = enddate;

    if (enddate && endtime) {
      const formatEndDt = moment(enddate).format(this.dtformat);
      placementEndDt = formatEndDt + 'T' + endtime + ':00';
    }
    return placementEndDt;
  }

  getPlcmntEndDt() {
    let placementEndDt = this.enddate;
    if (this.enddate && this.endtime) {
      const formatEndDt = moment(this.enddate).format(this.dtformat);
      placementEndDt = formatEndDt + 'T' + this.endtime + ':00';
    }
    return placementEndDt;
  }

  isLAOverlapCheck(placementStartDt: any, placementEndDt: any, placements: any, islaoverlap: any) {
    let firstStartDate: any = null;
    let lastEndDate: any = null;
    let isOpenRFKHExists = false;
    const editedPlacementId = this.placementEditDetails.placementEditForm.getRawValue().placementid;
    this.children?.forEach((child: any) => {
      const livingArrangementKey = this.placementEditDetails.placementEditForm.getRawValue().livingarrangementtypekey.trim();

      let placementDetails = child?.placements.filter((e: any) => ((livingArrangementKey === 'RFKH' && e.livingarrangementtypekey === 'RFKH') || (livingArrangementKey !== 'RFKH' && (e.livingarrangementtypekey === 'ERM' || e.livingarrangementtypekey === 'ERP' || e.livingarrangementtypekey === 'IMC' || e.livingarrangementtypekey === 'PSYH'))))
      placementDetails.forEach((place: any) => {
        //Logic to check if open RFKH placement exists
        if(place.livingarrangementtypekey === 'RFKH' && place.livingenddate=== null && place.placementid !== this.placementEditDetails.placementEditForm.getRawValue().placementid.trim() && !this.placementhasExitdate){
          isOpenRFKHExists = true; 
        }
        const laDetails = this.placementEditDetails.placementEditForm.getRawValue();
        const placStatDt = this.getPlacStatDt(place);
        const placEndDt = this.getPlacEndDt(place);
        placements = this.checkPlacementsFlag(placements, place, laDetails);
        //CDM-44708:Added logic to ignore comparision of same placement for date validation
        if ((firstStartDate == null || (new Date(placStatDt).getTime() < new Date(firstStartDate).getTime())) && place.placementid != editedPlacementId) {
          firstStartDate = placStatDt;
        }
        if (placEndDt && (lastEndDate == null || (new Date(placEndDt).getTime() > new Date(lastEndDate).getTime())) && place.placementid != editedPlacementId) {
          lastEndDate = placEndDt;
        }
        // CDM-31671 - LA Relative Kin Home overlap should check only for Relative Kin Home
        islaoverlap = this.handleLivingArrangementKeyDataFn(place, laDetails, placementStartDt, placStatDt, placEndDt, placementEndDt, islaoverlap);
      })
    })

    return {
      placements,
      islaoverlap,
      firstStartDate,
      lastEndDate,
      isOpenRFKHExists
    }
  }
  // Assosiated with isLAOverlapCheck method
  private handleLivingArrangementKeyDataFn(place: any, laDetails: any, placementStartDt: any, placStatDt: any, placEndDt: any, placementEndDt: any, islaoverlap: any) {
    const livingArrangementKey = this.placementEditDetails.placementEditForm.getRawValue().livingarrangementtypekey.trim();
    if ((livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH' || livingArrangementKey === 'RFKH') && (place.livingarrangementtypekey === 'ERM' || place.livingarrangementtypekey === 'ERP' || place.livingarrangementtypekey === 'IMC' || place.livingarrangementtypekey === 'PSYH' || place.livingarrangementtypekey === 'RFKH') && place.placementid !== laDetails.placementid) {
      if (this.checkAndReturnStartEndDateConFn(placementStartDt, placStatDt, placEndDt, placementEndDt)) {
        islaoverlap = true;
      }
    }
    return islaoverlap;
  }
  // Assosiated with isLAOverlapCheck method
  private checkAndReturnStartEndDateConFn(placementStartDt: any, placStatDt: any, placEndDt: any, placementEndDt: any) {
    return ((placementStartDt >= placStatDt && placementStartDt <= placEndDt) || (placementEndDt >= placStatDt && placementEndDt <= placEndDt))
      || ((placStatDt >= placementStartDt && placStatDt <= placementEndDt) || (placEndDt >= placementStartDt && placStatDt <= placementEndDt))
      || ((placementStartDt >= placStatDt || placementEndDt >= placStatDt) && placEndDt == null);
  }

  checkPlacementsFlag(placements: any, place: any, laDetails: any) {
    if (place?.enddate === null && place?.livingarrangementtypekey == 'RFKH' && place?.routingstatus != 'Rejected' && laDetails.placementid !== place.placementid) {
      placements = true;
    }
    return placements;
  }

  getPlacStatDt(place: any) {
    const placStatDt = place.startdate;
    const placStatTime = place.starttime;
    return this.getPlacStatDtTime(placStatDt, placStatTime);

  }

  getPlacStatDtTime(placStatDt: any, placStatTime: any) {
    if (placStatDt && placStatTime) {
      const formatPlacStartDt = moment(placStatDt).format(this.dtformat);
      let formatStartTime = placStatTime;
      if (placStatTime.length > 5) {
        const plcStartTime = new Date(placStatTime);
        formatStartTime = moment(plcStartTime).format('HH:mm');
      }
      placStatDt = formatPlacStartDt + 'T' + formatStartTime + ':00';
    }
    return placStatDt;
  }


  getPlacEndDt(place: any) {
    const placEndDt = place.enddate;
    const placEndTime = place.endtime;
    return this.getPlaceEndDtTime(placEndDt, placEndTime);
  }
  getPlaceEndDtTime(placEndDt: any, placEndTime: any) {
    if (placEndDt && placEndTime) {
      const formatPlacEndDt = moment(placEndDt).format(this.dtformat);
      let formatEndTime = placEndTime;
      if (placEndTime.length > 5) {
        const plcEndTime = new Date(placEndTime);
        formatEndTime = moment(plcEndTime).format('HH:mm');
      }
      placEndDt = formatPlacEndDt + 'T' + formatEndTime + ':00';
    }
    return placEndDt;
  }


  isError(islaoverlap: any, placement: any, placements: any) {
    const livingArrangementKey = this.placementEditDetails.placementEditForm.getRawValue().livingarrangementtypekey.trim();
    if (livingArrangementKey === 'RFKH') {
      if (this.placementEditDetails.placementEditForm.controls['add1'].invalid
        || this.placementEditDetails.placementEditForm.controls['statetypekey'].invalid
        || this.placementEditDetails.placementEditForm.controls['countytypekey'].invalid
        || this.placementEditDetails.placementEditForm.controls['zipcode'].invalid) {
        this._alertService.error('Please Enter Primary Caregiver Contact Information in the Person Card before proceeding');
        return true;
      }
    }

    if (livingArrangementKey === 'ERM' || livingArrangementKey === 'ERP' || livingArrangementKey === 'IMC' || livingArrangementKey === 'PSYH' || livingArrangementKey === 'RFKH') {
      if (islaoverlap) {
        this._alertService.error('Please enter the dates correctly as selected dates are overlapping with other existing Living Arrangement');
        return true;
      } else if (placement && placement.length && placements) {
        this._alertService.error('Overlapping Hospitalization Living Arrangement is not allowed, Please Discharge/End the Active record to create a new one.');
        return true;
      }
    }
    if (this.placementEditDetails.placementEditForm.invalid || !this.hospitalizationFormStatus || !this.isExitFormValid) {
      this._alertService.error(this.mandatorymsg);
      return true;
    }

    return false;
  }

  getDates() {
    this._commonHttpService.getSettings(['KRD_startdate','KRD_enddate']).subscribe(
      (res: any) => {
        this.isFormalKinshipPlacement = false;
        this.KRD_startdate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_startdate')?.settingvalue;
        this.KRD_enddate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_enddate')?.settingvalue;
        if (this.children && this.children.length
          && this.children[0].placement
           && this.children[0].placement.providerdetails 
           && this.children[0].placement.providerdetails.provider_id) {        
          if(this.children[0].placement.service_id == '9' ) {
             this.maxDate = new Date(this.KRD_enddate);
             this.filterCase = 'Restricted Relative placements are not valid later than ' +  moment(this.KRD_enddate).format('MM-DD-YYYY') + ' Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + ' in order for the kinship caregiver to continue to receive payment.'
             this.confirmUpdate();
          } else if(this.children[0].placement.service_id == '530' || this.children[0].placement.service_id == '531' ) {
            this.minDate = new Date(this.KRD_startdate);
         } else if (this.children[0].placement.service_id == '8') {
           this.isFormalKinshipPlacement = true;
           this.kinshipmaxStartDate = new Date(this.KRD_startdate);
         }
       }
        
        return res;
      },
      (error: any) => {
        console.error('Error fetching setting:', error);
      }
    );
  }

  placementErrorCheck(inputObj: any) {
    const placementStartDt = inputObj.placementStartDt;
    const placementEndDt = inputObj.placementEndDt;
    const placementCfeCheck = inputObj.placementCfeCheck;
    const childDOBforCFE = inputObj.childDOBforCFE;

    if (this.placementhasExitdate && placementEndDt && placementEndDt <= placementStartDt) {
      this._alertService.error('Exit date & time should be greater than the start date & time');
      return true;
    }

    if (this.isDatesOverlapping(inputObj)) {
      return true;
    }
    if (placementCfeCheck == 525) {
      const startDateformat: any = moment(this.startDate).format(this.dtformat);
      const endDateFormat: any = this.enddate ? moment(this.enddate).format(this.dtformat) : null;

      const getYearOfdob: any = Number(moment(childDOBforCFE).format('YYYY'));
      const monthDateOfdob: any = moment(childDOBforCFE).format('MM/DD');

      const getMinYear: any = Number(getYearOfdob) + Number(4);
      const getMaxYear: any = Number(getYearOfdob) + Number(18);
      const minAgeForCFE: any = monthDateOfdob + '/' + getMinYear;
      const maxAgeForCFE: any = monthDateOfdob + '/' + getMaxYear;

      const formatMinAge: any = moment(minAgeForCFE).format(this.dtformat);
      const formatMaxAge: any = moment(maxAgeForCFE).format(this.dtformat);
      if (startDateformat < formatMinAge || startDateformat > formatMaxAge) {
        this._alertService.error('Placement should be allowed for child within the age 4 to 18 to enter the Provider placement with placement structure "CfE Resource Home".');
        return true;
      }

      const notification_StartDate: any = moment(this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.start_dt).format('MMM DD, YYYY,');
      const notification_EndDate: any = moment(this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.end_dt).format('MMM DD, YYYY');
      const person_StartDate: any = this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.start_dt;
      const person_EndDate: any = this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.end_dt;

      if ((startDateformat < person_StartDate || startDateformat > person_EndDate) || (endDateFormat < person_StartDate || endDateFormat > person_EndDate)) {
        this._alertService.error("The Placement with the Placement structure ' CfE Resource Home' can be allowed only within the period " + notification_StartDate + " thru " + notification_EndDate);
        return true;
      }
    }

    return false;
  }

  isDatesOverlapping(inputObj: any) {
    const placementHistory = inputObj.placementHistory;
    const i = inputObj.i;
    const placementStartDt = inputObj.placementStartDt;
    const placementEndDt = inputObj.placementEndDt;
    const placStatDt = inputObj.placStatDt;
    const placEndDt = inputObj.placEndDt;
    const placementIdforEdit = inputObj.placementIdforEdit;
    const placementPersonid = inputObj.placementPersonid;
    const placementType = inputObj.placementType;
    if (placementHistory[i].placementid !== placementIdforEdit && placementHistory[i].personid === placementPersonid && placementType == 'PRPL') {
      if (((placementStartDt >= placStatDt && placementStartDt <= placEndDt) || (placementEndDt >= placStatDt && placementEndDt <= placEndDt))
        || ((placStatDt >= placementStartDt && placStatDt <= placementEndDt) || (placEndDt >= placementStartDt && placStatDt <= placementEndDt))) {
        this._alertService.error('Please enter the dates correctly as selected dates are overlapping with other existing placements');
        return true;
      }
    }
    return false;
  }

  mandatoryNotFilled(placementType: any) {
    if(this.mandatoryCheckCommentAndJudFn(placementType)) {
      return true
    }

    if (!this.startDate) {
      return true;
    }

    if ((!this.enddate || this.endtime === "Invalid date" || this.endtime === "") && this.placementhasExitdate) {
      return true;
    }

    if (placementType === 'LA') {
      return false;
    }

    if (this.checkluggage() && placementType === 'PRPL' && !this.placementhasExitdate) {
      return true;
    }

    return false;
  }

  private mandatoryCheckCommentAndJudFn(placementType: any) {
    if ((!this.editComments || !this.editComments.trim()) && placementType === 'PRPL') {
      return true;
    }
    
    if (!this.editleastrestrictiveplacement && placementType === 'PRPL') {
      return true;
    }
    if (this.placementhasExitdate && (!this.justification || !this.justification.trim()) && placementType === 'PRPL') {
      return true;
    }
    if (this.placementhasExitdate && this.editApprovedPlacement.controls['exittypekeycheck'].value == 'PLCC'){
       return this.checkluggageindicator();
    }
    if (this.onEditPlacement && !this.isLivingArrangement && !this.editleastrestrictiveplacement.trim() && placementType === 'PRPL') {
      return true;
    }
    return false;
  }

  savePlacementEditData(editData: any, placementType: any) {
    if (this.onEditPlacement && placementType === 'LA') {
      this.updatePlacementForm(editData);
      this.isSubmitting = false;
    } else if (this.children[0].placement.placementtypekey === 'PRPL') {
      const approvedrecords = this.children[0]?.placement?.placementrevision?.filter((item: { status: string; }) => item.status == 'Approved');
      if ((approvedrecords?.length == 0 && this.children[0].placement?.placementrevision !== null)
        || this.onEditPlacement === true) {
        editData.contractprogramid = this.children[0].placement.contractprogramid;
        editData.placementtypekey = this.children[0].placement.placementtypekey;
        editData.intakeservicerequestactorid = this.children[0].placement.intakeservicerequestactorid;
        editData.intakeservreqchildremovalid = this.children[0].placement.intakeservreqchildremovalid;
        editData.responseacceptedkey = "4612";
        editData.activereviewcheck = 'firstreview';
        editData.casenumber = this.daNumber;
        const reviewrecords = this.children[0].placement?.placementrevision?.filter((item: { approvalstatustypkey: string; activeflag: number; }) => item.approvalstatustypkey == '3045' && item.activeflag == 1);
        if (reviewrecords?.length > 0 || (this.onEditPlacement === true && approvedrecords?.length > 0)) {
          editData.activereviewcheck = 'Multiplereview';
        }
        this.addUpdatePlacement(editData);
      } else {
        this.handleEditPlacementForApprovalFn(editData);
      }
    } else {
      this.handleEditPlacementForApprovalFn(editData);
    }
    //}
  }
  private handleEditPlacementForApprovalFn(editData: any) {
    this._commonHttpService
      .create(editData, 'placement/exitplacement')
      .subscribe(response => {
        this._alertService.success('Placement edit recorded successfully', true);
        this.goBack();
      });
  }

  addUpdatePlacement(editData: any) {
    this._commonHttpService
      .create(editData, 'placement/addupdate')
      .subscribe(response => {
        if (response.msgStatus == 'ERROR') {
          this._alertService.error(response.message, true);
        } else if (response.msgStatus == 'Success') {
          this._alertService.success(response.message, true);
        }
        this.goBack();
      });
  }

  convertMatinputTimeToTimestamp(date: any, time: any) {
    return moment(`${moment(date).format('MM/DD/YYYY')} ${time}`).format();
  }

  concateDateTime(date: any, time: any) {
    date = date.split(" ")[0] + " " + time + ":00";
    return date;
  }

  updatePlacementForm(editData: any) {
    this.hospitalizationEditValues = null;
    let formData = this.placementEditDetails.placementEditForm.getRawValue();
    let isHospitalRecords = false;
    formData.placementtypekey = 'LA';
    formData.casenumber = this.daNumber;
    formData.startdate = this.convertMatinputTimeToTimestamp(formData.startdate, formData.starttime);
    //CDM-33200 Need to take updated end date and end time 
    formData = this.handleEndDateAndTimeCondFn(formData, editData);
    formData.isSupervisor = this.isSupervisor;
    formData = this.handleExitTypeCondFn(formData);

    formData.leastrestrictiveplacement = this.editleastrestrictiveplacement ? this.editleastrestrictiveplacement : this.exitFormValues['leastrestrictiveplacement'];
    formData.remarks = this.editComments ? this.editComments : this.exitFormValues['remarks'];


    if (
      (formData.livingarrangementtypekey === "IMC" ||
        formData.livingarrangementtypekey === "PSYH")
      && this.hospitalizationFormValues
      && this.hospitalizationFormValues["Hospital_ERexamination"]
    ) {
      this._alertService.error('Please select the appropriate Living Arrangement Type');
      return;

    }
    this.updatePlacementFormProcess(formData,isHospitalRecords,editData);
  }

  private handleExitTypeCondFn(formData: any) {
    if (this.editApprovedPlacement.controls['exittypekeycheck'].value || this.exitFormValues['exittypekey']) {
      formData.exittypekey = this.editApprovedPlacement.controls['exittypekeycheck'].value ? this.editApprovedPlacement.controls['exittypekeycheck'].value : this.exitFormValues['exittypekey'];
    } else {
      if (this.children[0]?.placement.placementtypekey === 'LA') {
        formData.exittypekey = this.children[0]?.placement?.revisionupdate?.exittypekey ? this.children[0]?.placement?.revisionupdate?.exittypekey : this.children[0]?.placement?.exittypekey;
      }
      else {
        formData.exittypekey = this.children[0]?.placement?.revisionupdate?.exittypekeydescription ? this.children[0]?.placement?.revisionupdate?.exittypekeydescription : this.children[0]?.placement?.exittypedescription;
      }
    }

    formData = this.handleExitreasonType(formData);

    if (this.editApprovedPlacement.controls['exittypekeycheck'].value =='PLCC') {
      formData.exitluggage = this.editApprovedPlacement.controls['exitluggage'].value 
      formData.exitluggageprovided = this.editApprovedPlacement.controls['exitluggageprovided'].value ;
      formData.exitluggagecomments = this.editApprovedPlacement.controls['exitluggagecomments'].value; 
      formData.exitdisposableortrashbag = this.editApprovedPlacement.controls['exitdisposableortrashbag'].value ;
    }
    return formData;
  }

  private handleExitreasonType(formData: any){
    if (this.editApprovedPlacement.controls['exitreasonchecktypekey'].value || this.exitFormValues['exitreasontypekey']) {
      formData.exitreasontypekey = this.editApprovedPlacement.controls['exitreasonchecktypekey'].value ? this.editApprovedPlacement.controls['exitreasonchecktypekey'].value : this.exitFormValues['exitreasontypekey'];
    } else {
      if(this.children[0]?.placement.placementtypekey === 'LA'){
        formData.exitreasontypekey = this.children[0]?.placement?.revisionupdate?.exitreasontypkey ? this.children[0]?.placement?.revisionupdate?.exitreasontypkey : this.children[0]?.placement?.exitreasontypkey;
      } else {
        formData.exitreasontypekey = this.children[0]?.placement?.revisionupdate?.exitreasontypkeydesc ? this.children[0]?.placement?.revisionupdate?.exitreasontypkeydesc : this.children[0]?.placement?.exitreasontypedescription;
      }
    }
    return formData;
  }

  updatePlacementFormProcess(formData: any,isHospitalRecords: any,editData: any) {

    if (formData.livingarrangementtypekey === 'ERM' || formData.livingarrangementtypekey === 'ERP' || formData.livingarrangementtypekey === 'IMC' || formData.livingarrangementtypekey === 'PSYH') {
      isHospitalRecords = true;
      this.checkHospitalizationCondFn();

      const obj = {
        add1: this.hospitalizationFormValues["Hospital_address1"],
        add2: this.hospitalizationFormValues["Hospital_address2"],
        cityname: this.hospitalizationFormValues["Hospital_city"],
        statetypekey: this.hospitalizationFormValues["Hospital_state"],
        zipcode: this.hospitalizationFormValues["Hospital_zipcode"],
        countytypekey: this.hospitalizationFormValues["Hospital_country"],
        primarycaregiver: this.hospitalizationFormValues["Hospital_name"],
        health: this.hospitalizationFormValues,
        placementid: editData.placementid
      }
      formData = { ...obj, ...formData }
    }


    const startDate = new Date(formData["startdate"]).getTime();
    const dischargeDate = this.hospitalizationFormValues && this.hospitalizationFormValues["Hospital_DischargedDate"]
      ? new Date(this.hospitalizationFormValues["Hospital_DischargedDate"]).getTime()
      : null;

    if (dischargeDate && dischargeDate <= startDate) {
      this._alertService.error("Discharge / Exit date & time should be greater than the start date & time");
      return;
    }

    if (isHospitalRecords) {
      ($('#hospitalization-proceed') as any).modal('show');
      this.hospitalizationEditValues = formData;
    } else {
      this._ServiceCasePlacementsService.sendApprovalInQueue(formData);
      setTimeout(() => {
        this.goBack();
      }, 3000);
    }
  }

  private handleEndDateAndTimeCondFn(formData: any, editData: any) {
    if (this.enddate && this.endtime) {
      const formatEndDt = moment(this.enddate).format(this.dtformat);
      formData.enddate = formatEndDt + 'T' + this.endtime + ':00';
      formData.endtime = this.endtime;
    } else if (formData.endtime) {
      formData.enddate = this.convertMatinputTimeToTimestamp(formData.enddate, formData.endtime);
    } else {
      formData.enddate = editData.enddate;
      formData.endtime = editData.endtime;
    }
    return formData;
  }

  private checkHospitalizationCondFn() {
    if (this.hospitalizationFormValues["Hospital_ERexamination"]) {
      this.hospitalizationFormValues["Hospital_examStartDate"] = this.hospitalizationFormValues["Hospital_examStartDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_examStartDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_examStartDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_examStartDate"] = null;
    }

    if (this.hospitalizationFormValues["Hospital_InpatientAdmission"]) {
      this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] = this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_InpatientAdmissionDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_InpatientAdmissionDate"] = null;
    }

    if (this.hospitalizationFormValues["Hospital_Discharged"]) {
      this.hospitalizationFormValues["Hospital_DischargedDate"] = this.hospitalizationFormValues["Hospital_DischargedDate"] ? this.concateDateTime(moment(new Date(this.hospitalizationFormValues["Hospital_DischargedDate"])).format('YYYY-MM-DD hh:mm A'), this.hospitalizationFormValues["Hospital_DischargedDate_starttime"]) : null;
    } else {
      this.hospitalizationFormValues["Hospital_DischargedDate"] = null;
    }
  }

  proceedWithUpdate() {

    if (this.hospitalizationEditValues) {
      ($('#hospitalization-proceed') as any).modal('hide');
      this._ServiceCasePlacementsService.sendApprovalInQueue(this.hospitalizationEditValues);
      setTimeout(() => {
        this.goBack();
      }, 3000);
    }
  }

  dischargeDate: any;
  exitEndDate: any;
  exitEndTime: any;
  dischargeTime: any;
  handleDischargeDateEvent(value: any) {
    this.dischargeDate = value;
  }

  handleDischargeTimeEvent(value: any) {
    this.dischargeTime = value;
  }

  handleExitDateEndDateEvent(value: any) {
    this.exitEndDate = value;
  }

  handleExitDateEndTimeEvent(value: any) {
    this.exitEndTime = value
  }

invalidExitEndDate = false;
void() {
  if (this._exitPlacementService.voidPlacementForm.invalid) {
    this._exitPlacementService.voidPlacementForm.markAllAsTouched();
    this._alertService.error(this.mandatorymsg);
    return;
  }
  const voidPlacementFormData = this._exitPlacementService.voidPlacementForm.getRawValue();
  voidPlacementFormData.isvoided = 1;
  if (this.children && this.children.length && this.children[0].placement) {
    voidPlacementFormData.placementid = this.children[0].placement.placementid;
    voidPlacementFormData.servicecaseid = this.children[0].placement.servicecaseid
      ? this.children[0].placement.servicecaseid
      : this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (this.children[0].placement.providerdetails) {
      voidPlacementFormData.providerid = this.children[0].placement.providerdetails.provider_id;
    }
  }
  voidPlacementFormData.voiddate = new Date();
  voidPlacementFormData.v_securityusersid = this.userInfo.user.userprofile.securityusersid;

  this.isSubmitting = true;
  this._commonHttpService
    .create(voidPlacementFormData, 'placement/voidplacementadd')
    .subscribe(response => {
      this._alertService.success('Placement voided successfully', true);
      this.goBack();
    });
}
   getApprovalConfirm() {
    if (this.isChildDeath() || this.isChildRunaway() || this.checkTypeAndName() || this.dod !== "") {
      return true;
    }
    /* If email & phone number objects having null EndDate */
    if (this.checkEmailAndPhoneDataFn()) {
      this.noEndDateEmailPhonMessage = "Please review the Contact Info tab on this youth’s Person card and enter a current phone number and/or current email address for them. If the youth does not have a phone number or email address, enter the information in the youth’s Person Card in the Contact Info tab for a family member or friend who is in close contact with them. This information is needed for future NYTD surveys";
      this.noEndDateEmailPhonModal.openConfirmationModal();
      return false;
    }
    return true;
  }
  private checkEmailAndPhoneDataFn() {
    return (this.ageGreatOrEqual17() && this.noFonOrEmails()) ||
      (
        this.ageGreatOrEqual17() &&
        this.isNulEnDatFonOrEmail()
      );
  }

  ageGreatOrEqual17() {
    return this.childAge >= 17;
  }
  isNulEnDatFonOrEmail(){
    return !this.isNulEndDatPhonNumb && !this.isNulEndDatEmail;
  }
  noFonOrEmails() {
    return this.emailIds?.length === 0 && this.phoneNumbers?.length === 0;
  }
  isChildDeath() {
    const exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue();
    return exitFormData.exittypekey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY
      && (exitFormData.exitreasontypekey === PlacementConstants.EXIT_TYPES.DEATH
        || exitFormData.exitreasontypekey === PlacementConstants.EXIT_TYPES.RNAWAY);
  }
  isChildRunaway() {
    const exitFormData = this._exitPlacementService.exitPlacementForm.getRawValue(); 
    return exitFormData.exittypekey === PlacementConstants.EXIT_TYPES.CHANG_IN_PLACMENT
    || exitFormData.exittypekey === PlacementConstants.EXIT_TYPES.CHANG_IN_PLACMENT_STRUCTURE;
  }
  checkTypeAndName() {
    return this.children[0].placement.placementTypeDesc === "Living Arrangement" && (this.children[0].placement.livingarrangementtype === "Runaway" || this.children[0].placement.livingarrangementtype === "Incarcerated")
  }
  getPhoneNumber(personid: any) {
    const source = this._commonHttpService.getPagedArrayList(
      new PaginationRequest(
        {
          method: 'get',
          where: { personid: personid },
          page: 1,
          limit: 10
        }),
      CommonUrlConfig.EndPoint.PERSON.PHONE.ListPhoneUrl + '?filter').pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }), share());
    const phoneNumber = source.pipe(pluck('data'));
    phoneNumber.subscribe(
      result => {
        this.phoneNumbers = result;
        this.isNulEndDatPhonNumb = this.phoneNumbers.some((item: any) => item.enddate === null);
      }
    );
  }
  updatePersonInfo(personid: string) { /* Updating person info for redirecting between CHILDREMOVAL ~ CONTACT page  */
    const sourceID = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const caseNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    const navigationInfo: any = { data: { caseNumber: '' } };
    navigationInfo.personId = personid;
    navigationInfo.source = 'SERVICE_CASE';
    navigationInfo.sourceID = sourceID;
    navigationInfo.data.caseNumber = caseNumber;
    this._navigationUtils.setNavigationInfo(navigationInfo);
  }
  getEmailPage(personid: any) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: personid },
            page: 1, 
            limit: 10
          }),
        CommonUrlConfig.EndPoint.PERSON.EMAIL.ListEmail + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0,
        };
      }), share());
    const emailID = source.pipe(pluck('data'));
    emailID.subscribe(
      result => {
        this.emailIds = result;
        this.isNulEndDatEmail =  this.emailIds.some((item: any) => item.enddate === null);
      }
    );
  }
  goToContctInfo(response: boolean) {
    if (response) {
      /* Redirect to new tab with contact page */
      setTimeout(() => {
        window.open('#/pages/person-info-cw/contacts');
      }, 500);
    } else {
      this.getPhoneNumber(this.personId);
      this.getEmailPage(this.personId);
      this.noEndDateEmailPhonModal.closeConfirmationModal();
    }
  }
  getAgeFromDOB(dobString: string): number {
    const dob = new Date(dobString);
    const today = new Date();  
    let age = today.getFullYear() - dob.getFullYear();
    const monthDiff = today.getMonth() - dob.getMonth();
    const dayDiff = today.getDate() - dob.getDate();
    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
      age--;
    }  
    return age;
  }

  validatePlacementDates(child: any) {

  let minDob = new Date();
  let maxDatee = new Date();
  let minRemovalDate = new Date();

    minDob = this.placementDateCheck(child, minDob, minRemovalDate).minDob;
    minRemovalDate = this.placementDateCheck(child, minDob, minRemovalDate).minRemovalDate;

    if (this.isLivingArrangement) {
      this.minDate = minDob;
    } else if (minRemovalDate) {
      this.minDate = minRemovalDate;
      if (child && child.childremoval && child.childremoval.length && Array.isArray(child.childremoval)) {
        this.handleEndDateCheckFn(child, maxDatee, minDob, minRemovalDate);
      }
    } else {
      if (minRemovalDate === new Date()) {
        this.minDate = minDob;
      } else {
        this.minDate = minRemovalDate;
      }
      if (child && child.childremoval && child.childremoval.length && Array.isArray(child.childremoval)) {
        this.handleEndDateCheckFn(child, maxDatee, minDob, minRemovalDate);
      }
    }
  }

  private placementDateCheck(child: any, minDob: any, minRemovalDate: any){
    if (child && child.dob) {
      const dob = new Date(child.dob);
      if (dob < minDob) {
        minDob = dob;
      }
    }

    if (child && child.childremoval && child.childremoval.length && Array.isArray(child.childremoval)) {
      // TO consider the Min Removal date
      const sortedOrder = child.childremoval.sort((a: any, b: any) => a.removaldate.localeCompare(b.removaldate));

      const childRemoval = sortedOrder[0];
      const removalDate = new Date(childRemoval.removaldate);
      if (removalDate < minRemovalDate) {
        minRemovalDate = removalDate;
      }
    }
    return {minDob, minRemovalDate};
  }

  private handleEndDateCheckFn(child: any, maxDatee: Date, minDob: Date, minRemovalDate: Date) {
    if (this.children && this.children.length && this.children[0].placement && child != undefined) {
      const childData = child.childremoval.filter((childD: { intakeservreqchildremovalid: any; }) => childD.intakeservreqchildremovalid === this.children[0].placement.intakeservreqchildremovalid);
      const childRemoval = childData[0];
      const removalEndDate = childRemoval?.exitdate ? new Date(childRemoval?.exitdate) : maxDatee;

      if (minRemovalDate) {
        this.maxDate = removalEndDate;
      } else {
        if (minRemovalDate !== new Date()) {
          this.maxDate = removalEndDate;
        }
      }
    }
  }

  getPlacementEndDate(child: any, minDob: any) {
    let placement = [];
    let placementendDate = minDob;
    if (child && child.placements) {
      placement = child.placements.filter((item: { placementtypekey: string; enddate: any; isvoided: number; }) => item.placementtypekey === 'PRPL' && item.enddate && item.isvoided !== 1);
      if (placement && placement.length > 0) {
        placement.forEach((plac: any) => {
          if (placementendDate && new Date(plac.enddate) > placementendDate) {
            placementendDate = plac.enddate;
          }
        })
      }
    }
    return placementendDate;
  }

  getPlacementStrType(providerId: any, service_id: any) {
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: {
          'structure_service_cd': 'P',
          'provider_id': providerId
        }
      },
      'tb_services/getplacementstructureslist?filter'
    ).subscribe(result => {
      this.placementStrType = result.filter(item => (item.service_id !== 501 && item.service_id !== 71 && item.service_id !== 503));
      // 71 - Emergency Foster Care Retainer
      // 501 - Adoptive Home
      // 503 - Guardianship Assistance Program
      // this.placementStrType = result
    });
  }

  getPlacementExitType() {
    this._commonHttpService.getArrayList(
      {
        method: 'get',
        nolimit: true,
        where: {
          tablename: 'placement_exit_type',
          teamtypekey: 'CW'
        }
      },
      'referencetype/gettypes?filter'
    ).subscribe(result => {
      this.exitTypes = result.filter(item => !PlacementConstants.ICPCExitTypes.includes(item.ref_key));
    });
  }


  getPlacementExitReasonType() {
    this._exitPlacementService.getreasontype().subscribe(result => {
      this.reasonforexit = result.filter(item => item.activeflag === 1)
      const age = moment().diff(this.children[0]?.dob, 'years');
      if (age < 18) {
        this.reasonforexit = this.reasonforexit.filter((item: { ref_key: string; }) => item.ref_key !== 'RNAWAY');
      }
      this.reasonforexit.sort((a: any, b: any) => a.description.localeCompare(b.description));
      this.onExitTypeKeyChange(true);
      if (this.children[0]?.placement && this.children[0].placement.exitreasontypekey) {
        this.editApprovedPlacement.patchValue({
          exitreasonchecktypekey: this.children[0].placement.exitreasontypekey,
          transferagency: this.children[0].placement.transferagency,
          otherpublicagency: this.children[0].placement.otherpublicagency,
        })
      }
    });


    this._exitPlacementService.gettransferagency().subscribe(result => {
      this.transferagencies = result.filter(item => item.activeflag === 1)
      this.transferagencies.sort((a: any, b: any) => a.description.localeCompare(b.description));
    });
  }
  onExitreasonchange() {
    this.editApprovedPlacement.patchValue({
      transferagency: null,
      otherpublicagency: null,
    });
  }
  ontransferagencychange() {
    this.editApprovedPlacement.patchValue({
      otherpublicagency: null,
    });
  }
  onExitTypeKeyChange(status: any) {
    const exitTypeKey = this.editApprovedPlacement.controls['exittypekeycheck'].value;
    if (status) {
      this.editApprovedPlacement.patchValue({
        exitreasonchecktypekey: null,
        transferagency: null,
        otherpublicagency: null,
      });
    }
    if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
      this.hideExitReasonType = true;
      if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT) {
        this._exitPlacementService.getReasonForExit(exitTypeKey).subscribe(result => {
          if (result && result.length) {
            this.reasonsForExit = result;
          }
        });
      }
      else if (exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
        this.reasonsForExit = this.reasonforexit;

      }
    } else {
      this.hideExitReasonType = false;
      this.reasonsForExit = [];
    }
  }
  gotolegal(e: any) {
    if (e.value == 'yes') {
      ($(this.legalpagepopupid) as any).modal('hide');
      this.legalinfoform.reset();
      const url = '#/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/court/legal-custody'
      window.open(url);
    }
    else {
      ($(this.legalpagepopupid) as any).modal('hide');
      this.legalinfoform.reset();
      this.router.navigate([this.listpagepath], { relativeTo: this.route });

    }
  }

  getpersondetail() {
    this._ServiceCasePlacementsService.getPersonList().subscribe(result => {
      this.getpersondetail_res = result;
    })
  }
  luggagebuttonreset(value: any) {

    if (value === 1) {
      this.plluggagepurchased = null;
      this.plluggagecomments = null;
      this.placementdisposableortrashbag =null;
    }
    if (value === 2) {
      this.plluggagecomments = null;
      this.placementdisposableortrashbag =null;
    }
  }
  
    checkluggage() {
    if (this.placementluggage === null || this.placementluggage === undefined) {       return true      } else if (this.placementluggage && this.placementluggage === true) {
        return false;
      } else if (this.placementluggage === false && (this.plluggagepurchased === null || this.plluggagepurchased === undefined)) {
        return true;
      } else if (this.plluggagepurchased && this.plluggagepurchased === true) {
        return false;
      }else if(this.plluggagepurchased === false &&(this.placementdisposableortrashbag === null || this.placementdisposableortrashbag === undefined)){
          return true;
        
      } else if (this.plluggagecomments === null || this.plluggagecomments === undefined || this.plluggagecomments?.length === 0) {
        return true;
      }else{
        return false;
      }
}

  updateHospitalizationFormValues(event: any) {
    this.hospitalizationFormValues = event ? event : {};
  }


  exitFormValChangesEvent(event: any) {
    this.exitFormValues = event["value"];
    this.isExitFormValid = event["isExitFormOpen"] ? event["valid"] : true;
  }

  getHospitalizationForm(event: any) {
    this.hospitalizationFormStatus = event
  }
  luggagebuttonresetexit(value: any){
    if(value ===1){

      this.editApprovedPlacement.patchValue({
        exitluggageprovided :null,
       exitluggagecomments:null,
        exitdisposableortrashbag :null

      })
      
      const plluggagepurchasedTemp: any = this.editApprovedPlacement.get('exitluggageprovided');
      plluggagepurchasedTemp.clearValidators();
      plluggagepurchasedTemp.updateValueAndValidity();
    
    }
      if(value ===2){
        this.editApprovedPlacement.patchValue({
          exitdisposableortrashbag :null, 
         exitluggagecomments:null
  
        })

      }
    
      const luggagecomments: any = this.editApprovedPlacement.get('exitluggagecomments');
      const placementdisposableortrashbag: any =this.editApprovedPlacement.get('exitdisposableortrashbag');
      luggagecomments.clearValidators();
      luggagecomments.updateValueAndValidity();
      placementdisposableortrashbag.clearValidators();
      placementdisposableortrashbag.updateValueAndValidity();
  }

  checkluggageindicator(){
    const exitluggageData = this.editApprovedPlacement.getRawValue()
    if (exitluggageData.exitluggage === null || exitluggageData.exitluggage === undefined) {
      return true;
    } else if (exitluggageData.exitluggage && exitluggageData.exitluggage === true) {
      return false;
    } else if (exitluggageData.exitluggage === false && (exitluggageData.exitluggageprovided === null || exitluggageData.exitluggageprovided === undefined)) {
      return true;
    } else if (exitluggageData.exitluggageprovided && exitluggageData.exitluggageprovided === true) {
      return false;
    }else if(exitluggageData.exitluggageprovided === false &&(exitluggageData.exitdisposableortrashbag === null || exitluggageData.exitdisposableortrashbag === undefined)){
        return true;
      
    } else if (exitluggageData.exitluggagecomments === null || exitluggageData.exitluggagecomments === undefined || exitluggageData.exitluggagecomments?.length === 0) {
      return true;
    }else{
      return false;
    }

  }

  commonValidatorFn(field: any) { 
    const control: any = this.addCPAHomeFormGroup.get(field); 
    if (this.providerDetailsShow) { 
      control?.setValidators([Validators.required]);
    } else { 
      control?.clearValidators();
    } 
    control?.updateValueAndValidity(); 
  } 
closemodal(){
    const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-placements/list';
        this.router.navigate([currentUrl]);
  }

}