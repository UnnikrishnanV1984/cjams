import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import moment from 'moment';
import { CommonHttpService, AuthService, AlertService, CommonDropdownsService } from '../../../@core/services';
import { AppUser } from '../../../@core/entities/authDataModel';

@Component({
    selector: 'vendor-pay-file-calendar',
    templateUrl: './vendor-pay-file-calendar.component.html',
    styleUrls: ['./vendor-pay-file-calendar.component.scss'],
    standalone: false
})
export class VendorPayFileCalendarComponent implements OnInit {
  payFileCalendar: any[]= [];
  calendarYear: any[] = [];
  calendarPayFileFormGroup!: FormGroup;
  minYear!: number;
  calendarYearList: any;
  listCalendar!: any[];
  token!: AppUser;
  currentDate!: Date;
  previousDate: any;
  min_date_vendor_file_dt_in: any;
  vendorpaynotifymsg = 'Vendor and Pay file dates cannot be in the past. If the date is set to "today" it has to be done before 5:00 PM';
  vendorFileErrorMsg = 'Vendor file date cannot precede more 7 days prior and after to the default date';
  payFileErrorMsg = 'Pay file date cannot precede more than 4 days prior and after to the default date';
  dtformat = 'YYYY-MM-DD';
  constructor(
    private _commonService: CommonHttpService,
    private _formBuilder: FormBuilder,
    private _authService: AuthService,
    private _alertService: AlertService,
    private __dropdownService: CommonDropdownsService
  ) { }

  ngOnInit() {
    this.getYear();
    this.token = this._authService.getCurrentUser();
    this.minYear = new Date().getFullYear();
    const maxYear = this.minYear + 20;
    for (let i = this.minYear; i <= maxYear; i++) {
      this.calendarYear.push(i);
    }
    this.initCalendarForm();
    this.getCalendarList();
    this.listVendorPayCalendar(this.minYear);
  }

  getYear() {
    const url = 'Fmis_payment_vendor_date/Fmis_payment_vendor_date_year_list';
    const data = {
      method: 'post'
    };
    this._commonService.create(data, url).subscribe( (response: any[]) => {
      this.calendarYearList = response.map(ele => {
        return {
          value: ele.year_no,
          text: ele.year_no
        };
      });
    });
  }

  saveCalendar()  {
    const url = 'Fmis_payment_vendor_date/Fmis_payment_vendor_date_update';
    const data = this.calendarPayFileFormGroup.getRawValue();
    let yearsObj = [];
    if (data) {
      if (data.calendar && data.calendar.length > 0) {
        // yearsObj = data.calendar.filter()
        yearsObj = data.calendar.map((ele: any) => {

            ele.month = ele.month_no;
            ele.securityuserid = this.token.user.securityusersid;
            return ele;
          // }
        });
      }
    }
    this._commonService.create({yearsObj: yearsObj}, url).subscribe(response => {
      if (response) {
        this._alertService.success('Saved Successfully');

        this.listVendorPayCalendar(response[0].update_fmis_vendor_payment_date[0].year_no);
      }
    });
  }

  generateNextYear() {
    const nextYear = this.minYear + 1;
    const url = 'Fmis_payment_vendor_date/Fmis_payment_vendor_date_nxtyr_update';
    this._commonService.getArrayList({
      year: nextYear,
      method: 'post'
    }, url).subscribe( res => {
      this._alertService.success('Generated Successfully');
      this.calendarPayFileFormGroup.patchValue({
      year_no: nextYear
      });
      this.listVendorPayCalendar(nextYear);
      this.getYear();
      this.calendarPayFileFormGroup.patchValue({
        year_no: nextYear
      });

    });
  }

  listVendorPayCalendar(year: any) {
    this.calendarPayFileFormGroup.setControl('calendar', this._formBuilder.array([]));
    this._commonService.getArrayList({
      method: 'get',
      nolimit: true,
      where: {
        teamtypekey : 'CW',
        year_no: year,
        delete_sw: 'N'
      },
      order: 'month_no asc'
    }, 'Fmis_payment_vendor_date?filter'
    ).subscribe(response => {
      if (response) {
        this.listCalendar = response;
        this.payFileCalendar = response;
        this.getCalendarList();
      }
    });
  }

