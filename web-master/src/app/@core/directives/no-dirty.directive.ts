import { Directive, HostListener } from '@angular/core';
import { NgControl } from '@angular/forms';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[noDirty]',
    standalone: false
})
export class NoDirtyDirective {
    constructor(private control: NgControl) {}

    @HostListener('keydown', ['$event'])
    onKeyDown(event: KeyboardEvent) {
        this.control.valueChanges?.subscribe((_v: any) => {
            if (this.control.dirty) {
                this.control.control?.markAsPristine();
            }
        });
    }
}
