
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService, AuthService, CommonDropdownsService, ValidationService } from '../../../../../@core/services';
import { forkJoin ,  Observable } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../../../../pages/case-worker/case-worker-url.config';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { FileError } from 'ngxf-uploader';
import { HealthConstants } from '../health-constants';
import { Health, BehaviouralHealthInfo } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import moment from 'moment';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'behavioral-health-info-cw',
    templateUrl: './behavioral-health-info-cw.component.html',
    styleUrls: ['./behavioral-health-info-cw.component.scss'],
    standalone: false
})
export class BehavioralHealthInfoCwComponent implements OnInit {
  behaviouralHealthInfoForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
  personBehavioralHealthId!: string;
  behaviouralcw: any[] = [];
  health: Health = {};
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  uploadedFile!: File;
  private token: AppUser;
  serviceDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  fearsTypeDropdownItems$!: Observable<DropdownModel[]>;
  isAddEdit = false;
  personId: any;
  tobaccoSelectionEnabled!: boolean;
  alchoholSelectionEnabled!: boolean;
  drugSelectionEnabled!: boolean;
  uploadedFiles = [];
  uploadNumber = '123434';
  address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
  abuseSubstanceId!: string;
  dtDisable = false;
  deleteItem: any;
  isPersonUnder21: any;
  updateByUserName: any;
  updateOnTimestampe: any;
  load:boolean = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  checkmandatory: boolean =false;
  isClosed = false;
  deletepopupid = '#delete-popup';
  infopopupid = '#info-popup';
  retrydoc: any = false;
  behavioralListCheck: any;
  behavioralid: any;

  private _formBuilder: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  public _authService: AuthService;
  private _healthService: PersonHealthService;
  private _personInfoService: PersonInfoService;
  private _commonDropDownService: CommonDropdownsService;
  private route: ActivatedRoute;