  initCalendarForm() {
    this.calendarPayFileFormGroup = this._formBuilder.group({
      year_no: [0]
    });
    this.calendarPayFileFormGroup.setControl('calendar', this._formBuilder.array([]));
    this.calendarPayFileFormGroup.patchValue({
      year_no: this.minYear
    });
  }
  createCalendarForm() {
    return this._formBuilder.group({
      month_no: ['', Validators.required],
      vendor_file_1_dt: ['', Validators.required],
      pay_file_1_dt: ['', Validators.required],
      vendor_file_2_dt: ['', Validators.required],
      pay_file_2_dt: ['', Validators.required],
      comments_tx: ['', Validators.required],
      min_date: [''],
      max_date: [''],
      vendor_1_default_date: [''],
      pay_1_default_date: [''],
      vendor_2_default_date: [''],
      pay_2_default_date: [''],
      updated_on: ['', Validators.required],
      updated_by: ['', Validators.required]
    });
  }

  private buildCalendarForm(x: any): FormGroup {
    return this._formBuilder.group({
      monthName: x.monthName,
      month_no: x.month_no,
      year: x.year_no,
      vendor_file_1_dt: this.__dropdownService.getValidDate(x.vendor_file_1_dt),
      pay_file_1_dt: this.__dropdownService.getValidDate(x.pay_file_1_dt),
      vendor_file_2_dt: this.__dropdownService.getValidDate(x.vendor_file_2_dt),
      pay_file_2_dt: this.__dropdownService.getValidDate(x.pay_file_2_dt),
      comments_tx: x.comments_tx,
      min_date_vendor_file_dt_1: this.getMinDatevendorfiledt1(x.vendor_file_1_dt),
      min_date: this.getMinDate(x.month_no, x.year_no),
      max_date: this.getMaxDate(x.month_no),
      vendor_1_default_date: this.checkDefaultDate('vendor_1', x.vendor_file_1_dt),
      pay_1_default_date: this.checkDefaultDate('pay_1', x.pay_file_1_dt),
      vendor_2_default_date: this.checkDefaultDate('vendor_2', x.vendor_file_2_dt),
      pay_2_default_date: this.checkDefaultDate('pay_2', x.pay_file_2_dt),
      past_month: this.checkIfPastMonth(x.month_no, x.year_no),
      updated_on: x.update_ts,
      updated_by: x.update_user_id,
      ischanged: false
    });
  }

