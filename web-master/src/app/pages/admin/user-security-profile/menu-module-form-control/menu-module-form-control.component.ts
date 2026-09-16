
import {EMPTY,  Subject ,  Observable } from 'rxjs';
import { Component, Input, OnInit } from '@angular/core';
import { AdminUrlConfig } from '../../admin-url.config';
import { Resource, ResourcePermission } from '../_entites/user-security-profile.data.modal';
import { GenericService } from '../../../../@core/services';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'menu-module-form-control',
    templateUrl: './menu-module-form-control.component.html',
    styleUrls: ['./menu-module-form-control.component.scss'],
    standalone: false
})
export class MenuModuleFormControlComponent implements OnInit {
    roleId: number | undefined;
    selectedResources: Resource[] = [];
    actionPermission$: Observable<ResourcePermission[]> = new Observable<ResourcePermission[]>();
    controlPermission$: Observable<ResourcePermission[]> = new Observable<ResourcePermission[]>();
    modulePermission$: Observable<ResourcePermission[]> = new Observable<ResourcePermission[]>();
    menuPermission$: Observable<ResourcePermission[]> = new Observable<ResourcePermission[]>();
    selectedResourses$: Observable<Resource[]> = new Observable<Resource[]>();
    @Input() permissionGroupId!: string;
    @Input() roleId$ = new Subject<number>();
    @Input() resourseListSubject$!: Subject<Resource[]>;
    @Input() resourseSubject$!: Subject<Resource>;
    constructor(private _resourceService: GenericService<ResourcePermission>) {}

    ngOnInit() {
        if (this.resourseListSubject$) {
            this.resourseListSubject$.subscribe((items) => {
                this.selectedResources = items;
            });
        }
    }

    resource(parent: any, type: string) {
        this.menuPermission$ = EMPTY;
        if (type === 'menu') {
            if (this.permissionGroupId) {
                this.menuPermission$ = this._resourceService.getArrayList(
                    {
                        method: 'get',
                        where: {
                            resourcetype: [1],
                            permissiongroupid: this.permissionGroupId ? this.permissionGroupId : ''
                        }
                    },
                    AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
                );
            } else if (this.roleId) {
                this.menuPermission$ = this._resourceService.getArrayList(
                    {
                        method: 'get',
                        where: {
                            resourcetype: [1],
                            roleid: this.roleId
                        }
                    },
                    AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
                );
            }
        }
        if (type === 'module') {
            this.modulePermission$ = EMPTY;
            this.controlPermission$ = EMPTY;
            this.actionPermission$ = EMPTY;
            this.modulePermission$ = this._resourceService.getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [2],
                        parentid: parent.id,
                        permissiongroupid: this.permissionGroupId
                    }
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
            );
        } else if (type === 'control') {
            this.controlPermission$ = EMPTY;
            this.actionPermission$ = EMPTY;
            this.controlPermission$ = this._resourceService.getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [3],
                        parentid: parent.id,
                        permissiongroupid: this.permissionGroupId
                    }
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
            );
        } else if (type === 'action') {
            this.actionPermission$ = EMPTY;
            this.actionPermission$ = this._resourceService.getArrayList(
                {
                    method: 'get',
                    where: {
                        resourcetype: [4],
                        parentid: parent.id,
                        permissiongroupid: this.permissionGroupId
                    }
                },
                AdminUrlConfig.EndPoint.UserProfile.ResourceListUrl + '?filter'
            );
        }
    }

    selectedResource(selectedItem: any, event: any, type: any) {
        const index = this.selectedResources.indexOf(selectedItem);
        const isChecked = event.target.checked;
        switch (type) {
            case 'isenabled':
                selectedItem.isenabled = isChecked;
                break;
            case 'isvisible':
                selectedItem.isvisible = isChecked;
                break;
            case 'isallowed':
                selectedItem.isallowed = isChecked;
                break;
        }
        this.selectedResources[index] = selectedItem;
        this.resourseSubject$.next(selectedItem);
    }
}
