import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { AddressType, EmailType , PhoneType } from '../../../../admin/general/_entities/general.data.models';
import { PersonInfoService } from '../../person-info.service';
import { AddressDetailsService } from '../address-details.service';
import { GenericService, AlertService, AuthService } from '../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';


@Component({
    selector: 'list-address',
    templateUrl: './list-address.component.html',
    styleUrls: ['./list-address.component.scss'],
    standalone: false
})
export class ListAddressComponent implements OnInit {
  personId: any;
  addressPersonList: AddressType[] = [];
  emailPersonList: EmailType[] = [];
  phonePersonList: PhoneType[] = [];
  deleteAddressId: any;
  emaildescs = {'P' : 'Primary Email', 'S': 'Secondary Email'} ;
  phonedescs = {'HM' : 'HOME', 'CL' : 'CELL' , 'WK' : 'WORK',  'FA': 'FAX' , 'BU':'BUSINESS', 'OTH': 'Other' , 'PRI': 'Primary' , 'SEC' : 'Secondary'};
  addressList: AddressType[] = [];
  isClosed = false;
  deletepopupid = '#delete-popup';
  constructor(
    private _commonHttpService: CommonHttpService,
    private _addressService: AddressDetailsService,
    private _personService: PersonInfoService,
    private _service_address: GenericService<AddressType>,
    private _alertService: AlertService,
    private _authService: AuthService
  ) {
  }

  ngOnInit() {
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : null;
    this._addressService.getAddressListPage(1);
    this.isClosed = this._authService.iscaseclosed('personaddress');
    this.getAddressList();
  }

    getAddressList() {
      this.addressList = [];
    this._commonHttpService
        .getPagedArrayList(
          new PaginationRequest(
            {
              method: 'get',
              where: { personid: this.personId },
              page: 1, // this.paginationInfo.pageNumber,
              limit: 10// this.paginationInfo.pageSize,
            }),
          CommonUrlConfig.EndPoint.PERSON.ADDRESS.ListAddressUrl + '?filter'
        ).subscribe((data : any) => {
          if (data) {
            this.addressPersonList = data;
            this.addressPersonList.sort((a, b) => {
              return <any>new Date(b.addressstartdate) - <any>new Date(a.addressstartdate);
            });
            for (const element of this.addressPersonList) {
              if (element.currentlocationflag === 1) {
                this.addressList.push(element);
                break;
              }
            }
            for (const element of this.addressPersonList) {
              if (element.currentlocationflag !== 1) {
                this.addressList.push(element);
              }
            }
          }
        });
  }


  listenAddressListChange() {
    this._addressService.addressPersonType$.subscribe( (data) => {
      if (data) {
        this.addressPersonList = data;
      }
    });
  }


  listenEmailListChange() {
    this._addressService.emailPersonType$.subscribe( (data) => {
      if (data) {
        this.emailPersonList = data;
      }
    });
  }

  listenPhoneListChnage()
  {
    this._addressService.phonePersonType$.subscribe( (data) => {
      if (data) {
        this.phonePersonList = data;
      }
    });
  }

  editAddress(modal:any) {
    this._addressService.isShowAddAddressEnabled(true);
    setTimeout( () => {
      this._addressService.getAddress(modal);
    }, 500);
  }

  confirmDelete(personaddressid:any) {
    this.deleteAddressId = personaddressid;
    (<any>$(this.deletepopupid)).modal('show');
  }

  declineDelete() {
    this.deleteAddressId = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }

  deleteAddress() {
    if (this.deleteAddressId) {
      this._service_address.endpointUrl = CommonUrlConfig.EndPoint.PERSON.ADDRESS.DeleteAddressUrl;
      this._service_address.remove(this.deleteAddressId).subscribe(
        response => {
          (<any>$(this.deletepopupid)).modal('hide');
          this._alertService.success('Address deleted successfully..');
          this._addressService.getAddressListPage(1);
          this.getAddressList();
      
        },
        error => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
   
      (<any>$(this.deletepopupid)).modal('hide');
    }
  }

  markAsCurrentAddress(address:any) {
    // trigger the api here for making this address and current
    this._commonHttpService
    .getArrayList(
        {
            method: 'post',
            personaddressid: address.personaddressid
        },
        CommonUrlConfig.EndPoint.PERSON.ADDRESS.UpdateCurrentAddressUrl
    ).subscribe(
      (result) => {
        this.getAddressList();
      }
    );

  }

}
