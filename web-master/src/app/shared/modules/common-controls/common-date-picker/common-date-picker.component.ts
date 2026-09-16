import { AfterViewInit, Component, forwardRef, Input, OnChanges, Output, ViewChild, HostListener,EventEmitter } from '@angular/core';
import { ControlValueAccessor, FormControl, NG_VALUE_ACCESSOR, NG_VALIDATORS } from '@angular/forms';
import { MatDatepicker } from '@angular/material/datepicker';
import moment from 'moment';
import { AlertService } from '../../../../@core/services';

const dtformat = 'MM/DD/YYYY';
export function validateDate() {
  return (c: FormControl) => {
    if (c.value) {
      const momentDate = moment(c.value, [moment.ISO_8601, dtformat]);
      if (!momentDate.isValid()) {
        return 'Invalid Date ' + c.value;
      }
    }
    return null;
  };
}

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'common-date-picker',
    host: {
        class: 'common-date-picker'
    },
    templateUrl: './common-date-picker.component.html',
    styleUrls: ['./common-date-picker.component.scss'],
    providers: [
        { provide: NG_VALUE_ACCESSOR, useExisting: forwardRef(() => CommonDatePickerComponent), multi: true },
        { provide: NG_VALIDATORS, useExisting: forwardRef(() => CommonDatePickerComponent), multi: true }
    ],
    standalone: false
})

export class CommonDatePickerComponent implements AfterViewInit, OnChanges, ControlValueAccessor {


  maskedDate: string ='';
  @Input() _dateValue: string | null | undefined;
   pickerDate: Date | null =null;
  @Input() validationwithdate= 'Y';
  @Input() placeholder!: string;
  @Input() required!: boolean;
  @Input() min!: any;
  @Input() minplaceholder!: Date;
  @Input() max?: any;
  @Input() disabled: boolean = false;
  @Input() commonDatePickerFilter: any;
  @Input() ngClass!: string;
  @Input() readOnly: any;
  @Output() valueChange = new EventEmitter();
  @Output() valueClick = new EventEmitter();
  dateFormat = dtformat;


  @ViewChild('picker') datePicker!: MatDatepicker<Date>;


  constructor(private _alertService: AlertService) {

  }

  ngAfterViewInit() {
    if (this.dateValue) {
      this.setValueToControls(this.dateValue);
    } else {
      //No operation needed here
    }
  }

  onDateClick() {
    this.valueClick.emit(this.maskedDate);
  }

  setValueToControls(value: any) {
    if (value) {
      this.pickerDate = this.formatStringToDate(value);
      this.maskedDate = this.pickerDate ? this.formatDateToString(this.pickerDate) : '';
    } else {
      this.resetControlValues();
    }

  }

  resetControlValues() {
    this.pickerDate = null;
    this.maskedDate = '';
  }

  ngOnChanges(changes: any) {
    this.validateDateFn = validateDate();
    this.min = this.min ? this.min : new Date(new Date().setFullYear(new Date().getFullYear() - 100));
    this.max = this.max ? this.max : new Date(new Date().setFullYear(new Date().getFullYear() + 100));

  }
  onMaskDateChanged(event: any) {
    this.valueChange.emit(this.maskedDate);
    if (!this.maskedDate) {
      this.resetDate();
      return null;
    }
    const momentDate = moment(this.maskedDate, this.dateFormat);
    if (!this.checkForValidation(momentDate)) {
      return null;
    }
    this.pickerDate = new Date(this.maskedDate);
    this.dateValue = this.maskedDate;
    this.valueChange.emit(this.dateValue);

  }

  checkForValidation(momentDate: any) {
    if (!momentDate.isValid()) {
      this._alertService.error(this.maskedDate + ' is not valid date');
      this.resetDate();
      return false;

    }
    if (this.min && momentDate.isBefore(this.min) && this.validationwithdate === 'Y') {
      const message = this.placeholder ? this.placeholder  : 'Selected date ';
      let msg = ' should be greater than ';
      if (this.minplaceholder) {
        msg = ' should be greater than or equal to ';
      }
      this._alertService.error(message + msg + this.formatDateToString(this.returnMinDateFn()));
      this.resetDate();
      return false;
    }
    if (this.max && momentDate.isAfter(this.max)) {
      const message = this.placeholder ? this.placeholder  : 'Selected date '; //CIDM-9947 - Dob/Dod will be specified
      this._alertService.error(message + ' should be less than ' + this.formatDateToString(this.max));
      this.resetDate();
      return false;
    }

    return true;
  }

  private returnMinDateFn(): Date {
    return (this.minplaceholder ? this.minplaceholder : this.min);
  }

  onMaskDateChange() {
    this.handleMaskDateFn();
  }

  private handleMaskDateFn() {
    if (this.datePicker.opened) {
      this.datePicker.close();
    }
  }

  onDatePickerClosed() {
    // No operation needed here
  }

  onPickerDateChange() {
    this.valueClick.emit(this.maskedDate);
    const momentDate = moment(this.pickerDate, moment.ISO_8601);
    if (!this.checkForValidation(momentDate)) {
      return null;
    }
    this.maskedDate = this.pickerDate ? this.formatDateToString(this.pickerDate) : '';
    this.dateValue = this.maskedDate;
    this.valueChange.emit(this.dateValue);
  }

  get dateValue() {
    return this._dateValue;
  }

  set dateValue(val) {
    this._dateValue = val;
    this.propagateChange(this._dateValue);
  }

  validateDateFn: any = () => {
    // No content to add or call
  };
  propagateChange = (_: any) => {
    // No content to add or call
  };

  writeValue(obj: any): void {
    this.dateValue = obj;
    this.setValueToControls(this.dateValue);
  }

  registerOnChange(fn: any): void {
    this.propagateChange = fn;
  }

  registerOnTouched(fn: any): void {
    // No content to add or call
  }

  formatDateToString(date: Date): any {
    const convertedDate = moment(date);
    if (convertedDate.isValid()) {
      return convertedDate.format(dtformat);
    } else {
      return null;
    }
  }
  formatStringToDate(dateString: string): any {
    const convertedDate = moment(dateString, moment.ISO_8601);
    if (convertedDate.isValid()) {
      return moment(dateString, moment.ISO_8601).toDate();
    } else {
      return null;
    }


  }

  setDisabledState?(isDisabled: boolean): void {
    this.disabled = isDisabled;
  }

  @HostListener('keydown', ['$event'])
  onKeyDown(event1: KeyboardEvent) {
    this.handleMaskDateFn();
  }

  validate(c: FormControl) {
    return this.validateDateFn(c);
  }

  resetDate() {
    this.pickerDate = null;
    this.maskedDate = '';
    this.dateValue = null;
  }

}
