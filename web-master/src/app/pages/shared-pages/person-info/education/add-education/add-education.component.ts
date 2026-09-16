import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit, Output, EventEmitter, Input, ViewChild, Injector } from '@angular/core';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DataStoreService, CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { PersonInfoService } from '../../person-info.service';
import { EducationInfoService } from '../education.service';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { NavigationUtils } from '../../../../_utils/navigation-utils.service';
import moment from 'moment';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { CommonUrlConfig } from '../../../../../../app/@core/common/URLs/common-url.config';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'add-education',
    templateUrl: './add-education.component.html',
    styleUrls: ['./add-education.component.scss'],
    standalone: false
})
export class AddEducationComponent implements OnInit {

  @Input()
  isEdit:boolean = false;
  _childremovaldates: any = [];
  additionalobjecttype: string = "";
  expandQtrReportCrds: boolean = false;
  retryobjecttype: string = "";
  get childremovaldates(): any {
      return this._childremovaldates;
  }

@Input() set childremovaldates(details: any) {
    if (details) {
        this._childremovaldates = details;
    } else {
      this._childremovaldates = [];
    }
}
  isdelayinenrollmentReq: boolean = false;
  isEnrollmentdateDisabled: boolean = false;
  personId: any;
  data: any[] = [];
  educationInstitutions: any[] = [];
  filteredEducationInstitutions: any[] = [];
  isentered :boolean = false;
  isSpecialEducation = false;
  disableEnroll = false;
  editflag = false;
  mandatoryField:boolean=false;
  mandatoryField1:boolean=false;
  isEdited:boolean = false;
  id: string='';
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  schoolTypeDropdownItems$!: Observable<DropdownModel[]>;
  educationProgramDropdownItems$!: Observable<DropdownModel[]>;
  schoolSettingDropdownItems$!: Observable<DropdownModel[]>;
  transportmodetypeDropdownItems$!: Observable<DropdownModel[]>;
  typeofclassDropdownItems$!: Observable<DropdownModel[]>;
  gradeDropdownItems$!: Observable<DropdownModel[]>;
  specialEducationInDensityDropdownItems$!: Observable<DropdownModel[]>;
  testnameDropdownItems$!: Observable<DropdownModel[]>;
  schoolSpDropdownItems$!: Observable<DropdownModel[]>;
  schoolExitReasonDropdownItems$!: Observable<DropdownModel[]> 
  disciplinaryActionDropdownItems$!: Observable<DropdownModel[]>;
  schoolEnrollmentDropdownItems$!: Observable<DropdownModel[]>;
  schoolAdjustmentDropdownItems$!: Observable<DropdownModel[]>;
  educationStartDate: any;
  isEndDateEntered:boolean = false;
  placementList: any[] = [];
  selectedItem: any = null;
  showdropdown:boolean = true;
  originalPlacements: any[] = [];
  originalEditPlacements: any[] = [];
  disableAddDetermination: boolean = true;
  bidRequiredEndDate: boolean = false;
  bestDeterminationList: any[] = [];
  educationalertList: any[] = []
  showBestDeterminationForm : boolean = false;
  disableBestDeterminationForm : boolean = false;
  @Input()
  requiredForApproval!: boolean;
  dateFormat = 'MM/DD/YYYY';
  datFormatWithTime = 'MM/DD/YYYY hh:mm:ss A';
  defaultList = ['CFCP', 'Dropped Out', 'Expelled', 'Graduated', 'Promoted', 'Repeating Grade', 'Transferred', 'Withdrawn'];
  transferredDue = 'Transferred-due to foster care placement';
  currentlyEnrolled = 'Currently Enrolled';
  bestInterestDeterminationForm :any= {
    bidDate: null,
    placementstructuredesc: null,
    placement_type: null,
    placementname: null,
    provider_name: null,
    address: null,
    exit_date: null,
    placementid: null,
    determinationvalue: null,
    placementdate: null,
    updatedon: null,
    updatedby: null
  };
  educationAlertForm :any= {
    personeducationalertactionid:null,
    reasoncode:null,
    actiontype:null,
    hidedropdown :null,
    stopdropdown :null,
    startdate:null,
    enddate :null,
    endreason:null,
    updatedon: null,
    updatedby: null

  };
  userInfo!: AppUser;
  additionalobjectid!: string;
  today = new Date();
  dd = this.today.getDate();
  mm = this.today.getMonth();
  yyyy = this.today.getFullYear();
  maxDate = new Date(this.yyyy, this.mm, this.dd);
  maximumDate: Date = new Date();
  toMinDate!: Date
  load:boolean = false;
  personEducationFormGroup!: FormGroup;
  @Output() addflag: EventEmitter<boolean> = new EventEmitter();
  gradeDropdownItems!: any[];
  schoolexitreasondropdown!: any[];
  highestgradeDropdownItems!: any[];  

