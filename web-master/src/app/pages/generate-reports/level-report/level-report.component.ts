import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';
import { CommonDropdownsService } from '../../../@core/services';

const reportType = 'level';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'level-report',
    templateUrl: './level-report.component.html',
    standalone: false
})
export class LevelReportComponent implements OnInit {
  reportForm!: FormGroup;
  levelList: any[] = [];
  levelDDList: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;

  constructor(
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService,
    private _dropdownService: CommonDropdownsService) { }

  ngOnInit() {
    this.initFormGroup();
    this.loadDropdowns();
  }

  loadDropdowns() {
    this._dropdownService.getListByTableID(131).subscribe(result => {
      this.levelDDList = result.map((res) => {
        return new DropdownModel({
          text: res.description,
          value: res.ref_key
        });
      });
    });
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      addmissisiontype: null,
      cjamsid: null,
      providername: null
    });
  }

  generateReport() {
    const formParams = this.reportForm.getRawValue();
    formParams.outputfilename = 'Level_Report';
    const filter = {
      where: formParams,
      method: 'get',
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize
    };
    this._reportService.listDocument(reportType, filter).subscribe((res: any) => {
      this.levelList = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type:any) {
    const formParams = this.reportForm.getRawValue();
    formParams.outputfilename = 'Level_Report';
    formParams.type = type;
    const filter = {
      where: formParams,
      method: 'post',
      nolimit: true
    };
    this._reportService.generateDocument(reportType, filter);
  }
  
  resetReport() {
    this.reportForm.reset();
    this.levelList = [];
    this.totalCount = 0;
  }
}
