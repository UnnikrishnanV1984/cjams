import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit, Injector} from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService, DataStoreService, SessionStorageService, AuthService, CommonDropdownsService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import moment from 'moment';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { InvolvedPerson } from '../../../as-service-plan/_entities/as-service-plan.model';
import { Observable } from 'rxjs';
import { ServiceCasePlacementsService } from '../../service-case-placements.service';
import { Router, ActivatedRoute } from '@angular/router';
declare let google: any;
const RESPONSE_ACCEPTED_YES = '4612';
import _ from 'lodash';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { ExitPlacementService } from '../../exit-placements/exit-placement.service';
import { PlacementConstants } from '../../constants';
@Component({
    selector: 'placement-referral',
    templateUrl: './placement-referral.component.html',
    styleUrls: ['./placement-referral.component.scss'],
    standalone: false
})
export class PlacementReferralComponent implements OnInit {

  selectedPlacementItem: any;
  relationShipDropdownItems: any[] = [];
  providerSearchForm!: FormGroup;
  referalForm!: FormGroup;
  childCharacteristics: any[] = [];
  otherLocalDeptmntType: any[] = [];
  placementStrType: any[] = [];
  placementStrTypelCfe: any[] = [];
  validplacementStrType: any[] = [];
  validfcProviderSearch: any[] = [];
  bundledPlcmntServicesType: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  fcProviderSearch: any[] = [];
  childRemovalData: any[] = [];
  intakeservicerequestactorid!: string;
  isPublicProvider!: boolean;
  isAddPlacement!: boolean;
  lastPlacementDate: any;
  activePlacementDate: any;
  placementRecordsList: any;
  selectedResponseStructure: any;
  reportedChildDob: any;
  selectedProvider: any;
  selectedViewProvider: any;
  isPrivateProvider!: boolean;
  isChildRemoval = false;
  selectedPlacement: any;
  isDateTime!: boolean;
  isSubmitting!: boolean;
  daNumber!: string;
  markersLocation : Array<any> = [];
  zoom!: number;
  defaultLat = 39.29044;
  defaultLng = -76.61233;
  id!: string;
  isServiceCase!: boolean;
  primcheck = true;
  comarRateRequired!: boolean;
  fcTotal!: number;
  selectedPlacementStructure: any;
  selectedChild!: InvolvedPerson;
  fcpaginationInfo: PaginationInfo = new PaginationInfo();
  inputRequest!: Object;
  placement$!: Observable<any[]>;
  placementCount$!: Observable<number>;
  ResponseAcceptedList: any[] = [];
  ResponseRejectedList: any[] = [];
  genderDropdownItems: any[] = [];
  selectedChildren: any[] = [];
  minAge!: number;
  maxAge!: number;
  gender!: string;
  minDate: any;
  minBeginDate: any;
  currProcess!: string;
  involevedPerson$!: Observable<InvolvedPerson[]>;
  lat = 51.678418;
  lng = 7.809007;
  showMap!: boolean;
  currentCounty: any;
  isResponseAccepted = false;
  maxDate!: Date;
  maxBeginDate!: Date;
  isOutOfPlacementSequence: boolean = false;
  filterChildRemoval: any;
  approval!: boolean;
  comarRateId : any;
  kinshipMaxdate: any;
  comarValues : any[] = [];
  comarValueExclude= ['8','76', '1', '74', '15', '14' , '75' , '167','78'];
  formData: any;
  fosterAr = ['Kin', 'Non-Relative', 'Relative'];
  adoptiveHomeAr = ['Foster Parent', 'Kin', 'Non-Relative', 'Relative'];
  showFoster: boolean = false;
  showAdoptive: boolean = false;
  showRelDropValue: boolean = false;
  private userInfo: AppUser;
  showchildrealtionshipdropdown: boolean=false;
  copyRelationShipDropdownItems: any;
  exitTypes: any[] = [];
  reasonsForExit: any[] = [];
  reasonForExitRequired = false;
  exitReasonKey: any;
  dtformat = 'YYYY-MM-DD';
  validationmsg = 'Please enter the dates correctly as selected dates are overlapping with other existing placements';
  placementexitapproved = 'Placement Exit Approved';
  placementexitrejected = 'Placement Exit Rejected';
  placementapproved = 'placement Approved';
  mandatorymessage: boolean =false;
  permanancyPlanExist = false;
  activeGapDoesExist!: boolean;
  courtOrderDate!: string | null;
  activeGapWithActiveSuspension: any;
  activeAdoptionIdDoesExist: any;
  activeAdoptionDateWithActiveSuspension: any;
  filterCase!: string;
  isSupervisor!: boolean;
  isAdoptionCase!: boolean;
  dateRanges: any;
  adoptioncaseid: any;
  suspensionBeginDate: any;
  KRD_enddate: any;
  KRD_startdate: any;
  test: any;

  private formBuilder: FormBuilder;
  private _commonService: CommonHttpService;
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  private _session: SessionStorageService;
  private router: Router;
  private route: ActivatedRoute;
  private _ServiceCasePlacementsService: ServiceCasePlacementsService;
  private _authService: AuthService;
  private _dropDownService: CommonDropdownsService;
  private exitService: ExitPlacementService;


  constructor(private injector: Injector){
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this.router = this.injector.get<Router>(Router);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._ServiceCasePlacementsService = this.injector.get<ServiceCasePlacementsService>(ServiceCasePlacementsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._dropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.exitService = this.injector.get<ExitPlacementService>(ExitPlacementService);

    this.userInfo = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.isOutOfPlacementSequence = this._dataStoreService.getData('isOutOfSequencePlacement');
    this.currProcess = 'search';
    this.minDate = new Date();
    this.minDate.setHours(0, 0, 0, 0);
    this.maxDate = new Date();
    this.minBeginDate = new Date();
    this.minBeginDate.setHours(0, 0, 0, 0);
    this.maxBeginDate = new Date();
    this._ServiceCasePlacementsService.placementApprovalQueue$.subscribe(response => {
      (<any>$('#placement-ackmt')).modal('show');
    });
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    if (this.isServiceCase) {
      this.inputRequest = {
        objectid: this.id,
        objecttypekey: 'servicecase',
        isgroup: 1
      };
    } else {
      this.inputRequest = { intakeservreqid: this.id };
    }
    const caseType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isAdoptionCase = caseType === CASE_TYPE_CONSTANTS.ADOPTION;
    this.forminitialize();
    this.getChildCharacteristics();
    this.getOtherLocalDeptmntType();
    this.getResponseAcceptedList();
    this.getPermanencyPlanList();
    this.getResponseRejectedList();
    this.loadGenderDropdownItems();
    this.loadPlacementItems();
    this.getBundledPlcmntServicesType();
    this.getComarlist();
    this.getPlacementStrType(null);
    this.getSelectedChildren();
    this.loadDropDowns();
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.getChildRemoval();
    this.isPublicProvider = false;
    this.isPrivateProvider = false;
    this.isDateTime = false;
    this.listReportSummary(this.id);
    this.selectedChildren = this._ServiceCasePlacementsService.selectedChildren;
    this.validatePlacementDates(this.selectedChildren);
    this._session.getObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD);
    this._ServiceCasePlacementsService.childSelection$.subscribe(children => {
      this.selectedChildren = this._ServiceCasePlacementsService.selectedChildren;
      this.referalForm.patchValue({
        startdate: null
      });
      this.validatePlacementDates(this.selectedChildren);
    });
    this.localdptSelected(true);
    this.getpersondetail();
    this.getSuspensionListing();
    this.getProgramAssignmentList();
    this.getDates();
  }

 /*  beginDateChange(referalForm) {
    const startDate = referalForm.getRawValue().startdate;
    const placements = [];
    const selectedChildren = this._ServiceCasePlacementsService.placementList;
    if(selectedChildren && selectedChildren.length) {
      selectedChildren.forEach(child => {
        if(child && child.placements && child.placements.length) {
          child.placements.forEach(placement => {
            placements.push(placement);
          });
        }
      });
    }
    const isRangeExist = placements.filter( (placement) =>
      placement.startdate &&  new Date(startDate).getTime() >= new Date(placement.startdate).getTime() &&
      new Date(startDate).getTime() <= new Date(placement.enddate).getTime()
     );
    if(isRangeExist && isRangeExist.length) {
      this._alertService.error('Placement begin date should be greater than existing placement range');
      this.referalForm.patchValue({ 'startdate' : null });
    }
  } */

  private listReportSummary(id: string) {
    let caseid = '';
    const isServicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    const cpscaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CPS_CASE_ID);
    caseid = (isServicecase && (cpscaseid !== null)) ? cpscaseid : this.id; //CDM-44365
    this._commonService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + caseid)
    .subscribe(result => {
      if (result && result.county && result.county.statecountycode) {
         this.currentCounty =  result.county.statecountycode;
      }
 });

}

getDates() {
  this._commonService.getSettings(['KRD_startdate','KRD_enddate']).subscribe(
    (res: any) => {
      this.KRD_startdate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_startdate')?.settingvalue;
      this.KRD_enddate = res.settings?.find((e: { settingname: string; }) => e.settingname === 'KRD_enddate')?.settingvalue;
      return res;
    },
    (error: any) => {
      console.error('Error fetching setting:', error);
    }
  );
}

loadDropDowns() {
  this.exitService.getExitTypes().subscribe(result => {
    if (result && result.length) {
      this.exitTypes = result.filter(i => i.ref_key == 'CIP' || i.ref_key == 'CIPS');
    }

  });
}

confirmUpdate() {
  ($('#maintenance-payment-check-dialog') as any).modal('show');
}


