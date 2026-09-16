import { Directive } from '@angular/core';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[appMaskDate]',
    standalone: false
})
export class AppMaskDateDirective {

  mask = [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]; // mm/dd/yyyy
  maskedInputController: any;
}
