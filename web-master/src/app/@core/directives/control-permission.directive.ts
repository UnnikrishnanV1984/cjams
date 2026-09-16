import { Directive, ElementRef, Input, AfterViewInit, Renderer2 } from '@angular/core';
import { UserResource } from '../entities/authDataModel';
import { RoleGuard } from '../guard';

@Directive({
    // tslint:disable-next-line:directive-selector
    selector: '[fieldKey]',
    standalone: false
})
export class DisableControlDirective implements AfterViewInit {
    @Input() fieldKey: string | undefined;
    constructor(private readonly _renderer: Renderer2, private elementRef: ElementRef, private _roleGuard: RoleGuard) {}
    ngAfterViewInit() {
        const screenPermission = <UserResource[]>this._roleGuard.getPermissionsList();
        if (screenPermission && screenPermission.length) {
            const fieldPermission = screenPermission.find(item => item.resourceid === this.fieldKey);
            if (fieldPermission && (fieldPermission.resourcetype === 3 || fieldPermission.resourcetype === 4)) {
                if (fieldPermission.isenabled) {
                    const __self = this;
                    __self._renderer.setProperty(this.elementRef.nativeElement, 'disabled', 'true');
                    const childInputNodes = this.elementRef.nativeElement.querySelectorAll('input, select, textarea, button, mat-select, quill-editor');
                    childInputNodes.forEach(function(elem: { nodeName: string; }) {
                        __self._renderer.setAttribute(elem, 'disabled', 'true');       // SonarQube fix moved this to top to reduce the complexity
                        if (elem.nodeName === 'MAT-SELECT' || elem.nodeName === 'QUILL-EDITOR') {
                            __self._renderer.setProperty(elem, 'disabled', true);
                        }/* else {
                            __self._renderer.setAttribute(elem, 'disabled', 'true');
                        }*/
                    });
                }
            }
        }
    }
}
