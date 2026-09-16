import { Component, OnInit, Injector, ViewChild, ElementRef, ViewEncapsulation } from '@angular/core';
import { CommonDropdownsService, CommonHttpService, AlertService, GenericService, ValidationService } from '../../../../@core/services';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { PersonInfoService } from '../person-info.service';
import { AddressDetailsService } from '../address-details/address-details.service';
import { AddressType } from '../../../admin/general/_entities/general.data.models';
import { MatDialog } from '@angular/material/dialog';
import { PrimaryPhoneNumberDialogComponent } from './primary-phone-number-dialog/primary-phone-number-dialog.component';
@Component({
    selector: 'contact-info',
    templateUrl: './contact-info.component.html',
    styleUrls: ['./contact-info.component.scss'],
    encapsulation: ViewEncapsulation.None,
    standalone: false
})
export class ContactInfoComponent implements OnInit {
  contactTypes: any[]=[];
  personPhoneFormGroup!: FormGroup;
  personEmailFormGroup!: FormGroup;
  phoneList :any= [];
  emailList:any = [];
  personId: any;
  reportPhoneMode: string='';
  personPhoneId: any;
  reportEmailMode: string='';
  personEmailId: any;
  deleteType = null;
  deleteId :any= null;
  addedit = 'Add New';
  primaryemailList: any[]=[];
  maxDate: any;
  isprimaryemailadded= false;
  isprimaryadded: boolean=false;
  deletepopupid = '#delete-popup';
  currentDate = new Date();
  primaryPhoneNumberTooltip: string = 'Click the Primary Radio Button to identify ONE (1) Primary Phone Number for a person. This number will pull to any assessment, form, or report as the preferred phone number for this person.';
  @ViewChild('dialog') dialogElement!: ElementRef<any>;
  
  private _commonDropDownService: CommonDropdownsService;
  private _formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _alertservices: AlertService;
  public _personService: PersonInfoService;
  private _addressService: AddressDetailsService;
  private _service_address: GenericService<AddressType>;
  public dialog: MatDialog;
  
  constructor(private injector: Injector){
    this._commonDropDownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertservices = this.injector.get<AlertService>(AlertService);
    this._personService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._addressService = this.injector.get<AddressDetailsService>(AddressDetailsService);
    this._service_address = this.injector.get<GenericService<AddressType>>(GenericService);
    this.dialog = this.injector.get<MatDialog>(MatDialog);
}

  ngOnInit() {
    this.reportPhoneMode = 'add';
    this.reportEmailMode = 'add';
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
    this._commonDropDownService.getPickListByName('phonetype').subscribe(contactTypes => {
      if (contactTypes && Array.isArray(contactTypes)) {
        this.contactTypes = contactTypes.filter(contact => contact.ref_key !== 'PRI' && contact.ref_key !== 'SEC');
      }
    });
    this.initializePhoneForm();
    this.initializeEmailForm();
    this._addressService.getEmailList(this.personId);
    this._addressService.getPhoneList(this.personId);
    this.getPhoneNumberList();
    this.getEmailList();
  }

  openDialog() {
    (<any>$('#phoneinfo-popup')).modal('show');   
  }

  closeDialog() {
   (<any>$('phoneinfo-popup')).modal('hide');
  }

  initializePhoneForm() {
    this.personPhoneFormGroup = this._formBuilder.group({
      phonenumber: ['', [Validators.required]],
      personphonetypekey: ['', [Validators.required]],
      startdate: [''],
      enddate: [''],
      isprimary: [false],
      commentsphone: ''
    });
  }

  initializeEmailForm() {
    this.personEmailFormGroup = this._formBuilder.group({
      email: ['', [ValidationService.mailFormat]],
      personemailtypekey: ['', [Validators.required]],
      startdate: [''],
      enddate: [''],
      commentsemail: ''
    });
  }

  resetPhone() {
    this.addedit = 'Add New';
    this.reportPhoneMode = 'add';
    this.personPhoneFormGroup.reset();
  }

