import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { PaginationInfo, DropdownModel } from '../../../@core/entities/common.entities';
import { GenerateReportsService } from '../generate-reports.service';
import { CommonDropdownsService, CommonHttpService } from '../../../@core/services';
import { NewUrlConfig } from '../../newintake/newintake-url.config';

const reportType = 'census';
@Component({
    selector: 'census-report',
    templateUrl: './census-report.component.html',
    standalone: false
})
export class CensusReportComponent implements OnInit {
  reportForm!: FormGroup;
  reportlist: any[] = [];
  PrimaryAdmissionList: any[] = [];
  providerUnitList: any[] = [];
  ethnicityList: any[] = [];
  countyList: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalCount!: number;

  constructor(
    private _formBuilder: FormBuilder,
    private _reportService: GenerateReportsService,
    private _dropdownService: CommonDropdownsService,
    private _httpService: CommonHttpService) { }

  ngOnInit() {
    this.initFormGroup();
    this.loadDropdowns();
  }

  initFormGroup() {
    this.reportForm = this._formBuilder.group({
      providername: null,
      providerunit: null,
      primaryadmissionreason: null,
      folderworker_firstname: null,
      folderworker_lastname: null,
      folderoffice: null,
      fieldworker_firstname: null,
      fieldworker_lastname: null,
      status: null,
      datefilter: null,
      startdate: null,
      enddate: null,
      date: null,
      ethnicity: null,
      residencecounty: null,
      jurisdictioncounty: null,
      jurisdictionoffice: null
    });
  }

  loadDropdowns() {
    this._dropdownService.getListByTableID(131).subscribe(result => {
      this.providerUnitList = result.map((res) => {
        return new DropdownModel({
          text: res.description,
          value: res.ref_key
        });
      });
    });
    this.getPrimaryAdmissionReason().subscribe(result => {
      this.PrimaryAdmissionList = result.map((res) => {
        return new DropdownModel({
          text: res.description,
          value: res.placementprimaryadmissionreasontypekey
        });
      });
    });
    this._httpService.getArrayList(
      {
        where: { activeflag: 1 },
        method: 'get',
        nolimit: true
      },
      NewUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
    ).subscribe(result => {
      this.ethnicityList = result.map((res) => {
        return new DropdownModel({
          text: res.typedescription,
          value: res.ethnicgrouptypekey
        });
      });
    });

    this._httpService.create(
      {
        nolimit: true,
        order: 'countyname asc',
      },
      NewUrlConfig.EndPoint.Intake.CountryListUrl
    ).subscribe(result => {
      this.countyList = result.map((res: { countyname: any; countyid: any; }) => {
        return new DropdownModel({
          text: res.countyname,
          value: res.countyid
        });
      });
    });
  }

  resetReport() {
    this.reportForm.reset();
    this.reportlist = [];
    this.totalCount = 0;
  }

  private getPrimaryAdmissionReason() {
    return this._httpService.getAll('placement/admissionreason');
  }

  generateReport() {
    const formParams = this.reportForm.getRawValue();
    formParams.method = 'get';
    formParams.page = this.paginationInfo.pageNumber;
    formParams.limit = this.paginationInfo.pageSize;
    this._reportService.listDocument(reportType, formParams).subscribe((res: any) => {
      this.reportlist = (res && res.data) ? res.data : [];
      this.totalCount = (res && res.totalcount) ? res.totalcount : 0;
    });
  }

  pageChanged(page: any) {
    this.paginationInfo.pageNumber = page.page;
    this.generateReport();
  }

  downloadReport(type: any) {
    const formParams = this.reportForm.getRawValue();
    formParams.outputfilename = 'Census_Report';
    formParams.method = 'post';
    formParams.nolimit = true;
    formParams.where = { outputfilename: 'Census_Report', type: type };
    this._reportService.generateDocument(reportType, formParams);
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }

}
