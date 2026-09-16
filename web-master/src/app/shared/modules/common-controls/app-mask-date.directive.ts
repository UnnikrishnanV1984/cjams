import { Directive, ElementRef, OnDestroy, ViewChild, AfterViewInit } from '@angular/core';
import createNumberMask from 'text-mask-addons/dist/createNumberMask';
import { MatDatepickerInput } from '@angular/material/datepicker';
import { Subscription ,  fromEvent } from 'rxjs';
import { NgControl } from '@angular/forms';

@Directive({
    // tslint:disable-next-line:directive-selectortransport-dboard.module.ts
    selector: '[appMaskDate]',
    standalone: false
})
export class AppMaskDateDirective implements  AfterViewInit, OnDestroy {

 // '^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$'
  mask = [/[0-1]/, /\d/, '/', /[0-3]/, /\d/, '/', /[1-2]/, /\d/, /\d/, /\d/]; // mm/dd/yyyy
  maskedInputController;
  @ViewChild(MatDatepickerInput) datepickerInput!: MatDatepickerInput<any>;
  eventSubscription: Subscription = new Subscription();
  constructor(
    private elementRef: ElementRef,
    private control: NgControl
  ) {

    this.maskedInputController = createNumberMask({
      inputElement: this.elementRef.nativeElement,
      mask: this.mask
    });
  }

  ngAfterViewInit() {
    this.eventSubscription = fromEvent(this.elementRef.nativeElement, 'input').subscribe(_ => {
        if(this.control?.control) {
            this.control.control.setValue(this.elementRef.nativeElement.value);
        }
    });
  }

  ngOnDestroy() {
    if (this.maskedInputController && this.maskedInputController.destroy) {
      this.maskedInputController.destroy();
    }
  }

}
