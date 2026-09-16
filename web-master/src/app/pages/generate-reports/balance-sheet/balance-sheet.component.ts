import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

const reportType = 'paymentLog';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../@core/services';
import { GenerateReportsService } from '../generate-reports.service';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'balance-sheet',
    templateUrl: './balance-sheet.component.html',
    standalone: false
})
export class BalanceSheetComponent implements OnInit {
  youthList: any;
  reportForm!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;
  restitutionList: any;
  constructor(
    private _commonHttpService: CommonHttpService,
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService
  ) { }

  ngOnInit() {
    this.getRestitutionYouthList();
    this.initFormGroup();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      youth: [{ value: null }, Validators.required]
    });
  }

  getRestitutionYouthList() {
    this._commonHttpService.getPagedArrayList({
      method: 'post',
      nolimit: true
    }, CommonUrlConfig.EndPoint.RESTITUTION.PAYMENT_DETAILS.YOUTH_LIST).subscribe(res => {
      this.youthList = res ? res.data : [];
    });
  }

  generateReport() {
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        youthpersonid: formParams.youth ? formParams.youth.personid : null,
        youth: formParams.youth ? `${formParams.youth.firstname} ${formParams.youth.lastname}` : null,
        outputfilename: 'CCU_Report'
      },
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.restitutionList = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.count) ? res.count : 0;
    });
  }

  resetReport() {
    this.reportForm.reset();
    this.restitutionList = [];
    this.totalCount = 0;
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type: any) {
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        youthpersonid: formParams.youth ? formParams.youth.personid : null,
        youth: formParams.youth ? `${formParams.youth.firstname} ${formParams.youth.lastname}` : null,
        outputfilename: 'CCU_Report',
        type: type
      },
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
    // .subscribe(res => {
    //   const downloadLink = res.data;
    //   if (downloadLink) {
    //     (<any>$('#downloadReport')).attr('href', downloadLink);
    //     (<any>$('#downloadReport'))[0].click();
    //     (<any>$('#downloadReport')).removeAttr('href');
    //   }
    // });
  }

  toggleTable(id: any) {
    (<any>$('.collapse.in')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
  }

}
