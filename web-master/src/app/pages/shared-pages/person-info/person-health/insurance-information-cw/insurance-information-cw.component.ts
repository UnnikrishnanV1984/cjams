
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
// tslint:disable-next-line:import-blacklist
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { HealthInsuranceInformation, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { AlertService, DataStoreService, CommonHttpService,CommonDropdownsService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import { PersonHealthService } from '../person-health.service';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'insurance-information-cw',
    templateUrl: './insurance-information-cw.component.html',
    styleUrls: ['./insurance-information-cw.component.scss'],
    standalone: false
})
export class InsuranceInformationCwComponent implements OnInit {
  healthinsuranceForm!: FormGroup;
  modalInt!: number;
  isCustomInsuranceProvider!: boolean;
  editMode!: boolean;
  reportMode!: string;
  minDate = new Date();
  maxDate = new Date();
  MaminDate = new Date();
  MamaxDate = new Date();
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  healthInsurance: HealthInsuranceInformation[] = [];
  typeofInsuranceDropDownItem$!: Observable<DropdownModel[]>;
  health!: Health;
  isPrimaryExists!: boolean;
  isPrimaryInsurance!: boolean;
  isInsuranceAvailableforPerson!: boolean;
  insuranceList!: any[];
  insuranceTypeList!: any[];
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  uploadedFiles = [];
  uploadNumber = '123434';
  medAssistance!: boolean;
  patientRelationships: any[] = [];
  isAddEdit = false;
  personId!: string;
  insuranceStartDate!: string;
  dtDisable = false;
  deleteItem: any;
  address: any = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
  load:boolean = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  checkforrequired: boolean =false;
  isClosed = false;
  deletepopupid = '#delete-popup';

  private formbulider: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  public  _personInfoService: PersonInfoService;
  private _healthService: PersonHealthService;
  private _commonDropdownService: CommonDropdownsService;
  public  _authService: AuthService;
  private route: ActivatedRoute;
  retrydoc: any = false;
  insuranceCheck: any;
  insuranceid: any;

