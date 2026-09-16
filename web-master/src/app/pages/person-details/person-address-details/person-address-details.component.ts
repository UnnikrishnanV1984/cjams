
import {of as observableOf,  Observable } from 'rxjs';

import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, AfterViewInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { ControlUtils } from '../../../@core/common/control-utils';
import { AlertService, CommonHttpService, GenericService, CommonDropdownsService, AuthService } from '../../../@core/services';
import { SuggestAddress } from '../../../@core/common/models/involvedperson.data.model';
import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { AddressType } from '../../admin/general/_entities/general.data.models';
import { PersonDetailsService } from '../person-details.service';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-address-details',
    templateUrl: './person-address-details.component.html',
    styleUrls: ['./person-address-details.component.scss'],
    standalone: false
})
export class PersonAddressDetailsComponent implements OnInit, AfterViewInit {
  personAddressInput: any[] = [];
  personAddressForm!: FormGroup;
  addresstypeLabel!: string;
  suggestedAddress!: SuggestAddress[];
  errorValidateAddress = false;
  addressAnalysis: any[] = [];
  involvedPersonFormGroup!: FormGroup;
  addressPersonType$ = new Observable<AddressType[]>();
  addressDropdownItems$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  addressPersonType = [];
  addAddress!: AddressType;
  personaddressid: any;
  addressid: any;
  reportMode!: string;
  isDjs = false;
  dangerAddressRequired!: boolean;
  selectedState!: string;
  i: any;
  deletepopupid = '#delete-popup';
  constructor(private _formBuilder: FormBuilder,
    private _alertservices: AlertService,
    private _commonHttpService: CommonHttpService,
    private _service_address: GenericService<AddressType>,
    private dropdownService: CommonDropdownsService,
    public personService: PersonDetailsService,
    private _authService: AuthService) { }

  ngOnInit() {
    this.isDjs = this._authService.isDJS();
    this.initForm();
    this.loadDropDown();
    this.getAddressListPage(1);
    this.reportMode = 'add';
    this.selectedState = 'MD';
    this.loadCounty(this.selectedState);
  }

  ngAfterViewInit() {
    this.personAddressForm.get('knownDangerAddress')?.valueChanges.subscribe((result) => {
      if (result === 'yes') {
          this.dangerAddressRequired = true;
          this.personAddressForm.get('knownDangerAddressReason')?.setValidators([Validators.required]);
          this.personAddressForm.get('knownDangerAddressReason')?.updateValueAndValidity();
          this.personAddressForm.get('knownDangerAddressReason')?.enable();
      } else {
          this.dangerAddressRequired = false;
          this.personAddressForm.get('knownDangerAddressReason')?.clearValidators();
          this.personAddressForm.get('knownDangerAddressReason')?.updateValueAndValidity();
          this.personAddressForm.get('knownDangerAddressReason')?.disable();
      }
  });
}

  initForm() {
      this.personAddressForm = this._formBuilder.group({
        knownDangerAddress: ['', [Validators.required]],
        knownDangerAddressReason: ['', [Validators.required]],
        addresstype: ['', Validators.required],
        phoneNo: [''],
        address: ['', Validators.required],
        Address2: [''], // Removed required
        zipcode: ['', Validators.required],
        state: ['', Validators.required],
        city: ['', Validators.required],
        county: ['', Validators.required],
        effectivedate: [''],
        expirationdate: ['']
      });
  }



  loadDropDown() {
    this.addressDropdownItems$ = this.dropdownService.getAddressType();
    this.stateDropdownItems$ = this.dropdownService.getStateList();
  }


