
import {of as observableOf,  Observable ,  forkJoin } from 'rxjs';

import {share, map, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ControlUtils } from '../../../@core/common/control-utils';
import { AlertService, GenericService } from '../../../@core/services';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { ValidationService } from '../../../@core/services/validation.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { ErrorInfo } from '../../../@core/common/errorDisplay';
import { HttpService } from '../../../@core/services/http.service';
import { PhoneType, EmailType } from '../../admin/general/_entities/general.data.models';
import { PersonDetailsService } from '../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'contact-details',
    templateUrl: './contact-details.component.html',
    styleUrls: ['./contact-details.component.scss'],
    standalone: false
})
export class ContactDetailsComponent implements OnInit {

  personPhoneForm!: FormGroup;
  personEmailForm!: FormGroup;
  phoneNumber: any[] = [];
  emailID: any[] = [];
  emailID$= new Observable<EmailType[]>();
  phoneNumber$= new Observable<PhoneType[]>();
  phoneTypeDropdownItems$!: Observable<DropdownModel[]>;
  emailTypeDropdownItems$!: Observable<DropdownModel[]>;
  addPhoneType!: PhoneType;
  emailIDType!: EmailType;
  endpointUrl!: string;
  error: ErrorInfo = new ErrorInfo();
  paginationInfo: any;
  personemailid: any;
  personphonenumberid: any;
  i: any;
  deletepopupid = '#delete-popup';
  deletemailpopupid = '#delete-popup-mail';
  constructor(private _formBuilder: FormBuilder,
    private _alertService: AlertService, private _commonHttpService: CommonHttpService, private http: HttpService, public personService: PersonDetailsService,
    private _service_phone: GenericService<PhoneType>,
    private _service_email: GenericService<EmailType>) { }

  ngOnInit() {
    this.intializeForm();
    this.loadDropDown();
    this.getPage(1);
    this.getEmailPage(1);
  }

  intializeForm() {
      this.personEmailForm = this._formBuilder.group({
          EmailID: ['', [ValidationService.mailFormat, Validators.required]],
          EmailType: ['', Validators.required]
    });
      this.personPhoneForm = this._formBuilder.group({
        phonenumber: ['', Validators.required],
        ismobile: ['', Validators.required],
        contacttype: ['', Validators.required]
    });
  }

  loadDropDown() {
    const source = forkJoin([this._commonHttpService.getArrayList(
      {
          method: 'get',
          nolimit: true,
          filter: {}
      },
      NewUrlConfig.EndPoint.Intake.PhoneTypeUrl + '?filter'),

      this._commonHttpService.getArrayList(
        {
            method: 'get',
            nolimit: true,
            filter: {}
        },
        NewUrlConfig.EndPoint.Intake.EmailTypeUrl + '?filter'
    )]).pipe(map((data) => {
      return {
        phoneType: data[0].map((res) => new DropdownModel({
              text: res.typedescription,
              value: res.personphonetypekey
          })
        ),
        emailType: data[1].map(
          (res) =>
              new DropdownModel({
                  text: res.typedescription,
                  value: res.personemailtypekey
              })
        )
      };
    }));

    this.phoneTypeDropdownItems$ = source.pipe(pluck('phoneType'));
    this.emailTypeDropdownItems$ = source.pipe(pluck('emailType'));
  }

  addPhone(addPhoneType: any) {
    const phonenum = this.personPhoneForm.get('phonenumber')?.value;
    const phoneType = this.personPhoneForm.get('contacttype')?.value;
    const mobile = this.personPhoneForm.get('ismobile')?.value;

    if (phonenum && phoneType) {
        addPhoneType.phonenumber = phonenum;
        addPhoneType.personphonetypekey = phoneType;
        addPhoneType.personid = this.personService.person.personid;
        addPhoneType.ismobile = mobile;
        this._commonHttpService.create(addPhoneType, CommonUrlConfig.EndPoint.PERSON.PHONE.AddUpdatePhone).subscribe(
          result => {
              this._alertService.success('Phone details Added/Updated successfully!');
              this.getPage(1);
          },
          error => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
      );
        this.personPhoneForm.reset();
    } else {
        this._alertService.warn('Please fill mandatory fields for Phone');
        ControlUtils.validateAllFormFields(this.personPhoneForm);
    }
  }

