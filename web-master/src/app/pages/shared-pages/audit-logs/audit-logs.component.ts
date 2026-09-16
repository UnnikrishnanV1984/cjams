import { Component, OnInit,Input } from '@angular/core';
import moment from 'moment';


declare var $: any;
@Component({
    selector: 'audit-logs',
    templateUrl: './audit-logs.component.html',
    styleUrls: ['./audit-logs.component.scss'],
    standalone: false
})
export class AuditLogsComponent implements OnInit {
    @Input() auditlogTrail!: any;
    formatAuditlog: any;
    auditlogTrailExpand: any;

  ngOnInit() {
    if (this.auditlogTrail?.length) {
      const sortresult = this.auditlogTrail;
      sortresult.forEach((el: any) => {
        const a = this.modifieddataCheckFn(el);
        this.formattingAuditDataFn(a);
      })
      this.formatAuditlog = sortresult;
    }
  }

  private formattingAuditDataFn(a: any) {
    if (a) {
      a.forEach((element: any) => {
        element.new_value = this.booleanToYesNo(element.new_value);
        element.old_value = this.booleanToYesNo(element.old_value);

        if (element.key.includes('date') && !element.key.includes('permanencyplanremainssamedate')) {
          element.new_value = this.formatDateValue(element.new_value);
          element.old_value = this.formatDateValue(element.old_value);
        }

        if (element.key.includes('time')) {
          element.new_value = this.formatTimeValue(element.new_value);
          element.old_value = this.formatTimeValue(element.old_value);
        }

        if (element.key.includes('permanencyplanremainssamedate')) {
          element.new_value = this.formatDateTimeValue(element.new_value);
          element.old_value = this.formatDateTimeValue(element.old_value);
        }

        if (element.key.includes('approvedon') || element.key.includes('submittedon') || element.key.includes('rejectedon')) {
          element.new_value = this.formatDateTimeValue(element.new_value);
        }
      });
    }
  }

  private modifieddataCheckFn(el: any) {
    return el.modifieddata && el.modifieddata.data ? el.modifieddata.data : null;
  }

  private booleanToYesNo(value: any) {
    if (value === true || value === 1) {
      return 'Yes';
    } else if (value === false || value === 0 || value === 2) {
      return 'No';
    }
    return value;
  }

  private formatDateValue(value: any) {
    if (moment(value).isValid()) {
      return this.getDateFormatted(value);
    }
    return value;
  }

  private formatTimeValue(value: any) {
    if (moment(value).isValid()) {
      return this.getTimeFormatted(value);
    }
    return value;
  }

  private formatDateTimeValue(value: any) {
    if (moment(value).isValid()) {
      return this.getDateTimeFormatted(value);
    }
    return value;
  }

    auditlogTrailOpen(id: any, index: any) {
        this.auditlogTrailExpand = [];
         if(id.modifieddata.data && id.modifieddata.data.length) {
             this.auditlogTrailExpand  = id.modifieddata.data
         }
        $('#audittrail-expand').modal('show');
     }

     getDateFormatted(date:any){
        if(date){
          return moment(date).format('MM/DD/YYYY');
        }else{
          return '';}
      }
    
      getDateTimeFormatted(date:any){
        if(date){
          return moment(date).format('MM/DD/YYYY, h:mm A');
        }else{
          return '';}
      }
    
      getTimeFormatted(date:any){
        if(date){
          return moment(date).format('h:mm A');
        }else{
          return '';}
      }
      
}