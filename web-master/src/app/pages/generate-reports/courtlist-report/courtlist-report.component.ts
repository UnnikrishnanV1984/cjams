import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';

import moment from 'moment';

const reportType = 'court';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'courtlist-report',
    templateUrl: './courtlist-report.component.html',
    standalone: false
})
export class CourtlistReportComponent implements OnInit {
  reportForm!: FormGroup;
  courtlist: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;
  statusList = [
    { text: 'Pending', value: 'Pending' },
    { text: 'Completed', value: 'Completed' }
  ];
  dtformat = 'YYYY-MM-DD';
  constructor(
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService) { }

  ngOnInit() {
    this.initFormGroup();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      startdate: [{ value: null }, Validators.required],
      enddate: [{ value: new Date(), disabled: true }, Validators.required],
      tillcurrentdate: true,
      status: [null]
    });
  }

  tillCurrentDate(isChecked: boolean) {
    if (!isChecked) {
      this.reportForm?.get('enddate')?.setValue(null);
      this.reportForm?.get('enddate')?.enable();
    } else {
      this.reportForm?.get('enddate')?.setValue(new Date());
      this.reportForm?.get('enddate')?.disable();
    }
  }

  generateReport() {
    const formParams = this.reportForm?.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        status: formParams.status,
        outputfilename: 'Court_List_Report'
      },
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.courtlist = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type:any) {
    const formParams = this.reportForm?.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        status: formParams.status,
        outputfilename: 'Court_List_Report',
        type: type
      },
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
  }

  resetReport() {
    this.reportForm.reset();
    this.courtlist = [];
    this.totalCount = 0;
    this.tillCurrentDate(false);
  }

}