  addalert:boolean = false;
  holdalertdropdown :any;
  stopalertdropdown :any;
  holdchkbox:any;
  stopchkbox :any;
  edualertmindate :any;
  disableeducationalertform :boolean = false;
  currentdate = new Date();
  holdalert: boolean = true;
  edualerteditflag :boolean = false;
  addnewalert :boolean = true;
  uploadedFiles1:any = [];
  uploadedFiles2 :any= [];
  uploadedFiles3 :any= [];
  uploadedFiles4 :any= [];
  uploadNumber = '123434';
  currentDate: Date = new Date();
  isClosed = false;
  delayinenrollments: any = [];
  attendanceInfos: any = [];
  persistedStartDate: any = null;
  placementIds: any = [];
  bidadded = 0;
  states: any[] = [];
  counties: any[] = [];
  @ViewChild(DocumentUploadListSharedComponent) documentuploaded!: DocumentUploadListSharedComponent;
  @Input() set cachedEducationalInfo(value: any) {
    if (value) {
      if (!this.isEdit && value.latestChangeInSchool) {
        this.bestDeterminationList = [value.latestChangeInSchool];
      }
      if (value.placementIds && value.placementIds.length > 0) {
        this.placementIds = value.placementIds;
      }
    }
  }
  address = { address1: null, address2: null, city: null, state: null, county: null, zipcode: null, disable: false, countyRefId: null };
  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _commonDropdownService: CommonDropdownsService;
  private _alertSevice: AlertService;
  public _personInfoService: PersonInfoService;
  private _dataStoreService: DataStoreService;
  private _educationInfoService: EducationInfoService;
  private _navigationUtils: NavigationUtils;
  public _authService: AuthService;
  private route: ActivatedRoute;
  retrydoc: any = false;
  constructor(private injector: Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._educationInfoService = this.injector.get<EducationInfoService>(EducationInfoService);
    this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
    });
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personeducation');
    this.userInfo = this._authService.getCurrentUser();
    const personInfo = this._personInfoService.getPersonInfo();
    if (personInfo && personInfo.personbasicdetails) {
      this.educationStartDate = personInfo.personbasicdetails.dob ? new Date(personInfo.personbasicdetails.dob) : null;
    }
    this.initiateFormGroup();
    this.loadDropDown();
    this.loadEducationInstitutionList();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.personId = this._personInfoService.getPersonId();
    this._educationInfoService.selectedEducation$.subscribe(data => {
      if (data && !this.isentered) {
        this.editEducation(data);
        if(this.bestDeterminationList.length > 0 && this.bestDeterminationList.find((item:any) => item.determinationvalue === 0)){
          this.disableEnroll = true;
        } else {
          this.disableEnroll = false;
        }
      }
    });
    this.edualertmindate = moment(new Date()).format(this.dateFormat);
    this.holdalert = true;
    this.currentdate = (new Date());
    this._commonDropdownService.getReferenveValuesByTypeId('10000')
      .subscribe( (response) => {
        response.sort(function (a, b) {
          return a.displayorder - b.displayorder;
        });
        this.delayinenrollments = response
      });
      this.stateDropdownItems$.subscribe(data => {
        this.states = data;
     });
     

      this.route.queryParams.subscribe(params => {
        if(params['retrydocument'] == "true") {
        this.expandQtrReportCrds = true;
        // the quarter of the file being retried, forwarded by UploadSharedService. Without it
        // the expanded/auto-opened panel would be whichever quarter loaded last, not the one retried.
        this.retryobjecttype = params['retryobjecttype'] ? params['retryobjecttype'] : "";
        if (this.retryobjecttype) {
          this.additionalobjecttype = this.retryobjecttype;
        }
        }
      });
  }

  private initiateFormGroup() {
    this.personEducationFormGroup = this._formBuilder.group({
      personid: [null],
      personEducation: this._formBuilder.group({
        personeducationid: [null],
        educationname: [null],
        educationtypekey: [null],
        schoolsettingtypekey: [null],
        transportmodetypekey: [null],
        transportmodetypedetail: [null],
        delayinenrollment: [null],
        delayinenrollmentdetail: [null],
        adrcityname: [null],
        adresscounty: [null],
        statecode: [null],
        startdate: [null],
        enrollmentdate: [null],
        enddate: [null],
        contactname: [null],
        adrworkphone: [null],
        adrworkxtn: [null],
        schoolschedule: [null],
        schooladjustment: [null],
        isspecialeducation: [null, Validators.required],
        specialeducationtypekey: [null],
        lastiepdate: [null],
        lastifspdate: [null],
        numberofabsences: [null],
        isreceived: [null],
        isverified: [null],
        isexcused: [null],
        extracurricular: [null],
        sasidno: [null],
        firstqtrabsence: [null],
        nonewenrollment: [null],
        firstqtrabsenceexcused: 0,
        firstqtrabsencenotexcused: 0,
        firstqtrabsencetardy: 0,
        secondqtrabsence: [null],
        secondqtrabsenceexcused: 0,
        secondqtrabsencenotexcused: 0,
        secondqtrabsencetardy: 0,
        thirdqtrabsence: [null],
        thirdqtrabsenceexcused: 0,
        thirdqtrabsencenotexcused: 0,
        thirdqtrabsencetardy: 0,
        fourthqtrabsence: [null],
        fourthqtrabsenceexcused: 0,
        fourthqtrabsencenotexcused: 0,
        fourthqtrabsencetardy: 0,
        summerschoolname: null,
        highestgradetypekey: null,
        currentgradetypekey: null,
        lastgradetypekey: null,
        schoolenrolltypekey: null,
        classtypetypekey: null,
        currentgradelevel: null,
        functioninggradelevel: null,
        lastgradelevel: null,
        firstqtrperformancetypekey: null,
        secondqtrperformancetypekey: null,
        thirdqtrperformancetypekey: null,
        fourthqtrperformancetypekey: null,
        speacialeducationrestrictivekey: null,
        lastattendeddate: null,
        schoolexitcomments: null,
        schoolchangereason: null,
        disciplinaryactioncomments: null,
        statustypekey: null
      }),
      personAccomplishment: this._formBuilder.group({
        personaccomplishmentid: [null],
        highestgradetypekey: [null],
        accomplishmentdate: [null],
        isrecordreceived: [null],
        receiveddate: [null]
      }),

      personEducationTesting: this._formBuilder.group({
        personeducationtestingid: [null],
        testingtypekey: [null],
        readinglevel: [null],
        readingtestdate: [null],
        testingprovider: [null]
      })



    });

    this.bestInterestDeterminationForm = {
      bidDate: null,
      placementstructuredesc: null,
      placement_type: null,
      placementname: null,
      provider_name: null,
      address: null,
      exit_date: null,
      placementid: null,
      determinationvalue: null,
      placementdate: null,
      updatedon: null,
      updatedby: null
    }
   this. educationAlertForm = {
    personeducationalertactionid:null,
    reasoncode:null,
    actiontype:null,
      hidedropdown :null,
      stopdropdown :null,
      startdate:null,
      enddate :null,
      endreason:null,
      updatedon: null,
      updatedby: null
  }
  if (this.isClosed || !this._authService.isPersonSubTabViewable('person','person.Education.add')) {
      this.personEducationFormGroup.disable();
  }

  }

  uploadclosed(event:any){
    if(event){
    this.documentuploaded.closeupload();
    this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  private loadDropDown(model?: any) {
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.educationProgramDropdownItems$ = this._commonDropdownService.getPickListByName('educationprogram');
    this.schoolTypeDropdownItems$ = this._commonDropdownService.getPickListByName('schooltype');
    this.schoolSettingDropdownItems$ = this._commonDropdownService.getPickListByName('schoolsettings');
    this.transportmodetypeDropdownItems$ = this._commonDropdownService.getPickListByName('educationaltransportation');
    this.typeofclassDropdownItems$ = this._commonDropdownService.getPickListByName('classtype');
    this.specialEducationInDensityDropdownItems$ = this._commonDropdownService.getPickListByName('specialeducationindensity');
    this.gradeDropdownItems$ = this._commonDropdownService.getPickListByName('gradelevel');
    this.schoolExitReasonDropdownItems$ = this._commonDropdownService.getPickListByName('educationstatus','CW');
    this.disciplinaryActionDropdownItems$ = this._commonDropdownService.getPickListByName('disciplinaryactions');
    this.testnameDropdownItems$ = this._commonDropdownService.getPickListByName('assessmenttest');
    this.schoolSpDropdownItems$ = this._commonDropdownService.getPickListByName('schoolspecialeducation');
    this.schoolAdjustmentDropdownItems$ = this._commonDropdownService.getPickListByName('schooladjustment');
    this.schoolEnrollmentDropdownItems$ = this._commonDropdownService.getPickListByName('schoolenroll');
    this.gradeDropdownItems$.subscribe((data: any) => {
      const list = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
        'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'GED', 'KDGN',
        'NIS', 'PSET', 'PSHS', 'UNK'];
      this.gradeDropdownItems = [];
      list.forEach(item => {
        const obj = this.returnCommonLoopDataFn(data, item);
        this.gradeDropdownItems.push(obj);
      });
    });
    this.gradeDropdownItems$.subscribe((data: any) => {
      const highestlist =  ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
      'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'GED','KDGN',
      'NIS', 'PSET', 'PSHS'];
       this.highestgradeDropdownItems = [];
       highestlist.forEach(item => {
         const highobj = data.find((ele:any) => ele.ref_key === item);
         this.highestgradeDropdownItems.push(highobj);
       });
    });
    this.schoolExitReasonDropdownItems$ .subscribe((data: any) => {
      this.schoolexitreasondropdown = [];
      this.defaultList.forEach(item => {
        const obj = this.returnCommonLoopDataFn(data, item);
        this.schoolexitreasondropdown.push(obj);
      });
      if (model && model.personEducation) {
        this._commonHttpService
        .post({
          personeducationid: model.personEducation.personeducationid
        }, 'personeducation_att_history/list')
        .subscribe((attResponse) => {
          if (attResponse && attResponse.length > 0) {
            attResponse.forEach((e: any) => {
              e.schoolexitreason = this.schoolexitreasondropdown.find((ele: any) => ele.ref_key === e.statustypekey).description;
            });
            this.attendanceInfos =  this.attendanceInfos.filter((value:any, index:any, self:any) =>
                    index === self.findIndex((t: any) => (
                      t.startdate === value.startdate
                    ))
                  );
          } else {
            this.attendanceInfos = [];
          }
        });
      }
    });
    this._commonHttpService
        .getArrayList(
            {
                where: { referencetypeid: 589, teamtypekey: 'CW' },
                method: 'get'
            },
            'referencetype/gettypes' + '?filter'
        ).subscribe ( (data) => {
            this.holdalertdropdown = data;

        });
        this._commonHttpService
        .getArrayList(
            {
                where: { referencetypeid: 590, teamtypekey: 'CW' },
                method: 'get'
            },
            'referencetype/gettypes' + '?filter'
        ).subscribe ( (data) => {
            this.stopalertdropdown = data;

    });
  }
  
  loadEducationInstitutionList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 100000,
      method: 'get'
    }, CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.schoollistreference + '?filter').subscribe((res: any) => {
      this.educationInstitutions = res ? JSON.parse(JSON.stringify(res)) : [];
      this.filteredEducationInstitutions = res ? res : [];
    });
  }
  updateAddress(values: any){
    this.selectedAddress(values);
  }
  getSuggestednames() {
    const educationname = this.personEducationFormGroup.controls.personEducation.value.educationname
    if (educationname) {
      this.filteredEducationInstitutions = this.educationInstitutions.filter((c: any) => c.schoolname.toLowerCase().startsWith(educationname.toLowerCase()))
    } else{
      this.filteredEducationInstitutions = this.educationInstitutions;
      const personEduForm = this.personEducationFormGroup.controls.personEducation;
      personEduForm.patchValue({
        adrworkphone: null
      });
      const addressInfo = {
        address1: null,
        address2: null,
        adrcityname: null,
        statecode: null,
        adresscountydesc: null,
        countyRefId: null,
        zipcode: null
      }
      this.setSmartyStreetAddress(addressInfo);
    }
  }
  selectedAddress(selectedData:any){
    if (selectedData) {
      let state = this.states.find((e: any) => e.value_text === selectedData.state);
      const state_refKey = state?.ref_key ? state?.ref_key : selectedData?.state;
      this._commonDropdownService.getPickListByMdmcode(state_refKey).subscribe(countyList => {
        this.counties = countyList;
        let country = this.counties.find((e: any) => e.value_text === selectedData.county);
        const personEduForm = this.personEducationFormGroup.controls.personEducation;
        personEduForm.patchValue({
          statecode: state?.ref_key,
          adresscounty: country?.ref_key
        });
        if (selectedData?.phoneno) {
          personEduForm.patchValue({
            adrworkphone: selectedData?.phoneno
          });
        } const addressInfo = {
          address1: selectedData?.address1,
          address2: selectedData?.address2,
          adrcityname: selectedData?.city,
          statecode: state_refKey,
          adresscountydesc: selectedData?.county,
          countyRefId: country?.ref_key,
          zipcode: selectedData?.zipcode
        }
        this.setSmartyStreetAddress(addressInfo);
      });
    }
  }
  loadBestDeterminationPlacements(personeducationid: any) {
    this._commonHttpService.getById(personeducationid, 'personeducation/geteducationplacements').subscribe((response) => {
      this.placementList = [];
      if (response?.geteducationplacements?.length > 0 && this.placementIds?.length > 0) {
        response.geteducationplacements = response.geteducationplacements.filter((e: any) => (!this.placementIds.includes(e.placementid)));
      }
      this.loadBestDeterminationPlacementsFn(response);
    });
  }

  private loadBestDeterminationPlacementsFn(response: any) {
    this.originalPlacements = response ? this.geteducationplacementsConditionFn(response) : [];
    this.originalEditPlacements = response ? this.geteducationplacementsConditionFn(response) : [];
    if (this.originalPlacements.length > 0) {
      this.disableAddDetermination = false;
    }
    this.originalPlacements.map((x:any) => { x.entry_date = moment(new Date(x.entry_date)).format(this.dateFormat); });
    if (this.bestDeterminationList?.length > 0) {
      this.bestDeterminationListIfConditionFn();
    } else {
      this.placementList = [...this.originalPlacements];
    }
  }

  private geteducationplacementsConditionFn(response: any): any {
    return response.geteducationplacements ? response.geteducationplacements : [];
  }

  private bestDeterminationListIfConditionFn() {
    if (this.originalPlacements?.length) {
      if (this.bestDeterminationList.length === this.originalPlacements.length) {
        this.disableAddDetermination = true;
      }
    }
    this.bestDeterminationList.map((element:any, i:any) => {
      let placement = null;
      placement = this.originalPlacements.find((pl:any) => { return pl.placementid !== element.placementid; });
      if (placement) {
        this.placementList.push(placement);
      }
    });
  }

  loadCounty(state:any) {
    this._commonDropdownService.getPickListByMdmcode(state).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }
  getValidationMessage(controlName:string,displayname:string){
    if(this.personEducationFormGroup?.get(`personEducation.${controlName}`)?.status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}
    getValidationMessage1(controlName:string,displayname:string){
      if(this.personEducationFormGroup.get(`personAccomplishment.${controlName}`)?.value == null )
      {
          return 'Please  '+displayname;
      }}
  checkAttDate() {
    if (this.personEducationFormGroup.value && this.personEducationFormGroup.value.personEducation && this.personEducationFormGroup.value.personEducation.enrollmentdate && this.personEducationFormGroup.value.personEducation.startdate  && (new Date(this.personEducationFormGroup.value.personEducation.startdate).getTime() < new Date(this.personEducationFormGroup.value.personEducation.enrollmentdate).getTime())) {
      this._alertSevice.error('Attendance start date should be equal or greater than the Enrollment date.');
      return true;
    }
    return false;
  }
  addOrUpdatePersonEducation(type:any) {
    if (type == 'personEducation') {
      this.mandatoryField = true;
    }
    if (type == 'personAccomplishment') {
      this.mandatoryField1 = true;
    }
    if (this.personEducationFormGroup.invalid) {
      return;
    }
    if (this.checkAttDate()) {
      return;
    }
    this.editflag = false;
    this.personEducationFormGroup.patchValue({ personid: this.personId });
    const data = this.personEducationFormGroup.getRawValue();
    const personEducation:any = [];
    const personAccomplishment = [];
    const personEducationTesting = [];
    const eduationAlert = [];
    const objectID = this._navigationUtils.getNavigationInfo().sourceID;
    const objectType:any = this._navigationUtils.getModuleType();
    if (type === 'personEducation') {
      this.personEducationIfConditionFn(data, objectID, objectType, personEducation);
    } else if (type === 'personAccomplishment') {
      personAccomplishment.push(data.personAccomplishment);
    } else if (type === 'personEducationTesting') {
      personEducationTesting.push(data.personEducationTesting);
    }
    this.personEducationDataFormat(data, type, personEducation, personAccomplishment, personEducationTesting);
  }

  private personEducationDataFormat(data: any, type: any, personEducation: any[], personAccomplishment: any[], personEducationTesting: any[]) {
    data.personEducation.firstqtrabsence = (data.firstqtrabsence) ? 1 : 0;
    data.personEducation.secondqtrabsence = (data.secondqtrabsence) ? 1 : 0;
    data.personEducation.thirdqtrabsence = (data.thirdqtrabsence) ? 1 : 0;
    data.personEducation.fourthqtrabsence = (data.fourthqtrabsence) ? 1 : 0;
    data.personEducation.nonewenrollment = (data.personEducation.nonewenrollment) ? true : false;

    data.submittype = type;
    data.personEducation.startdate = moment(new Date(data.personEducation.startdate)).format(this.dateFormat);
    if (personEducation.length == 0) {
      personEducation.push(data.personEducation);

    }
    data.personEducation = personEducation;
    data.personAccomplishment = personAccomplishment;
    data.personEducationTesting = personEducationTesting;
    if ((!this.showdropdown) || (data?.personEducation?.length && data.personEducation[0].statustypekey !== 'Unknown' && data.personEducation[0].statustypekey !== this.transferredDue && data.personEducation[0].statustypekey !== 'Suspended' && data.personEducation[0].statustypekey !== this.currentlyEnrolled)) {
      this.showdropdownCheckIfConditionFn(data);
    } else {
      this._alertSevice.error('Please select new values from School Exit Reason Dropdown');
    }
  }

  private showdropdownCheckIfConditionFn(data: any) {
    data.personEducation[0].schooladdress1 = this.address?.address1;
    data.personEducation[0].schooladdress2 = this.address?.address2;
    data.personEducation[0].adrcityname = this.address?.city;
    data.personEducation[0].statecode = this.address?.state;
    data.personEducation[0].adresscounty = this.address?.countyRefId;
    data.personEducation[0].schoolzipcode = this.address?.zipcode;
    data.personEducation[0].bidadded = this.bidadded;
    this._educationInfoService.saveEducationInfo(data).subscribe((response:any) => {
      this.bidRequiredEndDate = false;
      this._alertSevice.success('Education Details Saved Successfully.');
      this._educationInfoService.isShowAddEducationEnabled(false);
    },
      error => {
        this._alertSevice.error('Error In Saving Education Details.');
      }
    );
  }

  private personEducationIfConditionFn(data: any, objectID: string, objectType: string, personEducation: any[]) {
    if (data.personEducation.isreceived == '1') {
      data.personEducation.isreceived = true;
      data.personEducation.isverified = null;
      data.personEducation.isexcuesed = null;
    } else if (data.personEducation.isreceived == '0') {
      data.personEducation.isverified = true;
      data.personEducation.isreceived = null;
      data.personEducation.isexcuesed = null;
    } else if (data.personEducation.isreceived == '2') {
      data.personEducation.isexcuesed = true;
      data.personEducation.isreceived = null;
      data.personEducation.isverified = null;
    }
    if (this.bestDeterminationList.length > 0 && this.bestDeterminationList.find((item:any) => item.determinationvalue === 0)) {
      this.disableEnroll = true;
    } else {
      this.disableEnroll = false;
    }
    data.personEducation.objectid = objectID;
    data.personEducation.objecttype = objectType;
    data.personEducation['bestdetermination'] = {
      bestDeterminationList: []
    };
    this.bestDeterminationList.forEach((element:any) => {
      delete element["placementstructuredesc"];
      delete element["placementname"];
      delete element["placement_type"];
      delete element["exit_date"];
      delete element["address"];
      delete element["provider_name"];
      data.personEducation['bestdetermination'].bestDeterminationList.push(element);
    });
    this.saveeducationalert();
    data.personEducation['educationalert'] = this.educationalertList;
    personEducation.push(data.personEducation);
  }

  getEducation() {
    this.personEducationFormGroup.controls['personid'].setValue = this._personInfoService.getPersonId();
  }

  incrementButton(FormControlName: any) {
    this.personEducationFormGroup.controls.personEducation.patchValue({ FormControlName: 10 });
  }

  bestDeterminationPlacementChange(event:any) {
    const placementInfo = this.placementList.find((item:any) => item.placementid === event.value);
    this.bestInterestDeterminationForm.placement_type = placementInfo.placement_type;
    this.bestInterestDeterminationForm.placementdate = placementInfo.entry_date;
    this.bestInterestDeterminationForm.exit_date = placementInfo.exit_date;
    this.bestInterestDeterminationForm.address = placementInfo.address;
    this.bestInterestDeterminationForm.placementstructuredesc = placementInfo.placementstructuredesc;
    this.bestInterestDeterminationForm.provider_name = placementInfo.provider_name;
    this.bestInterestDeterminationForm.updatedby = this.userInfo.user.userprofile.fullname;
    this.bestInterestDeterminationForm.updatedon = moment(new Date()).format(this.datFormatWithTime);
  }
  edit(modal:any, i:any) {
    this.disableBestDeterminationForm = false;
    this.showBestDeterminationForm = true;
    this.placementList = this.originalEditPlacements;

    this.bestInterestDeterminationForm = {...modal};
  }

  view(modal:any) {
    this.disableBestDeterminationForm = true;
    this.showBestDeterminationForm = true;
    const placement = this.originalPlacements.find((pl :any)=> { return pl.placementid === modal.placementid});
    if(placement){
    this.placementList.push(placement);
    }
    this.bestInterestDeterminationForm = {...modal};
  }

  deleteConfirm(item:any, index:any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedItem = item;
  }

  resetForm() {
    // No content to add or call
  }

  delete() {
    let index :any= null;
    this.bestDeterminationList.map((element:any, i:any) => {
      if(element.placementid === this.selectedItem.placementid) {
        index = i;
      }
    });
    if (index > -1) {
      this.bestDeterminationList.splice(index, 1);
    }
    const placement = this.originalPlacements.find((pl:any )=> { return pl.placementid === this.selectedItem.placementid});
    if(placement){
    this.placementList.push(placement);
    }
    this.selectedItem = null;
  }

  addBestDetermination(){
    this.showBestDeterminationForm = true;
    this.disableBestDeterminationForm = false;
    this.bestInterestDeterminationForm = {
      placementstructuredesc: null,
      placement_type: null,
      bidDate: null,
      address: null,
      placementname: null,
      provider_name: null,
      exit_date: null,
      placementid: null,
      determinationvalue: null,
      placementdate: null,
      updatedon: null,
      updatedby: null
    }
    this.placementList = [];
    if(this.bestDeterminationList && this.bestDeterminationList.length && this.bestDeterminationList.length > 0){

      this.placementList = this.originalPlacements;
      let index:any = null;
      this.originalPlacements.forEach((pl:any,i:any) => {
        this.bestDeterminationList.forEach((element:any )=> {
          if(element.placementid === pl.placementid) {
            index = i;
          } else {
            index = null;
          }
        });
        if (typeof(index) == 'number') {
          this.placementList.splice(index, 1);
        }
      });
    }
      else{
        this.placementList = [...this.originalPlacements];
      }
  }

  saveBestDetermination() {
    this.showBestDeterminationForm = false;
    const checkExist = this.bestDeterminationList.filter((item:any) => item.placementid === this.bestInterestDeterminationForm.placementid)
    if(checkExist.length > 0) {
      this.checkExistIfConditionFn();
    } else {
      this.checkExistElseConditionFn();
    }
    if(this.bestInterestDeterminationForm.determinationvalue === 1 && !this.getformvalues('personEducation','enddate')){
      (<any>$('#change-school-popup')).modal('show');
      }
    if(this.bestDeterminationList.length > 0 && this.bestDeterminationList.find((item:any) => item.determinationvalue === 0)){
      this.disableEnroll = true;
    } else {
      this.disableEnroll = false;
    }
    this.setDelayiInEnrollmentRequiredStatus();
    this.bestInterestDeterminationForm = {
      bidDate: null,
      placement_type: null,
      placementstructuredesc: null,
      address: null,
      placementname: null,
      provider_name: null,
      exit_date: null,
      placementid: null,
      determinationvalue: null,
      placementdate: null,
      updatedon: null,
      updatedby: null
    };
    this.bidadded = 1;
  }

  private checkExistElseConditionFn() {
    let index = -1;
    this.placementList.map((element:any, i:any) => {
      if (element.placementid === this.bestInterestDeterminationForm.placementid) {
        index = i;
      }
    });
    if (index > -1) {
      this.placementList.splice(index, 1);
    }
    this.bidRequiredEndDate = true;
    this.bestDeterminationList.push(this.bestInterestDeterminationForm);
  }

  private checkExistIfConditionFn() {
    this.bestDeterminationList.map((element:any) => {
      if (element.placementid === this.bestInterestDeterminationForm.placementid) {
        element.determinationvalue = this.bestInterestDeterminationForm.determinationvalue;
        element.updatedby = this.userInfo.user.userprofile.fullname;
        element.updatedon = moment(new Date()).format(this.datFormatWithTime);
      }
    });
    let index = -1;
    this.placementList.map((element:any, i:any) => {    // NOSONAR `    // This function has less than 3 lines of identical code. Hence marking it as NO sonar
      if (element.placementid === this.bestInterestDeterminationForm.placementid) {
        index = i;
      }
    });
    if (index > -1) {
      this.placementList.splice(index, 1);
    }
  }

  cancelBestDetermination() {
    this.showBestDeterminationForm = false;
    this.bestInterestDeterminationForm = {
      bidDate: null,
      placementstructuredesc: null,
      placement_type: null,
      address: null,
      placementname: null,
      provider_name: null,
      exit_date: null,
      placementid: null,
      determinationvalue: null,
      placementdate: null,
      updatedon: null,
      updatedby: null
    }
    this.placementList = [];
    if(this.bestDeterminationList && this.bestDeterminationList.length && this.bestDeterminationList.length > 0){
      this.bestDeterminationList.map((element:any, i:any) => {
        let placement = null;
        placement = this.originalPlacements.find((pl:any) => {return pl.placementid !== element.placementid});
        if(placement){
        this.placementList.push(placement);
        }
      });
      }
      else{
        this.placementList = [...this.originalPlacements];
      }
      this.bidadded = 0;
  }

  editEducation(model:any) {
  
    this.isentered = true;
    this.editflag = true;
    this.loadCounty(model.personEducation.statecode);
    const elmnt :any= document.getElementById('tab_content');
    elmnt.scrollIntoView();
    this.personEducationConditionFn(model);
    if (this.editflag) {
      this.getformvalues('personEducation', 'nonewenrollment');
      this.isEnrollmentdateDisabled = model.personEducation?.nonewenrollment;
    }
    if (model.personAccomplishment) {
      if (model.personAccomplishment.isrecordreceived !== null) {
        if(model.personAccomplishment.isrecordreceived){
          model.personAccomplishment.isrecordreceived = model.personAccomplishment.isrecordreceived = "1"
        } else {
          model.personAccomplishment.isrecordreceived =  model.personAccomplishment.isrecordreceived = "0"
        }
      }
      this.personEducationFormGroup.controls['personAccomplishment'].patchValue(model.personAccomplishment);
    }
    if (model.personEducationTesting) {
      this.personEducationFormGroup.controls['personEducationTesting'].patchValue(model.personEducationTesting);
    }
    this.gradeDropdownItems$.subscribe((data: any) => {
      if (model.personEducation.highestgradetypekey !== 'UNK' && model.personEducation.highestgradetypekey !== 'PSHS') {
        const highestlist = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
          'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'GED', 'KDGN',
          'NIS', 'PSET'];
        this.highestgradeDropdownItems = [];
        highestlist.forEach(item => {
          const highobj = data.find((ele :any)=> ele.ref_key === item);
          this.highestgradeDropdownItems.push(highobj);
        });
      }
      else if (model.personEducation.highestgradetypekey === 'UNK') {
        const highestlist = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
          'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'GED', 'KDGN',
          'NIS', 'PSET', 'UNK'];
        this.highestgradeDropdownItems = [];
        highestlist.forEach(item => {
          const highobj = data.find((ele:any) => ele.ref_key === item);
          this.highestgradeDropdownItems.push(highobj);
        });

      }
      else if (model.personEducation.highestgradetypekey === 'PSHS') {
        const highestlist = ['GDO', 'GDTW', 'GDTH', 'GDFO', 'GDFI', 'GDSI',
          'GDSE', 'GDEI', 'GDNI', 'GDTE', 'GDEL', 'GDTWL', 'COL', 'GED', 'KDGN',
          'NIS', 'PSET', 'PSHS'];
        this.highestgradeDropdownItems = [];
        highestlist.forEach(item => {
          const highobj = data.find((ele:any )=> ele.ref_key === item);
          this.highestgradeDropdownItems.push(highobj);
        });

      }
    });
    this.schoolExitReasonDropdownItemsFn(model);
    this.personEducationDocumentConditionFn(model);
    const addressInfo = {
      address1: model?.personEducation?.schooladdress1,
      address2: model?.personEducation?.schooladdress2,
      adrcityname: model?.personEducation?.adrcityname,
      statecode: model?.personEducation?.statecode,
      adresscountydesc: model?.personEducation?.adresscountydesc,
      countyRefId: model?.personEducation?.adresscounty,
      zipcode: model?.personEducation?.schoolzipcode
    }
    this.setSmartyStreetAddress(addressInfo);
  }

  setSmartyStreetAddress(personEducation: any) {
    this.address = {
      address1: personEducation?.address1,
      address2: personEducation?.address2,
      city: personEducation?.adrcityname,
      state: personEducation.statecode,
      county: personEducation?.adresscountydesc,
      zipcode: personEducation?.zipcode,
      disable: false,
      countyRefId: personEducation?.countyRefId
    };
  }

  private personEducationConditionFn(model: any) {
    if (model.personEducation) {
      if (model.personEducation.startdate) {
        this.toMinDate = new Date(model.personEducation.startdate);
        this.isEdited = true;
      } else {
        this.isEdited = false;
      }
      if (model.personEducation?.schoolexitcomments === null || model.personEducation?.schoolexitcomments === '') {
        this.showdropdown = true;
      } else {
        this.showdropdown = false;
      }
      if (model.personEducation.enddate) {
        this.isEndDateEntered = true;
      }
      this.getModelFn(model);
      this.isEndDateEntered = false;
      this.personEducationFormGroup.controls['personEducation'].patchValue(model.personEducation);
      if (model.personEducation.bestdetermination && model.personEducation.bestdetermination.bestDeterminationList) {
        this.bestDeterminationList = model.personEducation.bestdetermination.bestDeterminationList;
      }
      this.setDelayiInEnrollmentRequiredStatus();
      this.ifEducationalertConditionFn(model);
      this.loadBestDeterminationPlacements(model.personEducation.personeducationid);
    }
  }

  private getModelFn(model: any) {
    let attendanceHistoryInfos:any = [];
    this.ifPersonEducationHistoryDataFn(model, attendanceHistoryInfos);
    attendanceHistoryInfos = attendanceHistoryInfos.filter((e: any) => e.startdate && e.enddate);
    attendanceHistoryInfos =  attendanceHistoryInfos.filter((valuee:any, indexx:any, selff:any) =>
      indexx === selff.findIndex((t: any) => (
        t.startdate === valuee.startdate
      ))
    );
    this.attendanceInfos = attendanceHistoryInfos;
    this.persistedStartDate = model.personEducation.startdate ? model.personEducation.startdate : null;

    model.personEducation.additionalobjectid = model.personEducation.personeducationid;
    this.additionalobjectid = model.personEducation.personeducationid;
    model.personEducation.isspecialeducation = this.reutrnIsspecialeducationFn(model);
    model.personEducation.isreceived = this.returnIsreceivedFn(model);
    model.personEducation.isverified = this.returnIsverifiedFn(model);
    model.personEducation.isexcuesed = this.returnIsexcuesedFn(model);
  }

  private reutrnIsspecialeducationFn(model: any): any {
    return model.personEducation.isspecialeducation ? '1' : this.isspecialeducationFalseConditionFn(model);
  }

  private returnIsexcuesedFn(model: any): any {
    return model.personEducation.isexcuesed ? '2' : null;
  }

  private returnIsverifiedFn(model: any): any {
    return model.personEducation.isverified ? '0' : null;
  }

  private returnIsreceivedFn(model: any): any {
    return model.personEducation.isreceived ? '1' : null;
  }

  private isspecialeducationFalseConditionFn(model: any): any {
    return !model.personEducation.isspecialeducation ? '0' : null;
  }

  private ifEducationalertConditionFn(model: any) {
    if (model.personEducation.educationalert) {
      this.educationalertList = model.personEducation.educationalert;
      const allowedit = this.educationalertList.find((item:any) => item.allowedit === true);
      if (allowedit) {
        this.addnewalert = false;
      }
      else {
        this.addnewalert = true;
      }
    }
  }

  private ifPersonEducationHistoryDataFn(model: any, attendanceHistoryInfos: any[]) {
    if (model?.personEducation?.personEducationHistory?.length > 0) {
      model.personEducation.personEducationHistory.forEach((ele: { bestdetermination: { bestDeterminationList: string | any[]; }; enddate: string | number | Date; startdate: string | number | Date; }) => {
        if (ele.bestdetermination?.bestDeterminationList && ele.bestdetermination.bestDeterminationList.length > 0) {
          const lastValue = ele.bestdetermination.bestDeterminationList[ele.bestdetermination.bestDeterminationList.length - 1];
          if (lastValue?.determinationvalue === 0) {
            let enddateF = new Date(ele.enddate ? ele.enddate : ele.startdate);
            enddateF.setDate(enddateF.getDate() + 1);
            attendanceHistoryInfos.push(this.addAttendanceInfo(ele, lastValue, enddateF));
          }
        }
      });
    }
  }
  private addAttendanceInfo(ele:any, lastValue:any, enddateF:any) {
    return {
      startdate: ele.startdate,
      startdateformated: new Date(ele.enddate ? ele.startdate : null),
      enddate: ele.enddate,
      enddateff: new Date(ele.enddate ? ele.enddate : ele.startdate),
      enddateF: enddateF,
      schoolexitreason: ele.statustypekeydesc,
      updatedby: ele.displayname,
      updatedon: lastValue.updatedon
    };
  }

  private schoolExitReasonDropdownItemsFn(model: any) {
    this.schoolExitReasonDropdownItems$.subscribe((data: any) => {
      if (model.personEducation.statustypekey !== "Unknown" && model.personEducation.statustypekey !== this.transferredDue && model.personEducation.statustypekey !== "Suspended" && model.personEducation.statustypekey !== this.currentlyEnrolled) {
        this.handleSchoolexitreasonDdDataFn(this.defaultList, data);
      } else if (model.personEducation.statustypekey == "Unknown" || model.personEducation.statustypekey == this.transferredDue || model.personEducation.statustypekey == "Suspended" || model.personEducation.statustypekey === this.currentlyEnrolled) {
        const list = this.defaultList;
        list.push(model.personEducation.statustypekey);
        this.handleSchoolexitreasonDdDataFn(list, data);
      }
    });
  }
  // Assosiated with schoolExitReasonDropdownItemsFn method
  private handleSchoolexitreasonDdDataFn(list: string[], data: any) {
    this.schoolexitreasondropdown = [];
    list.forEach(item => {
      const obj = this.returnCommonLoopDataFn(data, item);
      if (obj) {
        this.schoolexitreasondropdown.push(obj);
      }
    });
  }

  private returnCommonLoopDataFn(data: any, item: string) {
    return data.find((ele: { ref_key: string; }) => ele.ref_key === item);
  }

  private personEducationDocumentConditionFn(model: any) {
    if (model.personEducation.personEducationDcouments) {
      const docs = model.personEducation.personEducationDcouments;
      for (let i = 0; docs.length > i; i++) {
        if (docs[i].additionalobjecttype === "firstquarter") {
          this.firstquarterConditionFn(docs, i);
          this.setSelectedQuarter("firstquarter");
        }
        else if (docs[i].additionalobjecttype === "secondquarter") {
          this.secondquarterConditionFn(docs, i);
          this.setSelectedQuarter("secondquarter");
        }
        else if (docs[i].additionalobjecttype === "thirdtquarter") {
          this.thirdtquarterConditionFn(docs, i);
          this.setSelectedQuarter("thirdtquarter");
        }
        else if (docs[i].additionalobjecttype === "fourthquarter") {
          this.fourthquarterConditionFn(docs, i);
          this.setSelectedQuarter("fourthquarter");
        }
      }
    }
  }

  // this runs once per document, so the last quarter in the list would otherwise win. On a
  // retry the quarter is already known from the query param and must not be overwritten.
  private setSelectedQuarter(quarter: string) {
    if (!this.retryobjecttype) {
      this.additionalobjecttype = quarter;
    }
  }

  private fourthquarterConditionFn(docs: any, i: number) {
    this.uploadedFiles4.push({
      additionalobjecttype: docs[i].additionalobjecttype,
      documentpropertiesid: docs[i].documentpropertiesid,
      filename: docs[i].filename,
      originalfilename: docs[i].originalfilename,
      title: docs[i].attachmentclassificationsubtypekey,
      rootobjecttypekey: docs[i].rootobjecttypekey,
      s3bucketpathname: docs[i].s3bucketpathname,
      actualdocumentdate: docs[i].actualdocumentdate,
      documentdate: docs[i].documentdate,
      updatedon: docs[i].updatedon,
      documentattachment: {
        attachmentclassificationsubtypekey: docs[i].attachmentclassificationsubtypekey,
        attachmentclassificationtypekey: docs[i].attachmentclassificationtypekey,
        updatedby: docs[i].fullname
      },
      finalstatus: docs[i].finalstatus,
      uploadstatus: docs[i].uploadstatus,
      ecmsdocumentid: docs[i].ecmsdocumentid
    });
  }

  private thirdtquarterConditionFn(docs: any, i: number) {
    this.uploadedFiles3.push({
      additionalobjecttype: docs[i].additionalobjecttype,
      documentpropertiesid: docs[i].documentpropertiesid,
      filename: docs[i].filename,
      originalfilename: docs[i].originalfilename,
      title: docs[i].attachmentclassificationsubtypekey,
      rootobjecttypekey: docs[i].rootobjecttypekey,
      s3bucketpathname: docs[i].s3bucketpathname,
      actualdocumentdate: docs[i].actualdocumentdate,
      documentdate: docs[i].documentdate,
      updatedon: docs[i].updatedon,
      documentattachment: {
        attachmentclassificationsubtypekey: docs[i].attachmentclassificationsubtypekey,
        attachmentclassificationtypekey: docs[i].attachmentclassificationtypekey,
        updatedby: docs[i].fullname
      },
      finalstatus: docs[i].finalstatus,
      uploadstatus: docs[i].uploadstatus,
      ecmsdocumentid: docs[i].ecmsdocumentid
    });
  }

  private secondquarterConditionFn(docs: any, i: number) {
    this.uploadedFiles2.push({
      additionalobjecttype: docs[i].additionalobjecttype,
      documentpropertiesid: docs[i].documentpropertiesid,
      filename: docs[i].filename,
      originalfilename: docs[i].originalfilename,
      title: docs[i].attachmentclassificationsubtypekey,
      rootobjecttypekey: docs[i].rootobjecttypekey,
      s3bucketpathname: docs[i].s3bucketpathname,
      actualdocumentdate: docs[i].actualdocumentdate,
      documentdate: docs[i].documentdate,
      updatedon: docs[i].updatedon,
      documentattachment: {
        attachmentclassificationsubtypekey: docs[i].attachmentclassificationsubtypekey,
        attachmentclassificationtypekey: docs[i].attachmentclassificationtypekey,
        updatedby: docs[i].fullname
      },
      finalstatus: docs[i].finalstatus,
      uploadstatus: docs[i].uploadstatus,
      ecmsdocumentid: docs[i].ecmsdocumentid
    });
  }

  private firstquarterConditionFn(docs: any, i: number) {
    this.uploadedFiles1.push({
      additionalobjecttype: docs[i].additionalobjecttype,
      documentpropertiesid: docs[i].documentpropertiesid,
      filename: docs[i].filename,
      originalfilename: docs[i].originalfilename,
      title: docs[i].attachmentclassificationsubtypekey,
      rootobjecttypekey: docs[i].rootobjecttypekey,
      s3bucketpathname: docs[i].s3bucketpathname,
      actualdocumentdate: docs[i].actualdocumentdate,
      documentdate: docs[i].documentdate,
      updatedon: docs[i].updatedon,
      documentattachment: {
        attachmentclassificationsubtypekey: docs[i].attachmentclassificationsubtypekey,
        attachmentclassificationtypekey: docs[i].attachmentclassificationtypekey,
        updatedby: docs[i].fullname
      },
      finalstatus: docs[i].finalstatus,
      uploadstatus: docs[i].uploadstatus,
      ecmsdocumentid: docs[i].ecmsdocumentid
    });
  }

  cancelForm(type: any) {
    this.editflag = false;
    if(type === 'personEducation' && this.isEdited === false){
      this.personEducationFormGroup.controls['personEducation'].reset();
      this.isEndDateEntered = false;
    }else if(type === 'personAccomplishment' && this.isEdited === false){
      this.personEducationFormGroup.controls['personAccomplishment'].reset();
    }else if(type === 'personEducationTesting' && this.isEdited === false){
      this.personEducationFormGroup.controls['personEducationTesting'].reset();
    }else{
      this._educationInfoService.isShowAddEducationEnabled(false);
    }
  }

  allowPhoneNo(el:any) {
    if (el.target.value !== '') {
      el.target.value =  el.target.value.replace(/[a-zA-Z&\/\\#,$~%.'":*?<>{}]/g, '');
      return el.target.value;
    }
    return '';
  }

  checkNumber(el:any) {
    if (el.target.value !== '') {
      el.target.value =  el.target.value.replace(/[^0-9]/g, '');
      return el.target.value;
    }
    return '';
  }
  checkDecimal(el:any) {
    if (el.target.value !== '') {
      el.target.value =  el.target.value.replace(/[^0-9.]/g, '');
      return el.target.value;
    }
    return '';
  }
  startDateChanged(startDate: string) {
    this.toMinDate = new Date(startDate);
    this.personEducationFormGroup.controls.personEducation.patchValue({ enddate: null,statustypekey: null });
    this.isEndDateEntered = false;
    if (this.isExistingAttendanceStartDate(startDate)) {
      this.personEducationFormGroup.controls.personEducation.patchValue({ startdate: null });
      this._alertSevice.error('The attendance start date should be greater than the existing attendance start dates.');
      return;
    }
    this.checkAttDate();
  }

  // Moving the existing logic for start date validation 
  // Logic ti make sure the Attendance start date is not overlapping with the existing attendance start dates.
  private isExistingAttendanceStartDate(startDate: string) {
    if (!startDate || !this.attendanceInfos || this.attendanceInfos.length === 0) {
      return false;
    }
    const selectedTime = new Date(startDate).getTime();
    const persistedTime = this.persistedStartDate ? new Date(this.persistedStartDate).getTime() : null;
    return this.attendanceInfos.some((e: any) => e.startdate && e.enddate
      && new Date(e.startdate).getTime() === selectedTime
      && new Date(e.startdate).getTime() !== persistedTime);
  }
  enrollmentDateChanged(enrollmentdate: string) {
    this.toMinDate = new Date(enrollmentdate);
    this.setDelayiInEnrollmentRequiredStatus();
  }
  endDateChanged(endDate: string) {
    this.maximumDate = new Date(endDate);
    this.isEndDateEntered = endDate? true: false;
    if(!endDate){
      this.personEducationFormGroup.controls.personEducation.patchValue({ statustypekey: null });
    }
  }

  getformvalues(formName: string, key: string) {
    return this.personEducationFormGroup?.get(formName)?.get(key)?.value;
  }
  closePopover(element: any) {
    element.hide();
  }
  selectalerttype(event: any){
    this.educationAlertForm.reasoncode=null;
  }
  edustartDateChanged(startdate:any){
    
    startdate = moment(startdate); 
       
    this.educationAlertForm.enddate = startdate.add(12, 'months');

  }
  holdalertevent(event:any){
    if(!event.target.checked){
      this.educationAlertForm.enddate = new Date();
    }
  }
  saveeducationalert(){
    if(this.educationAlertForm.actiontype !=null){
    this.educationAlertForm.updatedby = this.userInfo.user.userprofile.fullname;
    this.educationAlertForm.updatedon = moment(new Date()).format(this.datFormatWithTime);
    this.educationalertList.push(this.educationAlertForm);
    this.addalert = false;
    }
    this. educationAlertForm = {
      personeducationalertactionid:null,
       reasoncode:null,
       actiontype:null,
        hidedropdown :null,
        stopdropdown :null,
        startdate:null,
        enddate :null,
        endreason:null,
        updatedon: null,
        updatedby: null

      }
  }
  edualertview(modal:any){
    this.holdalert = (modal.allowedit) ? true : false;
     this.addalert = true;
     this.disableeducationalertform = true;

     this.educationAlertForm ={...modal};

  }
  edualertedit(modal:any, i:any){
    if(modal.actiontype === 'H') {
      this.edualerteditflag = true;
    }
    else {
      this.edualerteditflag = false;
    }

     this.addalert = true;
     this.disableeducationalertform = false;
     this.holdalert = (modal.allowedit) ? true : false;
     this.educationAlertForm ={...modal};
  }
  canceledualertform(){
    this.addalert = false;
    this. educationAlertForm = {
      personeducationalertactionid:null,
       reasoncode:null,
       actiontype:null,
        hidedropdown :null,
        stopdropdown :null,
        startdate:null,
        enddate :null,
        endreason:null,
        updatedon: null,
        updatedby: null

      }
  }
  
  checkenddate(enddate:any){
    if(enddate <= this.currentdate){
      return false;
    }
    else{
      return true;
    }
  }
  removealert() {

    (<any>$('#removealert-popup')).modal('show');

  }
  confirmremovealert() {
    this.educationAlertForm.enddate = new Date();
  }
  educationalertformvalid(){

      if(this.educationAlertForm.actiontype) {
        if(this.educationAlertForm.reasoncode && this.educationAlertForm.startdate){
          return false;
        }
        else {
          return true;
        }
      }

  }

  showAdditionalInformation(){
    return this.getformvalues('personEducation','classtypetypekey') ||
    this.getformvalues('personEducation','currentgradelevel') ||
    this.getformvalues('personEducation','functioninggradelevel') ||
    this.getformvalues('personEducation','lastgradelevel') ||
    this.getformvalues('personEducation','firstqtrperformancetypekey') ||
    this.getformvalues('personEducation','secondqtrperformancetypekey') ||
    this.getformvalues('personEducation','thirdqtrperformancetypekey') ||
    this.getformvalues('personEducation','fourthqtrperformancetypekey') ||
    this.getformvalues('personEducation','lastattendeddate') ||
    this.getformvalues('personEducation','nonewenrollment')

  }
  delayinenrollmentChange() {
    this.personEducationFormGroup.get('personEducation.delayinenrollmentdetail')?.setValidators((this.getformvalues('personEducation','delayinenrollment') === 'O') ? [Validators.required] : null);
    this.personEducationFormGroup.get('personEducation')?.updateValueAndValidity();
    this.personEducationFormGroup.controls.personEducation.patchValue({
      delayinenrollmentdetail:  null
    });
  }
  setDelayiInEnrollmentRequiredStatus() {
    let enrollmentdate = this.getformvalues('personEducation','enrollmentdate');
    this.isdelayinenrollmentReq = false;
    if (enrollmentdate && (this.childremovaldates && this.childremovaldates?.length > 0)) {
          let chRd:any = [];
          let placementDates:any = [];
          this.childremovaldates.forEach((element:any) => {
            let fd = element.split('T')[0];
            let datef = fd.split('-');
            datef =  datef[1] + '/' + datef[2] + '/' + datef[0];
            placementDates.push(datef);
            chRd.push({
              date: fd,
              time: new Date(fd).getTime(),
              datef: datef
            });
          });
          let enrollmentdateOg = this.getformvalues('personEducation','enrollmentdate');
          let case2 = chRd.find((e:any) => (enrollmentdateOg === e.datef));
          if (case2) {
            this.isdelayinenrollmentReq = false;
            this.personEducationFormGroup.get('personEducation.delayinenrollment')?.setValidators(null);
            return;
          }
         chRd.sort((a:any,b:any) => (a.time > b.time) ? 1 : this.returnIfBGreaterThanAFn(b, a));
         let manD =  this.isDelayMandatory(placementDates, enrollmentdate.split('T')[0]);
         this.isdelayinenrollmentReq = (manD.includes('Mandatory'));
        }
    this.personEducationFormGroup.get('personEducation.delayinenrollment')?.setValidators(this.isdelayinenrollmentReq ? [Validators.required] : null);
    this.checkAttDate();
  }
  // Assosiated to setDelayiInEnrollmentRequiredStatus method
  private returnIfBGreaterThanAFn(b: any, a: any) {
    return ((b.time > a.time) ? -1 : 0);
  }

  private returnDaysToAddFn(enrollmentdate: any) {
    return (enrollmentdate.getDay() == 6 || enrollmentdate.getDay() == 0) ? 6 : 5;
  }
  isDelayMandatory(placementDates: string[], enrollmentDate: string) {
    const parseDate = (dateStr: string) => new Date(dateStr);
    const calculateBusinessDays = (start: Date, end: Date): number => {
      let count = 0;
      const currentDate = new Date(start);

      while (currentDate <= end) {
        const dayOfWeek = currentDate.getDay();
        if (dayOfWeek !== 0 && dayOfWeek !== 6) {
          count++;
        }
        currentDate.setDate(currentDate.getDate() + 1);
      }
      return count;
    };
    const enrollment = parseDate(enrollmentDate);
    const validPlacementDates = placementDates
      .map(date => parseDate(date))
      .filter(date => date <= enrollment);
    if (validPlacementDates.length === 0) {
      return "Ignore";
    }
    const mostRecentPlacement = new Date(Math.max(...validPlacementDates.map(date => date.getTime())));
    const businessDays = calculateBusinessDays(mostRecentPlacement, enrollment);
    return businessDays > 5 ? "Mandatory delay" : "Optional delay";
  }
  checkDateEqual(date1 : any, date2 : any) {
    date1.setHours(0);
    date1.setMinutes(0);
    date1.setSeconds(0);
    date1.setMilliseconds(0);
    date2.setHours(0);
    date2.setMinutes(0);
    date2.setSeconds(0);
    date2.setMilliseconds(0);
    return (date1.getTime() == date2.getTime());
  }

  nonewenrollmentchange(event: any) {
    if (!this.editflag && event.checked) {
      this.personEducationFormGroup.controls.personEducation.patchValue({
        enrollmentdate:  null,
        delayinenrollment: null
      });
      this.isdelayinenrollmentReq = false;
      this.personEducationFormGroup.get('personEducation.delayinenrollment')?.setValidators(null);
    }
    this.isEnrollmentdateDisabled =  (this.editflag && event.checked);
  }
}
