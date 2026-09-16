import { Component, OnInit } from '@angular/core';
import { DataStoreService, AuthService } from '../../../../../@core/services';
import { ClientPayment } from '../../../finance.constants';


@Component({
    selector: 'client-payment',
    templateUrl: './client-payment.component.html',
    standalone: false
})
export class ClientPaymentComponent implements OnInit {
  moduleview: any;

  constructor( private _dataStoreService: DataStoreService, private _authService: AuthService) {
   }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.historyclientpayment');
    this._dataStoreService.setData(ClientPayment.ClientPaymentSearchParams, null);
  }

}
