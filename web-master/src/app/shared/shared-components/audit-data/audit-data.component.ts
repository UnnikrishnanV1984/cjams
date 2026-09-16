import { Component, OnInit, Input } from '@angular/core';
import moment from 'moment';

declare let $: any;
@Component({
    selector: 'audit-data',
    templateUrl: './audit-data.component.html',
    styleUrls: ['./audit-data.component.scss'],
    standalone: false
})
export class AuditDataComponent implements OnInit {
  @Input() auditlogTrail:any[] = [];
  @Input() flow?:any;
  formatAuditlog: any;
  totalData: any;
  auditlogTrailExpand: any;
  agetype: any;
  vaccinename: any;
  currentPage = 1;
  totalRecords: any;
  itemPerPage = 10;
  recordstatus = {
    'No': 'Active',
    '0': 'Deleted',
    '1': 'Rejected',
    '3': 'Active (Undo)'
  }

  ngOnInit() {

    if (this.auditlogTrail && this.auditlogTrail.length) {
      const sortresult = this.sortAudit(this.auditlogTrail);
      
      this.formatAuditlog = sortresult.slice(0, 10);
      this.totalData = sortresult;
      this.totalRecords = sortresult.length;
    }

  }

  private sortAudit(sortresult: any){
    return sortresult.map((el: any) => {
      let a = el.modifieddata ? el.modifieddata : null;
      if(this.flow == 'safecohp' &&  el.modifieddata && el.modifieddata.data && el.modifieddata.data.length ) {
        el.modifieddata = el.modifieddata.data;
        a = el.modifieddata ;
      }
      if (a && a.length) {
        a.forEach((element: any) => {
          element = this.handleAndReturnElementData1Fn(element);
          element = this.handleAndReturnElementData2Fn(element);
          element = this.handleAndReturnElementData3Fn(element);
          if(element.key === 'vaccinename'){
            el.vaccinename = element.new_value;
          }
        });
      }
  
      return el;
    });
  }
  // Assosiated with ngOnInit method
  private handleAndReturnElementData1Fn(element: any) {
    if (element.key === 'recordstatus') {
      element.new_value = (this.recordstatus as any)[element?.new_value ?? 'No'];
      element.old_value = (this.recordstatus as any)[element?.old_value ?? 'No'];
    }
    if (element.new_value === true || ['1', 1].includes(element.new_value)) {
      element.new_value = 'Yes';
    }
    if (element.old_value === true || ['1', 1].includes(element.old_value)) {
      element.old_value = 'Yes';
    }
    if (element.new_value === false || element.new_value === 2 || ['0', 0].includes(element.new_value)) {
      element.new_value = 'No';
    }
    if (element.old_value === false || element.old_value === 2 || ['0', 0].includes(element.old_value)) {
      element.old_value = 'No';
    }

    return element;
  }
  // Assosiated with ngOnInit method
  private handleAndReturnElementData2Fn(element: any) {
    if(element?.new_value && this.isDate(element?.new_value)) {
      if (moment(element.new_value, "MM/DD/YYYY", true).isValid()) {
        element.new_value = this.getDateFormatted(element.new_value);
      }
      if (moment(element.new_value, moment.ISO_8601, true).isValid()) {
        element.new_value = this.getDateTimeFormatted(element.new_value);
      }
    }
    if(element?.old_value && this.isDate(element?.old_value)) {
      if (moment(element.old_value, "MM/DD/YYYY", true).isValid()) {
        element.old_value = this.getDateFormatted(element.old_value);
      }
      if (moment(element.old_value, moment.ISO_8601, true).isValid()) {
        element.old_value = this.getDateTimeFormatted(element.old_value);
      }
    }
    return element;
  }
  // Assosiated with ngOnInit method
  private handleAndReturnElementData3Fn(element: any) {
    if (element.key === 'immunizationdate') {
      if (element.new_value && moment(element.new_value).isValid()) {
        element.new_value = this.getDateFormatted(element.new_value);
      }
      if (element.old_value && moment(element.old_value).isValid()) {
        element.old_value = this.getDateFormatted(element.old_value);
      }
    }

    return element;
  }

  auditlogTrailOpen(id:any) {
    this.auditlogTrailExpand = [];
    if (id.modifieddata && id.modifieddata.length) {
      this.auditlogTrailExpand = id.modifieddata;          
    }
    ($('#audittrail-expand')).modal('show');
  }

  getDateFormatted(date: any) {
    if (date) {
      return moment(date).format('MM/DD/YYYY');
    } else {
      return '';
    }
  }

  getDateTimeFormatted(date: any) {
    if (date) {
      return moment(date).format('MM/DD/YYYY, h:mm A');
    } else {
      return '';
    }
  }

  getTimeFormatted(date: any) {
    if (date) {
      return moment(date).format('h:mm A');
    } else {
      return '';
    }
  }

  closeModal() {
    $('#audittrail-expand').modal('hide');
  }
  
  pageChanged(pageNumber: any) {
    this.currentPage = pageNumber;
    const startIndex = (this.currentPage - 1) * this.itemPerPage;
    const endIndex = startIndex + this.itemPerPage;
    const tempData = this.totalData.slice(startIndex, endIndex);
    this.formatAuditlog = [];
    this.formatAuditlog.push(...tempData);
  }

  isDate(str:any) {
    if(str) {
      const date = new Date(str);
      return !isNaN(date.getTime());
    }
  }

}