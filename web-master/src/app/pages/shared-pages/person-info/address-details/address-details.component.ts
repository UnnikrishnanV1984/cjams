import { Component, OnInit } from '@angular/core';
import { AddressDetailsService } from './address-details.service';
import { AuthService, SessionStorageService } from '../../../../@core/services';

@Component({
    selector: 'address-details',
    templateUrl: './address-details.component.html',
    styleUrls: ['./address-details.component.scss'],
    standalone: false
})
export class AddressDetailsComponent implements OnInit {

  Flag = true;
  isShowAddAddress: boolean = false;
  isClosed = false;
  constructor(
    private _addressService: AddressDetailsService,
    private _authService: AuthService,
    private _session: SessionStorageService,
  ) { }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personaddress');
    this.listenToEnableAddAddress();
  }

  enableAddAddress() {
    const currentValue = !this.isShowAddAddress;
    this.isShowAddAddress = currentValue;
    return this.isShowAddAddress;
  }

  listenToEnableAddAddress() {
    this._addressService.isShowAddAddress$.subscribe((data) => {
      this.isShowAddAddress = (data) ? true : false;
    });
    const activeModuleRole = this._session.getItem('activeModuleRole');
    if(activeModuleRole == 'Medical Specialist') {
      this.isShowAddAddress = false;
    }
  }


  addressAdd(flag:any) {
    if (flag) {
      this.isShowAddAddress = false;
      this.Flag = false;
      var _this = this;
      setTimeout(() => {
        _this.Flag = true;
      }, 1000);
    }

  }
}