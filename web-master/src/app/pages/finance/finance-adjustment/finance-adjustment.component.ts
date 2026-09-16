import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../@core/services/auth.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'finance-adjustment',
    templateUrl: './finance-adjustment.component.html',
    standalone: false
})
export class FinanceAdjustmentComponent implements OnInit {
  moduleview: any;

  constructor(private _authService: AuthService) { }
  
  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.financeadujustment');
  }
}
