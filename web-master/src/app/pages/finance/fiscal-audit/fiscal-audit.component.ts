import { Component } from '@angular/core';
import { FinanceService } from '../finance.service';
import { PaginationInfo } from '../../../@core/entities/common.entities';

@Component({
    selector: 'fiscal-audit',
    templateUrl: './fiscal-audit.component.html',
    styleUrls: ['./fiscal-audit.component.scss'],
    standalone: false
})
export class FiscalAuditComponent {
  changehistory: any;
  adjustment!: any[];
  historyInfo: PaginationInfo = new PaginationInfo();
  overpaymentInfo: PaginationInfo = new PaginationInfo();
  adjustmentInfo: PaginationInfo = new PaginationInfo();
  validationInfo: PaginationInfo = new PaginationInfo();

  constructor(
    public service?: FinanceService,
    ) { }

  getLogDetails(changeHistory: any, index: number) {
    this.changehistory = changeHistory;
    /* (<any>$('.provider-details-view tr')).removeClass('selected-bg');
    (<any>$(`#provider-details-view-${index}`)).addClass('selected-bg'); */
    this.service?.getSelectedFiscalDetails(changeHistory, index);
  }

  adjustmentInfoChanged(page: any) {
    if (this.changehistory) {
      this.service?.getFiscalAuditAdjustment(page, this.changehistory.change_type_cd, this.changehistory.revision_id);
    } else {
      this.service?.getFiscalAuditAdjustment(page, this.service?.changeHistory[0].change_type_cd, this.service?.changeHistory[0].revision_id);
    }
  }
  overpaymentInfoChanged(page: any) {
    if (this.changehistory) {
      this.service?.getFiscalAuditOverPayment(page, this.changehistory.change_type_cd, this.changehistory.revision_id);
    } else {
      this.service?.getFiscalAuditOverPayment(page, this.service?.changeHistory[0].change_type_cd, this.service?.changeHistory[0].revision_id);
    }
  }

  validationInfoChanged(page: any) {
    if (this.changehistory) {
      this.service?.getFiscalAudit(null, page, this.changehistory.change_type_cd, this.changehistory.revision_id);
    } else {
      this.service?.getFiscalAudit(null, page, this.service?.changeHistory[0].change_type_cd, this.service?.changeHistory[0].revision_id);
    }
  }

  historyChanged(page: any) {
    this.service?.getChangeHistory(page, this.service?.screenid, this.service?.screen);
  }

}