  resetEmail() {
    this.reportEmailMode = 'add';
    this.addedit = 'Add New';
    this.personEmailFormGroup.reset();
    if (this.emailList && this.emailList.length > 0) {
      this.primaryemailList = this.emailList.filter((email:any)=> email.personemailtypekey === 'P');
      if (this.primaryemailList.length > 0) {
        this.isprimaryadded = true;
      } else {
        this.isprimaryadded = false;
      }
    } else {
        this.isprimaryadded = false;
    }
  }
  private validatePhoneForm(): boolean {
    if (this.personPhoneFormGroup.controls.personphonetypekey.value !== 'OTH' 
        || !this.personPhoneFormGroup.controls.personphonetypekey.value) {
      this.toggleCommentsPhoneField('');
    }
  
    if (this.personPhoneFormGroup.invalid) {
      this.personPhoneFormGroup.markAllAsTouched();
      this._alertservices.error('Please fill required fields');
      return false;
    }
    return true;
  }
  addPhone() {
    if (!this.validatePhoneForm()) {
      return;
    }
    const today = new Date(new Date().toLocaleDateString());
    const primaryPhoneNumber:any = this.phoneList && this.phoneList.find((item:any) => item.isprimary && ((item.enddate && new Date(item.enddate) >= today) || !item.enddate) );
    const personPhoneForm = this.personPhoneFormGroup.getRawValue();
    let isEditingPhoneNumberIsPrimary = true;
    const formIsPrimary = Array.isArray(personPhoneForm.isprimary) ? personPhoneForm.isprimary[0] : personPhoneForm.isprimary;
    isEditingPhoneNumberIsPrimary = this.handleIfEditFn(isEditingPhoneNumberIsPrimary, formIsPrimary);
    if(primaryPhoneNumber && formIsPrimary &&  personPhoneForm.phonenumber !== primaryPhoneNumber.phonenumber && isEditingPhoneNumberIsPrimary) {
      this.openPrimaryPhoneNumberDialog(primaryPhoneNumber, personPhoneForm);
    } else {
      this.addUpdatePhoneNumber(personPhoneForm);
    }
    if(this.personPhoneFormGroup.invalid){
      this.personPhoneFormGroup.markAllAsTouched();
      this._alertservices.error('Please fill required fields');
      return;
    }
    const checkDuplicate = this.phoneList.find((x:any) => x.phonenumber == personPhoneForm.phonenumber && x.personphonetypekey == personPhoneForm.personphonetypekey);
    if (checkDuplicate && personPhoneForm.enddate == null) {
      this._alertservices.error('Entered phone number is already exist and active.');
    }
  }
  // Assosiated with addPhone method
  private handleIfEditFn(isEditingPhoneNumberIsPrimary: boolean, formIsPrimary: any) {
    if (this.addedit === 'Edit') {
      const currentPhoneNumberData:any = this.phoneList.find((item:any) => item.personphonenumberid === this.personPhoneId);
      const isPrimaryCurrent = !!currentPhoneNumberData.isprimary;
      isEditingPhoneNumberIsPrimary = isPrimaryCurrent === false && formIsPrimary === true;
    }
    return isEditingPhoneNumberIsPrimary;
  }
  private openPrimaryPhoneNumberDialog(primaryPhoneNumber: any, personPhoneForm: any): void {
    primaryPhoneNumber.type = this.getPhoneType(primaryPhoneNumber.personphonetypekey);
    primaryPhoneNumber.phonenumber = this.formatPhoneNumber(primaryPhoneNumber.phonenumber);
    primaryPhoneNumber.currentPhoneNumber = this.formatPhoneNumber(personPhoneForm.phonenumber);
  
    const dialogRef = this.dialog.open(PrimaryPhoneNumberDialogComponent, {
      width: '625px',
      height: '210px',
      data: primaryPhoneNumber,
      position: { top: '10%' }
    });
  
    dialogRef.afterClosed().subscribe(result => {
      if (result) {
        this.addUpdatePhoneNumber(personPhoneForm);
      } else {
        this.personPhoneFormGroup.patchValue({ isprimary: [false] });
      }
    });
  }
  addUpdatePhoneNumber(personPhoneForm: any) {
    const personPhoneId = (this.reportPhoneMode === 'add') ? null : this.personPhoneId;
    const addupdatePhone = [];
    addupdatePhone.push({
      personphonenumberid: personPhoneId,
      personid: this.personId,
      personphonetypekey: personPhoneForm.personphonetypekey,
      phonenumber: personPhoneForm.phonenumber,
      startdate: personPhoneForm.startdate ? new Date(personPhoneForm.startdate) : null,
      enddate: personPhoneForm.enddate ? new Date(personPhoneForm.enddate) : null,
      isprimary: (Array.isArray(personPhoneForm.isprimary) ? personPhoneForm.isprimary[0] : personPhoneForm.isprimary) || null,
      phoneextension: null,
      commentsphone: personPhoneForm.commentsphone
    });

    this._commonHttpService.create({ 'addupdatephonenumber': addupdatePhone }, 
      CommonUrlConfig.EndPoint.PERSON.PHONE.AddUpdatePhone).subscribe(result => {
        this._alertservices.success('Phone details Added/Updated successfully!');
        (<any>$('#addPhone')).modal('hide');
        this.reportPhoneMode = 'add';
        this._addressService.getPhoneList(this.personId);
        this.getPhoneNumberList();
      },
      error => {
        this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
  addEmail() {
    if (this.personEmailFormGroup.controls.personemailtypekey.value === 'O' || !this.personEmailFormGroup.controls.personemailtypekey.value) {
      this.toggleCommentsEmailField('');
    }
    if(this.personEmailFormGroup.invalid){
      this.personEmailFormGroup.markAllAsTouched();
      this._alertservices.error('Please fill required fields');
      return;
    }
    const personEmailForm = this.personEmailFormGroup.getRawValue();
    if (personEmailForm.personemailtypekey === 'S') {
     this.primaryemailList = this.emailList.filter((email:any) => email.personemailtypekey === 'P');
     if (this.primaryemailList.length > 0) {
      this.isprimaryemailadded = true;
      } else {
      this._alertservices.error('Please enter primary email address!');
         }
    } else {
      this.isprimaryemailadded = true;
    }
    if (this.isprimaryemailadded === true) {
    const personEmailId = (this.reportEmailMode === 'add') ? null : this.personEmailId;
    const addupdateemail = [];
    addupdateemail.push({personemailid: personEmailId,
        personid: this.personId,
        personemailtypekey: personEmailForm.personemailtypekey,
        email: personEmailForm.email,
        startdate: personEmailForm.startdate ? new Date(personEmailForm.startdate) : null,
        enddate: personEmailForm.enddate ? new Date(personEmailForm.enddate) : null,
        commentsemail: personEmailForm.commentsemail
    });

   this._commonHttpService.create({'addupdateemail': addupdateemail}, CommonUrlConfig.EndPoint.PERSON.EMAIL.AddUpdateEmail).subscribe(
      result => {
        this._alertservices.success('Email details Added/Updated successfully!');
        (<any>$('#addEmail')).modal('hide');
        this.reportEmailMode = 'add';
        this._addressService.getEmailList(this.personId);
        this.getEmailList();
      },
      error => {
        this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
    }
  }

  getPhoneNumberList() {
    this._addressService.phonePersonType$.subscribe( (data) => {
      this.phoneList = [];
      if (data.length > 0) {
        this.phoneList = data;
      }
    });
  }

  getEmailList() {
    this._addressService.emailPersonType$.subscribe( (data) => {
      this.emailList = [];
      if (data.length > 0) {
        this.emailList  = data;
      }
    });
  }

  getPhoneType(type:any) {
    if (this.contactTypes && type) {
      const typeObj = this.contactTypes.find(data => data.ref_key === type);
      return typeObj? typeObj.description : '';
    }
    return '';
  }

  getEmailType(type:any) {
    if (type) {
      let emailType = '';
      if (type === 'P') {
        emailType = 'Primary';
      } else if (type === 'S') {
        emailType = 'Secondary';
      } else if (type === 'O') {
        emailType = 'Other';
      }      
      return emailType;
    }
    return '';
  }

  editPhone(data:any) {
    this.addedit = 'Edit';
    this.reportPhoneMode = 'edit';
    data.startdate = this._commonDropDownService.getValidDate(data.startdate);
    data.enddate = this._commonDropDownService.getValidDate(data.enddate);
    this.personPhoneFormGroup.patchValue(data);
    this.personPhoneId = data.personphonenumberid;
  }

  editEmail(data:any) {
    if (data.personemailtypekey === 'P') {
      this.isprimaryadded = false;
    } else {
      if (this.emailList && this.emailList.length > 0) {
        this.primaryemailList = this.emailList.filter((email:any) => email.personemailtypekey === 'P');
        if (this.primaryemailList.length > 0) {
          this.isprimaryadded = true;
        } else {
          this.isprimaryadded = false;
        }
      } else {
          this.isprimaryadded = false;
      }
    }
    this.addedit = 'Edit';
    this.reportEmailMode = 'edit';
    data.startdate = this._commonDropDownService.getValidDate(data.startdate);
    data.enddate = this._commonDropDownService.getValidDate(data.enddate);
    this.personEmailFormGroup.patchValue(data);
    this.personEmailId = data.personemailid;
  }

  confirmDelete(id:any, type:any, typekey:any) {
    this.deleteType = type;
    this.deleteId = id;
    if ((type === 'email') && (typekey === 'P')) {
    this.primaryemailList = this.emailList.filter((email:any) => email.personemailtypekey === 'P');
     if (this.primaryemailList.length < 2) {
      this._alertservices.error('Please make sure to have atleast one primary email address!');
     }
    }
    (<any>$(this.deletepopupid)).modal('show');
  }

  declineDelete() {
    this.deleteType = null;
    this.deleteId = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }

  deletePhoneEmail() {
    if (this.deleteId) {
      const url = (this.deleteType === 'email') ? CommonUrlConfig.EndPoint.PERSON.EMAIL.DeleteEmailUrl : CommonUrlConfig.EndPoint.PERSON.PHONE.DeletePhoneUrl;
      this._service_address.endpointUrl =  url;
      this._service_address.remove(this.deleteId).subscribe(
        response => {
          (<any>$(this.deletepopupid)).modal('hide');
          const deleteType = (this.deleteType === 'email') ? 'Email' : 'Phone';
          this._alertservices.success(deleteType + ' deleted successfully..');

          if (this.deleteType === 'email') {
            this._addressService.getEmailList(this.personId);
            this.getEmailList();
          } else {
            this._addressService.getPhoneList(this.personId);
            this.getPhoneNumberList();
          }
        },
        error => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
      (<any>$(this.deletepopupid)).modal('hide');
    }
  }

  formatPhoneNumber(phoneNumber: string) {
    return this._commonDropDownService.formatPhoneNumber(phoneNumber);
  }

  toggleCommentsEmailField(selectedValue: string): void {
    const commentsControl = this.personEmailFormGroup.get('commentsemail');
  
    if (selectedValue === 'O') {
      commentsControl?.setValidators([Validators.required]);
    } else {
      commentsControl?.clearValidators();
    }
  
    commentsControl?.updateValueAndValidity();
  }

  toggleCommentsPhoneField(selectedValue: string): void {
    const commentsControl = this.personPhoneFormGroup.get('commentsphone');
  
    if (selectedValue === 'OTH') {
      commentsControl?.setValidators([Validators.required]);
    } else {
      commentsControl?.clearValidators();
    }
  
    commentsControl?.updateValueAndValidity();
  }
}