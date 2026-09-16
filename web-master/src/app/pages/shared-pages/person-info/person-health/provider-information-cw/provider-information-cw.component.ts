
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { DataStoreService } from '../../../../../@core/services/data-store.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, CommonHttpService, ValidationService, AuthService, CommonDropdownsService } from '../../../../../@core/services';
// tslint:disable-next-line:import-blacklist
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { Physician, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'provider-information-cw',
    templateUrl: './provider-information-cw.component.html',
    styleUrls: ['./provider-information-cw.component.scss'],
    standalone: false
})
export class ProviderInformationCwComponent implements OnInit {
  minDate = new Date();
  maxDate = new Date();
  providerForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  mandatoryField!: boolean;
  reportMode!: string;
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  specialty$!: Observable<DropdownModel[]>;
  degreeType$!: Observable<DropdownModel[]>;
  specialty: any = [];
  providercw: Physician[] = [];
  health: Health = {};
  uploadedFiles: any[] = [];
  uploadNumber = '123434';
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  personId!: string;
  isAddEdit = false;
  teamTypeKey!: string;
  address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
  personPhycisianInfoId!: string;
  selectedItem: any;
  dtDisable = false;
  maximumDate: Date = new Date();
  toMinDate: Date | null = null;
  isClosed = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  load:boolean = false;
  educationStartDate: any;
  retrydoc: any = false;
  providerListCheck: any;
  providerinfoid: any;

  private formbulider: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _personInfoService: PersonInfoService;
  private _authService: AuthService;
  private _commonDropDownService: CommonDropdownsService;
  private route: ActivatedRoute;

