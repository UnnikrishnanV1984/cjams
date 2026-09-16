import { Component, OnInit } from '@angular/core';

import moment from 'moment';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';

const reportType = 'ccu';

@Component({
    selector: 'ccu-case-report',
    templateUrl: './ccu-case-report.component.html',
    standalone: false
})
export class CcuCaseReportComponent implements OnInit {
  reportForm!: FormGroup;
  ccus: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;
  dtformat = 'YYYY-MM-DD';
  constructor(
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService
  ) { }

  ngOnInit() {
    this.ccus = [];
    this.initFormGroup();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      startdate: [{ value: null }, Validators.required],
      enddate: [{ value: new Date(), disabled: true }, Validators.required],
      tillcurrentdate: true
    });
  }

  tillCurrentDate(isChecked: boolean) {
    if (!isChecked) {
      this.reportForm.get('enddate')?.setValue(null);
      this.reportForm.get('enddate')?.enable();
    } else {
      this.reportForm.get('enddate')?.setValue(new Date());
      this.reportForm.get('enddate')?.disable();
    }
  }

  generateReport() {
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        outputfilename: 'CCU_Report'
      },
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.ccus = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  resetReport() {
    this.reportForm.reset();
    this.ccus = [];
    this.totalCount = 0;
    this.tillCurrentDate(true);
    this.reportForm.get('tillcurrentdate')?.setValue(true);
  }

  downloadReport(type: any) {
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        outputfilename: 'CCU_Report',
        type: type
      },
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
  }

  toggleTable(id: any) {
    (<any>$('.collapse.in')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
  }

}
