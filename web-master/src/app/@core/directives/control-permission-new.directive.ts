import { Directive, ElementRef, Input, AfterViewInit, Renderer2 } from '@angular/core';
import {AuthService } from '../services';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[fieldKeyNew]',
    standalone: false
})
export class DisableControlDirectiveNew implements AfterViewInit {
    @Input() fieldKeyNew: string | undefined;
    fieldKey: string[] = [];
    constructor(private readonly _renderer: Renderer2, private elementRef: ElementRef, private auth: AuthService) {}
    ngAfterViewInit() {
        // If the resource set to be disabled as true then control should be disabled.
        if(this.fieldKeyNew){
            this.fieldKey = this.fieldKeyNew.split(',');
            if(this.fieldKey && this.fieldKey.length) {
                if (this.auth.isDisabled(this.fieldKey[0], this.fieldKey[1])) {
                    const __self = this;
                    __self._renderer.setProperty(this.elementRef.nativeElement, 'disabled', 'true');
                    const childInputNodes = this.elementRef.nativeElement.querySelectorAll('input, select, textarea, button, mat-select, quill-editor');
                    childInputNodes.forEach(function(elem: { nodeName: string; }) {
                        if (elem.nodeName === 'MAT-SELECT' || elem.nodeName === 'QUILL-EDITOR') {
                            __self._renderer.setProperty(elem, 'disabled', true);
                        } else {
                            __self._renderer.setAttribute(elem, 'disabled', 'true');
                        }
                    });
                }
            }
        }

    }
}