  getPage(page: number) {
    const source = this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest(
                {
                    method: 'get',
                    where: { personid: this.personService.person.personid },
                    page: 1, // this.paginationInfo.pageNumber,
                    limit: 10// this.paginationInfo.pageSize,
                }),
                CommonUrlConfig.EndPoint.PERSON.PHONE.ListPhoneUrl + '?filter'
        ).pipe(map((result: any) => {
            return {
                data: result,
                count: result.length > 0 ? result[0].totalcount : 0
            };
        }),share(),);
    this.phoneNumber$ = source.pipe(pluck('data'));
    this.phoneNumber$.subscribe(
       result => {
          // No content to add or call
       }
  );
}

  getUrl(url: string) {
    return url ? url : this.endpointUrl;
  }


  addEmail(emailIDType: any) {
    const emailID = this.personEmailForm.get('EmailID')?.value;
    const emailType = this.personEmailForm.get('EmailType')?.value;
    emailIDType.email = emailID;
    emailIDType.personemailtypekey = emailType;
    emailIDType.personid = this.personService.person.personid;
    if (emailID && this.personEmailForm.invalid) {
        this._alertService.warn('Please enter a valid email id');
        return;
    }
    if (emailID && emailType && this.personEmailForm.valid) {
        this._commonHttpService.create(emailIDType, CommonUrlConfig.EndPoint.PERSON.EMAIL.AddUpdateEmail).subscribe(
          result => {
              this._alertService.success('Email details Added/Updated successfully!');
              this.getEmailPage(1);
          },
          error => {
              this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
      );
        this.personEmailForm.reset();
    } else {
        this._alertService.warn('Please fill mandatory fields for Email');
        ControlUtils.validateAllFormFields(this.personEmailForm);
    }
  }

  getEmailPage(page: number) {
    const source = this._commonHttpService
        .getPagedArrayList(
            new PaginationRequest(
                {
                    method: 'get',
                    where: { personid: this.personService.person.personid },
                    page: 1, // this.paginationInfo.pageNumber,
                    limit: 10// this.paginationInfo.pageSize,
                }),
                CommonUrlConfig.EndPoint.PERSON.EMAIL.ListEmail + '?filter'
        ).pipe(map((result: any) => {
            return {
                data: result,
                count: result.length > 0 ? result[0].totalcount : 0,
            };
        }),share(),);
    this.emailID$ = source.pipe(pluck('data'));
}


  deletePhone() {
      if (this.personphonenumberid) {
          this._service_phone.endpointUrl = CommonUrlConfig.EndPoint.PERSON.PHONE.DeletePhoneUrl;
          this._service_phone.remove(this.personphonenumberid).subscribe(
              response => {
                  this.phoneNumber.splice(this.personphonenumberid, 1);
                  this.phoneNumber$ = observableOf(this.phoneNumber);
                  (<any>$(this.deletepopupid)).modal('hide');
                  this._alertService.success('Phone Number deleted successfully..');
                  this.getPage(1);
                  this.personPhoneForm.reset();
                  this.personPhoneForm.enable();
              },
              error => {
                  this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
          );
      } else {
          this.phoneNumber.splice(this.personphonenumberid, 1);
          this.phoneNumber$ = observableOf(this.phoneNumber);
          this._alertService.success('Phone Number deleted successfully');
          this.getPage(1);
      }
  }

  confirmDelete(personphonenumberid: any) {
    this.personphonenumberid = personphonenumberid;
    (<any>$(this.deletepopupid)).modal('show');
  }

  declineDelete() {
    this.personphonenumberid = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }

  deleteEmail() {
      if (this.personemailid) {
          this._service_email.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EMAIL.DeleteEmailUrl;
          this._service_email.remove(this.personemailid).subscribe(
              response => {
                  this.emailID.splice(this.personemailid, 1);
                  this.emailID$ = observableOf(this.emailID);
                  (<any>$(this.deletemailpopupid)).modal('hide');
                  this._alertService.success('Email ID deleted successfully..');
                  this.getEmailPage(1);
                  this.personEmailForm.reset();
                  this.personEmailForm.enable();
              },
              error => {
                  this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
          );
      } else {
          this.emailID.splice(this.personemailid, 1);
          this.emailID$ = observableOf(this.emailID);
          (<any>$(this.deletemailpopupid)).modal('hide');
          this._alertService.success('Email ID deleted successfully');
          this.getEmailPage(1);
      }
  }

  confirmDeleteEmail(personemailid: any) {
    this.personemailid = personemailid;
    (<any>$(this.deletemailpopupid)).modal('show');
  }

  declineDeleteEmail() {
    this.personemailid = null;
    (<any>$(this.deletemailpopupid)).modal('hide');
  }

}
