import { Component, OnInit, ViewChild } from '@angular/core';
import { NytdExtractService } from './nytd-extract.service';
import { FormGroup } from '@angular/forms';
import { AuthService } from '../../../@core/services';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { PersonInfoService } from '../person-info/person-info.service';
import { ActivatedRoute } from '@angular/router';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import moment from 'moment';

@Component({
    selector: 'nytd-extract',
    templateUrl: './nytd-extract.component.html',
    styleUrls: ['./nytd-extract.component.scss'],
    standalone: false
})

export class NytdExtractComponent implements OnInit {
  isLoading: boolean = false;
  loggedInUser: any;
  surveyStatus: any = [];
  reportTypes: any = [];
  summary: MatTableDataSource<any> = new MatTableDataSource();
  userNames: any = [];
  reportingPeriods: any = [];
  selectedPeriod: any;
  selectedSummaryPeriod: any;
  NytdExtractFormGroup!: FormGroup;

  totalRecords: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  sortData: any;

  gridColumns: string[] = ['reportingperiod', 'reporttypekey', 'insertedon', 'updatedon', 'updatedby'];

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  constructor (
    private _authService: AuthService,
    private _NytdSurveyService: NytdExtractService,
    public _personService: PersonInfoService,
    private route: ActivatedRoute
  ) {
      this.route.data.subscribe(data => {
        if(data && data.config) {
          this.reportTypes = data.config.reportTypes;
          this.userNames = data.config.userNames;
          this.reportingPeriods = data.config.reportingPeriods;
          this.selectedSummaryPeriod = this.reportingPeriods[0].reportingperiod;
          this.selectedPeriod = this.reportingPeriods[0].reportingperiod;
        }
      });
  }
 
  ngOnInit() {
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
  }

  ngAfterViewInit(): void {
    setTimeout(() => {
      this.route.data.subscribe(data => {
        this.summary.sort = this.sort;
        this.summary.paginator = this.paginator;
        this.summary.data = data.config.summary;
        this.totalRecords = this.summary.data.length;
      });
    });
  }

  onSelectValueChange () {
    this.isLoading = true;
    this._NytdSurveyService.getNytdSummary(this.selectedSummaryPeriod).subscribe(res => {
      this.summary.sort = this.sort;
      this.summary.paginator = this.paginator;
      this.summary.data = res;
      this.isLoading = false;
    })
  }

  perform(action: string) {
    if (action === 'selectPeriod') {
      (<any>$('#select-reporting-period')).modal('show');
    } else if (action === 'download') {
      this.download(this.selectedPeriod);
      (<any>$('#select-reporting-period')).modal('hide');
    }
  }

  /**
   * 
   * @param reportingperiod 
   * The data file must follow the required naming convention: VVG1CX4.CFI.ss.Zyyyy.Xyymmdd.Thhmm.xml 
   * Where: "VVG1CX4" is the application account number that identifies NYTD data files for storage at the NIH Center for Information Technology; 
   * "CFI" refers to Cyberfusion, the mode of transmission as described in Section 7; 
   * "ss" is the State code; 
   * "Z" is the report period "A" (corresponding to the period October 1-March 31) or "B" (corresponding to the period April 1-September 30); 
   * "yyyy" is the report year; 
   * "X" is the type of transmission, R for regular, C for corrected, S for subsequent, or T for test; 
   * "yymmdd" is the year, month, and day; 
   * "T" refers to the time of transmission; 
   * "hhmm" is the hour and minutes that correspond to the time the State transmits the data file (24-hour clock); 
   * and ".xml" is the XML file name extension.
   */

  download(reportingperiod: any) {
    var dateTime = moment().format().toString();
    var dateString = dateTime.split('T')[0];
    var timeString = dateTime.split('T')[1];
    var yymmdd = (dateString.split('-')[0]).slice(2) + dateString.split('-')[1] + dateString.split('-')[2];
    var hhmm = timeString.split(':')[0] + timeString.split(':')[1];

    var filename = 'VVG1CX4.CFI.md'; //VVG1CX4.CFI.ss
    filename += (reportingperiod.slice(4) === '09' ? '.B' : '.A'); //Z
    filename += reportingperiod.substring(0, 4); //yyyy
    filename += '.R' + yymmdd //Xyymmdd
    filename += '.T' + hhmm; //Thhmm

    this._NytdSurveyService.downloadAsXml(reportingperiod).subscribe(res => {
      this._NytdSurveyService.saveAsXMLFile(res, filename);
    });
  }

  getReportType(typeCd: any) {
    const type = this.reportTypes.filter((r: any) => r.picklist_value_cd === typeCd);
    if(type && type.length>0) {
      return type[0].value_tx;
    } else {
      return '';
    }
  }

  getUserName(id: string) {
    const name = this.userNames.data.filter((u: any) => u.securityusersid == id);
    if(name && name.length>0) {
      return name[0].displayname;
    } else {
      return id;
    }
  }

  customSort(event: any) {
    this.sortData = event;
    this.paginationInfo.pageNumber = 1;
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
  }

}