  constructor(private injector: Injector){
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.providerinfoid = params['retryid'];
    });
  }

  ngOnInit() {
    this.personId =  this._personInfoService.getPersonId();
    this.teamTypeKey = this._authService.getAgencyName();
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.providerForm = this.formbulider.group({
      'personphycisianinfo_id' : null,
      'is_primary_care_physician': [null, Validators.required],
      'physician_name': ['', Validators.required],
      'physician_speciality': ['', Validators.required],
      'physician_facility': '',
      'physician_phone': '',
      'physician_email': ['', ValidationService.mailFormat],
      'start_Date': '',
      'End_Date': '',
      'otherspeciality': '',
      'degreetype': '',
      'physician_child_lang_check': '',
      'translation_service_available': ''
    });

    this.initializeProvider();
    this.loadDropDowns();
    this.getProviderInfoList();
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.provideradd');
    this.route.queryParams.subscribe(params => {
      const status = params['providerInfo'];
      if (status) {
        const providerInfo = JSON.parse(this._dataStoreService.getData('providerInfo-health-summary'));
        providerInfo.is_primary_care_physician = providerInfo.is_primary_care_physician === 'Yes';
        this.view(providerInfo);
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
  
  initializeProvider() {
    this.health = this._dataStoreService.getData(this.constants.Health);

    if (this.health && this.health.physician) {
      this.providercw = this.health.physician;
    }

    this.resetForm();
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
          order: 'description'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.physicianspecialtytype + '?filter'
      ),
      this._commonHttpService
      .getArrayList(
        {
            where: { referencetypeid: 335, teamtypekey: this.teamTypeKey },
            method: 'get'
        },
        'referencetype/gettypes' + '?filter'
      )
    ]).pipe(
      map((result: any) => {
        result[3].forEach((type: any) => {
          this.specialty[type.physicianspecialtytypekey] = type.description;
        });
        return {
          ethinicities: result[0].map(
            (res: { typedescription: any; ethnicgrouptypekey: any; }) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.ethnicgrouptypekey
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
          specialty: result[3].map(
            (res: { description: any; physicianspecialtytypekey: any; }) =>
              new DropdownModel({
                text: res.description,
                value: res.physicianspecialtytypekey
              })
          ),
          degreeType: result[4].map(
            (res: { description: any; ref_key: any; }) =>
              new DropdownModel({
                text: res.description,
                value: res.ref_key
              })
          )
        };
      }),
      share(),);
    this.countyDropDownItems$ = source.pipe(pluck('counties'));
    this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.degreeType$ = source.pipe(pluck('degreeType'));
    this.specialty$ = source.pipe(pluck('specialty'));
  }
  getValidationMessage(controlName: any, displayname: any){
 
    if(this.providerForm.controls[controlName].status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}
  add() {
    this.mandatoryField=true;
    if(this.providerForm.invalid ||! (this.address.address1)){
      return;
    }
      const data = {...this.providerForm.getRawValue(), ...this.address};
      const providerInfo = {
        is_primary_care_physician	 : data.is_primary_care_physician,
        physician_name               : data.physician_name,
        physician_speciality         : data.physician_speciality,
        physician_facility           : data.physician_facility,
        physician_child_lang_check   : data.physician_child_lang_check,
        translation_service_available: data.translation_service_available,
        start_Date                   : data.start_Date,
        End_Date                     : data.End_Date,
        physician_phone              : data.physician_phone,
        physician_email              : data.physician_email,
        otherspeciality              : data.otherspeciality,
        degreetype                   : data.degreetype,
        uploadpath: this.uploadedFiles

      };

      if (providerInfo.uploadpath) {
        providerInfo.uploadpath.forEach(document => {
          if (document.percentage) {
            delete document.percentage;
          }
        });
      }

      const providerInfoData = { ...providerInfo, ...this.address };
      const provider_info = { provider_info : [providerInfoData] };
      this._healthService.saveHealth({ 'personProviderHistory':  [provider_info] }).subscribe(response => {
        this._alertSevice.success('Provider Information Added Successfully');
        this.resetAll();
        this.getProviderInfoList();
      });
   // }
  }

    resetForm() {
    this.uploadedFiles = [];
    this.providerForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.dtDisable = false;
    this.providerForm.enable();
    this.selectedItem = null;
    this.resetAddress();
  }

  resetAll() {
    this.resetAddress();
    this.isAddEdit = false;
    this.resetForm();
    this.uploadedFiles = [];
  }

  resetAddress() {
    this.address = { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false};
  }

  update() {
    this.mandatoryField=true;
    if(this.providerForm.invalid ||! (this.address.address1)){
      return;
    }

      const data = {...this.providerForm.getRawValue(), ...this.address};
      const providerInfo = {
        is_primary_care_physician	 : data.is_primary_care_physician,
        physician_name               : data.physician_name,
        physician_speciality         : data.physician_speciality,
        physician_facility           : data.physician_facility,
        physician_child_lang_check   : data.physician_child_lang_check,
        translation_service_available: data.translation_service_available,
        start_Date                   : data.start_Date,
        End_Date                     : data.End_Date,
        physician_phone              : data.physician_phone,
        physician_email              : data.physician_email,
        otherspeciality              : data.otherspeciality,
        degreetype                   : data.degreetype,
        personphycisianinfo_id      :  this.personPhycisianInfoId,
        uploadpath: this.uploadedFiles

      };

      if (providerInfo.uploadpath) {
        providerInfo.uploadpath.forEach(document => { // NOSONAR  // This function has less than 3 lines of identical code. Hence, marking it as no sonar.
          if (document.percentage) {
            delete document.percentage;
          }
        });
      }

      const providerInfoData = { ...providerInfo, ...this.address, }
      const provider_info = { provider_info : [providerInfoData] };
      this._healthService.saveHealth({ 'personProviderHistory':  [provider_info] }, 0).subscribe(response => {
        this._alertSevice.success('Provider Information Updated Successfully');
        this.resetAll();
        this.getProviderInfoList();
      });
  }

  view(modal: any) {
    this.address = {
      address1: modal.address1,
      address2: modal.address2,
      city: modal.city,
      state: modal.state,
      zipcode: modal.zipcode,
      county: modal.county,
      disable: true
    };
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.address.address1 = modal.address1;
    this.address.address2 = modal.address2;
    this.address.city = modal.city;
    this.address.state = modal.state;
    this.address.zipcode = modal.zipcode;
    this.address.county = modal.county;
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    modal.start_Date = this._commonDropDownService.getValidDate(modal.startdate);
    modal.End_Date =  this._commonDropDownService.getValidDate(modal.enddate);
    this.patchForm(modal);
    this.editMode = false;
    this.dtDisable = true;
    this.providerForm.disable();
  }

  edit(modal: any, i?: any) {
    this.address = {
      address1: modal.address1,
      address2: modal.address2,
      city: modal.city,
      state: modal.state,
      zipcode: modal.zipcode,
      county: modal.county,
      disable: false
    };
    this.personPhycisianInfoId = modal.personphycisianinfo_id;
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.address.address1 = modal.address1;
    this.address.address2 = modal.address2;
    this.address.city = modal.city;
    this.address.state = modal.state;
    this.address.zipcode = modal.zipcode;
    this.address.county = modal.county;
    modal.start_Date = this._commonDropDownService.getValidDate(modal.startdate);
    modal.End_Date =  this._commonDropDownService.getValidDate(modal.enddate);
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.patchForm(modal);
    this.providerForm.enable();
  }
  cancel() {
    this.isAddEdit = false;
    this.resetForm();
  }

  startDateChanged(startDate: string) {
    this.toMinDate = new Date(startDate);
  }
  endDateChanged(endDate: string) {
    this.maximumDate = new Date(endDate);
  }

  private patchForm(modal: Physician) {
    this.providerForm.patchValue(modal);

    if (modal.startdate) {
      this.providerForm.patchValue({startdate: new Date(modal.startdate)});
    }
    if (modal.enddate) {
      this.providerForm.patchValue({enddate: new Date(modal.enddate)});
    }
    this.dtDisable = false;
  }

  addProviderInfo() {
    this.isAddEdit = true;
  }

  getProviderInfoList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId}
    }, 'personphycisianinfo/getproviderinfo?filter').subscribe(res => {
      this.providercw = res ? res.data : [];
      this.providerListCheck = this.providercw.find(item => item.personphycisianinfo_id === this.providerinfoid);
      if (this.providerListCheck && this.providerinfoid) {
          this.edit(this.providerListCheck);
          this.providerinfoid = null;
      }
    });
  }

  deleteConfirm(item: any, index: any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedItem = item;
  }

  delete() {
    const data = {
      'personphycisianinfo_id': this.selectedItem.personphycisianinfo_id,
    };
    const provider_info = { provider_info : [data] };
    this._healthService.saveHealth({ 'personProviderHistory': [provider_info] }, 2).subscribe(_ => {
      this._alertSevice.success('Provider Information Deleted Successfully');
      this.resetForm();
      this.getProviderInfoList();
    });
  }

  formatPhoneNumber(phoneNumber: string) {
    return this._commonDropDownService.formatPhoneNumber(phoneNumber);
  }

}
