import { Component, Input, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

import { ObjectUtils } from '../../../../../@core/common/initializer';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonHttpService, GenericService, AlertService } from '../../../../../@core/services';
import { DATypeScreenStatus, DefaultAccessConfig, DefaultAccessList } from '../_entities/da-type-config.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'default-access-list',
    templateUrl: './default-access-list.component.html',
    styleUrls: ['./default-access-list.component.scss'],
    standalone: false
})
export class DefaultAccessListComponent implements OnInit {
    @Input()
    id!: string;
    @Input()
    screenStatus!: DATypeScreenStatus;
    leftItems: DefaultAccessList[] = [];
    rightItems: DefaultAccessList[] = [];
    defaultAccessListForm!: FormGroup;
    defaultaccesslistmodal: DefaultAccessConfig = new DefaultAccessConfig();
    private rightSelectedItems: DefaultAccessList[] = [];
    private leftSelectedItems: DefaultAccessList[] = [];
    noitemselectedmsg = 'No items selected.';
    constructor(
        private formBuilder: FormBuilder,
        private _defaultAccessListService: GenericService<DefaultAccessList>,
        private _defaultAccessListCommonService: CommonHttpService,
        private _alertService: AlertService,
        private _changeDetect: ChangeDetectorRef
    ) {}
    ngOnInit() {
        this.reusableInitializerFn();
    }

    formInitilize() {
        this.defaultAccessListForm = this.formBuilder.group({
            positioncode: [''],
            roletypekey: [''],
            firstname: [''],
            lastname: ['']
        });
    }

    saveItems() {
        const positionCodes: string[] = [];
        this.rightItems.forEach((item) => {
            if (item.positioncode) {
                positionCodes.push(item.positioncode);
            }
        });
        this._defaultAccessListCommonService.endpointUrl = 'daconfig/accesslist/addupdate';
        this.defaultaccesslistmodal.servicerequesttypeconfigid = this.id;
        this.defaultaccesslistmodal.loadnumber = positionCodes;
        this._defaultAccessListCommonService.create(this.defaultaccesslistmodal).subscribe((response) => {
            this.reusableInitializerFn();
        });
    }
    private reusableInitializerFn() {
        this.formInitilize();
        this.searchDefaultAccessListList(this.defaultAccessListForm.value, 'list');
        this.selectedList();
    }

    selectedList() {
        this._defaultAccessListService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: {
                        servicerequesttypeconfigid: this.id,
                        activeflag: 1
                    }
                }),
                'admin/teammember/getteammemberdetails?filter'
            )
            .subscribe((result) => {
                this.screenStatus.hasDefaultAccessList = !(result.data === null || result.data.length === 0);
                this.rightItems = result.data === null ? [] : result.data;
            });
    }
    searchDefaultAccessListList(modalvalue: DefaultAccessList, type: string) {
        modalvalue.servicerequesttypeconfigid = this.id;
        modalvalue.type = type;
        ObjectUtils.removeEmptyProperties(modalvalue);
        this._defaultAccessListService
            .getPagedArrayList(
                new PaginationRequest({
                    method: 'get',
                    where: modalvalue,
                    limit: 10
                }),
                'admin/teammember/getteammemberdetails?filter'
            )
            .subscribe((result) => {
                this.leftItems = result.data === null ? [] : result.data;
            });
    }

    selectItem(position: string, selectedItem: DefaultAccessList, control: any) {
        if (position === 'left') {
            if (control.target.checked) {
                this.leftSelectedItems.push(selectedItem);
            } else {
                const index = this.leftSelectedItems.indexOf(selectedItem);
                this.leftSelectedItems.splice(index, 1);
            }
        } else {
            if (control.target.checked) {
                this.rightSelectedItems.push(selectedItem);
            } else {
                const index = this.rightSelectedItems.indexOf(selectedItem);
                this.rightSelectedItems.splice(index, 1);
            }
        }
    }

    addAccessList() {
        if (this.leftSelectedItems.length) {
            this.moveItems(this.leftItems, this.rightItems, this.leftSelectedItems);
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    addAllAccessList() {
        if (this.leftItems.length) {
            this.moveItems(this.leftItems, this.rightItems, Object.assign([], this.leftItems));
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    removeAccessList() {
        if (this.rightSelectedItems.length) {
            this.moveItems(this.rightItems, this.leftItems, this.rightSelectedItems);
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    removeAllAccessList() {
        if (this.rightItems.length) {
            this.moveItems(this.rightItems, this.leftItems, Object.assign([], this.rightItems));
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }

    private moveItems(source: DefaultAccessList[], target: DefaultAccessList[], selectedItems: DefaultAccessList[]) {
        selectedItems.forEach((item: DefaultAccessList, i) => {
            const selectedIndex = source.indexOf(item);
            if (selectedIndex !== -1 /*selectedItem.length*/) {
                source.splice(selectedIndex, 1);
                target.push(item);
            }
        });
        this._changeDetect.detectChanges();
    }

    private clearSelectedItems(position: string) {
        if (position === 'left') {
            this.leftSelectedItems = [];
        } else {
            this.rightSelectedItems = [];
        }
    }
}
