import { Directive, ElementRef, HostListener } from '@angular/core';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[stringOnlyAllowSpace]',
    standalone: false
})
export class StringOnlyAllowSpaceDirective {
    private regex: RegExp = new RegExp(/^[a-zA-Z-'\s]*$/);
    private specialKeys: Array<string> = [
        'Backspace',
        'Tab',
        'End',
        'Home',
        '-',
        '\''
    ];

    constructor(private el: ElementRef) {}
    @HostListener('keydown', ['$event'])
    onKeyDown(event: KeyboardEvent) {
        if (this.specialKeys.indexOf(event.key) !== -1) {
            return;
        }
        const current: string = this.el.nativeElement.value;
        const next: string = current.concat(event.key);
        if (next && !String(next).match(this.regex)) {
            event.preventDefault();
        }
    }
}