  loadCounty(statekey?: any) {
    const state = statekey ? statekey : this.personAddressForm.get('state')?.value;
    const source = this._commonHttpService.getArrayList(
      {
        where: { state: state },
        order: 'countyname',
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Listing.CountyListUrl + '?filter'
    ).pipe(map((result) => {
      return {
        counties: result.map(
          (res) =>
            new DropdownModel({
              text: res.countyname,
              value: res.countyname
            })
        )
      };
    }),share(),);

    this.countyDropDownItems$ = source.pipe(pluck('counties'));
  }

  addPersonAddress(addAddress: any) {
    const personAddressForm = this.personAddressForm.getRawValue();
    if (personAddressForm) {
      addAddress.danger = personAddressForm.knownDangerAddress;
      addAddress.personaddresstypekey = personAddressForm.addresstype;
      addAddress.personid = this.personService.person.personid;
      addAddress.dangerreason = personAddressForm.knownDangerAddressReason;
      addAddress.address = personAddressForm.address;
      addAddress.address2 = personAddressForm.Address2;
      addAddress.zipcode = personAddressForm.zipcode;
      addAddress.state = personAddressForm.state;
      addAddress.city = personAddressForm.city;
      addAddress.county = personAddressForm.county;
      addAddress.personaddressid = this.personaddressid;
      if (this.personAddressForm.value.effectivedate) {
        addAddress.effectivedate = personAddressForm.effectivedate;
      } else {
        addAddress.effectivedate = null;
      }
      if (this.personAddressForm.value.expirationdate) {
        addAddress.expirationdate = personAddressForm.expirationdate;
      } else {
        addAddress.expirationdate = null;
      }

      this._commonHttpService.create(addAddress, CommonUrlConfig.EndPoint.PERSON.ADDRESS.AddUpdateUrl).subscribe(
        result => {
          this._alertservices.success('Address details Added/Updated successfully!');
          this.getAddressListPage(1);
          this.reportMode = 'add';
        },
        error => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
      this.personAddressForm.reset();
      this.personAddressForm.enable();
    } else {
      this._alertservices.warn('Please fill mandatory fields for Phone');
      ControlUtils.validateAllFormFields(this.personAddressForm);
    }
  }


  getAddressListPage(page: number) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this.personService.person.personid },
            page: 1, // this.paginationInfo.pageNumber,
            limit: 10// this.paginationInfo.pageSize,
          }),
        CommonUrlConfig.EndPoint.PERSON.ADDRESS.ListAddressUrl + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }),share(),);
    this.addressPersonType$ = source.pipe(pluck('data'));
  }

  deleteAddress() {
    if (this.addressid) {
      this._service_address.endpointUrl = CommonUrlConfig.EndPoint.PERSON.ADDRESS.DeleteAddressUrl;
      this._service_address.remove(this.addressid).subscribe(
        response => {
          this.addressPersonType.splice(this.addressid, 1);
          this.addressPersonType$ = observableOf(this.addressPersonType);
          (<any>$(this.deletepopupid)).modal('hide');
          this._alertservices.success('Address deleted successfully..');
          this.getAddressListPage(1);
          this.personAddressForm.reset();
          this.personAddressForm.enable();
        },
        error => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
      this.addressPersonType.splice(this.addressid, 1);
      this.addressPersonType$ = observableOf(this.addressPersonType);
      (<any>$(this.deletepopupid)).modal('hide');
      this._alertservices.success('Address deleted successfully');
      this.getAddressListPage(1);
    }
  }

  confirmDelete(personaddressid: any) {
    this.addressid = personaddressid;
    (<any>$(this.deletepopupid)).modal('show');
  }

  declineDelete() {
    this.addressid = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }

  clear() {
    this.personAddressForm.reset();
    this.reportMode = 'add';
  }

  edit(model: any) {
    this.loadCounty(model.state);
    setTimeout(() => {
      this.personAddressForm.patchValue(model);
      this.personAddressForm.patchValue({
        addresstype: model.personaddresstypekey,
        Address2: model.address2,
        knownDangerAddress: [model.danger ? 'yes' : 'no'],
        knownDangerAddressReason: model.dangerreason
      });
    }, 100);
    this.personaddressid = model.personaddressid;
    this.reportMode = 'edit';
  }

  view(model: any) {
    this.loadCounty(model.state);
    setTimeout(() => {
      this.personAddressForm.patchValue(model);
      this.personAddressForm.patchValue({
        addresstype: model.personaddresstypekey,
        Address2: model.address2,
        knownDangerAddress: [model.danger ? 'yes' : 'no'],
        knownDangerAddressReason: model.dangerreason
      });
      this.personAddressForm.disable();
    }, 100);
    this.personaddressid = model.personaddressid;
    this.reportMode = 'view';
  }

  selectedAddress(model: any) {
    this.suggestedAddress = [];
    this.involvedPersonFormGroup.patchValue({
      Address: model.streetLine ? model.streetLine : '',
      City: model.city ? model.city : '',
      State: model.state ? model.state : ''
    });
    this.validateAddressResponse();
    this.validateAddress();
  }

  validateAddressResponse() {
    const addressInput = {
      street: this.involvedPersonFormGroup.value.Address ? this.involvedPersonFormGroup.value.Address : '',
      street2: this.involvedPersonFormGroup.value.Address2 ? this.involvedPersonFormGroup.value.Address2 : '',
      city: this.involvedPersonFormGroup.value.City ? this.involvedPersonFormGroup.value.City : '',
      state: this.involvedPersonFormGroup.value.State ? this.involvedPersonFormGroup.value.State : '',
      zipcode: this.involvedPersonFormGroup.value.Zip ? this.involvedPersonFormGroup.value.Zip : '',
      match: 'invalid'
    };

    this.addressAnalysis = [];
    this._commonHttpService
      .getSingle(
        {
          method: 'post',
          where: addressInput
        },
        CommonUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
        (result) => {
          if (result[0].analysis) {
            this.patchDataIfAnalysisFn(result);
          }
        },
        (error) => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

  private patchDataIfAnalysisFn(result: any) {
    this.involvedPersonFormGroup.patchValue({
      Zip: result[0].components.zipcode ? result[0].components.zipcode : '',
      County: result[0].metadata.countyName ? result[0].metadata.countyName : ''
    });

    if (result[0].analysis.dpvMatchCode) {
      this.addressAnalysis.push({
        text: result[0].analysis.dpvMatchCode
      });
    }
    if (result[0].analysis.dpvFootnotes) {
      this.addressAnalysis.push({
        text: result[0].analysis.dpvFootnotes
      });
    }
    if (result[0].analysis.dpvCmra) {
      this.addressAnalysis.push({
        text: result[0].analysis.dpvCmra
      });
    }
    if (result[0].analysis.dpvVacant) {
      this.addressAnalysis.push({
        text: result[0].analysis.dpvVacant
      });
    }
    if (result[0].analysis.active) {
      this.addressAnalysis.push({
        text: result[0].analysis.active
      });
    }
    if (result[0].analysis.ewsMatch) {
      this.addressAnalysis.push({
        text: result[0].analysis.ewsMatch
      });
    }
    if (result[0].analysis.lacslinkCode) {
      this.addressAnalysis.push({
        text: result[0].analysis.lacslinkCode
      });
    }
    if (result[0].analysis.lacslinkIndicator) {
      this.addressAnalysis.push({
        text: result[0].analysis.lacslinkIndicator
      });
    }
    if (result[0].analysis.suitelinkMatch) {
      this.addressAnalysis.push({
        text: result[0].analysis.suitelinkMatch
      });
    }
    if (result[0].analysis.footnotes) {
      this.addressAnalysis.push({
        text: result[0].analysis.footnotes
      });
    }
  }

  validateAddress() {
    const addressInput = {
      street: this.personAddressForm.value.address1 ? this.personAddressForm.value.address1 : '',
      street2: this.personAddressForm.value.Address2 ? this.personAddressForm.value.Address2 : '',
      city: this.personAddressForm.value.city ? this.personAddressForm.value.city : '',
      state: this.personAddressForm.value.state ? this.personAddressForm.value.state : '',
      zipcode: this.personAddressForm.value.zipCode ? this.involvedPersonFormGroup.value.zipCode : '',
      match: undefined
    };

    this.addressAnalysis = [];
    this._commonHttpService
      .getSingle(
        {
          method: 'post',
          where: addressInput
        },
        CommonUrlConfig.EndPoint.Intake.ValidateAddressUrl
      )
      .subscribe(
        (result) => {
          if (result.isValidAddress === false) {
            this.errorValidateAddress = true;
          } else {
            this.errorValidateAddress = false;
          }
        },
        (error) => {
          this._alertservices.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
  }

}
