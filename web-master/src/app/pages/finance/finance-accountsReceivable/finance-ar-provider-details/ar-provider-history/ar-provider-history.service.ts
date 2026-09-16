import { Injectable } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';

@Injectable()
export class ArProviderHistoryService {
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount:any;
  historyPaginationInfo: PaginationInfo = new PaginationInfo();
  historyTotalcount:any;
  overPaymentHistory: any[] = [];
  historyDetails: any[] = [];
  selectedPaymentid:any;
  index: any;
  receiptDetails: any;
  historyIndex:any;
  receiptIndex:any;
  receipt: any;
  receivable_detail_id:any;
  receivable_id:any;
  receivable_balance_no: any;
  collection_status_cd: any;
  payment_type_cd: any;
  county_cd: any;
  receivable_status_cd: any;
  approval_status_cd: string='';
  manual_sw: string='';
}
