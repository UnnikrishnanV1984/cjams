
import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { CommonHttpService, CommonDropdownsService } from '../../../../../@core/services';

@Component({
    selector: 'smarty-street-address',
    host: {
        class: 'smarty-street-address'
    },
    templateUrl: './smarty-street-address.component.html',
    standalone: false
})
export class SmartyStreetAddressComponent implements OnInit {

  @Input() requiredForApproval :boolean=false;
  @Input() mandatoryrequired :boolean=false;
  @Input() countyrequired :boolean=false;
  @Input() isRequiredSingleLine :boolean=false;
  @Output() 
  addressEvent = new EventEmitter();
  suggestedAddress$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  countyDropDownItems$!: Observable<any[]>;
  private _address?: { address1: string, address2: string, city: string, state: string, zipcode: string, county: string, disable?: false};

  get address(): any {
      return this._address;
  }

  @Input() set address(detail: any) {
      if (detail) {
          this._address = detail;
          if (detail.state) {
            this.loadCounty(detail.state);
          }
      } else {
        this._address = { address1: "", address2: "", city: "", state: "", zipcode: "", county: "", disable: false};
      }
  }
  constructor(private _commonHttpService: CommonHttpService,
    private _commonDropdownService: CommonDropdownsService) { }

  ngOnInit() {
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    if(this.address?.state){
      this.loadCounty(this.address?.state);
    }
  }

  loadCounty(sateKey:any) {
    this._commonDropdownService.getPickListByMdmcode(sateKey).subscribe(countyList => {
      this.countyDropDownItems$ = observableOf(countyList);
    });
  }

  selectedAddress(suggestion:any) {
    this.address.address1 = suggestion.streetLine ? suggestion.streetLine : '';
    this.address.city = suggestion.city ? suggestion.city : '';
    this.address.state = suggestion.state ? suggestion.state : '';
    this.loadCounty(this.address.state);
    const addressInput = {
      street: suggestion.streetLine ? suggestion.streetLine : '',
      street2: '',
      city: suggestion.city ? suggestion.city : '',
      state: suggestion.state ? suggestion.state : '',
      zipcode: '',
      match: 'invalid'
    };
    this._commonHttpService
      .getSingle(
          {
              method: 'post',
              where: addressInput
          },
          'People/validateaddress'
      )
      .subscribe(
          (result) => {
              if (result[0].analysis) {
                this.address.zipcode = result[0].components.zipcode ? result[0].components.zipcode : '';
                this.address.county = result[0].metadata.countyName ? result[0].metadata.countyName : '';
                this.addressEvent.emit(this.address)
               }
              }
      );
      this.addressEvent.emit(this.address)
  }
  getSuggestedAddress() {
    if (this.address && this.address.address1 &&
      this.address.address1.length >= 3) {
      this.suggestAddress();
    }
  }
  suggestAddress() {
    this._commonHttpService
      .getArrayListWithNullCheck(
        {
          method: 'post',
          where: {
            prefix: this.address.address1,
            cityFilter: '',
            stateFilter: '',
            geolocate: '',
            geolocate_precision: '',
            prefer_ratio: 0.66,
            suggestions: 25,
            prefer: 'MD'
          }
        },
        'People/suggestaddress'
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

  addressDataHandler(){
    this.addressEvent.emit(this.address)
  }

}