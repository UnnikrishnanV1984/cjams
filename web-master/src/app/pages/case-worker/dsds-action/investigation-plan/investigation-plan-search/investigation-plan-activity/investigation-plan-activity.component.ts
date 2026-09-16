import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { ActivityPlan } from '../../_entities/investigationplan.data.models';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-plan-activity',
    templateUrl: './investigation-plan-activity.component.html',
    styleUrls: ['./investigation-plan-activity.component.scss'],
    standalone: false
})
export class InvestigationPlanActivityComponent implements OnInit {
    daNumber: string;
    id: string;
    leftItems: ActivityPlan[] = [];
    rightItems: ActivityPlan[] = [];
    private investigationID: string;
    private rightSelectedItems: ActivityPlan[] = [];
    private leftSelectedItems: ActivityPlan[] = [];
    noitemselectedmsg = 'No items selected.';
    constructor(private _service: CommonHttpService, private _router: Router, private route: ActivatedRoute, private _alertService: AlertService, private _changeDetect: ChangeDetectorRef,
        private _dataStoreService: DataStoreService) {
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.AmmappingListUrl;
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.investigationID = this.route.snapshot.params['investigationID'];
    }
    ngOnInit() {
        this.getAvailableConfiguration();
        $('#myModal-add-activity').modal('show');
    }
    getAvailableConfiguration() {
     this._service
            .getPagedArrayList(
                new PaginationRequest({
                    order: 'name ASC',
                    where: {
                        activitytypekey: { inq: ['Allegation', 'Investigation'] },
                        activeflag: 1,
                        ondemand: 't'
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.AmmappingListUrl + '?filter'
            )
            .subscribe((result) => {
                this.leftItems = result.data === null ? [] : result.data;
            });
    }
    saveItem() {
        this.rightItems = this.rightItems.map((item) =>
            Object.assign({
                description: item.description,
                amactivityid: item.amactivityid,
                ammappingid: item.ammappingid,
                objectid: this.investigationID,
                activitytypekey: item.activitytypekey
            })
        );
        const inputRequest = { activity: this.rightItems };
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvestigationPlan.GetActvitiesAddUrl;
        this._service.create(inputRequest).subscribe((response) => {
                this.getAvailableConfiguration();
                this.closePopup();
                this.rightItems = [];
        });
    }
    closePopup() {
        $('#myModal-add-activity').modal('hide');
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/investigation-plan';
        this._router.navigateByUrl(currentUrl).then(() => {
            this._router.navigated = false;
            this._router.navigate([currentUrl]);
            this._alertService.success('Activities added successfully!');
        });
    }
    selectAll() {
        if (this.leftItems.length) {
            this.moveItems(this.leftItems, this.rightItems, Object.assign([], this.leftItems));
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    select() {
        if (this.leftSelectedItems.length) {
            this.moveItems(this.leftItems, this.rightItems, this.leftSelectedItems);
            this.clearSelectedItems('left');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelect() {
        if (this.rightSelectedItems.length) {
            this.moveItems(this.rightItems, this.leftItems, this.rightSelectedItems);
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    unSelectAll() {
        if (this.rightItems.length) {
            this.moveItems(this.rightItems, this.leftItems, Object.assign([], this.rightItems));
            this.clearSelectedItems('right');
        } else {
            this._alertService.warn(this.noitemselectedmsg);
        }
    }
    buttonState() {
        if (this.rightItems) {
            return false;
        } else {
            return true;
        }
    }

    selectItem(position: string, selectedItem: ActivityPlan, control: any) {
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

    private moveItems(source: ActivityPlan[], target: ActivityPlan[], selectedItems: ActivityPlan[]) {
        selectedItems.forEach((item: ActivityPlan, i) => {
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
