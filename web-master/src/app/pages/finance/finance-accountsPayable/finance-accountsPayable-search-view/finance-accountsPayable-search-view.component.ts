
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { FinanceUrlConfig } from '../../finance.url.config';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { DataStoreService, AlertService, AuthService } from '../../../../@core/services';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'accountsPayable-search-view',
    templateUrl: './finance-accountsPayable-search-view.component.html',
    styleUrls: ['./finance-accountsPayable-search-view.component.scss'],
    standalone: false
})
export class FinanceAccountsPayableSearchViewComponent implements OnInit {
    accountPayable: any[]=[];
    // @Input() selectedAccountsPayable: FinanceAccountsPayableSearchEntry;
   // @Input() paymentid;
    selectedAccountsPayable: any;
    paymentInterface: any[]=[];
    checkStatus$!: Observable<DropdownModel[]>;
    selectedRecord: any[]=[];
    selectedPaymentdetails: any;
    pageInfo: PaginationInfo = new PaginationInfo();
    paginationInfo: PaginationInfo = new PaginationInfo();
    paginationNumber: PaginationInfo = new PaginationInfo();
  paymentId: any;
  totalcount: any;
  payment: any;
  notes: any;
  oldnotes: any;
  checkPaymentStatus: any;
  statuscheck: any;
  totalCount: any;
  totalRecords: any;
  payment_id: any;
  oldcheckPaymentStatus: any;
  streetNo: string='';
  streetDir: string='';
  street: string='';
  suit: string='';
  adrUnitType: string='';
  city: string='';
  adrUnitNo: string='';
  state: string='';
  zipCode: any;
  paymentAddress: string='';
  stateandZip: string='';
  releasedStatusFlag: boolean = false;
  isVissbleButton:boolean=false;
  paymentdetailspopupid = '#payment-details';
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  isValue = 1;
    constructor(
        private _commonService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        private _alertService: AlertService,
        public _authService: AuthService
    ) { }

    ngOnInit() {
        this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
        this.loadcheckStatus();
        this.pageInfo.pageNumber = 1;
        this.paginationInfo.pageNumber = 1;
        this.paginationNumber.pageNumber = 1;
        this.paginationInfo.sortColumn = 'client_id';
        this.paginationInfo.sortBy = 'desc';
        this._dataStoreService.currentStore.subscribe((store:any) => {
          if (store.paymentid) {
            this.accountPayable = [];
            this.selectedAccountsPayable = {};
            (<any>$('#modal-view-finace-accountsPayable')).modal('show');
            this.selectAccountsPayable(store.paymentid);
            if(store.paymentid.payment_status_cd ==='Released') {
              this.releasedStatusFlag =true;
            } else {
              this.releasedStatusFlag = false;
            }
          }
        });
       // (<any>$('#modal-view-finace-accountsPayable')).collapse('show');
        // this.selectAccountsPayable();
    }

    toggleTax = () => {
      this.isTaxidHidden = !this.isTaxidHidden;
      if (this.isTaxidHidden) {
        this.ssnEye = 'fa-eye';
        this.showSsnMask = true;
      } else {
        this.ssnEye = 'fa-eye-slash';
        this.showSsnMask = false;
      }
    }

    viewMaintenance() {
      this._dataStoreService.setData('paymentid', null);
    }

    selectAccountsPayable(paymentsearch:any) {
      this.accountPayable = [];
      this.selectedAccountsPayable = {};
        this.paymentId = paymentsearch;
        paymentsearch['sortcolumn'] = this.paginationInfo.sortColumn;
        paymentsearch['sortorder'] = this.paginationInfo.sortBy;
        this._commonService.getPagedArrayList(new PaginationRequest({
          where: paymentsearch,
          limit : 10,
          page: this.pageInfo.pageNumber,
          method: 'post'
        }), FinanceUrlConfig.EndPoint.accountsPayable.getAccountsPayableInfo).subscribe(res => {

          if (res && res.data && res.data.length) {
            this.accountPayable = res.data;
            this.accountsPayableInfoResponseFn(res);
            setTimeout(() => {
              this.selectPaymentDetails(this.selectedAccountsPayable, 0);
            }, 10);
          }
        });
      }
      // Associtaed with selectAccountsPayable function
  private accountsPayableInfoResponseFn(res: any) {
    this.selectedAccountsPayable = (res.data.length > 0) ? res.data[0] : '';
    this.streetNo = res.data[0].adr_street_tx ? res.data[0].adr_street_tx + ' ' : '';
    this.streetDir = res.data[0].adr_pre_dir_cd ? res.data[0].adr_pre_dir_cd + ' ' : '';
    this.street = res.data[0].adr_street_nm ? res.data[0].adr_street_nm + '  ' : '';
    this.suit = res.data[0].adr_street_suffix_cd ? res.data[0].adr_street_suffix_cd + ' ' : '';
    this.adrUnitType = res.data[0].adr_unit_type_cd ? res.data[0].adr_unit_type_cd + ' ' : '';
    this.adrUnitNo = res.data[0].adr_unit_no_tx ? res.data[0].adr_unit_no_tx + ' ' : '';
    this.city = res.data[0].adr_city_nm ? res.data[0].adr_city_nm + ',' : '';
    this.state = res.data[0].adr_state_cd ? res.data[0].adr_state_cd + ' ' : '';
    this.zipCode = res.data[0].adr_zip5_no ? res.data[0].adr_zip5_no : '';
    this.paymentAddress = this.streetNo + this.streetDir + this.street + this.suit + this.adrUnitType + this.adrUnitNo + this.city;
    this.stateandZip = this.state + this.zipCode;
    this.totalcount = (res.data && res.data.length > 0) ? res.data[0].totalcount : 0;
  }

