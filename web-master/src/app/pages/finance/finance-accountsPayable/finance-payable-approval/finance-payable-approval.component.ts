import { Component, OnInit } from '@angular/core';
import { AuthService, SessionStorageService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';

@Component({
    selector: 'finance-payable-approval',
    templateUrl: './finance-payable-approval.component.html',
    styleUrls: ['./finance-payable-approval.component.scss'],
    standalone: false
})
export class FinancePayableApprovalComponent implements OnInit {
  user!: AppUser;
  financeDirector:boolean=false;
  financeSupervisor:boolean=false;
  financeWorker:boolean=false;
  activeModule: any;
  moduleview: any;

  constructor(private _authService: AuthService,
    private _sessionStorage: SessionStorageService) { }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('finance', 'finance.finance.accountspayableapproval');
    this.user = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.user.role.name === 'DF') {
      this.financeDirector = true;
      this.financeSupervisor = false;
      this.financeWorker = false;
    } else if (this.activeModule === 'Finance Approval') {
      this.financeSupervisor = true;
      this.financeDirector = false;
      this.financeWorker = false;
    } else if (this.activeModule === 'Finance') {
      this.financeSupervisor = false;
      this.financeDirector = false;
      this.financeWorker = true;
    }
  }

}
