
import {of as observableOf,  Observable  } from 'rxjs';
import { Component, OnInit, Injector } from '@angular/core';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { Validators, FormBuilder, FormGroup, FormControl } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { DataStoreService, CommonDropdownsService, AlertService, AuthService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { EmploymentProfileService } from '../employment-profile.service';
import { PersonInfoService } from '../../person-info.service';
import { InvolvedPersonsConstants } from '../../../../case-worker/dsds-action/involved-persons/_entities/involvedPersons.constants';
import { Employer, Work } from '../../../../case-worker/dsds-action/involved-persons/_entities/involvedperson.data.model';


@Component({
    selector: 'add-employment',
    templateUrl: './add-employment.component.html',
    styleUrls: ['./add-employment.component.scss'],
    standalone: false
})

export class AddEmploymentComponent implements OnInit {
  suggestedAddress$!: Observable<any[]>;
  personEmployeeFormGroup!: FormGroup;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  addresstypeDropdownItems$!: Observable<DropdownModel[]>;
  prefixDropdownItems$!: Observable<DropdownModel[]>;
  suffixDropdownItems$!: Observable<DropdownModel[]>;
  payperiodDropDownItem$!: Observable<DropdownModel[]>;
  personId: any=[];
  reportMode!: string;
  personAddressId: any=[];
  modalInt!: number;
  editMode!: boolean;
  employer: any=[];
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Work;
  work: Work = {};
  phoneNumberList :any= [];
  emailList:any = [];
  employmentStartDate: any=[];
  employeeButton:string = 'ADD';

  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _alertSevice: AlertService;
  private _employmentService: EmploymentProfileService;
  private _personService: PersonInfoService;
  private _dataStoreService: DataStoreService;
  public  _personInfoService: PersonInfoService;
  private _commonDropdownService: CommonDropdownsService;
  public  _authService: AuthService;

  constructor(private injector: Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._employmentService = this.injector.get<EmploymentProfileService>(EmploymentProfileService);
    this._personService =this.injector.get<PersonInfoService>(PersonInfoService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    }

  ngOnInit() {
    const personInfo = this._personInfoService.getPersonInfo();
    if (personInfo && personInfo.personbasicdetails) {
      this.employmentStartDate = personInfo.personbasicdetails.dob ? personInfo.personbasicdetails.dob : null;
      this.employeeButton = this._personInfoService.empActionText;
    }
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.initiateFormGroup();
    this.loadDropDown();
    this.phoneNumberList = this.getPhoneNumberList();
    this.emailList = this.getEmailList();
    this.personId = this._personService.getPersonId();
    if (this._personInfoService.workInfo && this._personInfoService.workInfo.personid) {
      this.updateFormView(this._personInfoService.workInfo);
    }
    this._personInfoService.workInfoListener$.subscribe( workInfo => {
          if (workInfo && workInfo.personid) {
            this.updateFormView(workInfo);
          }
    });
  }

  updateFormView(workInfo:any) {
    this.emailList = this.getEmailList();
    this.phoneNumberList = this.getPhoneNumberList();

    this.emailList = this.updateContactList(workInfo.email, this.emailList, 'email');
    this.phoneNumberList = this.updateContactList(workInfo.workphone, this.phoneNumberList, 'phonenumber');

    this.personEmployeeFormGroup.patchValue(workInfo);
}

private updateContactList(contactInfo: string | string[], contactList:any, contactField: string) {
    if (contactInfo && contactInfo.length > 0) {
        if (typeof contactInfo === 'string') {
            if (contactInfo.includes('[{')) {
                contactList = JSON.parse(contactInfo);
            } else {
                contactList[0][contactField] = contactInfo;
            }
        } else {
            contactList = contactInfo;
        }
    }
    return contactList;
}

  private initiateFormGroup() {
    this.personEmployeeFormGroup = this._formBuilder.group({
      employername: '',
      personworkcarrergoalid: '',
      personemploymentid: '',
      personemployerdetailid: '',
      noofhours: '',
      duties: '',
      startdate: [null],
      enddate: [null],
      reasonforleaving: '',
      addresstype: '',
      address1: '',
      address2: '',
      cityname: '',
      statetypekey: '',
      zip5no: new FormControl(null, [Validators.pattern('^[0-9]*$')]),
      countytypekey: '',
      EmailID: '',
      EmailType: '',
      fax: '',
      extension: '',
      contactnumber: '',
      contacttype: '',
      clienttitle: new FormControl('', Validators.pattern('[a-zA-Z ]*')),
      emplymenttypekey: '',
      workschedule: '',
      income: new FormControl('', [Validators.pattern('^[0-9]+([.][0-9]+)?$')]) ,
      wagefreqtypekey: '',
      supervisorfirstname: '',
      supervisormiddlename: '',
      supervisorlastname: '',
      supervisorsuffixtypekey: '',
      supervisorprefixtypekey: '',
      careergoals: ''
    });
    if (this._authService.iscaseclosed('personemployment') || !this._authService.isPersonSubTabViewable('person','person.Employment.add')) {
      this.personEmployeeFormGroup.disable();
    }
  }

  editAddress(model: { [x: string]: any; state?: any; personaddresstypekey?: any; address2?: any; danger?: any; dangerreason?: any; personaddressid?: any; }) {
    this.loadCounty(model.state);
    setTimeout(() => {
      this.personEmployeeFormGroup.patchValue(model);
      this.personEmployeeFormGroup.patchValue({
        addresstype: model.personaddresstypekey,
        address2: model.address2,
        knownDangerAddress: [model.danger ? 'yes' : 'no'],
        knownDangerAddressReason: model.dangerreason
      });
    }, 100);
    this.personAddressId = model.personaddressid;
    this.reportMode = 'edit';
  }
  addPersonEmployment() {
    if (this.personEmployeeFormGroup.invalid) {
      this.personEmployeeFormGroup.markAllAsTouched();
      return;
    }
    const data = this.personEmployeeFormGroup?.getRawValue();
    data.phoneNumberList = this.phoneNumberList;
    data.emailList = this.emailList;
    this._personInfoService.savePersonworkDetails(data).subscribe(response => {
      this._alertSevice.success('Employment details added successfully!');
      this._employmentService.isShowAddEmploymentEnabled(false);
      this._personInfoService.reloadworkDetails(1);
    }
    );
    this.employeeButton = 'ADD';
  }

  getSuggestedAddress() {
    if (this.personEmployeeFormGroup.value.address1 &&
        this.personEmployeeFormGroup.value.address1.length >= 3 ) {
         this.suggestAddress();
     }
 }
 suggestAddress() {
     this._commonHttpService
         .getArrayListWithNullCheck(
             {
                 method: 'post',
                 where: {
                     prefix: this.personEmployeeFormGroup.value.address1,
                     cityFilter: '',
                     stateFilter: '',
                     geolocate: '',
                     geolocate_precision: '',
                     prefer_ratio: 0.66,
                     suggestions: 25,
                     prefer: 'MD'
                 }
             },
             NewUrlConfig.EndPoint.Intake.SuggestAddressUrl
             ).subscribe(
              (result: any) => {
                if (result.length > 0) {
                this.suggestedAddress$ = observableOf(result);
              } else {
                this.suggestedAddress$ = observableOf([]);
              }
              }
            );
         }
     selectedAddress(model: { streetLine: any; city: any; state: any; }) {
      this.personEmployeeFormGroup.patchValue({
        address1: model.streetLine ? model.streetLine : '',
        cityname: model.city ? model.city : '',
        statetypekey: model.state ? model.state : ''
     });
      const addressInput = {
        street: model.streetLine ? model.streetLine : '',
        street2: '',
        city: model.city ? model.city : '',
        state: model.state ? model.state : '',
        zipcode: '',
        match: 'invalid'
      };
      this._commonHttpService
        .getSingle(
            {
                method: 'post',
                where: addressInput
            },
            NewUrlConfig.EndPoint.Intake.ValidateAddressUrl
        )
        .subscribe(
            (result) => {
                if (result[0].analysis) {
                    this.personEmployeeFormGroup.patchValue({
                        zip5no: result[0].components.zipcode ? result[0].components.zipcode : ''
                    });
                    if (result[0].metadata.countyName) {
                      this._commonHttpService.getArrayList(
                        {
                          nolimit: true,
                          where: { referencetypeid: 306, mdmcode:  {"like": this.personEmployeeFormGroup.value.statetypekey + "~%25","options":"i" }, description: result[0].metadata.countyName}, method: 'get'
                        },
                        'referencevalues?filter'
                    ) .subscribe(
                      (resultresp) => {
                        this.personEmployeeFormGroup.patchValue({
                          countytypekey: resultresp[0].ref_key
                      });
                      }
                    );
                  }
                 }
                }
        );

 }
 private loadDropDown() {
  this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
  this.countyDropDownItems$ = this._commonDropdownService.getPickListByName('county');
  this.payperiodDropDownItem$ = this._commonDropdownService.getPickListByName('wagefrequency');
  this.prefixDropdownItems$ = this._commonDropdownService.getPickListByName('prefix');
  this.suffixDropdownItems$ = this._commonDropdownService.getPickListByName('suffix');
  this.addresstypeDropdownItems$ =  this._commonDropdownService.getAddressType();

}
loadCounty(state: any) {
  this._commonDropdownService.getPickListByMdmcode(state.ref_key).subscribe(countyList => {
    this.countyDropDownItems$ = observableOf(countyList);
  });
}
private add() {
  this.employer.push(this.personEmployeeFormGroup?.getRawValue());
  this.updateData();
  this._alertSevice.success('Added Successfully');
  this.resetForm();
}

private resetForm() {

  this.modalInt = -1;
  this.editMode = false;
  this.reportMode = 'add';
  this.personEmployeeFormGroup.reset();
  this.personEmployeeFormGroup.enable();
  this.personEmployeeFormGroup?.get('enddate')?.enable();
  this.personEmployeeFormGroup?.get('enddate')?.setValidators([Validators.required]);
  this.personEmployeeFormGroup?.get('enddate')?.updateValueAndValidity();
  this.personEmployeeFormGroup?.get('reasonforleaving')?.enable();
  this.personEmployeeFormGroup?.get('reasonforleaving')?.setValidators([Validators.required]);
  this.personEmployeeFormGroup?.get('reasonforleaving')?.updateValueAndValidity();
}

private update() {
  if (this.modalInt !== -1) {
    this.employer[this.modalInt] = this.personEmployeeFormGroup?.getRawValue();
  }
  this.updateData();
  this.resetForm();
  this._alertSevice.success('Updated Successfully');
}

private updateData() {
  this.work = this._dataStoreService.getData(this.constants.Work);
  this.work.employer = this.employer;
  this._dataStoreService.setData(this.constants.Work, this.work);
}


  cancelForm() {
    this._employmentService.isShowAddEmploymentEnabled(false);
  }

  private patchForm(modal: Employer) {
    this.personEmployeeFormGroup.patchValue(modal);
  }

  private edit(modal: Employer, i: number) {
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.personEmployeeFormGroup.enable();
    this.isCurrentEmployerSaved(modal.currentemployer);
  }

  isCurrentEmployerSaved(control: any) {
    if (control) {

      this.personEmployeeFormGroup?.get('enddate')?.disable();
      this.personEmployeeFormGroup?.get('enddate')?.clearValidators();
      this.personEmployeeFormGroup?.get('enddate')?.updateValueAndValidity();
      this.personEmployeeFormGroup?.get('reasonforleaving')?.disable();
      this.personEmployeeFormGroup?.get('reasonforleaving')?.clearValidators();
      this.personEmployeeFormGroup?.get('reasonforleaving')?.updateValueAndValidity();
    } else {

      this.personEmployeeFormGroup?.get('enddate')?.enable();
      this.personEmployeeFormGroup?.get('enddate')?.setValidators([Validators.required]);
      this.personEmployeeFormGroup?.get('enddate')?.updateValueAndValidity();
      this.personEmployeeFormGroup?.get('reasonforleaving')?.enable();
      this.personEmployeeFormGroup?.get('reasonforleaving')?.setValidators([Validators.required]);
      this.personEmployeeFormGroup?.get('reasonforleaving')?.updateValueAndValidity();
    }
  }

  private delete(index: any) {
    this.employer.splice(index, 1);
    this.updateData();
    this._alertSevice.success('Deleted Successfully');
    this.resetForm();
  }

  getPhoneNumberList() {
    // check for phone number api a list once both associated with address.
    // assign phoneNumberList
      // set the phone list here on edit
    return [{
      contactType: '',
      phonenumber: null
    }];
  }

  getEmailList() {
     // check for  email api list once both associated with address.
    // assign phoneNumberList, emailList
    // set the email List  on edit
    return [{
      type: 'Primary',
      email: null
    },
    {
      type: 'Secondary',
      email: null
    }];
  }

  setMaxDate(type: string) {
    if (type === 'startdate') {
      const formenddate = this.personEmployeeFormGroup?.getRawValue().enddate;
      const enddate = (formenddate) ? new Date(formenddate) : new Date();
      const currdate = new Date();
      return (enddate < currdate) ? enddate : currdate;
    }
    if (type === 'enddate') {
      return new Date();
    }
  }
}