      sortAccountPayable($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.selectAccountsPayable(this.paymentId);
      }

      pageChanged(page:any) {
        this.pageInfo.pageNumber = page;
        this.selectAccountsPayable(this.paymentId);
      }

    paymentInterfaceStatus(payment_id:any) {
      this.payment_id = payment_id;
        this._commonService.getArrayList({
            where: {
                payment_id: +payment_id
            },
            method: 'get',
            limit: 10,
            page: this.paginationInfo.pageNumber,
            fmslimit: 10,
            fmspage: this.paginationNumber.pageNumber
        }, 'tb_payment_status/paymentafsfmis?filter'
        ).subscribe(response => {
          if (response) {
            this.paymentInterface = response;
            this.totalCount = (response.length > 0) ? response[0].totalcount : 0;
            if (this.totalcount !== 0) {
              this.totalRecords = (response[0].afsorfmis && response[0].afsorfmis.length > 0) ? response[0].afsorfmis[0].totalcount : 0;
            }
          }

        });
    }

    paginationChanged(page:any) {
      this.paginationNumber.pageNumber = page;
      this.paymentInterfaceStatus(this.payment_id);
    }
    pageNumberChanged(page:any) {
      this.paginationInfo.pageNumber = page;
      this.paymentInterfaceStatus(this.payment_id);
    }

    interfaceClose() {
      this.paginationNumber.pageNumber = 1;
    }

    loadcheckStatus() {
        this.checkStatus$ = this._commonService.getArrayList({
          where: {picklist_type_id : '37'},
          nolimit: true,
          method: 'get'
        }, FinanceUrlConfig.EndPoint.accountsPayable.PaymentPickList + '?filter'
        ).pipe( map((result) => {
          return result.map(
              (res) =>
                  new DropdownModel({
                      text: res.value_tx,
                      value: res.picklist_value_cd
                  })
          );
        }));
      }

      editPayment(paymentDetails:any) {
        this.payment = paymentDetails;
        this.checkPaymentStatus = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
        this.statuscheck = paymentDetails.check_status_cd ? paymentDetails.check_status_cd : null;
        this.notes = paymentDetails.notes_tx ? paymentDetails.notes_tx : '';
        this.oldcheckPaymentStatus = this.checkPaymentStatus;
        this.oldnotes = this.notes;
        (<any>$(this.paymentdetailspopupid)).modal('show');
        (<any>$('#payment-interface')).modal('hide');
      }

      updateCheckStatus() {
        (document as any).getElementById('msg_checkPaymentStatus').innerHTML = (this?.checkPaymentStatus) ? '' : 'Please select Check Status';
        if (this.notes && this.checkPaymentStatus) {
          if (this.checkPaymentStatus === this.statuscheck && this.notes === this.oldnotes) {
            this._alertService.warn('Check Status is already updated, Please update new one');
            return false;
          } else {
              this._commonService.endpointUrl = 'tb_payment_header/updatePaymentCheckStatus/' + this.paymentId.paymentid;
              const model = {
                notes: this.notes,
                check_status: this.checkPaymentStatus
              };
              this._commonService.create(model).subscribe(res => {
                if (res) {
                  this._alertService.success('Check Status updated Successfully');
                  (<any>$(this.paymentdetailspopupid)).modal('hide');
                  this.paymentInterfaceStatus(this.paymentId.paymentid);
                  (<any>$('#payment-interface')).modal('show');
                }
              });
            }
        } else {
          this._alertService.error('Please fill the mandatory fields');
        }
      }

      selectPaymentDetails(paymentdetails:any, index:any) {
        this.selectedPaymentdetails = paymentdetails;
        (<any>$('.provider-details-view tr')).removeClass('selected-bg');
        (<any>$(`#provider-details-view-${index}`)).addClass('selected-bg');
        const el = document.getElementById('draftStatement');
        if (el) {
          el.scrollIntoView();
        }
      }

      checkStatusChange(value:any) {
        (document as any).getElementById('msg_checkPaymentStatus').innerHTML = (this?.checkPaymentStatus) ? '' : 'Please select Check Status';
        if (value == '4849') {
          (<any>$(this.paymentdetailspopupid)).modal('hide');
          (<any>$('#confirm-checkstatus')).modal('show');
        } else {
          this.oldcheckPaymentStatus = this.checkPaymentStatus;
        }
      }
      ConfirmPopup(index:any) {
        (<any>$('#confirm-checkstatus')).modal('hide');
        (<any>$(this.paymentdetailspopupid)).modal('show');
        if (index === 1) {
          this.checkPaymentStatus = this.oldcheckPaymentStatus;
        }
      }

      printInterface() {
        window.print();
      }

}
