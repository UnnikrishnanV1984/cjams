import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Observable } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../@core/entities/constants';
import { AlertService, GenericService } from '../../../../@core/services';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../../admin-url.config';
import { DistributionGroupNameResults, DistributionSearchResults } from '../_entities/distribution-list.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'distribution-list',
    templateUrl: './distribution-list.component.html',
    styleUrls: ['./distribution-list.component.scss'],
    standalone: false
})
export class DistributionListComponent implements OnInit {
    usernotificationgroupid!: string | undefined;
    titleName!: string;
    searchGroupInput!: object;
    createButton!: boolean;
    searchResultForm!: FormGroup;
    groupForm!: FormGroup;
    groupNameResults: DistributionGroupNameResults[] = [];
    searchResults: DistributionSearchResults[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    groupName = new DistributionGroupNameResults();
    dispositionSearchData = new DistributionSearchResults();
    selectedItems: any[] = [];
    searchModelData: any;
    totalRecords$!: Observable<number>;
    createusergrptitle = 'Create User Group';
    constructor(
        private formBuilder: FormBuilder,
        private _distributionListService: GenericService<DistributionGroupNameResults>,
        private _distributionListHttpService: CommonHttpService,
        private _alertService: AlertService
    ) {
        this._distributionListService.endpointUrl = AdminUrlConfig.EndPoint.General.UserNotificationGroupUrl;
    }

    ngOnInit() {
        this.distributionListForm();
        this.createButton = true;
        this.titleName = this.createusergrptitle;
        this.paginationInfo.total = -1;
        this.getPage(1);
        this.groupNameResultsShow();
        this.searchGroupResult();
        this.groupForm.get('usernotificationgroupname');
    }
    searchGroupResult() {
        if (this.searchResultForm.value.firstname === null && this.searchResultForm.value.lastname === null && this.searchResultForm.value.positioncode === null) {
            this.searchResultForm.value.firstname = '';
            this.searchResultForm.value.lastname = '';
            this.searchResultForm.value.positioncode = '';
        }
        if (this.groupName.usernotificationgroupid) {
            this.searchGroupInput = {
                usrnotificationgroupid: this.groupName.usernotificationgroupid
            };
        } else {
            this.searchGroupInput = {
                firstname: this.searchResultForm.value.firstname,
                lastname: this.searchResultForm.value.lastname,
                positioncode: this.searchResultForm.value.positioncode
            };
        }
        this._distributionListHttpService
            .getAllPaged(
                new PaginationRequest({
                    page: this.paginationInfo.pageNumber,
                    limit: 10,
                    where: this.searchGroupInput
                }),
                AdminUrlConfig.EndPoint.General.GetGroupingListUrl
            )
            .subscribe((result) => {
                this.searchResults = result.data;
                if (this.groupName.usernotificationgroupid) {
                    this.selectedItems = result.data.filter((item) => item.activeflag).map((item) => {
                            return item.teammemberid;
                     });
                }
                this.groupName = Object.assign({});
            });
    }
    checkListItem(event: any, model: DistributionSearchResults) {
        if (event.target.checked) {
            this.selectedItems.push(model.teammemberid);
        } else {
            this.selectedItems.splice(this.selectedItems.indexOf(model.teammemberid), 1);
        }
    }
    saveUserGroup() {
        if (this.selectedItems.length) {
            this.groupName.usernotificationgroupname = this.groupForm.value.usernotificationgroupname;
            this.groupName.effectivedate = new Date();
            this.groupName.activeflag = 1;
            this.groupName.updatedby = null;
            this.groupName.insertedby = null;
            this.groupName.expirationdate = new Date();
            this.groupName.teammemberid = this.selectedItems;
            this._distributionListService.endpointUrl = AdminUrlConfig.EndPoint.General.UserNotificationGroupUrl;
            this._distributionListService.create(this.groupName).subscribe((response: any) => {
                    this._alertService.success('Group name saved successfully');
                    this.getPage(this.paginationInfo.pageNumber);
                    this.groupNameResultsShow();
                    this.editUserGroup(response);
                    this.updateUserGroup();
                },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.groupForm.get('usernotificationgroupname')?.enable();
        } else {
            this._alertService.info('Please Select User List');
        }
    }
    editUserGroup(model: DistributionGroupNameResults) {
        this.searchResultForm.reset();
        this.titleName = 'Edit User Group';
        this.createButton = false;
        this.groupName = Object.assign({}, model);
        this.groupForm.patchValue({ usernotificationgroupname: model.usernotificationgroupname });
        this.usernotificationgroupid = model.usernotificationgroupid;
        this.searchGroupResult();
        this.groupForm.get('usernotificationgroupname')?.disable();
    }
    updateUserGroup() {
        this._distributionListService.endpointUrl = AdminUrlConfig.EndPoint.General.GroupNameAddUpdateUrl;
        this.titleName = this.createusergrptitle;
        this.createButton = true;
        this.groupForm.get('usernotificationgroupname')?.enable();
        this.groupForm.reset();
        this.groupName.effectivedate = new Date();
        this.groupName.teammemberid = this.selectedItems;
        if (this.usernotificationgroupid) {
            this.groupName.usernotificationgroupid = this.usernotificationgroupid;
        }
        this._distributionListService.create(this.groupName).subscribe((response: any) => {
                this.getPage(this.paginationInfo.pageNumber);
                this.selectedItems = Object.assign([]);
                this._alertService.success('Distribution list updated successfully');
                this.resetSearchResult();
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.resetSearchResult();
            }
        );
    }
    deleteUserGroup(model: DistributionGroupNameResults) {
        if(model.usernotificationgroupid) {
            this._distributionListService.remove(model.usernotificationgroupid).subscribe(
                (respone) => {
                    if (respone) {
                        this._alertService.success('Group name deleted successfully.');
                        this.getPage(this.paginationInfo.pageNumber);
                        this.groupNameResultsShow();
                    }
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
            this.searchResultForm.reset();
            this.groupForm.get('usernotificationgroupname')?.enable();
            this.resetSearchResult();
        }
    }
    resetSearchResult() {
        this.searchResultForm.reset();
        this.searchGroupResult();
    }
    cancelUserGroup() {
        this.titleName = this.createusergrptitle;
        this.createButton = true;
        this.groupForm.reset();
        this.searchResultForm.reset();
        this.groupForm.get('usernotificationgroupname')?.enable();
    }
    private getPage(page: number) {
        this.paginationInfo.pageNumber = page;
    }
    private distributionListForm() {
        this.searchResultForm = this.formBuilder.group({
            positioncode: [''],
            firstname: [''],
            lastname: ['']
        });
        this.groupForm = this.formBuilder.group({
            usernotificationgroupname: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
    }
    private groupNameResultsShow() {
        this._distributionListService.getArrayList({}).subscribe((result) => {
            this.groupNameResults = result;
        });
    }
}
