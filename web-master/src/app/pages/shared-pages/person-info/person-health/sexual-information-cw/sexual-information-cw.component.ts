
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { forkJoin ,  Observable } from 'rxjs';
import { PersonSexual } from '../../../involved-persons/_entities/involvedperson.data.model';
import { DropdownModel, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, CommonDropdownsService, AuthService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import moment from 'moment';
import { PersonInfoService } from '../../person-info.service';
import { AppConstants } from '../../../../../@core/common/constants';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';

declare let $: any;
const OTHER_KEY = '7780';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'sexual-information-cw',
    templateUrl: './sexual-information-cw.component.html',
    styleUrls: ['./sexual-information-cw.component.scss'],
    standalone: false
})
export class SexualInformationCwComponent implements OnInit {
  sexualInfoForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
  modalInt!: number;
  sexualcw: any[] = [];
  sexuallyTransmittedDiseases$!: Observable<DropdownModel[]>;
  birthControlMethods$!: Observable<DropdownModel[]>;
  sexualOrientationMethods$!: Observable<any[]>;
  genderIdentiyList$!: Observable<any[]>;

  isAddEdit!: boolean;
  showSTDSpecify = false;
  showBCMSpecify = false;
  showSexualOrientationSpecify = false;
  showGenderIdentitySpecify = false;
  uploadedFiles: any[] = [];
  uploadNumber = '123434';
  selectedItem: any;
  dtDisable = false;
  genderKey: any;
  othergendertypekey: any;
  caseId: any;
  minDate: any;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  load:boolean = false;
  checkmandatory: boolean =false;
  isClosed = false;
  validationmsg = 'Please fill mandatory fields';
  dtformat1 = 'YYYY-MM-DD';
  dtformat2 = 'MM/DD/YYYY';
  childrens:any = [];
  maxDate = new Date();

  private _formBuilder: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _commonDropDownService: CommonDropdownsService;
  private _personService: PersonInfoService;
  public _authService: AuthService;
  private route: ActivatedRoute;
  private _commonDDService: CommonDropdownsService;
  retrydoc: any = false;
  SexualInfoListCheck: any;
  personsexualinfoid: any;

