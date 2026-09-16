import { ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { PayableSearchParams } from '../../_entities/finance-entity.module';
import { ActivatedRoute, Router } from '@angular/router';
import { clone } from 'lodash';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../../@core/services';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { FinanceUrlConfig } from '../../finance.url.config';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { FinanceService } from '../../finance.service';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-finance-accountsPayable-search-result',
    templateUrl: './finance-accountsPayable-search-result.component.html',
    styleUrls: ['./finance-accountsPayable-search-result.component.scss'],
    standalone: false
})
export class FinanceAccountsPayableSearchResultComponent implements OnInit {
  selectedID: any;
  providerList  :any[]=[];
  accountpayableList :any[]= [];
  totalcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  selectedRecord: any;
  paymentDetails = [];
  searchParams!: PayableSearchParams;
  amount1!: number;
  amount2!: number;
  pageInfo: PaginationInfo[] = new Array(10).fill(new PaginationInfo());
  id: any;
  paymentid: any;
  totalPage: number[] = new Array(10).fill(0);
  provider_id: any;
  selectPaymentid: any;
  selectedPaymentid: any;
  // sortedData: any;
  provider_index: any;
  isReadonly:boolean=false;
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  expandedIndex: number | null = null;
  
  private readonly _commonService: CommonHttpService;
  private readonly route: ActivatedRoute;
  private readonly _dataStoreService: DataStoreService;
  private cdr: ChangeDetectorRef;

  constructor(
    private readonly injector: Injector,
    private readonly _session: SessionStorageService,
    private readonly _authService: AuthService,
    private readonly _router: Router,
    private readonly _providerpopup: FinanceService
    ) {

      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
      this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
      this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
    }

  ngOnInit() {
    this.searchParams = new PayableSearchParams();
    this._dataStoreService.currentStore.subscribe(store => {
      const searchParams = store['AccountPayableSerchFilter'];
      if (searchParams && (JSON.stringify(searchParams) !== JSON.stringify(this.searchParams))) {
        if (searchParams === 'clear') {
          this.providerList = [];
        } else {
          this.searchParams = searchParams;
          ObjectUtils.removeEmptyProperties(this.searchParams);
          this.loadList(true);
        }
      }
    });
    const activeModuleRole = this._session.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
    this.isReadonly =  this._authService.readonlyButton('read_only_access','add-edit-person');}
  }

  toggleSsn = (row:any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isTaxidHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }

  loadList(isInit = false) {
    this.accountpayableList = [];
    this.expandedIndex = null;
     this.searchParams.providerid = this.searchParams?.providerid ? this.searchParams.providerid : null;
    this.searchParams.paymentid = this.searchParams.paymentid ? this.searchParams.paymentid : null;
    this.paymentid = this.searchParams.paymentid ? this.searchParams.paymentid : null;
    this.searchParams.clientid = this.searchParams.clientid ? this.searchParams.clientid :null;
    this.searchParams.taxid = this.searchParams.taxid ? this.searchParams.taxid : null;
    if (isInit) {
      this.paginationInfo.sortColumn = 'providerid';
      this.paginationInfo.sortBy = 'desc';
    }
    this.searchParams.sortorder = this.paginationInfo.sortBy ? this.paginationInfo.sortBy : '';
    this.searchParams.sortcolumn= this.paginationInfo.sortColumn ? this.paginationInfo.sortColumn :'';
    this.paginationInfo.pageNumber = isInit ? 1 : this.paginationInfo.pageNumber
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'post',
        where: this.searchParams
        }), 'tb_provider/getproviderMaintainancesearch'
    ).subscribe((result: any) => {
      if (result) {

        //change the format of taxid based on the tax type
        for (const item of result) {
          item.tax_id_no = this.formatTaxId(item.prov_tax_type_cd, item.tax_id_no);

        }
       
        this.providerList = result;
        this.totalcount = this.returnTotalcountFn();
      }
    });
    this.cdr.markForCheck();
  }

  private returnTotalcountFn(): number {
    return (this.providerList && this.providerList.length > 0) ? this.providerList[0]?.totalcount : 0;
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page;
    this.loadList();
  }

  toggleTable(id:any, providerid:any, index:any, mode:any) {
    this.accountpayableList = [];
    const searchParams = clone(this.searchParams);
    this.id = id;
    this.provider_index = index;
    this.provider_id = providerid;
    if (!this.paymentid) {
      searchParams.paymentid = null;
    }
    searchParams.providerid = providerid;
    if (mode === 'Add') {
      this.pageInfo[index].pageNumber = 1;
      // $('.collapse.in').collapse('hide');
      // $('#' + id).collapse('toggle');
      this.expandedIndex = this.expandedIndex === index ? null : index;
      this.selectedID = id;
    }

    $('.provider-details tr').removeClass('selected-bg');
    $(`#provider-details-${index}`).addClass('selected-bg');
    this._commonService.getPagedArrayList(new PaginationRequest({
      where: searchParams,
      limit : this.pageInfo[index].pageSize,
        page: this.pageInfo[index].pageNumber,
      method: 'post'

    }), FinanceUrlConfig.EndPoint.accountsPayable.getPaymentList).subscribe(res => {
      this.accountpayableList = res.data;
      this.totalPage[index] = (this.accountpayableList && this.accountpayableList.length > 0) ? this.accountpayableList[0].totalcount : 0;
    });
  }



  pageNumberChanged(page:any, index:any) {
    this.pageInfo[index].pageNumber = page;
    this.toggleTable(this.id, this.provider_id, this.provider_index, 'Edit');
  }

  getNetAmount(gross_amount_no:any, offset_amount_no:any) {
    this.amount1 = (gross_amount_no) ? parseFloat(gross_amount_no) : 0;
    this.amount2 = (offset_amount_no) ? parseFloat(offset_amount_no) : 0;
    return (this.amount1 - this.amount2).toFixed(2);
  }

  selectAccountsPayable(paymentid:any, paymentStatus:any) {
    const searchParams = clone(this.searchParams);
    this.selectedPaymentid = paymentid;
    searchParams.paymentid = paymentid;
    searchParams.payment_status_cd = paymentStatus;
    this._dataStoreService.setData('paymentid', searchParams);
  }

  onMaintenancePayments($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
}

onAccountsHeaders($event: ColumnSortedEvent) {
  this.paginationInfo.sortBy = $event.sortDirection;
  this.paginationInfo.sortColumn = $event.sortColumn;
}

showProviderPopup(providerID:any) {
  this._dataStoreService.setData('paymentid', null);
  $('#modal-view-finace-accountsPayable').modal('hide');
  this._dataStoreService.setData('ProviderInfoID', providerID);
  $('#provider-info-popup').modal('show');
  this._providerpopup.getProviderDetails(providerID);
  this._providerpopup.page = 'Maintenance';
}

formatTaxId(taxType: string, taxId: string): string{
  let value;
  if(taxType==='SSN'){
   value=(String(taxId).substring(0, 3) + '-' + String(taxId).substring(3, 5) + '-' + String(taxId).substring(5, 9));
  }else{
    value=(String(taxId).substring(0, 2) + '-' + String(taxId).substring(2, 9));
  }
  return value;
}
}
