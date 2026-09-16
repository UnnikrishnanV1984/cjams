import { Injectable } from '@angular/core';
import { CommonHttpService, AuthService } from '../../../../@core/services';
import { FinanceUrlConfig } from '../../finance.url.config';
import { AppConstants } from '../../../../@core/common/constants';

@Injectable()
export class FinanceArProviderDetailsService {
  private _providerid: string='';
  provider: any=[] ;
  public get providerid(): string {
    return this._providerid;
  }
  public set providerid(value: string) {
    this._providerid = value;
  }
  constructor(
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService
  ) { }

  loadProviderDetails() {
    this._commonHttpService.getPagedArrayList({
      limit: 1,
      page: 1,
      where: {
        providerid: this.providerid
      },
      method: 'post'
    }, FinanceUrlConfig.EndPoint.accountsReceivable.search.list).subscribe((res: any) => {
      this.provider = (res && res.length) ? res[0] : null;
    });
  }

  isFW() {
    return this._authService.getCurrentUser().role.name === AppConstants.ROLES.FINANCE_WORKER;
  }

  isSupervisor() {
    return this._authService.getCurrentUser().role.name === AppConstants.ROLES.LDSS_FISCAL_SUPERVISOR;
  }
}
