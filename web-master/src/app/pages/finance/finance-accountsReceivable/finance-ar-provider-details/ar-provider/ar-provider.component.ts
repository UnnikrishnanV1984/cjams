import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AlertService } from '../../../../../@core/services';
import { FinanceArProviderDetailsService } from '../finance-ar-provider-details.service';
import { FormBuilder } from '@angular/forms';
import { FinanceUrlConfig } from '../../../finance.url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ProviderSearchDetails } from '../../../_entities/finance-entity.module';
import { PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { HttpService } from '../../../../../@core/services/http.service';
import FileSaver from 'file-saver';

@Component({
    selector: 'ar-provider',
    templateUrl: './ar-provider.component.html',
    styleUrls: ['./ar-provider.component.scss'],
    standalone: false
})
export class ArProviderComponent implements OnInit {
  providerSearchDetails!: ProviderSearchDetails | null |undefined;
  providerAddress: any;
  street: string='';
  city: string='';
  county: string='';
  state: string='';
  zipcode: any;
  paymentHistoryResult: any[] = [];
  paymentDetail: any;
  providerCategory: any[]=[];
  placement:boolean=false;
  vendor:boolean=false;
  community:boolean=false;
  paymentDetailList: any[]=[];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalcount: any;
  paymentDetailView:boolean=false;
  streetNo: string='';
  receivableColletionStatusList: any[]=[];
  overpaymentnotice1 = 'Overpayment Notice 1';
  overpaymentnotice2 = 'Overpayment Notice 2';
  overpaymentnotice3 = 'Overpayment Notice 3';
  collection = ['Recovery', 'Offset', 'Debt Referral Notice', 'A/R Balance Notice', this.overpaymentnotice1, this.overpaymentnotice2, this.overpaymentnotice3];
  isTaxidHidden: boolean = true;
  ssnEye = 'fa-eye';
  showSsnMask :boolean= true;

  constructor(
    private _commonHttpService: CommonHttpService,
    public _providerService: FinanceArProviderDetailsService,
    private _formBuilder: FormBuilder,
    private _alertService: AlertService,
    private http: HttpService
  ) { }

  ngOnInit() {
    this.getProviderSearchDetails();
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

  getProviderSearchDetails() {
    this._commonHttpService.endpointUrl = FinanceUrlConfig.EndPoint.accountsReceivable.provider.providerSearch;
    const modal = {
      where: {
        providerid: this._providerService.providerid
      }
    };
    this._commonHttpService.create(modal).subscribe(
      (response:any) => {
        if (response) {
          const providerSearchDetails = response.length ? response[0] : {};
          this.providerSearchDetails = providerSearchDetails;
          this.providerAddressDetailsFn();
          setTimeout(() => {
            // No content to add or call
          }, 100);
          const providerCategory = this.providerSearchDetails?.provider_category_cd.split(',');
          if (providerCategory?.includes('1782') ||
            providerCategory?.includes('1783') ||
            providerCategory?.includes('3049') ||
            providerCategory?.includes('3274') ||
            providerCategory?.includes('3794') ||
            providerCategory?.includes('3302')) {
            this.placement = true;
          }

          if (providerCategory?.includes('3304')) {
            this.vendor = true;
          }

          if (providerCategory?.includes('3305')) {
            this.community = true;
          }
        }
      },
      (error) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);

      });
  }
  // Associated with getProviderSearchDetails function
  private providerAddressDetailsFn() {
    this.streetNo = this.providerSearchDetails?.adr_street_tx ? this.providerSearchDetails?.adr_street_tx + ', ' : '';
    this.street = this.providerSearchDetails?.adr_street_nm ? this.providerSearchDetails?.adr_street_nm + ', ' : '';
    this.city = this.providerSearchDetails?.adr_city_nm ? this.providerSearchDetails?.adr_city_nm + ', ' : '';
    this.county = this.providerSearchDetails?.adr_county_nm ? this.providerSearchDetails?.adr_county_nm + ', ' : '';
    this.state = this.providerSearchDetails?.adr_state_cd ? this.providerSearchDetails?.adr_state_cd + ', ' : '';
    this.zipcode = this.providerSearchDetails?.adr_zip5_no ? this.providerSearchDetails?.adr_zip5_no : '';
  }

  paymentHistory() {
     this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
      where: {
        provider_id: +this._providerService.providerid
      },
      method: 'get',
      limit: 5,
      page: this.paginationInfo.pageNumber
    }), FinanceUrlConfig.EndPoint.accountsReceivable.provider.paymentHistory + '?filter'
    ).subscribe((result: any) => {
      if (result) {
        this.paymentHistoryResult = result.data;
        this.totalcount = (this.paymentHistoryResult && this.paymentHistoryResult.length > 0) ? this.paymentHistoryResult[0].totalcount : 0;
      }
    });
  }

  viewPayment(payment: any) {
    this.paymentDetailView = true;
    this.paymentDetail = payment;
    if (this.paymentDetail && this.paymentDetail.paymentdetail !== null && this.paymentDetail.paymentdetail !== undefined) {   
      this.paymentDetail.paymentdetail.forEach((item: any) => {
        item.clientName = this.returnPersonNameFn(item);
      });
    }
    
  }

  private returnPersonNameFn(item: any) {
    let personName: string = '';
    if (item.prefx) {
      personName = item.prefx + ' ';
    }
    if (item.firstname) {
      personName = personName + item.firstname + ' ';
    }
    if (item.middlename) {
      personName = personName + item.middlename + ' ';
    }
    if (item.lastname) {
      personName = personName + item.lastname + ' ';
    }
    if (item.suffix) {
      personName = personName + item.suffix;
    }
    return personName;
  }

  pageChanged(page: number) {
    this.paginationInfo.pageNumber = page;
    this.paymentDetailView = false;
    this.paymentHistory();
  }

  downloadStautsDocumentPDF (key: string) {
    let notice_type;
    if (key === this.overpaymentnotice1) {
      notice_type = '1';
    } else if (key === this.overpaymentnotice2) {
      notice_type = '2';
    } else if (key ===this.overpaymentnotice3) {
      notice_type = '3';
    } else {
      notice_type = key;
    }
    const modal = {
      "count": -1,
      "where": {
          "documenttemplatekey": [
              "overpaymentnotice"
          ],
          "provider_id": this._providerService.providerid,
          "notice_type": notice_type,
          "format": 'PDF'
      },
      "method": "post"
    };
    this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
    .subscribe((result) => {
      const blob = new Blob([new Uint8Array(result)]);
      FileSaver.saveAs(blob,  key+'.pdf');
    });
  }

  downloadStautsDocument (key: string) {
    let notice_type;
    if (key === this.overpaymentnotice1) {
      notice_type = '1';
    } else if (key === this.overpaymentnotice2) {
      notice_type = '2';
    } else if (key ===this.overpaymentnotice3) {
      notice_type = '3';
    } else {
      notice_type = key;
    }
    const modal = {
      "count": -1,
      "where": {
          "documenttemplatekey": [
              "overpaymentnotice"
          ],
          "provider_id": this._providerService.providerid,
       //   "receivable_detail_id": this.overpaymentId,
          "notice_type": notice_type,
          "format": 'DOCX'
      },
      "method": "post"
    };
    this.http.download('evaluationdocument/generateintakedocument', modal, {}, 'buffer')
    .subscribe((result) => {
      const blob = new Blob([new Uint8Array(JSON.parse(result).data[0].data)]);
      FileSaver.saveAs(blob,  key+'.docx');
    });
  }

}
