import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { ActivatedRoute } from '@angular/router';
import { DataStoreService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { AuthService } from '../../../../@core/services/auth.service';
import { PaymentsResolverService } from './payments-resolver-service';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'payments',
    templateUrl: './payments.component.html',
    styleUrls: ['./payments.component.scss'],
    standalone: false
})
export class PaymentsComponent implements OnInit {
  id: string;
  paymentList: any[] = [];
  moduleview: any;

  constructor(
    private _commonService: CommonHttpService,
    public _authService: AuthService,
    private route: ActivatedRoute, private _dataStoreService: DataStoreService, private paymentsResolverService: PaymentsResolverService) {   
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID); 
    //   this.route.data.subscribe(data => {
    //     if (data && data.hasOwnProperty('result')) {
    //       _authService.setAuthDetail('payments',data.result);
    //     }
    // });
    }

  ngOnInit() {
    this.paymentsResolverService.getPayments().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail('payments',data);
        }
    })
    this.moduleview = this._authService.isModuleAccessable('payments', 'payments');
    this.getPaytmentList();
  }
  getPaytmentList() {
    this._commonService.getSingle(
      {
          'count': -1,
          'page': 1,
          'limit': 50,
          'where': { 'objectid': this.id, 'casenumber': null },
          'method': 'get'
      },
      'servicecase/servicecasepaymentlist?filter'
  )
      .subscribe(result => {
          if (result && result.length) {
              this.paymentList = result;
          }
      });
  }

}