  constructor(private injector: Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._personService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
       this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.personsexualinfoid = params['retryid'];
    });
}

  ngOnInit() {
    this.reportMode = 'add';
    this.isClosed = this._authService.iscaseclosed('personhealth');
    const today = new Date();
    const dd = today.getDate();
    const mm = today.getMonth();
    const yyyy = today.getFullYear();
    this.minDate = new Date(yyyy, mm, dd);
    this.othergendertypekey  =this._personService?.personInfo?.personbasicdetails?.othergendertypekey;
    this.genderKey = this._personService?.personInfo?.personbasicdetails?.gendertypekey;    
    let caseInfo;
    const info = this._dataStoreService.getObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO);
    if(info){
      caseInfo = info;
    }
    else {
      const navigationInfoData = localStorage.getItem('navigationInfo');
      if(navigationInfoData) {
        caseInfo = JSON.parse(navigationInfoData);
      }
    }
    this.caseId = caseInfo.data?.caseNumber;
    if(!this.retrydoc){
   this.getCareGiverPersonChildInfo()
    }
    this.loadDropDowns();
    this.initForm();
    this.getSexualInfo();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.getInvolvedPerson();
    this.route.queryParams.subscribe(params => {
      const status = params['reproductiveHealth'];
      if (status) {
        const reproductiveHealth = JSON.parse(this._dataStoreService.getData('reproductive-health-summary'));
        if (reproductiveHealth.sexualactiveflag.toLowerCase() === 'yes') {
          reproductiveHealth.sexualactiveflag = 1;
        } else if (reproductiveHealth.sexualactiveflag.toLowerCase() === 'no') {
          reproductiveHealth.sexualactiveflag = 0;
        } else {
          reproductiveHealth.sexualactiveflag = 2;
        }
        this.view(reproductiveHealth,1);
      }
    });
    this.getSexualInfo();
  }

  uploadclosed(event: any){
    if(event){
    this.documentuploaded.closeupload();
    this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  processSTDSpecify() {
    const data = this.sexualInfoForm.getRawValue();
    if (data.sextransdis === OTHER_KEY) {
      this.showSTDSpecify = true;
    } else {
      this.showSTDSpecify = false;
    }
  }

  processBCMSpecify() {
    const data = this.sexualInfoForm.getRawValue();
    if (data.birthcontrol === OTHER_KEY) {
      this.showBCMSpecify = true;
    } else {
      this.showBCMSpecify = false;
    }

  }

  processSexaulOrientationpecify() {
    const data = this.sexualInfoForm.getRawValue();
    if (data.sexualorientationkey === 'Other (specify)') {
      this.showSexualOrientationSpecify = true;
    } else {
      this.showSexualOrientationSpecify = false;
    }

  }

  processGenderIdentitySpecify() {
    const data = this.sexualInfoForm.getRawValue();
    if (data.genderidentity === 'OTHER') {
      this.showGenderIdentitySpecify = true;
    } else {
      this.showGenderIdentitySpecify = false;
    }

  }

  initForm() {
    this.sexualInfoForm = this._formBuilder.group({
      personsexualinfoid: null,
      childrenno: [null],
      pregnancyno: [null],
      ispregnant: [null, Validators.required],
      sextransdis: '',
      birthcontrol: '',
      stdspecify: '',
      bcspecify: '',
      specify: '',
      sicomments: '',
      sexualactiveflag: [null, Validators.required],
      std_treatment_startdate: [null],
      birthcontroldate: [null],
      sexualorientationkey: '',
      sexualorientationcomments: '',
      genderidentity: '',
      genderidentityspecify: '',
      pregnancyduedate: [null],
      ispregnancyduedateunknown: [null],
      currentlyparenting: [null],
      notparentingreason: [null],
      isfatheredachild: [null],
      currentlyparentingother: [null],
      notparentingotherreason: [null],
      isgivenbirth: [null],
      servicecaseid: [this.caseId],
    });
  }

  resetForm() {
    this.dtDisable = false;
    this.sexualInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.sexualInfoForm.enable();
    this.isAddEdit = false;
    this.uploadedFiles = [];
    this.showSTDSpecify = false;
    this.showBCMSpecify = false;
    this.showSexualOrientationSpecify = false;
    this.showGenderIdentitySpecify = false;
    this.uploadedFiles = [];
    this.selectedItem = null;
  }

 
  processOtherControls() {
    this.processBCMSpecify();
    this.processGenderIdentitySpecify();
    this.processSTDSpecify();
    this.processSexaulOrientationpecify();
  }
  getSexualActiveFlag(modal: any) {
    let sexualactiveflag = null;
    if (modal.sexualactiveflag === 1 || modal.sexualactiveflag === "1") {
      sexualactiveflag = 'Yes';
    } else if (modal.sexualactiveflag === 0 || modal.sexualactiveflag === "0") {
      sexualactiveflag = 'No';
    } else {
      sexualactiveflag = 'Unknown';
    }
    return sexualactiveflag;
  }
  getIsPregnant(modal: any) {
    let  ispregnant = null;
    if (modal.ispregnant) {
      ispregnant = 'yes';
    } else {
      ispregnant = 'no';
    }
    return ispregnant;
  }
  getCurrentlyParenting(modal: any) {
    let  currentlyparenting = null;
    if(modal.currentlyparenting !== null) {
      if (modal.currentlyparenting) {
        currentlyparenting = 'yes';
      } else {
        currentlyparenting = 'no';
      }
    }
    return currentlyparenting;
  }

  getCurrentlyParentingOther(modal1: any) {
    let currentlyparentingother = null;
    if(modal1.currentlyparentingother !== null) {
      if (modal1.currentlyparentingother) {
        currentlyparentingother = 'yes';
      } else {
        currentlyparentingother = 'no';
      }
    }
    return currentlyparentingother;
  }

  getFatheredAChild(modal: any) {
    let  isfatheredachild = null;
    if (modal.isfatheredachild) {
      isfatheredachild = 'yes';
    } else {
      isfatheredachild = 'no';
    }
    return isfatheredachild;
  }

  getGivenBirth(modal1: any) {
    let  isgivenbirth = null;
    if (modal1.isgivenbirth) {
      isgivenbirth = 'yes';
    } else {
      isgivenbirth = 'no';
    }
    console.info(modal1.isgivenbirth)
    return isgivenbirth;
  }
  
  reMapValues(modal: any) { 
 
    modal.birthcontroldate = (modal.birthcontroldate) ? this._commonDropDownService.getValidDate(modal.birthcontroldate) : null;
    modal.std_treatment_startdate = (modal.std_treatment_startdate) ? this._commonDropDownService.getValidDate(modal.std_treatment_startdate) : null;
    return modal;

  }
  edit(modal: any, i?: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.patchForm(this.reMapValues(modal));
    const ispregnant = this.getIsPregnant(modal);
    const sexualactiveflag = this.getSexualActiveFlag(modal);
    this.sexualInfoForm.patchValue({ 
      ispregnant: ispregnant, sexualactiveflag: sexualactiveflag, 
      currentlyparenting: this.getCurrentlyParenting(modal), 
      isfatheredachild : this.getFatheredAChild(modal), 
      isgivenbirth: modal.isgivenbirth ? 'yes' : 'no', 
      currentlyparentingother: this.getCurrentlyParentingOther(modal) });
    this.processOtherControls();
    this.sexualInfoForm.enable();
  }

  view(modal: any, i:any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = false;
    this.modalInt = i;
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.patchForm(this.reMapValues(modal));
    const ispregnant = this.getIsPregnant(modal);
    const sexualactiveflag = this.getSexualActiveFlag(modal);
    this.sexualInfoForm.patchValue({ 
      ispregnant: ispregnant, sexualactiveflag: sexualactiveflag, 
      currentlyparenting: this.getCurrentlyParenting(modal), 
      isfatheredachild : this.getFatheredAChild(modal), 
      isgivenbirth: this.getGivenBirth(modal), 
      currentlyparentingother: this.getCurrentlyParentingOther(modal)});
    this.processOtherControls();
    this.dtDisable = true;
    this.sexualInfoForm.disable();
  }

  cancel() {
    this.resetForm();
  }

  private patchForm(modal: PersonSexual) {
    this.dtDisable = false;
    this.sexualInfoForm.patchValue(modal);
  }

  add() {
    this.checkmandatory = true;
    if(this.sexualInfoForm.invalid){
      this.sexualInfoForm.markAllAsTouched();
      this._alertSevice.error('Please fill required fields');
      return;
    }
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    const sexualinfo = { ...this.sexualInfoForm.getRawValue(), ...uploadInfo };
  
    if(this.handleIfPregnancyduedateunknownFn(sexualinfo)) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }

    if(sexualinfo.pregnancyduedate && moment(sexualinfo.pregnancyduedate).format(this.dtformat1) < moment().format(this.dtformat1) && sexualinfo.currentlyparenting === null) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }

    if(this.checkGenderAndReturnFn(sexualinfo)) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }

    if(this.genderKey === 'M' && sexualinfo.isfatheredachild === null) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }

    if(sexualinfo.isfatheredachild === 'yes' && sexualinfo.currentlyparenting === null) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }

    if(sexualinfo.currentlyparentingother === 'no' && sexualinfo.notparentingotherreason === null) {
      this._alertSevice.warn(this.validationmsg);
      return;
    }
   
    this.ifUploadpathCondition(sexualinfo);

    let isNew = 1;
    let message = 'Reproductive Health Info Added Successfully';
    if (this.editMode) {
      isNew = 0;
      message = 'Reproductive Health Info Updated Successfully';
    }
    this._healthService.saveHealth({ 'reproductiveHealthInfo': [sexualinfo] }, isNew).subscribe(response => {
      this._alertSevice.success(message);
      this.getSexualInfo();
    });
    this.resetForm();
  }
  // Assosiated with add method
  private checkGenderAndReturnFn(sexualinfo: any) {
    return (sexualinfo.currentlyparenting === 'no' && (((this.genderKey === 'M' || this.genderKey === 'TGIF' || this.othergendertypekey === 0 && sexualinfo.isfatheredachild === 'yes') || 
    (this.genderKey === 'F' || this.genderKey === 'TGIM' || this.othergendertypekey === 1 && sexualinfo.isgivenbirth === 'yes')) && !sexualinfo.notparentingreason));
  }

  // Assosiated with add method
  private handleIfPregnancyduedateunknownFn(sexualinfo: any) {
    return (sexualinfo.ispregnant === 'yes' && (sexualinfo.ispregnancyduedateunknown === null || sexualinfo.ispregnancyduedateunknown === false) && sexualinfo.pregnancyduedate === null);
  }

  private ifUploadpathCondition(sexualinfo: any) {
    if (sexualinfo.uploadpath) {
      this.uploadpathLoopFn(sexualinfo);
    }
    sexualinfo.birthcontroldate = this.getBirthcontroldateFn(sexualinfo);
    sexualinfo.std_treatment_startdate = this.getBirthcontroldateFn(sexualinfo);
  }

  private uploadpathLoopFn(sexualinfo: any) {
    sexualinfo.uploadpath.forEach((document: { percentage: any; }) => {
      if (document.percentage) {
        delete document.percentage;
      }
    });
  }

  private getBirthcontroldateFn(sexualinfo: any): any {
    return (sexualinfo.birthcontroldate) ? moment(new Date(sexualinfo.birthcontroldate)).format(this.dtformat2) : null;
  }

  addHospitalization() {
    this.isAddEdit = true;
  }

  private update() {
    if (this.modalInt !== -1) {
      this.sexualcw[this.modalInt] = this.sexualInfoForm.getRawValue();
    }
    this.resetForm();
    this._alertSevice.success('Updated Successfully');
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '344', 'delete_sw': 'N' }
        },
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl}?filter`
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '23', 'delete_sw': 'N' }
        },
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl}?filter`
      )
    ]).pipe(map((result) => {
      return {
        sexuallyTransmittedDiseasesValues: result[0].map(
          (res) =>
            new DropdownModel({
              text: res.description_tx,
              value: res.picklist_value_cd
            })
        ),
        birthControlMethodValues: result[1].map(
          (res) =>      // NOSONAR    // This function has less than 3 lines of identical code. Hence, marking it as no sonar
            new DropdownModel({
              text: res.description_tx,
              value: res.picklist_value_cd
            })
        )
      };
    }),
      share(),);
    this.sexuallyTransmittedDiseases$ = source.pipe(pluck('sexuallyTransmittedDiseasesValues'));
    this.birthControlMethods$ = source.pipe(pluck('birthControlMethodValues'));
    this.sexualOrientationMethods$ = this._commonDropDownService.getListByTableID('332');
    this.genderIdentiyList$ = this._commonDropDownService.getListByTableID('333');
  }

  getSexualInfo() {
    this.sexualcw = [];
    this._healthService.getSexualInfo().subscribe(res => {

      this.sexualcw = (res && res.count) ? res.personsexualinfo : [];
        this.SexualInfoListCheck = this.sexualcw.find(item => item.personsexualinfoid === this.personsexualinfoid);
          if (this.SexualInfoListCheck && this.personsexualinfoid) {
              this.edit(this.SexualInfoListCheck);
              this.personsexualinfoid = null;
          }
    });
  }
  
  getCareGiverPersonChildInfo() {
    this.childrens = [];
    let personDetails =  this._personService.getPersonInfo();
    this._personService.getCareGiverPersonChildInfo({
      serviceid: this._commonDDService.getStoredCaseUuid(),
      personid: personDetails.personbasicdetails.personid
    }).subscribe(res => {
      if (res && res.length > 0) {
        res.forEach((element: { age: any; dob: any; }) => {
          element.age = this.calculateAge(element.dob);
        });
        this.childrens = res;
      }
    });
  }

  deleteConfirm(item: any) {
   $('#delete-popup').modal('show');
    this.selectedItem = item;
  }

  delete() {
    const data = {
      'personsexualinfoid': this.selectedItem.personsexualinfoid,
    };
    this._healthService.saveHealth({ 'reproductiveHealthInfo': [data] }, 2).subscribe(_ => {
      this._alertSevice.success('Reproductive Health Info Deleted Successfully');
      this.resetForm();
      this.getSexualInfo();
    });
  }

  calculateAge(dob: any) {
    let age: any = "";
    if (dob && moment(new Date(dob), this.dtformat2, true).isValid()) {
      const today = moment();
      const birthdate = moment(dob);
      const years = today.diff(birthdate, 'years');
      if (years > 0) {
        age = years + ' yr ';
      }
      age += today.subtract(years, 'years').diff(birthdate, 'months') + ' mon';
      return age;
    }
    return age;
  }

  checkPregnancyUnknown($event: any) {
    if($event.checked) {
      this.sexualInfoForm.patchValue({ pregnancyduedate: null});
      this.sexualInfoForm.controls['pregnancyduedate'].disable();
      $('#pregnancy-duedate-unknown').modal('show');
    } else {
      this.sexualInfoForm.controls['pregnancyduedate'].enable();
    }
  }

  valiatePregnancyDueDate() {
    const pregnancyduedate = this.sexualInfoForm.getRawValue().pregnancyduedate;
    if(pregnancyduedate && moment(pregnancyduedate).format(this.dtformat1) < moment().format(this.dtformat1)) {
      return true;
    } else {
      return false;
    }
  }
  
  radioChange() {
    if(this.sexualInfoForm.getRawValue().isfatheredachild === 'no') {
      this.sexualInfoForm.patchValue({ currentlyparenting: null });
    }
  }
  radioChangeFemale() {
    if(this.sexualInfoForm.getRawValue().isgivenbirth === 'no') {
      this.sexualInfoForm.patchValue({ currentlyparentingother: null });
    }
  }

  childAlert(type: any, value: any) {
    if (type && this.childrens && this.childrens.length === 0) {
    $('#childrensList').modal(type);
    }
    if (value !== 'close') {
      this.sexualInfoForm.patchValue({ currentlyparenting: value });
    }
  }

  private getInvolvedPerson() {
    let inputRequest;
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    if (this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE)) {
        inputRequest = {
            objectid: this.id,
            objecttypekey: 'servicecase',
            isExpungementSuperUser: isExpungementSuperUser,
        };
    } else {
        inputRequest = {
            intakeserviceid: this.id,
            isExpungementSuperUser: isExpungementSuperUser,
             'iscaseexpunged': iscaseexpunged
        };
    }
    this._commonHttpService
        .getPagedArrayList(
            {
                where: inputRequest,
                page: 1,
                limit: 50,
                nolimit: true,
                method: 'get'
            },
            `${url}?filter`
        ).subscribe((result: any) => {
            if (result?.data?.length>0) {
                const pids: any[] = [];
                result?.data?.forEach((p: { personid: any; }) => {
                  if(!pids?.includes(p?.personid)) {
                      pids.push(p?.personid);
                  }
                });
                if(pids?.length>0){
                    this?.getpregnants(pids);
                }
            }
        });
      }

      id!: string;
      pregnants: any[] = [];
      pregnantspopupid = '#pregnants-popup';
      getpregnants(pids: any) {
          this.pregnants = [];
          this._commonHttpService
              .getPagedArrayList(
                  new PaginationRequest({
                      page: 1,
                      limit: 50,
                      nolimit: true,
                      method: 'get',
                where: { v_pids: pids }
              }),
              'personsexualinfo/getpregnants?filter'
            ).subscribe((res: any) => {
                if(res && res[0]?.getpregnants?.length > 0) {
                  res[0]?.getpregnants?.forEach((e: { pregnant: any; }) => {
                      if(!this?.pregnants?.includes(e.pregnant)) {
                          this?.pregnants?.push(e.pregnant);
                      } 
                  });
                  if(this.pregnants?.length>0) {
                    ($(this.pregnantspopupid)).modal('show');
                  }
                }
            });
        } 

        closePregnantsPopup(){
          ($(this.pregnantspopupid)).modal('hide');
        }
        
}
