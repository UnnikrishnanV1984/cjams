import { Directive, ElementRef, HostListener } from '@angular/core';
@Directive({
    selector: '[appTwoDigitDecimaNumber]',
    standalone: false
})
export class TwoDigitDecimaNumberDirective {
  private regex: RegExp = new RegExp(/^\d*\.?\d{0,2}$/g);
  private specialKeys: Array<string> = ['Backspace', 'Tab', 'End', 'Home', 'ArrowLeft', 'ArrowRight', 'Del', 'Delete'];
  constructor(private el: ElementRef) {
  }
  @HostListener('keydown', ['$event'])
  onKeyDown(event: KeyboardEvent) {
    // Allow Backspace, tab, end, and home keys
    if (this.specialKeys.indexOf(event.key) !== -1) {
      return;
    }
    const current: string = this.el.nativeElement.value;
    const position = this.el.nativeElement.selectionStart;
    if (event.key === '.') {
      // If the current string is empty or the first character is a decimal,
      // add a 0 before the decimal point
      if (current.length === 0 || current[0] === '.') {
        event.preventDefault(); // Prevent the original '.' input
        this.el.nativeElement.value = '0.' + current.slice(position); // Add 0 before decimal
        return;
      }
    }
    const next: string = [current.slice(0, position), event.key === '.' ? '.' : event.key, current.slice(position)].join('');
    if (next && !String(next).match(this.regex)) {
      event.preventDefault();
    }
  }
}