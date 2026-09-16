import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonAuditLogService } from './person-audit-log.service';
import { PersonDetailsService } from '../person-details.service';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { DataStoreService } from '../../../@core/services';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-audit-trail',
    templateUrl: './person-audit-trail.component.html',
    styleUrls: ['./person-audit-trail.component.scss'],
    standalone: false
})
export class PersonAuditTrailComponent implements OnInit {

  auditLogs: any[] = [];
  feilds: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  selectedFeild: any;
  showSsnMask:boolean=true;
  createddate = new Date();
  isAuthorized :any; //for fortify issues 
  constructor(private router: Router,
    private _datastoreService :DataStoreService,
    private route: ActivatedRoute,
    private _service: PersonAuditLogService,
    private personService: PersonDetailsService) {
    this.route.data.subscribe(response => {
      this.processAuditLogs(response.auditLogs);
    });
  }

  ngOnInit() {
    this.isAuthorized= this._datastoreService.isAuthorized(); //for fortify issues
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;
    this.feilds = this.getFields();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadTable();
  }

  loadTable() {
    this.auditLogs = [];
    this._service.getAuditLogs(this.personService.person.personid).subscribe(response => {

      if (response && response.length) {
        this.createddate = response[response.length - 1].insertedon;
        this.processAuditLogs(response);
      }

    });
  }

  processAuditLogs(items: any) {
    if (this.selectedFeild && this.selectedFeild.value) {
      items.forEach((item: any) => {
        if (item.modifieddata && item.modifieddata[this.selectedFeild.value]) {
          const tempModifiedData = item.modifieddata[this.selectedFeild.value];
          item.modifieddata = {};
          item.modifieddata[this.selectedFeild.value] = tempModifiedData;
          this.auditLogs.push(item);
        }

      });
    } else {
      items.forEach((item: any) => {
        if (item.modifieddata && !this.isEmpty(item.modifieddata)) {
          this.auditLogs.push(item);
        }

      });

    }

    this.totalRecords = this.auditLogs.length;
  }

  isEmpty(obj: any) {
    for (const prop in obj) {
      if (obj.hasOwnProperty(prop)) {
        return false;
      }
    }

    return JSON.stringify(obj) === JSON.stringify({});
  }

  private getFields() {
    return [{
      text: 'Firstname',
      value: 'firstname'
    },
    {
      text: 'Lastname',
      value: 'lastname'
    },
    {
      text: 'DOB',
      value: 'dob'
    },
    /* {
      text: 'Marital Status',
      value: 'maritalstatus'
    },
    {
      text: 'SSN',
      value: 'ssn'
    },
     */
    {
      text: 'Weight',
      value: 'weight'
    },
    {
      text: 'Height',
      value: 'height'
    },
    {
      text: 'Occupation',
      value: 'occupation'
    }];
  }

}