  constructor(private injector:Injector){
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.insuranceid = params['retryid'];
    });
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth');
    const personInfo = this._personInfoService.getPersonInfo();
    if(personInfo && personInfo.personbasicdetails) {
      this.insuranceStartDate = personInfo.personbasicdetails.dob ? personInfo.personbasicdetails.dob : null;
    }
    this.personId =  this._personInfoService.getPersonId();
    this.loadDropDowns();
    this.medAssistance = false;
    this.editMode = false;
    this.reportMode = 'add';
    this.isPrimaryExists = false;
    this.isPrimaryInsurance = true;
    this.isInsuranceAvailableforPerson = false;
    this.modalInt = -1;
    this._commonDropdownService.getPickList('172').subscribe(response => {
      this.patientRelationships = response;
    });
    this.isCustomInsuranceProvider = false;
    this.healthinsuranceForm = this.formbulider.group({
      ismedicaidmedicare: [null, [Validators.required]],
      insurancetype: '',
      medicalinsuranceprovider: '',
      providertype: '',
      policyholdername: [''],
      customprovidertype: '',
      providerphone: '',
      patientpolicyholderrelation: '',
      policynumber: [''],
      medicarenumber: [''],
      caresmatypekey: '',
      groupnumber: '',
      startdate: '',
      enddate: '',
      medicaidstartdate: '',
      medicaidenddate: '',
      updateddate: '',
      managedcareorganization: '',
      personhealthinsuranceid: '',
      providedbynotes:'',
      infoclienttypekey:'',
    });

    if (this._personInfoService.getClosed()) {
      this.healthinsuranceForm.disable();
    }
    this.health = this._dataStoreService.getData(this.constants.Health);

    if (this.health && this.health.healthInsurance) {
      this.healthInsurance = this.health.healthInsurance;

      const Index = this.healthInsurance.findIndex(c => c.providertype === 'Primary');
      if (Index !== -1) {
        this.isPrimaryExists = true;
      } else {
        this.isPrimaryExists = false;
      }
    }

    this.getInsuranceInfoList();
    this.route.queryParams.subscribe(params => {
      const status = params['insuranceInfo'];
      if (status) {
        const insuranceInfo = JSON.parse(this._dataStoreService.getData('insuranceInfo-health-summary'));
        insuranceInfo.ismedicaidmedicare = (insuranceInfo.ismedicaidmedicare.toLowerCase() === 'yes')
        this.view(insuranceInfo);
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


  setInsurance(option: any) {
    if(option.value == 'MEDIC') {
      this.isPrimaryInsurance = true;
      this.healthinsuranceForm.patchValue({ 'providertype': 'Primary' });
    } else {
      this.isPrimaryInsurance = false;
    }
  }
  setInsuranceType(option: any) {
    if(option == 'Primary'){
      this.isPrimaryExists = true;
    }
  }
  resetInsuranceType(option: any) {
    if(option == 'Primary'){
      this.isPrimaryExists = false;
    }
  }
  modifyInsuranceType(option: any) {
    if(option == 'Secondary'){
      this.isPrimaryExists = false;
    }
   
  }
  setProviderType(option: any) {
    if (option.value === 'other' || option === 'other') {
      this.isCustomInsuranceProvider = true;
    } else {
      this.isCustomInsuranceProvider = false;
    }
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1 },
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.EthnicGroupTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          ethinicities: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.ethnicgrouptypekey
              })
          ),
          states: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          )
        };
      }),
      share(),);
    this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.typeofInsuranceDropDownItem$ = this._commonDropdownService.getDropownsByTable('Type of Insurance');
  }

  loadCounty() {
    const state = this.healthinsuranceForm.get('state')?.value;
    const source = this._commonHttpService.create(
      {
        where: { state: state },
        order: 'countyname asc',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
    ).pipe(map((result) => {
      return {
        counties: result.map(
          (res: { countyname: any; }) =>
            new DropdownModel({
              text: res.countyname,
              value: res.countyname
            })
        )
      };
    }),share(),);

    this.countyDropDownItems$ = source.pipe(pluck('counties'));
  }

  selectmedicalassistance(control: any) {
    this.medAssistance = control;
  }
  add() {
    this.checkforrequired  =true;
    if( this.healthinsuranceForm.valid){
    const currDate = new Date();
    this.healthinsuranceForm.patchValue({ 'updateddate': currDate });
    const insuranceForm = this.healthinsuranceForm.getRawValue();        
    this.setInsuranceType(insuranceForm.providertype);
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    const data = {...this.healthinsuranceForm.getRawValue(), ...uploadInfo,  ...this.address};
    data.addressline1 = this.address.address1;
    data.addressline2 = this.address.address2;
    data.zip = this.address.zipcode;
    if(insuranceForm.policynumber == null && insuranceForm.medicarenumber == null &&  insuranceForm.ismedicaidmedicare){
      this._alertSevice.error('Please Enter Policy Number or MA Number');
      return;
    }
    this._healthService.saveHealth({ 'insuranceInfo': [data] }).subscribe(response => {
      this._alertSevice.success('Insurance Information Added Successfully');
      this.resetForm();
      this.getInsuranceInfoList()
    });
  }
  else{
    this._alertSevice.error("Please fill all required fields");
  }
  }

  private enableorDisableField(field: any, opt: any) {
    if (opt) {
      this.healthinsuranceForm.get(field)?.enable();
      this.healthinsuranceForm.get(field)?.updateValueAndValidity();
    } else {
      this.healthinsuranceForm.get(field)?.disable();
      this.healthinsuranceForm.get(field)?.clearValidators();
      this.healthinsuranceForm.get(field)?.updateValueAndValidity();
    }
  }

  isInsuranceExsists(item: any) {
    let opt: any;

    if(item?.providedbynotes && item?.providedbynotes === 'E&E'){
      opt = true;
    }else{
      opt = item?.ismedicaidmedicare ? item?.ismedicaidmedicare : item;
    }
    this.enableorDisableField('insurancetype', opt);
    this.enableorDisableField('medicalinsuranceprovider', opt);
    this.enableorDisableField('customprovidertype', opt);
    this.enableorDisableField('providertype', opt);
    this.enableorDisableField('policynumber', opt);
    this.enableorDisableField('startdate', opt);
    this.enableorDisableField('groupnumber', opt);
    this.enableorDisableField('medicarenumber', opt);
    this.enableorDisableField('medicaidstartdate', opt);    
    this.isInsuranceAvailableforPerson = opt;
    this.healthinsuranceForm.reset();
    setTimeout( () => {
      this.healthinsuranceForm.patchValue({ 'ismedicaidmedicare':  (item?.providedbynotes && item?.providedbynotes === 'E&E') ? false : opt });
    }, 200);
  }

  resetForm() {
    this.healthinsuranceForm.reset();
    this.address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
    this.dtDisable = false;
    this.isInsuranceAvailableforPerson = false;
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.healthinsuranceForm.enable();
    this.isCustomInsuranceProvider = false;
    this.medAssistance = false;
    this.healthinsuranceForm.get('ismedicaidmedicare')?.setValidators([Validators.required]);
    this.healthinsuranceForm.get('ismedicaidmedicare')?.updateValueAndValidity();
  }

  update() {
    if (this.modalInt !== -1) {
      const currDate = new Date();
      this.healthinsuranceForm.patchValue({ 'updateddate': currDate });
      const insuranceForm = this.healthinsuranceForm.getRawValue();
      this.setInsuranceType(insuranceForm.providertype);
      this.healthInsurance[this.modalInt] = this.healthinsuranceForm.getRawValue();
      const uploadInfo: any = {};
      uploadInfo['uploadpath'] = this.uploadedFiles;
      const data: any = {...this.healthInsurance[this.modalInt], ...uploadInfo,  ...this.address};
      data.zip = this.address.zipcode;
      if(insuranceForm.policynumber == null && insuranceForm.medicarenumber == null){
        this._alertSevice.error('Please Enter Policy Number or MA Number');
        return;
      }
      this._healthService.saveHealth({ 'insuranceInfo': [data] }, 0).subscribe(response => {
        this._alertSevice.success('Insurance Information Updated Successfully');
        this.resetForm();
        this.getInsuranceInfoList();
      });
    }
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.isInsuranceExsists(modal);
    if (modal.medicalinsuranceprovider !== null) {
      this.setProviderType(modal.medicalinsuranceprovider);
    }
    this.resetInsuranceType(modal.providertype);
    this.medAssistance = modal.medicalassistance;
    this.reportMode = 'edit';
    this.editMode = false;
    this.patchForm(modal);
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.address.disable = true;
    this.dtDisable = true;
    this.healthinsuranceForm.disable();
  }

  edit(modal: any, i?: any) {
    this.isAddEdit = true;
    this.isInsuranceExsists(modal);
    this.resetInsuranceType(modal.providertype);
    if (modal.medicalinsuranceprovider !== null) {
      this.setProviderType(modal.medicalinsuranceprovider);
    }
    this.medAssistance = modal.medicalassistance;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.healthinsuranceForm.enable();
    this.enableorDisableField('ismedicaidmedicare', false);
  }

  public delete() {
    const modal = this.deleteItem; 

    const data = {
      'personhealthinsuranceid': modal.personhealthinsuranceid,
    };
    this._healthService.saveHealth({ 'insuranceInfo': [data] }, 2).subscribe(_ => {
        this._alertSevice.success('Insurance Information Deleted Successfully');
        this.resetForm();
        this.getInsuranceInfoList();
        (<any>$(this.deletepopupid)).modal('hide');
        this.deleteItem = null;
      });

  }

  cancel() {
    this.resetForm();
  }


  startDateChanged() {
    this.healthinsuranceForm.patchValue({ enddate: '' });
    const empForm = this.healthinsuranceForm.getRawValue();
    this.maxDate = new Date(empForm.enddate);    
  }
  endDateChanged() {
    this.healthinsuranceForm.patchValue({ startdate: '' });
    const empForm = this.healthinsuranceForm.getRawValue();
    this.minDate = new Date(empForm.startdate);    
  }

  private patchForm(modal: HealthInsuranceInformation) {
    this.healthinsuranceForm.patchValue(modal);
    this.healthinsuranceForm.patchValue({
      startdate: modal.effectivedate,
      enddate: modal.expirationdate
    });
    this.address.address1 =  modal.address1;
    this.address.address2 =  modal.address2;
    this.address.city =  modal.city;
    this.address.state =  modal.state;
    this.address.county =  modal.county;
    this.address.zipcode =  modal.zip;
    this.address.disable = false;
    this.dtDisable = false;
  }

  addInsuranceInfo() {
    this.isAddEdit = true;
  }

  getInsuranceInfoList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId}
    }, 'personhealthinsurance/list?filter').subscribe(res => {
     this.healthInsurance = res ? res.data : [];
           this.insuranceCheck = (this.healthInsurance as any[]).find(item => item.personhealthinsuranceid === this.insuranceid);
          if (this.insuranceCheck && this.insuranceid) {
              this.edit(this.insuranceCheck);
              this.insuranceid = null;
          }
    });
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
    (<any>$(this.deletepopupid)).modal('show');
  }

}
