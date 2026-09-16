import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormBuilder } from '@angular/forms';

import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { AlertService } from '../../../../../../@core/services';
import { CommonHttpService } from '../../../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../../../admin-url.config';
import { ReviewConfigList } from '../../../_entities/reviewda.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'co-edl-review',
    templateUrl: './co-edl-review.component.html',
    standalone: false
})
export class CoEdlReviewComponent implements OnInit {
    leftItems: ReviewConfigList[] = [];
    rightItems: ReviewConfigList[] = [];
    selectedConfiguration: string[] = [];
    private rightSelectedItems: ReviewConfigList[] = [];
    private leftSelectedItems: ReviewConfigList[] = [];
    confirmedList = new Array<string>();
    noitemselectedmsg = 'No items selected.';
    constructor(private _service: CommonHttpService, private formBuilder: FormBuilder, private _alertService: AlertService, private _changeDetect: ChangeDetectorRef) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AllegationConfigListUrl;
    }
    ngOnInit() {
        this.getAvailableConfiguration();
    }
    getAvailableConfiguration() {
        this._service
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    where: { activeflag: 1 },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.AllegationConfigListUrl + '?filter'
            )
            .subscribe((result) => {
                this.leftItems = result;
                this.getSelectedConfiguration();
            });
    }
    getSelectedConfiguration() {
        this._service
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 1,
                    where: {
                        configurationsettingid: '73dea5ae-e291-43d3-808c-e5cf7e3df570',
                        name: 'Inv_COEDLReviewAssessmentConfig'
                    },
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.DAConfig.ConfigurationSettingsUrl + '/list?filter'
            )
            .subscribe((result: any) => {
                if (result && result[0] && result[0].value) {
                    this.selectedConfiguration = result[0].value.split(',');
                    this.preSelect();
                }
            });
    }

    private preSelect() {
        if (this.selectedConfiguration) {
            this.rightItems = this.rightItems.map((item) => {
                this.selectedConfiguration.forEach((id) => {
                    if (item.assessmenttemplateid === id) {
                        item.isSelected = true;
                    }
                });
                return item;
            });
        }
    }
    saveItem() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.DAConfig.AllegationConfigurationUrl;
        const selectedItems = this.rightItems.map((item) => {
            return item.assessmenttemplateid;
        });
        this._service
            .create({
                name: 'Inv_COEDLReviewAssessmentConfig',
                assesssmenttemplateid: [selectedItems.toString()],
                category: 'Investigation'
            })
            .subscribe((response) => {
                if (response) {
                    this._alertService.success('Management review  saved successfully');
                    this.getAvailableConfiguration();
                    this.rightItems = [];
                }
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
    selectItem(position: string, selectedItem: ReviewConfigList, control: any) {
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
    private moveItems(source: ReviewConfigList[], target: ReviewConfigList[], selectedItems: ReviewConfigList[]) {
        selectedItems.forEach((item: ReviewConfigList, i) => {
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
