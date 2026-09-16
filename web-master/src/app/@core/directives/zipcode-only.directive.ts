import { Directive, ElementRef, HostListener } from '@angular/core';
import { AlertService } from '../services';
import { NgControl } from '@angular/forms';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[zipcodeOnly]',
    standalone: false
})
export class ZipcodeOnlyDirective {



  constructor(private el: ElementRef,
    private alertService: AlertService,
    private control: NgControl) { }
  @HostListener('blur', ['$event.target'])
  onBlur(target: any) {

    if (target.value && !this.isValidZipCode(target.value)) {
      this.alertService.error(target.value + ' is not an valid zipcode');
      target.value = '';
    }
    this.control.control?.setValue(target.value);


  }

  isValidZipCode(zipcode: string): boolean {
    const regex: RegExp = new RegExp(/^[0-9]{5}(?:-[0-9]{4})?$/);
    return regex.test(zipcode);
  }

}