  getCalendarList() {
    this.calendarPayFileFormGroup.setControl('calendar', this._formBuilder.array([]));
    const control = <FormArray>this.calendarPayFileFormGroup.controls['calendar'];
    this.payFileCalendar = this.payFileCalendar.map((x: any) => {
      x.monthName = this.getMonthName(x.month_no);
      return x;
    });
    this.payFileCalendar.forEach((x) => {
      control.push(this.buildCalendarForm(x));
    });
  }
  check(value: any) {
    this.previousDate = value;
  }
  // checkvendorfiledt1(value, i) {
  //   this.previousDate = value;
  //   (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
  //     min_date_vendor_file_dt_1: new Date(this.previousDate - 7)
  //   });
  // }
  appendList(i: number, date: string, value: any) {
     if (value) {
      const currentDate = new Date();
      const selectedDate = new Date(value);
      const prevdefaultDate = new Date(this.previousDate);
      const lastMonthlastDay = new Date(prevdefaultDate.getFullYear(), prevdefaultDate.getMonth(), 0);

      if (date === '1') {
        return this.ifDateVendorFile(currentDate, selectedDate, lastMonthlastDay, i);
      }  else if (date === '4') {
        return this.ifDatePayFile(currentDate, selectedDate, i);
      } else if (date === '13') {
        return this.ifDateVendor2File(currentDate, selectedDate, i);
      }  else if (date === '16') {
        return this.ifDatePay2File(currentDate, selectedDate, i);
      }
     }
    (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
      ischanged: true
    });
  }

  private ifDateVendorFile (currentDate: any, selectedDate: any, lastMonthlastDay: any, i: any){
    if (currentDate >= selectedDate) {
      if (currentDate.getHours() >= 17) {
        this._alertService.error(this.vendorpaynotifymsg);
        (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
          vendor_file_1_dt: new Date(this.previousDate)
        });
        return false;
      }
    }
    if ((selectedDate.getDate() > 7) && ( selectedDate.getDate() < (lastMonthlastDay.getDate() - 7) ))  {
      this._alertService.error(this.vendorFileErrorMsg);
      (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
        vendor_file_1_dt: new Date(this.previousDate)
      });
      return false;
    }
  }

  private ifDatePayFile (currentDate: any, selectedDate: any, i: any){
    if (currentDate >= selectedDate) {
      if (currentDate.getHours() >= 17) {
        this._alertService.error(this.vendorpaynotifymsg);
        (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
          pay_file_1_dt: new Date(this.previousDate)
        });
        return false;
      }
    }
    if (selectedDate.getDate() > 7) {
      this._alertService.error(this.payFileErrorMsg);
      (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
        pay_file_1_dt: new Date(this.previousDate)
      });
      return false;
    }
  }

  private ifDateVendor2File (currentDate: any, selectedDate: any, i: any){
    if (currentDate >= selectedDate) {
      if (currentDate.getHours() >= 17) {
        this._alertService.error(this.vendorpaynotifymsg);
        (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
          vendor_file_2_dt: new Date(this.previousDate)
        });
        return false;
      }
    }
    if (selectedDate.getDate() > 19 || selectedDate.getDate() < 7) {
      this._alertService.error(this.vendorFileErrorMsg);
      (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
        vendor_file_2_dt: new Date(this.previousDate)
      });
      return false;
    }
  }

  private ifDatePay2File (currentDate: any, selectedDate: any, i: any){
    if (currentDate >= selectedDate) {
      if (currentDate.getHours() > 17) {
        this._alertService.error(this.vendorpaynotifymsg);
        (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
          pay_file_2_dt: new Date(this.previousDate)
        });
        return false;
      }
    }
    if (selectedDate.getDate() > 19 || selectedDate.getDate() < 13) {
      this._alertService.error(this.payFileErrorMsg);
      (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls[i].patchValue({
        pay_file_2_dt: new Date(this.previousDate)
      });
      return false;
    }
  }

  getMonthName(id: number) {
   switch (id) {
     case 1: return 'January';
     case 2: return 'February';
     case 3: return 'March';
     case 4: return 'April';
     case 5: return 'May';
     case 6: return 'June';
     case 7: return 'July';
     case 8: return 'August';
     case 9: return 'September';
     case 10: return 'October';
     case 11: return 'November';
     case 12: return 'December';
   }
  }

  checkIfPastMonth(month: any, year: any) {
    const currentMonth = moment().get('month') + 1;
    const curryear = new Date().getFullYear();
    if ((year && year > curryear) || (month && month >= currentMonth)) {
      return false;
    }
    return true;
  }

  getMinDate(month: any, year: any) {
    const _date = new Date(); 
    const current_date = _date.getDate();
    const current_month = (_date.getMonth()+1); 
    const current_year = _date.getFullYear();
    const _year_no = this.calendarPayFileFormGroup.getRawValue().year_no;
    let minDate;
    if (year <= current_year) {
      if(month <= current_month) {
        minDate = moment(_year_no + '/' + current_month + '/' + current_date).format(this.dtformat);
      } else  if (month === (current_month + 1)) {
        minDate = moment(_year_no + '/' + month + '/' + current_date).format(this.dtformat);
      } else {
        minDate = moment(_year_no + '/' + month + '/01').format(this.dtformat);
      }
    } else {
        minDate = moment(_year_no + '/' + month + '/01').format(this.dtformat);
    }
    return this.__dropdownService.getValidDate(minDate);
  }
  getMinDatevendorfiledt1(indate: string) {
    var vendorpayfileDate1=new Date(indate);
    vendorpayfileDate1.setDate(vendorpayfileDate1.getDate() - 7) ;
    return vendorpayfileDate1;
  }
  getMaxDate(month: any) {
    return moment(this.calendarPayFileFormGroup.getRawValue().year_no + '/' + month + '/01').endOf('month').add(1).format(this.dtformat);
  }

  checkDefaultDate(type: string, dateDefault: string) {
    const date = this.__dropdownService.getValidDate(dateDefault);
    if (type === 'vendor_1') {
      return (moment(date).format('D') == '1') ? false : true;
    } else if (type === 'pay_1') {
      return (moment(date).format('D') == '4') ? false : true;
    } else if (type === 'vendor_2') {
      return (moment(date).format('D') == '13') ? false : true;
    } else if (type === 'pay_2') {
      return (moment(date).format('D') == '16') ? false : true;
    } else {
      return true;
    }
  }

  getCalanderControls() {
    return  (<FormArray>this.calendarPayFileFormGroup.get('calendar')).controls;
}

}
