import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';
import { AlertService } from '../../../@core/services';

const reportType = 'exceptionReport';

@Component({
    selector: 'exception-report',
    templateUrl: './exception-report.component.html',
    standalone: false
})
export class ExceptionReportComponent implements OnInit {
  exceptionReport!: string;
  reportForm!: FormGroup;
  exceptionReports: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;
  constructor(
    private _route: ActivatedRoute,
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService,
    private _alertService: AlertService
  ) {
    _route.queryParams.subscribe(params => {
      this.exceptionReport = params['report'];
      this.ngOnInit();
    });
  }

  ngOnInit() {
    this.exceptionReports = [];
    this.initFormGroup();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      balanceGreaterThan: [null],
      balanceAmount: [null],
      activeSupervision: [null],
      isCCU: [null]
    });
    setTimeout(() => {
      this.balanceChanged();
    }, 100);
  }

  balanceChanged() {
    const formValues = this.reportForm.getRawValue();
    if (formValues.balanceGreaterThan && formValues.balanceGreaterThan.length) {
      this.reportForm?.get('balanceAmount')?.setValidators(Validators.required);
    } else {
      this.reportForm?.get('balanceAmount')?.clearValidators();
    }
    this.reportForm?.get('balanceAmount')?.updateValueAndValidity();
    if (formValues.balanceAmount && formValues.balanceAmount.length) {
      this.reportForm?.get('balanceGreaterThan')?.setValidators(Validators.required);
    } else {
      this.reportForm?.get('balanceGreaterThan')?.clearValidators();
    }
    this.reportForm?.get('balanceGreaterThan')?.updateValueAndValidity();
  }

  generateReport() {
    if (this.reportForm.invalid) {
      this._alertService.warn('Balance amount and Balance Condition should be used in combination.');
      return;
    }
    const formParams = this.reportForm.getRawValue();
    const where = formParams;
    const isAgeUnder21 = this.exceptionReport === 'EU21' ? false : null;
    where.ageOver21 = (this.exceptionReport === 'EO21') ? true : isAgeUnder21;
    const filter = {
      where: where,
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.exceptionReports = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type:any) {
    const formParams = this.reportForm.getRawValue();
    const where = formParams;
    where.type = type;

    if (this.exceptionReport === 'EU21') {
      where.ageOver21 = false;
      where.reportName = 'EXCEPTION REPORT - Under 21';
      where.outputfilename = 'Exception_Under_21';
    } else if (this.exceptionReport === 'EO21') {
      where.ageOver21 = true;
      where.reportName = 'EXCEPTION REPORT - Over 21';
      where.outputfilename = 'Exception_Over_21';
    } else {
      where.ageOver21 = null;
      where.reportName = 'RC Not Under DJS Supervision Report';
      where.outputfilename = 'Exception_RC_Only';
    }
    const filter = {
      where: where,
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
  }

  resetReport() {
    this.reportForm.reset();
    this.exceptionReports = [];
    this.totalCount = 0;
  }

  toggleTable(id:any) {
    (<any>$('.collapse.in')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
  }

}