  constructor(private injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.behavioralid = params['retryid'];
    });
    this.token = this._authService.getCurrentUser();
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this.personId = this._personInfoService.getPersonId();
    this.isPersonUnder21 = (moment().diff(this._personInfoService.getPersonInfo()?.personbasicdetails.dob, 'years')) > 21 ? false : true;
    this.reportMode = 'add';
    this.loadDropDowns();
    this.initForm();
    this._healthService.getHealthInfoWithKey(HealthConstants.LIST_KEY.PERSON_BEHAVIOR);

    this.getBehavioralHealthList();
    this.route.queryParams.subscribe(params => {
      const status = params['behavirolHealth'];
      if (status) {
        const behavirolHealth = JSON.parse(this._dataStoreService.getData('behavirolHealth-health-summary'));
        behavirolHealth.isbehaviouraldiagnosis = behavirolHealth.isbehaviouraldiagnosis === 'yes';
        behavirolHealth.isusetobacco = behavirolHealth.isusetobacco === 'yes';
        behavirolHealth.isusedrug = behavirolHealth.isusedrug === 'yes';
        behavirolHealth.isusealcohol = behavirolHealth.isusealcohol === 'yes';
        this.view(behavirolHealth);
      }
    });
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
  initForm() {
    this.behaviouralHealthInfoForm = this._formBuilder.group({
      isbehaviouraldiagnosis: [null, [Validators.required]],
      typeofservice: '',
      clinicianname: '',
      // addressline1: '',
      // addressline2: '',
      // city: '',
      // state: '',
      // county: '',
      // zipcode: '',
      phonenumber: '',
      currentdiagnosis: '',
      reportname: '',
     // reportpath: '',
      email: ['', [ValidationService.mailFormat]],
      dateofevaluation: null,
      evaluationby: '',
      nodiagnosisreason: '',
      uploadpath: '',
      isusetobacco: [null, Validators.required],
      //   isusedrugoralcohol: null,
      isusedrug: [null, Validators.required],
      drugfrequencydetails: '',
      drugageatfirstuse: '',
      isusealcohol: [null, Validators.required],
      alcoholfrequencydetails: '',
      alcoholageatfirstuse: '',
      drugoralcoholproblems: '',
      tobaccofrequencydetails: '',
      tobaccoageatfirstuse: '',
      phobiakey: '',
      phobiacomments: '',
      ischildhassextraffichistory: null,
      issextraffichistoryreported: null,
      sextraffichistoryreportedon: null,
      ischildhassextraffic: null,
      issextrafficreported: null,
      sextrafficreportedon: null,
      nochangesinsextraffic: null
    });
  }

  resetForm() {
    this.behaviouralHealthInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.dtDisable = false;
    this.address.disable = false;
    this.uploadedFiles = [];
    this.drugSelectionEnabled = false;
    this.tobaccoSelectionEnabled = false;
    this.alchoholSelectionEnabled = false;
    this.behaviouralHealthInfoForm.enable();
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.address.address1 = modal.address1;
    this.address.address2 = modal.address2;
    this.address.city = modal.city;
    this.address.state = modal.state;
    this.address.zipcode = modal.zipcode;
    this.address.county = modal.county;
    this.address.disable = true;
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.patchSubstance(modal);
    this.patchForm(modal);
    this.editMode = false;
    this.dtDisable = true;
    this.behaviouralHealthInfoForm.disable();
  }

  edit(modal: any, i?: any) {
    this.personBehavioralHealthId = modal.personbehavioralhealthid;
    this.abuseSubstanceId = modal.parentabusesubstanceid;
    this.reportMode = 'edit';
    this.editMode = true;
    this.isAddEdit = true;
    this.patchSubstance(modal);
    this.address.address1 = modal.address1;
    this.address.address2 = modal.address2;
    this.address.city = modal.city;
    this.address.state = modal.state;
    this.address.zipcode = modal.zipcode;
    this.address.county = modal.county;
    this.address.disable = false;
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    modal.dateofevaluation = this._commonDropDownService.getValidDate(modal.dateofevaluation);
    this.patchForm(modal);
    this.dtDisable = false;
    this.behaviouralHealthInfoForm.enable();
    if(modal.nochangesinsextraffic ===  true) {
        this.updateByUserName = modal.updatedby;
        this.updateOnTimestampe = moment(modal.updateon).format('MM-DD-YYYY hh:mm A');
     }
  }

  patchSubstance(modal: any) {
    if (modal.isusetobacco) {
      this.tobaccoSelection('1');
    } else {
      this.tobaccoSelection('2');
    }

    if (modal.isusedrug) {
      this.drugSelection('1');
    } else {
      this.drugSelection('2');
    }

    if (modal.isusealcohol) {
      this.alchoholSelection('1');
    } else {
      this.alchoholSelection('2');
    }
  }

  public delete() {
    const modal = this.deleteItem; 

    const behaviouralId = {
      'personbehavioralhealthid': modal.personbehavioralhealthid,
    };
    const substanceId = {
      'personabusesubstanceid': modal.personabusesubstanceid,
    };
    this._healthService.saveHealth({ 'personBehaviour': [behaviouralId], 'personHealthSubstanceAbuse': [substanceId] }, 2).subscribe(_ => {
      this._alertSevice.success('Behavioral/Substance Details Deleted Successfully');
      this.resetForm();
      this.getBehavioralHealthList();
      (<any>$(this.deletepopupid)).modal('hide');
        this.deleteItem = null;
    });
  }

  cancel() {
    this.isAddEdit = false;
    this.resetForm();
  }

  patchForm(modal: BehaviouralHealthInfo) {
    this.behaviouralHealthInfoForm.patchValue(modal);
  }

  add() {
    this.checkmandatory = true;
    if(this.behaviouralHealthInfoForm.valid) {
      

    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;

    const modal = this.behaviouralHealthInfoForm.getRawValue();
    let behaviouralData = {};
    behaviouralData = {
      isbehaviouraldiagnosis: modal.isbehaviouraldiagnosis,
      typeofservice: modal.typeofservice,
      clinicianname: modal.clinicianname,
      phonenumber: modal.phonenumber,
      currentdiagnosis: modal.currentdiagnosis,
      reportname: modal.reportname,
      email: modal.email,
      dateofevaluation: modal.dateofevaluation,
      evaluationby: modal.evaluationby,
      nodiagnosisreason: modal.nodiagnosisreason,
      phobiakey: modal.phobiakey,
      phobiacomments: modal.phobiacomments
    };

    const behavioralHealth =  { ...behaviouralData, ...uploadInfo, ...this.address };


    let substanceAbusecw = {};
    substanceAbusecw = {
      isusetobacco: modal.isusetobacco,
      isusedrug: modal.isusedrug,
      drugfrequencydetails: modal.drugfrequencydetails,
      drugageatfirstuse: modal.drugageatfirstuse,
      isusealcohol: modal.isusealcohol,
      alcoholfrequencydetails: modal.alcoholfrequencydetails,
      alcoholageatfirstuse: modal.alcoholageatfirstuse,
      drugoralcoholproblems: modal.drugoralcoholproblems,
      tobaccofrequencydetails: modal.tobaccofrequencydetails,
      tobaccoageatfirstuse: modal.tobaccoageatfirstuse,
      ischildhassextraffichistory: modal.ischildhassextraffichistory,
      issextraffichistoryreported: modal.issextraffichistoryreported,
      sextraffichistoryreportedon: modal.sextraffichistoryreportedon,
      ischildhassextraffic: modal.ischildhassextraffic,
      issextrafficreported: modal.issextrafficreported,
      sextrafficreportedon: modal.sextrafficreportedon,
      nochangesinsextraffic: modal.nochangesinsextraffic
    };

    if (modal.uploadpath) {
      modal.uploadpath.forEach((document: { percentage: any; }) => {
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }

    this._healthService.saveHealth({
      'personBehaviour': [behavioralHealth],
      'personHealthSubstanceAbuse': [substanceAbusecw]
    }).subscribe(response => {
      this._alertSevice.success('Behavioral/Substance Details Added Successfully');
      (<any>$(this.infopopupid)).modal('show');
      this.resetAll();
      this.getBehavioralHealthList();
    });
    this.resetForm();
  }
  else{
    this._alertSevice.error('Please enter all required fields')
  }
  }

  resetAll() {
    this.resetAddress();
    this.isAddEdit = false;
    this.resetForm();
    
    this.uploadedFiles = [];
  }

  resetAddress() {
    this.address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
  }

  uploadFile(file: File | FileError): void {
    if (!(file instanceof File)) {
      return;
    }

    this.uploadedFile = file;
    this.behaviouralHealthInfoForm.patchValue({ reportname: file.name });
  }

  update() {
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;

    const modal = this.behaviouralHealthInfoForm.getRawValue();
    let behaviouralData = {};
    behaviouralData = {
      isbehaviouraldiagnosis: modal.isbehaviouraldiagnosis,
      typeofservice: modal.typeofservice,
      clinicianname: modal.clinicianname,
      phonenumber: modal.phonenumber,
      currentdiagnosis: modal.currentdiagnosis,
      reportname: modal.reportname,
      email: modal.email,
      dateofevaluation: modal.dateofevaluation,
      evaluationby: modal.evaluationby,
      nodiagnosisreason: modal.nodiagnosisreason,
      phobiakey: modal.phobiakey,
      phobiacomments: modal.phobiacomments,
      personbehavioralhealthid: this.personBehavioralHealthId
    };

    const behavioralHealth =  { ...behaviouralData, ...uploadInfo, ...this.address };

    let substanceAbusecw = {};
    substanceAbusecw = {
      isusetobacco: modal.isusetobacco,
      isusedrug: modal.isusedrug,
      drugfrequencydetails: modal.drugfrequencydetails,
      drugageatfirstuse: modal.drugageatfirstuse,
      isusealcohol: modal.isusealcohol,
      alcoholfrequencydetails: modal.alcoholfrequencydetails,
      alcoholageatfirstuse: modal.alcoholageatfirstuse,
      drugoralcoholproblems: modal.drugoralcoholproblems,
      tobaccofrequencydetails: modal.tobaccofrequencydetails,
      tobaccoageatfirstuse: modal.tobaccoageatfirstuse,
      parentabusesubstanceid: this.abuseSubstanceId,
      ischildhassextraffichistory: modal.ischildhassextraffichistory,
      issextraffichistoryreported: modal.issextraffichistoryreported,
      sextraffichistoryreportedon: modal.sextraffichistoryreportedon,
      ischildhassextraffic: modal.ischildhassextraffic,
      issextrafficreported: modal.issextrafficreported,
      sextrafficreportedon: modal.sextrafficreportedon,
      nochangesinsextraffic: modal.nochangesinsextraffic,
    };

    if (modal.uploadpath) {
      modal.uploadpath.forEach((document: { percentage: any; }) => {    // NOSONAR    // This function has identical implementation of less that 3 lines. Hence, marking it as no sonar.
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }

    this._healthService.saveHealth({
      'personBehaviour': [behavioralHealth],
      'personHealthSubstanceAbuse': [substanceAbusecw]
    }, 0).subscribe(response => {
      this._alertSevice.success('Behavioral/Substance Details Updated Successfully');
      (<any>$(this.infopopupid)).modal('show');
      this.resetAll();
      this.getBehavioralHealthList();
    });
    this.resetForm();
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { activeflag: 1 },
          order: 'description asc'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.personservicetype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      ),
      this._commonHttpService.create(
        {
          nolimit: true,
          order: 'countyname asc'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '80', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )
    ]).pipe(map((result: any) => {
      return {
        typeofservice: result[0].map(
          (res: { description: any; personservicetypekey: any; }) =>
            new DropdownModel({
              text: res.description,
              value: res.personservicetypekey
            })
        ),
        states: result[1].map(
          (res: { statename: any; stateabbr: any; }) =>
            new DropdownModel({
              text: res.statename,
              value: res.stateabbr
            })
        ),
        counties: result[2].map(
          (res: { countyname: any; }) =>
            new DropdownModel({
              text: res.countyname,
              value: res.countyname
            })
        ),
        fearsTypeList: result[3].map(
          (res: { description_tx: any; value_tx: any; }) =>
            new DropdownModel({
              text: res.description_tx,
              value: res.value_tx
            })
        )
      };
    }),
      share(),);
    this.serviceDropdownItems$ = source.pipe(pluck('typeofservice'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.countyDropDownItems$ = source.pipe(pluck('counties'));
    this.fearsTypeDropdownItems$ = source.pipe(pluck('fearsTypeList'));
  }

  addBehavioralInfo() {
    this.isAddEdit = true;
  }

  getBehavioralHealthList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId }
    }, 'personabusesubstance/behavesubstancelist?filter').subscribe(res => {
        this.behaviouralcw = res ? res.data : [];
        this.behavioralListCheck = this.behaviouralcw.find(item => item.personbehavioralhealthid === this.behavioralid);
        if (this.behavioralListCheck && this.behavioralid) {
            this.edit(this.behavioralListCheck);
            this.behavioralid = null;
        }
    });
  }
  test(test: any) {
    //No operation needed here
  }

  drugSelection(control: any) {
    if (control === '1') {
      this.drugSelectionEnabled = true;
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.enable();
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.setValidators([Validators.required]);
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.enable();
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.setValidators([Validators.required]);
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.updateValueAndValidity();

    } else {
      this.resetdrugfields();
      this.drugSelectionEnabled = false;
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.disable();
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.clearValidators();
      this.behaviouralHealthInfoForm.get('drugfrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.disable();
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.clearValidators();
      this.behaviouralHealthInfoForm.get('drugageatfirstuse')?.updateValueAndValidity();
    }
  }

  alchoholSelection(control: any) {
    if (control === '1') {
      this.alchoholSelectionEnabled = true;
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.enable();
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.setValidators([]);
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.enable();
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.setValidators([Validators.required]);
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
    } else {
      this.resetalcoholfields();
      this.alchoholSelectionEnabled = false;
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.disable();
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.clearValidators();
      this.behaviouralHealthInfoForm.get('alcoholfrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.disable();
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.clearValidators();
      this.behaviouralHealthInfoForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
    }
  }

  tobaccoSelection(control: any) {
    if (control === '1') {
      this.tobaccoSelectionEnabled = true;
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.enable();
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.setValidators([Validators.required]);
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.enable();
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.setValidators([Validators.required]);
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
    } else {
      this.resettobaccorfields();
      this.tobaccoSelectionEnabled = false;
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.disable();
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.clearValidators();
      this.behaviouralHealthInfoForm.get('tobaccofrequencydetails')?.updateValueAndValidity();
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.disable();
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.clearValidators();
      this.behaviouralHealthInfoForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
    }
  }

  resetdrugfields() {
    this.behaviouralHealthInfoForm.patchValue({ 'drugfrequencydetails': null });
    this.behaviouralHealthInfoForm.patchValue({ 'drugageatfirstuse': null });
  }

  resetalcoholfields() {
    this.behaviouralHealthInfoForm.patchValue({ 'alcoholfrequencydetails': null });
    this.behaviouralHealthInfoForm.patchValue({ 'alcoholageatfirstuse': null });
  }

  resettobaccorfields() {
    this.behaviouralHealthInfoForm.patchValue({ 'tobaccofrequencydetails': null });
    this.behaviouralHealthInfoForm.patchValue({ 'tobaccoageatfirstuse': null });
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
    (<any>$(this.deletepopupid)).modal('show');
  }

  closePopup() {
    (<any>$(this.infopopupid)).modal('hide');
  }

  onChange(modal: any, type: any) {
    if(type === 1 && !modal) {
      this.behaviouralHealthInfoForm.controls.issextraffichistoryreported.clearValidators();
      this.behaviouralHealthInfoForm.controls.sextraffichistoryreportedon.clearValidators();
      this.behaviouralHealthInfoForm.patchValue({
        issextraffichistoryreported : null,
        sextraffichistoryreportedon: null
      });
    } else if(type === 2 && !modal) {
      this.behaviouralHealthInfoForm.controls.issextrafficreported.clearValidators();
      this.behaviouralHealthInfoForm.controls.sextrafficreportedon.clearValidators();
      this.behaviouralHealthInfoForm.patchValue({
        issextrafficreported: null, 
        sextrafficreportedon: null
      })
    } else if(type === 3 && !modal) {
      this.behaviouralHealthInfoForm.controls.sextraffichistoryreportedon.clearValidators();
      this.behaviouralHealthInfoForm.patchValue({
          sextraffichistoryreportedon: null
      });
    } else if(type === 4 && !modal) {
      this.behaviouralHealthInfoForm.controls.sextrafficreportedon.clearValidators();
      this.behaviouralHealthInfoForm.patchValue({
        sextrafficreportedon: null
      });
    }
  }

}