onExitTypeChange(status: any) {
  const exitTypeKey = this.referalForm.getRawValue().exittypekey;
  if (exitTypeKey === PlacementConstants.EXIT_TYPES.CHANGE_IN_PLACEMENT || exitTypeKey === PlacementConstants.EXIT_TYPES.PERM_LEAVING_CUSTODY) {
    this.reasonForExitRequired = true;
    this.referalForm.patchValue({
      exitreasontypekey : (this.exitReasonKey && !status) ? this.exitReasonKey : null
    })
    this.referalForm.get('exitreasontypekey')?.enable();
    this.exitService.getReasonForExit(exitTypeKey).subscribe(result => {
      if (result && result.length) {
        this.reasonsForExit = result;
      }
    });
  } else {
    this.reasonForExitRequired = false;
    this.referalForm.get('exitreasontypekey')?.disable();
    this.reasonsForExit = [];
  }
}

  validatePlacementDates(selectedChildren: any) {
    if (selectedChildren && selectedChildren.length && Array.isArray(selectedChildren)) {
      this.continuePlacementDatesValidation(selectedChildren);
   }
  }

  continuePlacementDatesValidation(selectedChildren: any) {
    let minDob = new Date();
    let minRemovalDate = new Date();
    const lastPlacements: any[] = [];
    selectedChildren.forEach((child: any, index: any) => {
      if (child.dob) {
        const dob = new Date(child.dob);
        if (dob < minDob) {
          minDob = dob;
        }
      }
      if (child.childremoval && child.childremoval.length && Array.isArray(child.childremoval)) {
        const sortedOrder = child.childremoval.sort((a: any, b: any) => a.removaldate.localeCompare(b.removaldate));
        this.filterChildRemoval = child.childremoval;
        const childRemoval = sortedOrder[0];
        const removalDate = new Date(childRemoval.removaldate);
        if (removalDate < minRemovalDate || index === 0) {
          minRemovalDate = removalDate;
        }
      }

      if (Array.isArray(child.placements)) {
        let providerPlacemnts = child.placements.filter((item: { placementtypekey: string; isvoided: any; }) => item.placementtypekey === 'PRPL' && !item.isvoided);
        this.placementRecordsList = providerPlacemnts.filter((item: { routingstatus: string; }) => (item.routingstatus !== 'Rejected'));
        this.activePlacementDate = this._ServiceCasePlacementsService.checkChildActivePlacementDate(child.placements);
        if (this.isOutOfPlacementSequence) {
          providerPlacemnts = providerPlacemnts.filter((item: { enddate: null; }) => item.enddate !== null);
        }
        if (providerPlacemnts && providerPlacemnts.length) {
          const orderedPlacements = _.orderBy(providerPlacemnts, function (placement) { return moment(placement.enddate).format('YYYYMMDD'); }, ['desc']);
          const lastPlacement = orderedPlacements[0];
          lastPlacements.push(lastPlacement);
        }
      }
    });

    this.setPlacementDates(minDob, minRemovalDate, lastPlacements);

  }

  setPlacementDates(minDob: any, minRemovalDate: any, lastPlacements: any){
    if (minRemovalDate === new Date()) {
      this.minDate = new Date(minDob);
      this.minDate.setHours(0, 0, 0, 0);
      this.minBeginDate = new Date(minDob);
      this.minBeginDate.setHours(0, 0, 0, 0);
    } else {
      this.minDate = new Date(minRemovalDate);
      this.minDate.setHours(0, 0, 0, 0);
      this.minBeginDate = new Date(minRemovalDate);
      this.minBeginDate.setHours(0, 0, 0, 0);
    }

    if (lastPlacements.length) {
      const orderedPlacements = _.orderBy(lastPlacements, function (placement) { return moment(placement.enddate).format('YYYYMMDD'); }, ['desc']);
      const lastPlacement = orderedPlacements[0];
      if (lastPlacement.enddate) {
        this.minBeginDate = new Date(lastPlacement.enddate);
        this.lastPlacementDate = new Date(lastPlacement.enddate);
        this.minBeginDate.setHours(0, 0, 0, 0);
      }
    }

    this.kinshipMaxdate = moment(minDob).add(18, 'years').add(1, 'day').format(this.dtformat);
  }

  forminitialize() {
    this.providerSearchForm = this.formBuilder.group({
      childcharacteristics: [null],
      bundledplacementservices: [null],
      otherLocalDeptmntTypeId: [null],
      placementstructures: [null],
      zipcode: null,
      isLocalDpt: [true],
      firstname: null,
      middlename: null,
      lastname: null,
      providername: null,
      isgender: [false],
      isAge: [false],
      providerid: null,
      agemin: null,
      agemax: null,
      gender: null
    });
    this.providerSearchForm.get('firstname')?.disable();
    this.providerSearchForm.get('middlename')?.disable();
    this.providerSearchForm.get('lastname')?.disable();

    if(this.isOutOfPlacementSequence){
      this.referalForm = this.formBuilder.group({
        providersentdate: [null],
        providerdesc: [null],
        responseacceptedkey: [null, Validators.required],
        rejectreasonkey: [null],
        service_id: ['', Validators.required],
        ratestructureid: [{value: '', disabled: true}, Validators.required],
        startdate: [null, Validators.required],
        starttime: ['08:00', Validators.required],
        enddate: [null, Validators.required],
        endtime: ['08:00', Validators.required],
        exittypekey:[null, Validators.required],
        exitreasontypekey:[null, Validators.required],
        primaryrelationship: [''],
        isssaapproval: [false],
        ifcapprovaldate: [null],
        remarks: [''],
        leastrestrictiveplacement: [''],
        justification: ['', Validators.required],
        placementtypekey: ['PRPL'],
        ischildplacedoutside: [null],
        casecounty: [''],
        placementluggage :[''],
        plluggagepurchased :[''],
        plluggagecomments:[''],
        casenumber :this.daNumber,
        placementdisposableortrashbag:['']
      });
    }
    else {
    this.referalForm = this.formBuilder.group({
      providersentdate: [null],
      providerdesc: [null],
      responseacceptedkey: [null, Validators.required],
      rejectreasonkey: [null],
      service_id: ['', Validators.required],
      ratestructureid: [{value: '', disabled: true}, Validators.required],
      enddate: [null],
      endtime: ['08:00'],
      exittypekey:[null],
      exitreasontypekey:[null],
      startdate: [null],
      starttime: ['08:00'],
      primaryrelationship: [''],
      isssaapproval: [false],
      ifcapprovaldate: [null],
      remarks: [''],
      leastrestrictiveplacement: [''],
      justification: [''],
      placementtypekey: ['PRPL'],
      ischildplacedoutside: [null],
      casecounty: [''],
      placementluggage :[''],
      plluggagepurchased :[''],
      plluggagecomments:[''],
      casenumber: this.daNumber,
      placementdisposableortrashbag:['']
    });
    }
    this.referalForm.get('isssaapproval')?.disable();
    this.referalForm.get('ifcapprovaldate')?.disable();

  }
  closeMap() {
    this.markersLocation = [];
    this.showMap = false;
    (<any>$('#map-popup')).modal('hide');
  }
  close() {
    (<any>$('#placement-ackmt')).modal('hide');
    this.goBack();
  }

  goBack() {
    this._ServiceCasePlacementsService.getChildRemovalInfoAndPlacements().subscribe(response => {
      this._ServiceCasePlacementsService.broadCastPageRefresh();
      this.router.navigate(['../../list'], { relativeTo: this.route });
    });
  }

  getRangeArray(n: number): any[] {
    return Array(n);
  }

  getChildRemoval() {
    this._commonService.getSingle(
      {
        where: this.inputRequest,
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
        .GetChildRemovalList + '?filter'
    )
      .subscribe(result => {
        if (result && result.length) {
          this.isChildRemoval = true;
          this.childRemovalData = result;
        }
      });
  }


  getSelectedChildren() {
    this.selectedChildren = this._ServiceCasePlacementsService.getSelectedChildren();
    this.selectedChildren.forEach(child =>{
      child['activePlacementDate'] = null;
      child['lastPlacementEndDate'] = null;
       if(child.hasActivePlacement){
        if(Array.isArray(child.placements)) {
          child['activePlacementDate'] =  this._ServiceCasePlacementsService.checkChildActivePlacementDate(child.placements);
        }
       }
    });
    if (this.selectedChildren && this.selectedChildren.length > 0) {
      // for min,max age calculation
      if (this.selectedChildren.length > 1) {
        this.minAge = this.filterAge(this.selectedChildren, 'min');
        this.maxAge = this.filterAge(this.selectedChildren, 'max');
        this.providerSearchForm.patchValue({
          agemin: this.minAge,
          agemax: this.maxAge
        });

      }

      if (this.selectedChildren.length === 1) {
        this.minAge = this.filterAge(this.selectedChildren, 'min');
        this.maxAge = this.filterAge(this.selectedChildren, 'max');
        this.gender = this.selectedChildren[0].typedescription;
        this.providerSearchForm.patchValue({
          gender: this.gender,
          agemin: this.minAge,
          agemax: this.maxAge
        });
      }

    }
  }


  filterAge(selectedChildern: any, type: any) {
    let age: any;
    const firstChildAge = this.getAge(selectedChildern[0].dob).toString();
    let min = parseInt(firstChildAge, 10);
    let max = parseInt(firstChildAge, 10);
    let result = parseInt(firstChildAge, 10);
    selectedChildern.forEach((child: { dob: any; }) => {
      age = this.getAge(child.dob);
      age = parseInt(age, 10);
      switch (type) {
        case 'min': if (age < min) {
          min = age;
          result = min;
        }
          break;
        case 'max':
          if (age > max) {
            max = age;
            result = max;
          }
          break;
        default: break;
      }
    });
    return result;
  }



  getResponseAcceptedList() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'referencetypeid': 79
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.GetReasonTypes).subscribe(result => {
      this.ResponseAcceptedList = result;
    });
  }

  getProgramAssignmentList() {
    const personid = this._ServiceCasePlacementsService.selectedChildren?.map(e => e.personid)[0]
    const servicecaseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)

    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { objectid: servicecaseid, personid: personid },
                method: 'get',
                nolimit: true
            }),
            'Personprogramareas/getpersonprogramarea?filter'
        )
        .subscribe(async (result: any) => {
            if (result && Array.isArray(result) && result.length) {
              this.adoptioncaseid = result.map(e => e.personprogramarea)?.[0].filter((e: { objecttypekey: string; }) => e.objecttypekey === 'adoptioncase')?.[0]?.objectid;
            }
            this.suspensionBeginDate = await this.getSuspensionListing(this.adoptioncaseid);
          });
  }

  async getPermanencyPlanList() {
    this._commonService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'permanencyplan/list?filter'
      ).subscribe(async result => {
        this.permanancyPlanExist = result.length > 0;
        const selectedChildPIDs = this._ServiceCasePlacementsService.selectedChildren?.map(e => e.cjamspid)[0]
        this.activeGapDoesExist = result
                  .filter(e => Number(e.cjamspid) === selectedChildPIDs)
                  .some(e => e.permanencyplans?.some((plan: any) => plan.childhasactivegap));
                  // If there is active suspension then make this variable false
                  // if end date is nul then active suspension
                  //061c71ea-72af-477c-a9ed-1189016eb6f7
        const permanencyPlanId = result.filter(e => Number(e.cjamspid) === selectedChildPIDs).map(e => e.permanencyplans)?.[0]?.filter((e: { childhasactivegap: boolean; }) => e.childhasactivegap === true).map((e: any) => e.permanencyplanid)[0];
        this.activeAdoptionIdDoesExist = result.find(e => Number(e.cjamspid) === selectedChildPIDs)?.permanencyplans?.[0]?.casedetails?.[0].adoptioncaseid;
        if(this.activeAdoptionIdDoesExist) {
          this.activeAdoptionDateWithActiveSuspension = await this.getSuspensionListing(this.activeAdoptionIdDoesExist)
        }
        if (this.activeGapDoesExist) {
          this.activeGapWithActiveSuspension = await this.getActiveSuspensionStatus(permanencyPlanId, selectedChildPIDs);
        } else {
            this.activeGapWithActiveSuspension = false;
        }
        const personid = this._ServiceCasePlacementsService.selectedChildren?.map(e => e.personid)[0]
        this.courtOrderDate = this.activeGapDoesExist ? await this.getCourtOrderDate(personid) : 'No Date';
      });
  }

  async getSuspensionListing(id = null) {
      if (!id) {
        return;
      }
      const res = await this._commonService
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
          return null;
  }

  toMidnight(date: any) {
    if (!date) return null;
    const d = new Date(date);
    d.setHours(0, 0, 0, 0);
    return d;
  }

  async getActiveSuspensionStatus(id: any, pid: any): Promise<boolean> {
    try {
        const res:any = await this._commonService.getPagedArrayList(
            new PaginationRequest({
                where: {
                    permanencyplanid: id
                },
                method: 'get'
            }),
            'gapdisclosure/getguardianship' + '?filter'
        ).toPromise();

        const items:any = res.data || [];

        const gapSuspensions = res.data.filter((e:any )=> Number(e.cjamspid) === pid)?.[0]?.gapsuspension;

        this.dateRanges = gapSuspensions.map((suspension: { startdate: any; enddate: any; }) => ({
          startdate: this.toMidnight(suspension.startdate),
          enddate: this.toMidnight(suspension.enddate)
        }));

       return items.length > 0 && items[0]?.gapsuspension?.length > 0
            ? items[0]?.gapsuspension?.slice(-1)[0].enddate === null
            : false;
    } catch (error) {
        console.error('Error fetching suspension status:', error);
        return false;
    }
}


  private async getCourtOrderDate(pid: any): Promise<string | null> {
    try {
        const res:any = await this._commonService.getArrayList(
            {
                method: 'get',
                where: {
                    objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
                    objecttype: 'servicecase'
                }
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl + '?filter'
        ).toPromise();

        return res.filter((e:any) => e.personid == pid).map((e:any) => e.courtorderdate)[0] || null;

    } catch (error) {
        console.error('Error fetching court order date:', error);
        return null;
    }
}



  getChildCharacteristics() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '43'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
      this.childCharacteristics = result;
    });
  }

  CheckFormControlValue(formControl: any) {
    return (formControl && formControl !== '') ? formControl : null;
  }

  getOtherLocalDeptmntType() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
      this.otherLocalDeptmntType = result;
    });
  }


  localdptSelected(value: any) {

    if (value) {
      this.providerSearchForm.get('firstname')?.enable();
      this.providerSearchForm.get('middlename')?.enable();
      this.providerSearchForm.get('lastname')?.enable();
      this.providerSearchForm.get('otherLocalDeptmntTypeId')?.enable();
    } else {
      this.providerSearchForm.get('providername')?.enable();
      this.providerSearchForm.get('otherLocalDeptmntTypeId')?.reset();
      this.providerSearchForm.get('otherLocalDeptmntTypeId')?.disable();
    }
  }

  getComarlist(){
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'structure_service_cd': 'P',
        'comar_sw': 'Y'
      },
      nolimit: true,
      method: 'get'
    }),CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.comarlisteUrl).subscribe(result => {
      this.comarValues = result;
    });
    }

    getcomarlistValues(){
      const placementStructure = this.referalForm.getRawValue().service_id;
      if (placementStructure === '500' || placementStructure === '77') {
        this.comarRateRequired = true;
        this.referalForm.get('ratestructureid')?.reset();
        this.referalForm.get('ratestructureid')?.enable();
        this.referalForm.get('ratestructureid')?.setValidators([Validators.required]);
        this.referalForm.get('ratestructureid')?.updateValueAndValidity();
        let comarCategoryValues : any[] = this.comarValues?.filter(item =>  item.service_id !== 500 &&  item.service_id !== 9 &&  item.service_id !== 8);
        if(placementStructure === '500'){
          comarCategoryValues = comarCategoryValues?.filter(item1 => item1.service_id !== 11710 && item1.service_id !== 11709);
        }
        this.placementStrType = comarCategoryValues;
      } else if (placementStructure === '530') {
        this.comarRateRequired = true;
        this.referalForm.get('ratestructureid')?.enable();
        this.referalForm.get('ratestructureid')?.setValidators([Validators.required]);
        this.referalForm.get('ratestructureid')?.updateValueAndValidity();
        this.placementStrType = this.comarValues.filter(item =>  (item.service_id == '11409' || item.service_id =='11' || item.service_id == '530'));
        this.referalForm.patchValue({
          ratestructureid: null
        });
      } else if (placementStructure === '531') {
        this.referalForm.get('ratestructureid')?.disable();
        this.referalForm.get('ratestructureid')?.clearValidators();
        this.referalForm.get('ratestructureid')?.updateValueAndValidity();
        this.comarRateRequired = false;
        this.referalForm.patchValue({
          ratestructureid: null
        });
      }
    }

    getPlacementStrType(providerId: any) {
      this._commonService.getArrayList(new PaginationRequest({
        where: {
          'structure_service_cd': 'P',
          'provider_id': providerId
        },
        nolimit: true,
        method: 'get'
      }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
        this.placementStrTypelCfe = _.cloneDeep(result);
        this.placementStrType = result.filter(item =>  (item.service_id !== 501 && item.service_id !== 71 && item.service_id !== 503 && item.service_id !== 8 && item.service_id !== 9));
        // 71 - Emergency Foster Care Retainer
        // 501 - Adoptive Home
        // 503 - Guardianship Assistance Program
        this.validplacementStrType = this.placementStrType.filter(item => item.service_status === 'Active'
        && (item.service_id !== 501 && item.service_id !== 71 && item.service_id !== 503 && item.service_id !== 8 && item.service_id !== 9));
        this.getcomarlistValues();
      });
    }

  async fPrimCountryCheck() {

    return new Promise((resolve, reject) => {
      return this._commonService.getArrayList(new PaginationRequest({
        where: {
          'casenumber': this.daNumber
        },
        nolimit: true,
        method: 'get'
      }), CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementFPrimCountry + '?filter').subscribe((result: any) => {
        const fprimcountry = result['data'].at(0).f_prim_county;
        if (!['1430', '1433', '1437', '1443', '1442'].includes(fprimcountry)) {
          this._alertService.error('CfE Placement is currently applicable only for the five pilot jurisdictions in Maryland. Baltimore County, Carroll County, Frederick County, Prince George’s County and Montgomery County');
          this.primcheck = false;
        }
        resolve(true);
      }, (err) => {
        resolve(false);
      });
    })
  }

  getPlacementStrTypePvtProv(providerId: any) {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'structure_service_cd': 'P',
        'provider_id': providerId
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
      this.placementStrType = result.filter(item => (item.service_id !== 501 && item.service_id !== 71 && item.service_id !== 503));
      this.validplacementStrType = this.placementStrType.filter(item => item.service_id !== 501 && item.service_id !== 71 && item.service_id !== 503);
      this.getcomarlistValues();
    });
  }

  getBundledPlcmntServicesType() {
    this._commonService.getArrayList(new PaginationRequest({
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
      this.bundledPlcmntServicesType = result;
    });
  }

  resetproviderSearchForm() {
    this.providerSearchForm.reset();
  }

  getFcProviderSearch() {
    if (this.providerSearchForm.invalid) {
      this._alertService.error('Please fill required fields');
      return false;
    }


    if (this._ServiceCasePlacementsService.selectedChildren.length === 0) {
      this._alertService.error('Please select the children');
      return false;
    }

    const formValues = this.providerSearchForm.getRawValue();
    this.formData = formValues;
    formValues.casecounty = this.currentCounty ? this.currentCounty : '';
    if (formValues.isgender && !formValues.gender) {
      this._alertService.error('Please select gender');
      return false;
    }
    formValues.gender = formValues.isgender ? (this.getgender(formValues)) : null;

    Object.keys(this.providerSearchForm.controls).forEach(key => {
      formValues[key] = this.CheckFormControlValue(formValues[key]);
    });
    const body: any = {};
    Object.assign(body, formValues);
    // Sending param after joining
    body['isLocalDpt'] = this.booleanCheck(formValues.isLocalDpt);
    body['localdepartmenthomecaregiver'] = this.booleanCheck(formValues.isLocalDpt);
    body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics.join() : null;
    body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId && formValues.otherLocalDeptmntTypeId.length ? formValues.otherLocalDeptmntTypeId.join() : null;
    body['placementstructures'] = formValues.placementstructures && formValues.placementstructures.length ? formValues.placementstructures.join() : null;
    body['bundledplacementservices'] = formValues.bundledplacementservices && formValues.bundledplacementservices.length ? formValues.bundledplacementservices.join() : null;
    body['fromproviderplacement'] = true;
    const dob = moment(this.reportedChildDob);
    const age16 = dob.clone().add(16, 'years');
    const age21 = dob.clone().add(21, 'years');
    const isAgeBtwn16And18 = moment().isBetween(age16, age21, null, '[]');
    if (isAgeBtwn16And18 && formValues.placementStrTypeId === '1') {// Independent Living Residential Program
      this._alertService.error('A child between the age of 16 and 21 years cannot be placed in \'Independent Living Residential Program\' Placement Structure.');
      return false;
    }
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: body,
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
      this.fcProviderSearch = result.data;
      this.validfcProviderSearch = this.fcProviderSearch.filter(item => item.service_status === 'Active');
      this.fcTotal = result.count;
      (<any>$('#fc_list')).click();
      this.currProcess = 'select';
    });
    this.loadPlacementItems();
  }
  getgender(formValues: any){
    return formValues.gender ? formValues.gender : null;
  }
  booleanCheck(inputData: any){
    return inputData ? inputData : false;
  }

  selectedViewProv(provId: any) {
    this.selectedViewProvider = provId;
  }

  selectedProv(provId: any) {
    this.selectedProvider = provId;
    this.selectedProvider.contract_program_id ? this.getPlacementStrTypePvtProv(this.selectedProvider.provider_id) : this.getPlacementStrType(this.selectedProvider.provider_id);
  }

  formatPhoneNumber(phoneNumberString: any) {

    const cleaned = ('' + phoneNumberString).replace(/\D/g, '');
    const match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
      return '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return null;

  }

  backToSearchList() {
    this.currProcess = 'select';
    this.selectedProvider = null;
  }

  backToSearch() {
    this.currProcess = 'search';
    this.selectedProvider = null;
    this.providerSearchForm.reset();
    this.providerSearchForm.patchValue({
      isLocalDpt: true,
      isgender: false,
      isAge: false,
      gender: this.gender,
      agemin: this.minAge,
      agemax: this.maxAge
    });
    this.getPlacementStrType(null);
  }

  listMap(provider: any) {
    this.zoom = 13;
    this.defaultLat = 39.29044;
    this.defaultLng = -76.61233;
    // this.fcProviderSearch.map((map) => {
    // (<any>$('#map-popup')).modal('show');
    this.markersLocation = [];
    // if (map.length > 0) {
    // this.fcProviderSearch.forEach((provider) => {
    //  this._ServiceCasePlacementsService.getGoogleMarker(provider.providerdetails[0].address).subscribe(res => {
    //     console.log(res);
    //   });
    const geocoder = new google.maps.Geocoder();
    if (geocoder) {
      geocoder.geocode({ 'address': provider.providerdetails[0].address }, (results: any, status: any) => {
        if (status === google.maps.GeocoderStatus.OK) {
          this.markersLocation = [];
          const marker = { lat: results[0].geometry.location.lat(), lng: results[0].geometry.location.lng() };
          this.lat = marker.lat;
          this.lng = marker.lng;
          this.markersLocation.push(marker);
          this.defaultLat = marker.lat;
          this.defaultLng = marker.lng;
          (<any>$('#map-popup')).modal('show');
          setTimeout(() => {
            this.showMap = true;
          }, 300);

        } else {
          this._alertService.error('Invalid/no address found.');
        }
      });
    }
  }
  mapClose() {
    this.markersLocation = [];
    this.showMap = false;
  }

  getLicenseCoordinatorName(obj: any) {
    let name = '';
    if (obj && obj.length > 0) {
      obj.forEach((namObj: any, index: any) => {
        name = name + namObj.license_cordinator;
        name = ((index + 1) < obj.length) ? name + ',' : name;
      });
      return name;
    } else {
      return name;
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
      const validStartDateArray = ranges.filter(e => this.isWithinRange(placementstartDate, e.startdate, e.enddate));
      if (!validStartDateArray) {
        return false
      }
      return validStartDateArray.some(e => this.isWithinRange(placementendDate, e.startdate, e.enddate));
    }

    return ranges.some(e => this.isWithinRange(placementstartDate, e.startdate, e.enddate));
  }


  saveReferal() {
    const serviceId = this.referalForm.getRawValue()?.service_id;
    if(this.saveReferalValidation(serviceId)) {
      return;
    }

    this.mandatorymessage = true;
    if (this.referalForm.valid) {
      const referalDetails = this.referalForm.getRawValue();
      const placementDates = this._ServiceCasePlacementsService.formatPlacementDates(referalDetails);
      if(!this._ServiceCasePlacementsService.checkChildRemovalFn(placementDates,this.filterChildRemoval)){
        this._alertService.error('Please enter the dates correctly as Removal is not Available for selected dates');
        return;
      }

      //child specific placement check
      if (!this.checkChildSpecificPlacement()) { return }
      if (this.isOutOfPlacementSequence && !this.checkOutOfPlacementSequenceFn(referalDetails, placementDates)) { return }
      if (!this.checkPlacementRecordsListFn(placementDates)) {
        return
      }
      if (!this.cfeAgecheck(referalDetails)) {
        return;
      }
      this.checkServiceProviderFn(referalDetails);

      this.handleToCheckMandatoryFieldsFn(referalDetails);
    } else {
      this.isSubmitting = false;
      this.referalForm.markAllAsTouched();
      this._alertService.error('Please fill required fields');
    }
  }

  saveReferalValidation(serviceId: any){
    const endDateLimit: any = this.KRD_enddate ? new Date(this.KRD_enddate) : null;
    const startDateLimit: any = this.KRD_startdate ? new Date(this.KRD_startdate) : null;

    let placementstartDate: any = this.referalForm.get('startdate')?.value ? new Date(this.referalForm.get('startdate')?.value)  : null;
    let placementendDate: any = this.referalForm.get('enddate')?.value ? new Date(this.referalForm.get('enddate')?.value) : null;

    if (serviceId === '9' && placementendDate > endDateLimit) {
      this.filterCase = 'Restricted Relative placements are not valid later than '  +  moment(this.KRD_enddate).format('MM-DD-YYYY') + ' Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + ' in order for the kinship caregiver to continue to receive payment.'
      this.confirmUpdate();
      return true;
    }

    if ((serviceId === '530' || serviceId === '531') && placementstartDate < startDateLimit) {
      this.filterCase = 'This placement structure is only valid starting on '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + '. A different placement or living arrangement must be used for any time prior to this date.'
      this.confirmUpdate();
      return true;
    }

    if(!this.handleToCheckActiveGapListFn()) {
      return true;
    }
    return false;
  }

  private handleToCheckMandatoryFieldsFn(referalDetails: any) {
    if (referalDetails.leastrestrictiveplacement === '') {
      this.isSubmitting = false;
      this.referalForm.markAllAsTouched();
      this._alertService.error('Please fill required fields');
    } else {
      this.isSubmitting = true;
      this._ServiceCasePlacementsService.sendApprovalInQueue(referalDetails);
    }
  }

  //Associated with saveReferal function
  private handleToCheckActiveGapListFn() {
    const activeGapCheck = this.activeGapDoesExist && this.activeGapWithActiveSuspension
    const activeAdoptionCheck = this.activeAdoptionIdDoesExist && this.activeAdoptionDateWithActiveSuspension
    let placementstartDate: any = this.referalForm.get('startdate')?.value
        ? new Date(this.referalForm.get('startdate')?.value)
        : null;
    let placementendDate: any = this.referalForm.get('enddate')?.value
        ? new Date(this.referalForm.get('enddate')?.value)
        : null;
    const isInRange = activeGapCheck ? !this.isDateInRange(placementstartDate, placementendDate, this.dateRanges) : true;

    if (activeGapCheck || activeAdoptionCheck) {
      if (isInRange) {
        this.filterCase = 'Placement Date is Overlapping with the GAP Agreement Date. Please check and correct the Placement Date or GAP Suspension accordingly to proceed with the Provider Placement.';
        this.confirmUpdate();
        return false;
      }
    }

    let suspensionBeginDateFormatted = this.toMidnight(this.suspensionBeginDate);

    if (suspensionBeginDateFormatted && placementstartDate && suspensionBeginDateFormatted > placementstartDate) {
      this.filterCase = 'Placement Date is Overlapping with the Adoption Agreement Date. Please check and correct the Placement Date or  Adoption Suspension accordingly to proceed with the Provider Placement.';
      this.confirmUpdate();
      return false;
    }
    return true;
  }
  //Associated with saveReferal function
  private checkServiceProviderFn(referalDetails: any) {
    referalDetails.isssaapproval = referalDetails.isssaapproval ? referalDetails.isssaapproval : 0;
    if (this.selectedProvider && this.selectedProvider.provider_id) {
      referalDetails.providerid = this.selectedProvider.provider_id;
      referalDetails.contractprogramid = this.selectedProvider.contract_program_id;
      if (this.selectedProvider.affiliate_provider_id) {
        referalDetails.providerorganizationid = this.selectedProvider.affiliate_provider_id;
      } else {
        if (this.selectedProvider.providerdetails && this.selectedProvider.providerdetails.length) {
          referalDetails.providerorganizationid = this.selectedProvider.providerdetails[0].provider_organization_id;
        }
      }
    }
    referalDetails.placementtypekey = 'PRPL';
    referalDetails.primaryrelationship = (referalDetails.primaryrelationship) ? referalDetails.primaryrelationship : ' ';
    referalDetails.remarks = (referalDetails.remarks) ? referalDetails.remarks : ' ';
    referalDetails.leastrestrictiveplacement = (referalDetails.leastrestrictiveplacement) ? referalDetails.leastrestrictiveplacement : '';
  }

  private childRemovalcheck(placementDates: any,childRemovalcheck: any) : boolean {
    for (let j = 1; j < childRemovalcheck.length; j++) {
      const a = childRemovalcheck[j].removaltime;
      const b = childRemovalcheck[j - 1].exitdate;
      if ((new Date(placementDates.placementStartDt) > new Date(b) && new Date(placementDates.placementStartDt) < new Date(a)) || (new Date(placementDates.placementEndDt) > new Date(b) && new Date(placementDates.placementEndDt) < new Date(a))) {
        return false;
      }
    }
    return true;
  }

  //Associated with saveReferal function
  private checkOutOfPlacementSequenceFn(referalDetails: any, placementDates: any) {
    if (!referalDetails.enddate) {
      this._alertService.error('Placement entry end date should be entered as this is an out of sequence placement.');
      return false;
    }
    if (new Date(referalDetails.enddate) < new Date(referalDetails.startdate)) {
      this._alertService.error('Placement entry end date should be greater than start date');
      return false;
    }
    if (!referalDetails.justification || referalDetails.justification === '') {
      this._alertService.error('Justification should be entered as this is an out of sequence placement.');
      return false;
    }

    if (!this.outOfPlacementSequencePlacementValidationFn(placementDates)) {
      return false
    }
    return true;
  }
  //Associated with saveReferal function
  private outOfPlacementSequencePlacementValidationFn(placementDates: any) {
    if (this.placementRecordsList && this.placementRecordsList.length) {
      let placStatDt;
      let placEndDt;
      let placStatTime;
      let placEndTime;
      let placementrevisionstatus;
      for(let element of this.placementRecordsList) {
        placStatDt = element.startdate;
        placEndDt = element.enddate
        placStatTime = element.starttime;
        placEndTime = element.endtime

        if (element.placementrevision && element.placementrevision.length && element.placementrevision[0].status) {
          placementrevisionstatus = element.placementrevision[0].status;
        }
        const startAndEndDate = this.startAndEndDateFn(placStatDt, placStatTime, placEndDt, placEndTime);

        if (!this.outOfPlacementSequenceDateValidationFn(placementDates, startAndEndDate, placementrevisionstatus)) {
          return false
        }
      }
      return true;
    }
    return true;
  }
  //Associated with saveReferal function
  private outOfPlacementSequenceDateValidationFn(placementDates: any, startAndEndDate: any, placementrevisionstatus: any) {
    if (this.checkOutOfPlacementSequenceDateValidationFnIfCondFn(placementDates, startAndEndDate, placementrevisionstatus)) {
      this._alertService.error(this.validationmsg);
      return false;
    } else if (placementDates.placementStartDt <= startAndEndDate.placEndDt && !placementDates.placementEndDt) {
      this.isOutOfPlacementSequence = true;
      this._alertService.error('Please enter the Placement End Date');
      return false;
    }
    return true
  }
  private checkOutOfPlacementSequenceDateValidationFnIfCondFn(placementDates: any, startAndEndDate: any, placementrevisionstatus: any) {
    return ((((placementDates.placementStartDt >= startAndEndDate.placStatDt && placementDates.placementStartDt <= startAndEndDate.placEndDt) || (placementDates.placementEndDt >= startAndEndDate.placStatDt && placementDates.placementEndDt <= startAndEndDate.placEndDt)) && placementrevisionstatus !== 'Rejected') || ((placementDates.placementStartDt >= startAndEndDate.placStatDt || placementDates.placementEndDt >= startAndEndDate.placStatDt) && startAndEndDate.placEndDt == null) || ((startAndEndDate.placStatDt >= placementDates.placementStartDt && startAndEndDate.placStatDt <= placementDates.placementEndDt) || (startAndEndDate.placEndDt >= placementDates.placementStartDt && startAndEndDate.placStatDt <= placementDates.placementEndDt)));
  }

  //Associated with saveReferal function
  private checkPlacementRecordsListFn(placementDates: any) {
    if (this.placementRecordsList && this.placementRecordsList.length) {
      for (const element of this.placementRecordsList) {
        const placementEndDtCheck = this.returnPlacementEndDtCheckFn(element);
        const placementEndTimeCheck = this.returnPlacementEndTimeCheckFn(element);
        let checkingPlacement: any = null;
        if (placementEndDtCheck && placementEndTimeCheck) {
          checkingPlacement = this._ServiceCasePlacementsService.formatDateTime(placementEndDtCheck, placementEndTimeCheck);
        }
        if (checkingPlacement >= placementDates.placementStartDt) {
          let placementrevisionstatus;
          const placStatDt = element.startdate;
          const placEndDt = element.enddate
          const placStatTime = element.starttime;
          const placEndTime = element.endtime;

            placementrevisionstatus = this.returnPlacementRevisionCheckFn(element, placementrevisionstatus);

            const startAndEndDate = this.startAndEndDateFn(placStatDt, placStatTime, placEndDt, placEndTime);
            if (!this.placementRecordsListFnDateValidationFn(placementDates, startAndEndDate, placementrevisionstatus)) {
              return false
            }
        }
      }
      return true;
    }
    return true;
  }
  private returnPlacementRevisionCheckFn(element: any, placementrevisionstatus: any) {
    if (element.placementrevision && element.placementrevision.length && element.placementrevision[0].status) {
      placementrevisionstatus = element.placementrevision[0].status;
    }
    return placementrevisionstatus;
  }

  private returnPlacementEndTimeCheckFn(element: any) {
    return element.endtime ? moment(element.endtime).format('HH:mm') : null;
  }

  private returnPlacementEndDtCheckFn(element: any) {
    return element.enddate ? moment(element.enddate).format(this.dtformat) : null;
  }

  //Associated with saveReferal function
  private placementRecordsListFnDateValidationFn(placementDates: any, startAndEndDate: any, placementrevisionstatus: any) {
    if ((((placementDates.placementStartDt >= startAndEndDate.placStatDt && placementDates.placementStartDt <= startAndEndDate.placEndDt) || (placementDates.placementEndDt >= startAndEndDate.placStatDt && placementDates.placementEndDt <= startAndEndDate.placEndDt)) && placementrevisionstatus !== 'Rejected') || ((placementDates.placementStartDt >= startAndEndDate.placStatDt || placementDates.placementEndDt >= startAndEndDate.placStatDt) && startAndEndDate.placEndDt == null)) {
      this._alertService.error(this.validationmsg);
      return false;
    } else if (placementDates.placementStartDt <= startAndEndDate.placEndDt && !placementDates.placementEndDt) {
      this.isOutOfPlacementSequence = true;
      this._alertService.error('Please enter the Placement End Date');
      return false;
    }
    return true
  }
  //Associated with saveReferal function
  private startAndEndDateFn(placStatDt: any, placStatTime: any, placEndDt: any, placEndTime: any) {
    if (placStatDt && placStatTime) {
      const formatPlacStartDt = moment(placStatDt).format(this.dtformat);
      let formatStartTime = placStatTime;
      if (placStatTime.length > 5) {
        const plcStartTime = new Date(placStatTime);
        formatStartTime = moment(plcStartTime).format('HH:mm');
      }
      placStatDt = formatPlacStartDt + 'T' + formatStartTime + ':00';
    }
    if (placEndDt && placEndTime) {
      const formatPlacEndDt = moment(placEndDt).format(this.dtformat);
      let formatEndTime = placEndTime;
      if (placEndTime.length > 5) {
        const plcEndTime = new Date(placEndTime);
        formatEndTime = moment(plcEndTime).format('HH:mm');
      }
      placEndDt = formatPlacEndDt + 'T' + formatEndTime + ':00';
    }
    return { placStatDt, placEndDt };
  }

  //Associated with saveReferal function
  //Child specifc placement validation
  private checkChildSpecificPlacement() {
    /**
     * Kinship child specific values
      8	Formal Kinship Care
      530	Kinship
      531	Non-paid Kinship
    **/
    const KINSHIP_PLACEMENT_STRUCTURE_IDS = ['8', '530', '531'];
    if (this.selectedProvider) {

      let childnotmatch = 0;

      /**
       * here we have to use the --> this.referalForm.getRawValue().service_id
       * instead of the --> this.selectedProvider.placement_service_id
       * because they have the ability to 'change' the selected placement structure
       * in the placement referal form even after selecting from the search results
       */
      //if no child specific details have been identified, we still want to block kinship placements
      if(this.selectedProvider.csadetails == null) {
        if(this.selectedProvider.provider_category_cd == '1783' &&
          KINSHIP_PLACEMENT_STRUCTURE_IDS.includes(this.referalForm.getRawValue().service_id)) {
            (<any>$('#child-specific-agreement-error')).modal('show');
            childnotmatch = childnotmatch + 1;
        }
      }

      //if child specifc details are identified, then we want to check that only the specific children are authorized
      if(this.selectedProvider.csadetails && this.selectedProvider.csadetails.length) {

        let authorizedcsapersonids = new Set<string>();
        //kinship child specific authorizaition is not one-to-one so will have to
        //account for multiple children being authorized per provider
        this.selectedProvider.csadetails.forEach((element: { personid: string; }) => {
          authorizedcsapersonids.add(element.personid);
        });

        //we have to make sure each selected child is authorized for the csa kinship placement
        childnotmatch = this.getchildMatch(childnotmatch, authorizedcsapersonids, KINSHIP_PLACEMENT_STRUCTURE_IDS);
      }
      return childnotmatch <= 0;
    }
    return true;
  }

  getchildMatch(childnotmatch: any, authorizedcsapersonids: any, KINSHIP_PLACEMENT_STRUCTURE_IDS: any){
    this.selectedChildren.forEach((child, index) => {
      // if( child.personid != csapersonid) {
      // check if any one of the selected chidren for placement is NOT authorized as per the provider csa
      if ( !authorizedcsapersonids.has(child.personid) ) {
        //Public provider kinship csa
        if(this.selectedProvider.provider_category_cd == '1783') {
          if (
            KINSHIP_PLACEMENT_STRUCTURE_IDS.includes(this.referalForm.getRawValue().service_id)
            ) {
            (<any>$('#child-specific-agreement-error')).modal('show');
            childnotmatch = childnotmatch + 1;
          }
        }
        //Private contract program csa
        else {
          (<any>$('#child-specific-agreement-error')).modal('show');
          childnotmatch = childnotmatch + 1;
        }
      }
    });
    return childnotmatch;
  }

  //Associated with saveReferal function
  private referalDetailsServiceIdFn(referalDetails: any) {
    const formatStartDate = moment(referalDetails.startdate).format(this.dtformat);
    const formatEndDate = referalDetails.enddate ? moment(referalDetails.enddate).format(this.dtformat) : null;
    const person_StartDate = this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.start_dt;
    const person_EndDate = this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.end_dt;
    const notification_StartDate = moment(this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.start_dt).format('MMM DD, YYYY,');
    const notification_EndDate = moment(this.getpersondetail_res.data[0]?.cfe_diff_dates[0]?.end_dt).format('MMM DD, YYYY');

    if (referalDetails.service_id == 525) {
      if (((formatStartDate < person_StartDate || formatStartDate > person_EndDate) && formatStartDate) || (formatEndDate && (formatEndDate < person_StartDate || formatEndDate > person_EndDate))) {
        this._alertService.error("The Placement with the Placement structure ' CfE Resource Home' can be allowed only within the period " + notification_StartDate + " thru " + notification_EndDate);
        return false;
      }
    }

    const referalDateData = this.splitTimeFn(referalDetails);
    if (!this.childRemovalHasDateFn(referalDateData)) { return false; }

    return true
  }
  //Associated with saveReferal function
  private cfeAgecheck(referalDetails: any) {
    const providerid = this.placementStrTypelCfe.find(ele => ele.service_nm === this.selectedProvider.placementstructure);

    if (providerid.service_id === 525) {
      const formatStart = moment(this.referalForm.get('startdate')?.value).format(this.dtformat);

      const getYearOfdob = Number(moment(this.selectedChildren[0].dob).format('YYYY'));
      const monthDateOfdob = moment(this.selectedChildren[0].dob).format('MM/DD');

      const getMinYear = Number(getYearOfdob) + Number(4);
      const getMaxYear = Number(getYearOfdob) + Number(18);
      const minAgeForCFE = monthDateOfdob + '/' + getMinYear;
      const maxAgeForCFE = monthDateOfdob + '/' + getMaxYear;
      const formatMinAge = moment(minAgeForCFE).format(this.dtformat);
      const formatMaxAge = moment(maxAgeForCFE).format(this.dtformat);


      if (formatStart < formatMinAge || formatStart > formatMaxAge) {
        this._alertService.error('Placement should be allowed for child within the age 4 to 18 to enter the Provider placement with placement structure "CfE Resource Home".');
        return false;
      }
    }
    if (!this.referalDetailsServiceIdFn(referalDetails)) {
      return false;
    }
    return true;
  }
  //Associated with saveReferal function
  private splitTimeFn(referalDetails: any) {
    const referalDate: any = new Date(referalDetails.startdate);
    const referalEndDate: any = referalDetails.enddate ? new Date(referalDetails.enddate) : null;
    const timeSplit = referalDetails.starttime.split(':');
    const timeSplitEndTime = referalDetails.endtime ? referalDetails.endtime.split(':') : null;
    if (timeSplit && Array.isArray(timeSplit) && timeSplit.length >= 2) {
      let referalTimeHour: number = Number(timeSplit[0]);
      const referalTimeMinPlusMeridiem = timeSplit[1];
      const referalTimeMinAndMeridiem = referalTimeMinPlusMeridiem.split(' ');
      const appointmentTimeMin = referalTimeMinAndMeridiem[0];
      const meridiem = referalTimeMinAndMeridiem[1];
      if (meridiem === 'PM') {
        referalTimeHour += 12;
      }
      referalDate.setHours(referalTimeHour);
      referalDate.setMinutes(appointmentTimeMin);
    }

    if (this.isOutOfPlacementSequence && timeSplitEndTime && Array.isArray(timeSplitEndTime) && timeSplitEndTime.length >= 2) {
      let referalEndTimeHour: number = Number(timeSplitEndTime[0]);
      const referalEndTimeMinPlusMeridiem = timeSplitEndTime[1];
      const referalEndTimeMinAndMeridiem = referalEndTimeMinPlusMeridiem.split(' ');
      const appointmentEndTimeMin = referalEndTimeMinAndMeridiem[0];
      const meridiem = referalEndTimeMinAndMeridiem[1];
      if (meridiem === 'PM') {
        referalEndTimeHour += 12;
      }
      referalEndDate.setHours(referalEndTimeHour);
      referalEndDate.setMinutes(appointmentEndTimeMin);
    }

    return { referalDate };
  }
  //Associated with saveReferal function
  private childRemovalHasDateFn(referalDateData: any) {
    // D-07165 Validate: Child removal date should be less than remval date.
    if (this.isChildRemoval && this.childRemovalData && this.childRemovalData[0].hasOwnProperty('removaldate')) {
      const removalDate = new Date(this.childRemovalData[0].removaldate);

      if (referalDateData.referalDate < removalDate) {
        this._alertService.warn('Placement entry begin date should be greater than child removal date.');
        return false;
      }
      return true;
    }

    if (this.minDate && moment(referalDateData.referalDate).isBefore(this.minDate)) {
      this._alertService.error('Placement Begin Date should be greater than ' + moment(this.minDate, moment.ISO_8601).toDate());
      return false;
    }
    return true;
  }

  getpersondetail_res: any;
  getpersondetail() {
    this._ServiceCasePlacementsService.getPersonList().subscribe(result => {
      this.getpersondetail_res = result;
    })
  }
  placementStructureSelect(item: any) {
    this.relationShipDropdownItems = [];
    this.referalForm.patchValue({
      primaryrelationship: null
    });
    if(["11405", "11406", "11407", "11408", "78", "500", "12", "10"].indexOf(item.value) > -1){
      this.referalForm.get('primaryrelationship')?.enable();
      this.referalForm.get('primaryrelationship')?.setValidators([Validators.required]);
      this.showRelDropValue = true
    }else {
      this.referalForm.get('primaryrelationship')?.disable();
      this.referalForm.get('primaryrelationship')?.clearValidators();
      this.showRelDropValue = false;
    }
    this.referalForm.get('primaryrelationship')?.updateValueAndValidity();
    this.selectedPlacementStructure = item.value;
    setTimeout(() => {
        if(this.selectedPlacementStructure != "500" && item.value !== '10'){
            const newRelationObj = this.copyRelationShipDropdownItems.filter((el: any) =>{ return el.sequencenumber == 129 ||
              el.sequencenumber == 130 || el.sequencenumber == 131;})
          this.relationShipDropdownItems = newRelationObj;
          } else if(item.value == '10') {
            const newRelationObj = this.copyRelationShipDropdownItems.filter((el: any) =>{ return el.sequencenumber == 130 || el.sequencenumber == 131 || el.sequencenumber == 132;})
                this.relationShipDropdownItems = newRelationObj;
          }
          else{
            const newRelationObj = this.copyRelationShipDropdownItems.filter((el: any) =>{ return el.sequencenumber == 129 ||
              el.sequencenumber == 130 || el.sequencenumber == 131 || el.sequencenumber == 132;})
            this.relationShipDropdownItems = newRelationObj;
          }
    }, 500);

    this.referalFormValidations(item);
    this.getcomarlistValues();
    this.checkForKinshipValidation();
    this.displayKRDAlert();
  }
  referalFormValidations(item: any){
    if (this.selectedProvider.provider_category_cd !== '1783') {
      this.referalForm.get('ratestructureid')?.disable();
      this.referalForm.get('ratestructureid')?.clearValidators();
      this.referalForm.get('ratestructureid')?.updateValueAndValidity();
      this.comarRateRequired = false;
    } else if (this.selectedProvider.provider_category_cd === '1783' && this.selectedPlacementStructure.comar_sw === 'Y') {
      const placementStructure = this.referalForm.getRawValue().service_id;
      if(placementStructure != '8' && placementStructure != '76') {
        this.referalForm.patchValue({
          ratestructureid: placementStructure
        });
      }

      this.referalForm.get('ratestructureid')?.disable();
      this.referalForm.get('ratestructureid')?.clearValidators();
      this.referalForm.get('ratestructureid')?.updateValueAndValidity();
      this.comarRateRequired = false;
    } else {
      this.referalForm.get('ratestructureid')?.enable();
      this.referalForm.get('ratestructureid')?.setValidators([Validators.required]);
      this.referalForm.get('ratestructureid')?.updateValueAndValidity();
      this.comarRateRequired = true;
    }
    if (item.source.triggerValue === 'Intermediate Foster Care Difficulty of Care') {
      this.referalForm.get('isssaapproval')?.enable();
      this.referalForm.get('ifcapprovaldate')?.enable();
    } else {
      this.referalForm.patchValue({
        ifcapprovaldate: null,
        isssaapproval: false,
      });
      this.referalForm.get('isssaapproval')?.disable();
      this.referalForm.get('ifcapprovaldate')?.disable();
    }
    const placementSt = this.referalForm.getRawValue().service_id;

    if (placementSt != '8' && placementSt != '76') {
      this.referalForm.patchValue({
        ratestructureid: placementSt
      });
    }
    this.referalForm.get('ratestructureid')?.disable();
  }

  loadGenderDropdownItems() {
    this._commonService.create(
      {
        where: { activeflag: 1 },
        method: 'post',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.GenderTypeUrl + '/genderlist'
    ).subscribe((genderList) => {
      this.genderDropdownItems = genderList;
    });
  }
  loadPlacementItems(){
      this._dropDownService.getRelations().subscribe(relations => {
        this.copyRelationShipDropdownItems = JSON.parse(JSON.stringify(relations));
        if (this.referalForm && this.referalForm.getRawValue() && this.referalForm.getRawValue().service_id != "500" && this.referalForm.getRawValue().service_id !== '10') {
          const newRelationObj = this.copyRelationShipDropdownItems.filter((el: { sequencenumber: number; }) => {
              return el.sequencenumber == 129 ||
                  el.sequencenumber == 130 || el.sequencenumber == 131;
          })
          this.relationShipDropdownItems = newRelationObj;
      }  else if(this.referalForm && this.referalForm.getRawValue() && this.referalForm.getRawValue().service_id == '10') {
        const newRelationObj = this.copyRelationShipDropdownItems.filter((el: { sequencenumber: number; }) => {
          return el.sequencenumber == 132 ||
              el.sequencenumber == 130 || el.sequencenumber == 131;
        })
        this.relationShipDropdownItems = newRelationObj;
      } else {
        const newRelationObj = this.copyRelationShipDropdownItems.filter((el: { sequencenumber: number; }) => {
              return el.sequencenumber == 129 ||
                  el.sequencenumber == 130 || el.sequencenumber == 131 || el.sequencenumber == 132;
          })
          this.relationShipDropdownItems = newRelationObj;
      }
    })
  }

  initReferalForm() {
    this.referalForm = this.formBuilder.group({
      sentDate: [null],
      description: [null],
      responseAccepted: [null],
      responseRejected: [null],
      placementStructure: [''],
      ratestructureid: [''],
      startdate: [null],
      starttime: ['08:00'],
      primaryrelationship: [''],
      enddate: [null],
      endtime: ['08:00'],
      isssaapproval: [0],
      ifcapprovaldate: [null],
      remarks: [''],
      leastrestrictiveplacement: [''],
      justification: ['']
    });
    this.referalForm.get('isssaapproval')?.disable();
    this.referalForm.get('ifcapprovaldate')?.disable();
  }





  isdateTimeChanged() {
    this.isDateTime = true;
  }
  getPlacement(page: number) {
    const source = this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: this.paginationInfo.pageSize,
          where: {
            casenumber: this.daNumber
          },
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
      ).pipe(
      map((res) => {
        return {
          data: res.data,
          count: res.count
        };
      }),
      share(),);
    this.placement$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.placementCount$ = source.pipe(pluck('count'));
    }
  }


  // D-07665 Start
  getPlacementWithPersonId(page: number, personidtemp: string) {
    const source = this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: this.paginationInfo.pageSize,
          where: {
            casenumber: this.daNumber,
            personid: personidtemp
          },
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
      ).pipe(
      map((res) => {    // NOSONAR.   // Less than 3 lines of duplicate code. Hence marking it as no sonar.
        return {
          data: res.data,
          count: res.count
        };
      }),
      share(),);
      this.placement$ = source.pipe(pluck('data'));
      if (page === 1) {
        this.placementCount$ = source.pipe(pluck('count'));
      }
  }
  // D-07665 End



  getInvolvedPerson() {
    this.involevedPerson$ = this._commonService
      .getArrayList(
        {
          method: 'get',
          where: this.inputRequest
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data'
      ).pipe(
      map((res: any) => {
        return res['data'].filter((item: { rolename: string; }) => item.rolename === 'CHILD' || item.rolename === 'RC' || item.rolename === 'AV');
      }));
  }




  getResponseRejectedList() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'referencetypeid': 80
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.GetReasonTypes).subscribe(result => {
      this.ResponseRejectedList = result;
    });
  }



  // removePlacementRequest() {
  //     const body = {
  //         'exit_reason_cd': this.exitForm.getRawValue().reasonforexit,
  //         'exit_type_cd': this.exitForm.getRawValue().exitType,
  //         'exit_explanation_tx': this.exitForm.getRawValue().explanation,
  //         'exit_dt': moment(this.exitForm.getRawValue().enddate).format(this.dtformat),
  //         'exit_tm': this.exitForm.getRawValue().endtime
  //     };

  //     this._commonService.patch(this.selectedPlacement.placement_id, body, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.removeplacement).subscribe(result => {
  //         this.selectedChild = null;
  //         this.getPlacement(1);
  //         (<any>$('#exit')).modal('hide');
  //         this._alertService.success('Successfully exited from placement');

  //     });
  // }




  approveOrReject(placementID: string, isApprove: boolean) {
    const request = isApprove ? {
      objectid: placementID,
      eventcode: 'PLTR',
      status: 'Approved',
      comments: this.placementexitapproved,
      notifymsg: this.placementexitapproved,
      routeddescription: this.placementexitapproved,
      v_securityusersid: this.userInfo.user.userprofile.securityusersid
    } : {
        objectid: placementID,
        eventcode: 'PLTR',
        status: 'Rejected',
        comments: this.placementexitrejected,
        notifymsg: this.placementexitrejected,
        routeddescription: this.placementexitrejected,
        v_securityusersid: this.userInfo.user.userprofile.securityusersid
      };

    this._commonService.create(request, CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.approveOrReject)
      .subscribe(result => {
        this.getPlacement(1);
        this._alertService.success(`${isApprove ? 'Approved successfully.' : 'Rejected successfully.'}`);

      });
  }

  approvePlacementRequest(placement: any) {
    const body = {
      'objectid': this.id,
      'eventcode': 'PLAREF',
      'status': 'Approved',
      'comments': this.placementapproved,
      'notifymsg': this.placementapproved,
      'routeddescription': this.placementapproved,
      'approval_status_cd': '3047'
    };
    this._commonService.patch(placement.placement_id, body,
      CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.approvePlacementRequestUrl).subscribe(result => {
        this._alertService.success('Successfully approved placement');
        this.getPlacement(1);
      });
  }

  rejectPlacementRequest(placement: any) {
    this._commonService.patch(placement.placement_id, { 'approval_status_cd': '3281' }
      , CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.rejectPlacementRequestUrl).subscribe(result => {
        this._alertService.success('Successfully rejected placement');
        this.getPlacement(1);
      });
  }


  fcPageChanged(pageEvent: any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getFcProviderSearch();
  }




  resetSearch() {
    this.providerSearchForm.reset();
    this.referalForm.reset();
    this.referalForm.patchValue({
      starttime: '08:00',
      casenumber:this.daNumber
    });

  }
  resetReferal() {
    this.referalForm.reset();
    this.referalForm.patchValue({
      starttime: '08:00',
      casenumber:this.daNumber
    });
  }

  async goToReferal() { //  NOSONAR   // Less than 15 complex codition. Hence marking it as no sonar.
    if (this.selectedProvider.placementstructure == "Regular Foster Care" || this.selectedProvider.placementstructure ==
      "Treatment Foster Care Level 1" || this.selectedProvider.placementstructure == "Treatment Foster Care Level 2"
      || this.selectedProvider.placementstructure == "Treatment Foster Care Level 3" || this.selectedProvider.placementstructure ==
      "Treatment Foster Care Level 4" || this.selectedProvider.placementstructure == "Treatment Foster Care (Private)"
      || this.selectedProvider.placementstructure == "Treatment Foster Care (Public)"
      || this.selectedProvider.placementstructure == "Pre-Finalized Adoptive Home") {
      this.showRelDropValue = true
      this.showchildrealtionshipdropdown = true
    }
    else {
      this.showRelDropValue = false
      this.showchildrealtionshipdropdown = false
    }
    this.isSubmitting = false;

    /**
     * Relevant Kinship types for the child specific placements
     *    8	  Formal Kinship Care
     *    530	Kinship
     *    531	Non-paid Kinship
    */
    //B-202467: adding a child specific agrrement check for placement
    //As requested in the UAT, adding the CSA valication before the vacancy check
    const KINSHIP_PLACEMENT_STRUCTURE_IDS = [8, 530, 531];
    if (this.selectedProvider) {
      let childnotmatch = 0;
      //if no child specific details have been identified, we still want to block kinship placements
      if(this.selectedProvider.csadetails == null) {
        if(this.selectedProvider.provider_category_cd == '1783' &&
          KINSHIP_PLACEMENT_STRUCTURE_IDS.includes(this.selectedProvider.placement_service_id)) {
            (<any>$('#child-specific-agreement-error')).modal('show');
            childnotmatch = childnotmatch + 1;
        }
      }

      //if child specifc details are identified, then we want to check that only the specific children are authorized
      if(this.selectedProvider.csadetails && this.selectedProvider.csadetails.length) {
        childnotmatch = this.handleCsadetailsFn(KINSHIP_PLACEMENT_STRUCTURE_IDS, childnotmatch);
        }

       if (childnotmatch > 0) {
         return;
       }
    }

    //Vacancy check
    if (this.selectedProvider && this.selectedProvider.vacancy < this.selectedChildren.length) {
      (<any>$('#placement-vacancy-error')).modal('show');
      return;
    }
    this.resetReferal();
    this.referalForm.patchValue({
      providersentdate: new Date()
    });

    if (this.selectedProvider.provider_category_cd === '1783') {
      this.referalForm.get('ratestructureid')?.setValidators([Validators.required]);
      this.referalForm.get('ratestructureid')?.updateValueAndValidity();
      this.comarRateRequired = true;
    } else {
      this.referalForm.get('ratestructureid')?.disable();
      this.referalForm.get('ratestructureid')?.clearValidators();
      this.referalForm.get('ratestructureid')?.updateValueAndValidity();
      this.comarRateRequired = false;
    }
    this.getResponseAcceptedList();
    this.getResponseRejectedList();
    if (this.selectedProvider && this.selectedProvider.contract_program_id) {
      this.getPlacementStrTypePvtProv(this.selectedProvider.provider_id);
      this.referalForm.get('service_id')?.disable();
    } else {
      this.getPlacementStrType(this.selectedProvider.provider_id);
      this.referalForm.get('service_id')?.enable();
    }
    this.patchPlacementStructure();
  }
  // Assosiated with goToReferal method
  private handleCsadetailsFn(KINSHIP_PLACEMENT_STRUCTURE_IDS: number[], childnotmatch: number) {
    let authorizedcsapersonids = new Set<string>();
    //kinship child specific authorizaition is not one-to-one so will have to
    //account for multiple children being authorized per provider
    this.selectedProvider.csadetails.forEach((element: { personid: string; }) => {
      authorizedcsapersonids.add(element.personid);
    });

    //we have to make sure each selected child is authorized for the csa kinship placement
    this.selectedChildren.forEach((child, index) => {
      // if( child.personid != csapersonid) {
      // check if any one of the selected chidren for placement is NOT authorized as per the provider csa
      if (!authorizedcsapersonids.has(child.personid)) {
        //Public provider kinship csa
        if (this.selectedProvider.provider_category_cd == '1783') {
          if (KINSHIP_PLACEMENT_STRUCTURE_IDS.includes(this.selectedProvider.placement_service_id)) {
            (<any>$('#child-specific-agreement-error')).modal('show');
            childnotmatch = childnotmatch + 1;
          }
        }

        //Private contract program csa
        else {
          (<any>$('#child-specific-agreement-error')).modal('show');
          childnotmatch = childnotmatch + 1;
        }
      }
    });
    return childnotmatch;
  }

  patchPlacementStructure() {
    // Patch placement Structure
    if (this.selectedProvider) {
      const providerid = this.placementStrType.find(ele => ele.service_nm === this.selectedProvider.placementstructure);
      this.referalForm.patchValue({
        service_id: providerid ? String(providerid.service_id) : null,
      });
      if (providerid && providerid.service_id === 525) {
        this.minBeginDate = new Date(Date.parse('2021-10-02'));
        this.minBeginDate.setHours(0, 0, 0);
        this.maxBeginDate = new Date(Date.parse('2023-10-01'));
        this.maxBeginDate.setHours(0, 0, 0);
      }
      if (!this.primcheck) {
        return false;
      }
      setTimeout(() => {
        const placementSt = this.referalForm.getRawValue().service_id;
        if (!this.comarValueExclude.includes(placementSt)) {
          this.referalForm.patchValue({
            ratestructureid: placementSt
          });
        }
        this.getcomarlistValues();
      }, 500);
      this.checkForKinshipValidation();
      this.displayKRDAlert();
    }
    if (this.selectedProvider && this.selectedProvider.casecounty) {
      const ischildplacedoutside = this.selectedProvider.casecounty === '1' ? false : true;
      this.referalForm.patchValue({ ischildplacedoutside: ischildplacedoutside });
    }
    this.currProcess = 'send';
    this.loadPlacementItems();
  }
  goToSearch() {
    this.resetSearch();
    (<any>$('#fc_search')).click();
  }

  responseSelect(item: any) {
    this.selectedResponseStructure = item.value;
    if (this.selectedResponseStructure === RESPONSE_ACCEPTED_YES) {
      this.isResponseAccepted = true;
      this.referalForm.get('providersentdate')?.setValidators([Validators.required]);
      this.referalForm.get('startdate')?.setValidators([Validators.required]);
      this.referalForm.get('starttime')?.setValidators([Validators.required]);
      this.referalForm.get('rejectreasonkey')?.setValidators(null);
      this.referalForm.get('rejectreasonkey')?.reset();
      this.referalForm.get('remarks')?.setValidators(null);
      this.referalForm.get('leastrestrictiveplacement')?.setValidators(null);
      this.referalForm.patchValue({rejectreasonkey: null});
      this.referalForm.get('rejectreasonkey')?.disable();
      this.approval = true;
    } else {
      this.isResponseAccepted = false;
      this.approval = false;
      this.referalForm.get('providersentdate')?.setValidators(null);
      this.referalForm.get('rejectreasonkey')?.setValidators([Validators.required]);
      this.referalForm.get('remarks')?.setValidators([Validators.required]);
      this.referalForm.get('leastrestrictiveplacement')?.setValidators([Validators.required]);
      this.referalForm.get('providersentdate')?.setErrors(null);
      this.referalForm.get('providersentdate')?.clearValidators();
      this.referalForm.get('startdate')?.setValidators(null);
      this.referalForm.get('startdate')?.setErrors(null);
      this.referalForm.get('startdate')?.clearValidators();
      this.referalForm.get('starttime')?.setValidators(null);
      this.referalForm.get('starttime')?.setErrors(null);
      this.referalForm.get('starttime')?.clearValidators();
      this.referalForm.get('rejectreasonkey')?.enable();
    }
    this.referalForm.get('providersentdate')?.updateValueAndValidity();
    this.referalForm.get('startdate')?.updateValueAndValidity();
    this.referalForm.get('starttime')?.updateValueAndValidity();
  }




  openTitle4e() {
    (<any>$('#title4e')).modal('show');
  }





  private getAge(dateValue: any) {
    if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
      return moment().diff(rCDob, 'years');
    } else {
      return '';
    }
  }


  providerTypeSelected(event: any) {
    if (event.value === '1') {
      this.isPublicProvider = true;
      this.isPrivateProvider = false;
    } else {
      this.isPublicProvider = false;
      this.isPrivateProvider = true;
    }
  }

  scShowPlacement(placement: any) {
    this.selectedPlacement = placement;
    (<any>$('#fc-view')).modal('show');
  }

  getPlacementDates(log: any, isentry: any) {
    if (log && log.length) {
      const event = { date: this.getEventDate(log, isentry),
                      time: this.getEventTime(log, isentry) };
      return event.date + ' ' + event.time;
    } else {
      return '';
    }
  }

  getEventDate(log: any, isentry: any){
    if (isentry === 1) {
      return (log[0].entry_dt) ? log[0].entry_dt : '';
    } else {
      return (log[0].exit_dt) ? log[0].exit_dt : '';
    }
  }

  getEventTime(log: any, isentry: any){
    if (isentry === 1) {
      return (log[0].entry_tm) ? log[0].entry_tm : '';
    } else {
      return (log[0].exit_tm) ? log[0].exit_tm : '';
    }
  }

  pesonDateOfBirth(item: any) {

    this.reportedChildDob = item.value.dob;
    this.intakeservicerequestactorid = item.value.intakeservicerequestactorid;
    this.selectedChild = item.value;
    this.getPlacementWithPersonId(1, this.selectedChild.personid);
    this.placement$.pipe(
      map((res) => {
        const id = item.value.cjamspid;
        const blah = res.find((ite) => (ite.clientid === id && item.placementexitdate));
        if (blah) {
          this.isAddPlacement = false;
        } else {
          this.isAddPlacement = true;
        }
      }))
      .subscribe();
  }

  checkForKinshipValidation() {
    var placmentSturctureID = this.referalForm.getRawValue().service_id;
    if(!placmentSturctureID) {
      placmentSturctureID = String(this.selectedProvider.placement_service_id);
    }
    // 9 is for Restricted (Relative) Foster Care
    // 8 is for Formal Kinship
    if (placmentSturctureID === '9' || placmentSturctureID == '8' ) {
      this.maxDate = new Date(this.KRD_enddate);
     } else if (placmentSturctureID === '530' || placmentSturctureID === '531' ) {
       this.minDate = new Date(this.KRD_startdate);
     } else {
       this.maxDate = new Date();
     }
     this.maxBeginDate = this.maxDate;
  }

  displayKRDAlert() {
    var placmentSturctureID = this.referalForm.getRawValue().service_id;
    if(!placmentSturctureID) {
      placmentSturctureID = String(this.selectedProvider.placement_service_id);
    }
    if (placmentSturctureID === '530' || placmentSturctureID === '531') {
      this.filterCase = 'Kinship or Non-paid Kinship are valid starting ' + moment(this.KRD_startdate).format('MM-DD-YYYY')
      this.confirmUpdate();
     } else if (placmentSturctureID === '9') {
      this.filterCase = 'Restricted Relative placements are invalid later than ' + moment(this.KRD_enddate).format('MM-DD-YYYY');
      this.confirmUpdate();
     } else if (placmentSturctureID === '8') {
      this.filterCase = 'Formal Kinship Care placements are invalid later than ' + moment(this.KRD_enddate).format('MM-DD-YYYY');
      this.confirmUpdate();
     }
  }

  luggagebuttonreset(value: any){

    if(value ===1){

      this.referalForm.patchValue({
        plluggagepurchased :null,
        plluggagecomments:null,
        placementdisposableortrashbag :null

      })

      const plluggagepurchasedTemp: any = this.referalForm.get('plluggagepurchased');
      plluggagepurchasedTemp.clearValidators();
      plluggagepurchasedTemp.updateValueAndValidity();

    }
      if(value ===2){
        this.referalForm.patchValue({

          plluggagecomments:null

        })

      }

      const luggagecomments: any = this.referalForm.get('plluggagecomments');
      const placementdisposableortrashbag: any = this.referalForm.get('placementdisposableortrashbag');
      luggagecomments.clearValidators();
      luggagecomments.updateValueAndValidity();
      placementdisposableortrashbag.clearValidators();
      placementdisposableortrashbag.updateValueAndValidity();
  }

}
