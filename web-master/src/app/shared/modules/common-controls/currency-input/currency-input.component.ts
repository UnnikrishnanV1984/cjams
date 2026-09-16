import { Component, forwardRef, AfterViewInit, OnChanges, Input, Output, ChangeDetectorRef, ElementRef, ViewChildren, QueryList, EventEmitter } from '@angular/core';
import { NG_VALUE_ACCESSOR, ControlValueAccessor } from '@angular/forms';
import { CurrencyPipe } from '@angular/common';

@Component({
    selector: 'currency-input',
    templateUrl: './currency-input.component.html',
    styleUrls: ['./currency-input.component.scss'],
    providers: [
        { provide: NG_VALUE_ACCESSOR, useExisting: forwardRef(() => CurrencyInputComponent), multi: true }
    ],
    standalone: false
})
export class CurrencyInputComponent implements AfterViewInit, OnChanges, ControlValueAccessor {



  @Input() _curValue!: string | null;
  formattedCurValue!: string | null;
  hidden: any = false;
  @Input() placeholder!: string;
  @Input() required!: boolean;
  @Input() min!: number;
  @Input() max!: number;
  @Input() disabled?: boolean;
  @Input() commonDatePickerFilter: any;
  @Input() ngClass!: string;
  @Output() valueChange = new EventEmitter();
  dateFormat = 'MM/DD/YYYY';

  @ViewChildren('formatted') formattedInput!:QueryList<ElementRef>;
  @ViewChildren('original') originalInput!:QueryList<ElementRef>;


  constructor(private currencyPipe: CurrencyPipe, private cdr: ChangeDetectorRef) {
  }

  ngAfterViewInit() {
    this.cdr.detectChanges();
    if (this.curValue) {
      this.setValueToControls(this.curValue);
    }
  }
  setDisabledState?(isDisabled: boolean): void {
    this.disabled = isDisabled;
  }

  setValueToControls(value: any) {
      this.formattedCurValue = this.currencyPipe.transform(value);
  }

  onFocus(event: any) {
    // setTimeout(() => {
      this.hidden = true;
    // }, 100);
    // this.originalInput.nativeElement.focus();
  }

  onFocusOut(event: any) {
    this.hidden = false;
    const val = event.target.value;
    this.setValueToControls(val);
  }

  resetControlValues() {
    this.formattedCurValue = null;
  }

  ngOnChanges(changes: any) {
    // No operation needed here
  }
  onMaskCurChanged(event: any) {
    this.valueChange.emit(this.formattedCurValue ?? '');
    this.curValue = this.formattedCurValue;
    this.valueChange.emit(this.curValue ?? '');

  }

  onValueChange(event: any) {
    const val = event.target.value;
    this.setValueToControls(val);
  }

  get curValue() {
    return this._curValue;
  }

  set curValue(val) {
    this._curValue = val;
    this.propagateChange(this._curValue);
  }

  propagateChange = (_: any) => {
    // No content to add or call
  };

  writeValue(obj: any): void {
    this.curValue = obj;
    this.setValueToControls(this.curValue);
  }

  registerOnChange(fn: any): void {
    this.propagateChange = fn;
  }

  registerOnTouched(fn: any): void {
    // No content to add or call
  }

  resetDate() {
    this.formattedCurValue = null;
    this.curValue = null;
  }
}
