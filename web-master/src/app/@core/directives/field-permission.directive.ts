import { Directive, Input, OnInit, TemplateRef, ViewContainerRef, ChangeDetectorRef } from '@angular/core';
import { UserResource } from '../entities/authDataModel';
import { RoleGuard } from '../guard';
// tslint:disable-next-line:directive-selector
@Directive({
    selector: '[securityKey]',
    standalone: false
})
export class FieldPermissionDirective implements OnInit {
    constructor(private templateRef: TemplateRef<any>,
        private _roleGuard: RoleGuard,
        private viewContainer: ViewContainerRef,
        private cdr: ChangeDetectorRef) {}
    _securityKey: any;
    @Input() set securityKey(key: any) {
        this._securityKey = key;
    }
    ngOnInit() {
        if (this._securityKey) {
            this.cdr.detectChanges();
            const screenPermission = <UserResource[]>this._roleGuard.getPermissionsList();
            if (screenPermission && screenPermission.length) {
                const fieldPermission = screenPermission.find(item => item.resourceid === this._securityKey);
                if (!fieldPermission) {
                    this.viewContainer.createEmbeddedView(this.templateRef);
                } else {
                    this.checkResourcetypeFn(fieldPermission);
                }
            } else {
                 this.viewContainer.createEmbeddedView(this.templateRef);
            }
        } else {
            this.viewContainer.createEmbeddedView(this.templateRef);
        }
    }
    // Assosiated with ngOnInit method
    private checkResourcetypeFn(fieldPermission: UserResource) {
        if (fieldPermission.resourcetype === 3) {
            if (fieldPermission.isallowed) {
                this.viewContainer.clear();
            } else {
                this.viewContainer.createEmbeddedView(this.templateRef);
            }
        } else if (fieldPermission.resourcetype === 4) {
            if (fieldPermission.isvisible) {
                this.viewContainer.createEmbeddedView(this.templateRef);
            } else {
                this.viewContainer.clear();
            }
        } else {
            this.viewContainer.clear();
        }
    }
}
