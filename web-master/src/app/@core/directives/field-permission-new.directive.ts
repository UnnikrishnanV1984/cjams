import { Directive, Input, OnInit, TemplateRef, ViewContainerRef, ChangeDetectorRef } from '@angular/core';
import { AuthService } from '../services';
// tslint:disable-next-line:directive-selector
@Directive({
    selector: '[securityKeyNew]',
    standalone: false
})
export class FieldPermissionDirectiveNew implements OnInit {
    @Input() securityKeyNew: string | undefined;
    securityKey: string[] = [];
    constructor(private templateRef: TemplateRef<any>,
        private viewContainer: ViewContainerRef,
        private cdr: ChangeDetectorRef, private auth: AuthService) { }
    ngOnInit() {
        if (this.securityKeyNew) {
            if(this.securityKeyNew.includes(',')) {
                this.securityKey = this.securityKeyNew.split(',');
            } else {
                return true;
            }
            this.cdr.markForCheck();
            if(this.securityKey && this.securityKey.length) {
                if (this.auth.isView(this.securityKey[0], this.securityKey[1])) {
                    this.viewContainer.createEmbeddedView(this.templateRef);
                } else {
                    this.viewContainer.clear();
                }
            } else {
                this.viewContainer.createEmbeddedView(this.templateRef);
            }
        }else {
            this.viewContainer.createEmbeddedView(this.templateRef);
        }
    }

}
