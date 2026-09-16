import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

import moment from 'moment';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';

const reportType = 'newcase';
@Component({
    selector: 'new-case-report',
    templateUrl: './new-case-report.component.html',
    standalone: false
})
export class NewCaseReportComponent implements OnInit {
  reportForm!: FormGroup;
  newCases: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;
  dtformat = 'YYYY-MM-DD';
  constructor(
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService
  ) { }

  ngOnInit() {
    this.newCases = [];
    this.initFormGroup();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      startdate: [{ value: null }, Validators.required],
      enddate: [{ value: new Date(), disabled: true }, Validators.required],
      tillcurrentdate: true
    });
  }

  resetReport() {
    this.reportForm.reset();
    this.newCases = [];
    this.totalCount = 0;
    this.tillCurrentDate(true);
    this.reportForm?.get('tillcurrentdate')?.setValue(true);
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
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        outputfilename: 'NewCaseReport'
      },
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.newCases = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type:any) {
    const formParams = this.reportForm.getRawValue();
    const filter = {
      where: {
        startdate: formParams.startdate ? moment(formParams.startdate).format(this.dtformat) : null,
        enddate: formParams.enddate ? moment(formParams.enddate).format(this.dtformat) : null,
        outputfilename: 'NewCaseReport',
        type: type
      },
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
    // .subscribe((res: any) => {
    //   const downloadLink = res.data;
    //   if (downloadLink) {
    //     (<any>$('#downloadReport')).attr('href', downloadLink);
    //     (<any>$('#downloadReport'))[0].click();
    //     (<any>$('#downloadReport')).removeAttr('href');
    //   }
    // });
  }

  toggleTable(id:any) {
    (<any>$('.collapse.in')).collapse('hide');
    (<any>$('#' + id)).collapse('toggle');
  }

}
