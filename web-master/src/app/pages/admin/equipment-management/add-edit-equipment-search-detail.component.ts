
import {EMPTY,  Observable ,  Subject } from 'rxjs';

import {pluck, map} from 'rxjs/operators';
import { Component, Injector, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
// import { CustomValidators } from 'ngx-validator';

import { DropdownModel, PaginationInfo, PaginationRequest, TreeViewModel } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AlertService, ValidationService } from '../../../@core/services';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { AdminUrlConfig } from '../admin-url.config';
import {
    Equipment,
    EquipmentAssignment,
    EquipmentPositionDetail,
    SelectedEquipmentManagementDetail,
    TeamPosition,
} from './_entities/equipment-management.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-equipment-search-detail',
    templateUrl: './add-edit-equipment-search-detail.component.html',
    styleUrls: ['./add-edit-equipment-search-detail.component.scss'],
    standalone: false
})
export class AddEditEquipmentSearchDetailComponent implements OnInit {
    @Input() selectedDetailIdSubject$ = new Subject<string>();
    @Input() equipmentSearchPageSubject$ = new Subject<number>();
    @Input()
    currentPageNumber!: number;
    @Input()
    equipmentSearchTriggeredSubject$!: Subject<string>;
    selectedEquipmentManagementDetail = new SelectedEquipmentManagementDetail();
    teamTreeview$!: Observable<TreeViewModel[]>;
    typeDropdownItems$!: Observable<DropdownModel[]>;
    equipmentManagementDetail = new Equipment();
    teamPosition$!: Observable<any>;
    selectedTeamPosition = new TeamPosition();
    teamPosition = new TeamPosition();
    equipmentDetailformGroup!: FormGroup;
    equipmentAssignment$!: Observable<EquipmentAssignment[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    selectedRow!: string | null;
    isReassign!: boolean;
    isDisabled = true;
    isCreateBtnDisabled = false;
    isDeleteBtnDisabled = true;
    minDate = new Date();
    selectedTypeDropdownItem!: string;
    private _formBuilder: FormBuilder;
    private _equipmentConfigHttpService: CommonHttpService
    private _alertService: AlertService;
    
    constructor(
        private injector : Injector,
        private _service: GenericService<Equipment>,
        private _teamTreeViewService: GenericService<TreeViewModel>,
        private _equipmentPositionDetailService: GenericService<EquipmentPositionDetail>,
        private _equipmentTeamPositionService: GenericService<TeamPosition>,
        private _equipmentAssignmentService: GenericService<EquipmentAssignment>
    ) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._equipmentConfigHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
    }

    ngOnInit() {
        this.isDeleteBtnDisabled = true;
        this.equipmentDetailformGroup = this._formBuilder.group({
            equipmentid: [null],
            equipmenttypekey: ['', Validators.required],
            manufacturer: [''],
            model: [''],
            serialnumber: [''],
            whitetagnumber: [''],
            yellowtagnumber: [''],
            found: [''],
            disposed: [''],
            upforreplacement: [''],
            unit: [''],
            description: [''],
            comments: [''],
            dh60date: [null],
            sutnumber: [''],
            roomnumber: [''],
            locationcode: [''],
            primarymachine: [''],
            transfer: [''],
            activeflag: ['']
        }, {
            validators: [ValidationService.minDateValidator(new Date())]
        });
        this.selectedEquipmentManagementDetail = Object.assign({});
        this.selectedDetailIdSubject$.subscribe(id => {
            this._equipmentConfigHttpService
                .getById(
                    id,
                    AdminUrlConfig.EndPoint.EquipmentMgmt.TeamMemberEquipmentUrl
                )
                .subscribe(
                    response => {
                        this.editItem(response);
                        $('#collapseTwo').addClass('in');
                    },
                    error => {
                        this.reusableALertErrorMsgFn();
                    }
                );
        });
        this.equipmentSearchTriggeredSubject$.subscribe(typeKey => {
            this.clearItem();
            this.equipmentDetailformGroup.patchValue({
                equipmenttypekey: typeKey
            });
        });

        this.typeDropdownItems$ = this._equipmentConfigHttpService
            .getArrayList({}, AdminUrlConfig.EndPoint.EquipmentMgmt.EquipmenTypeUrl).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.equipmenttypekey,
                            value: res.equipmenttypekey
                        })
                );
            }));
    }

    saveItem(model: Equipment) {
        if (
            this.equipmentDetailformGroup.dirty &&
            this.equipmentDetailformGroup.valid
        ) {
            this.equipmentManagementDetail = Object.assign({}, model);
            if (model.equipmentid) {
                this.equipmentManagementDetail.updatedby = 'Default';
                this._service
                    .update(
                        '',
                        this.equipmentManagementDetail,
                        AdminUrlConfig.EndPoint.EquipmentMgmt
                            .EquipmentUpdatetUrl
                    )
                    .subscribe((response: any) => {
                            if (response) {
                                this._alertService.success(
                                    'Successfully updated equipment'
                                );
                                this.equipmentSearchPageSubject$.next(
                                    this.currentPageNumber
                                );
                            }
                        }, (_error: any) => {
                            this.reusableALertErrorMsgFn();
                        }
                    );
            } else {
                this.equipmentManagementDetail.updatedby = 'Default';
                this.equipmentManagementDetail.insertedby = 'Default';
                this.equipmentManagementDetail.effectivedate = new Date();
                this.equipmentManagementDetail.activeflag = 1;
                this._service
                    .create(
                        this.equipmentManagementDetail,
                        AdminUrlConfig.EndPoint.EquipmentMgmt.EquipmentAddtUrl
                    )
                    .subscribe((response: any) => {
                            this.saveTeamPosition(response.equipmentid);
                            this._alertService.success(
                                'Successfully saved equipment'
                            );
                            this.clearItem();
                            this.equipmentSearchPageSubject$.next(
                                this.currentPageNumber
                            );
                            this.selectedTeamPosition = Object.assign({});
                        }, (_error: any) => {
                            this.reusableALertErrorMsgFn();
                        }
                    );
            }
        }
    }

    private reusableALertErrorMsgFn() {
        this._alertService.error(
            GLOBAL_MESSAGES.ERROR_MESSAGE
        );
    }

    addItem(isReassign: any) {
        this.isReassign = isReassign;
        this.teamTreeview$ = this._teamTreeViewService
            .getArrayList({}, AdminUrlConfig.EndPoint.EquipmentMgmt.TeamUrl).pipe(
            map(result => result));
    }
    editItem(model: SelectedEquipmentManagementDetail) {
        this.isDisabled = false;
        this.isCreateBtnDisabled = false;
        this.selectedEquipmentManagementDetail = model;
        this.selectedEquipmentManagementDetail.equipment = model.equipment;
        this.equipmentDetailformGroup.patchValue(
            this.selectedEquipmentManagementDetail.equipment
        );
        const teammember = this.selectedEquipmentManagementDetail.teammember;
        if (teammember) {
            this.selectedTeamPosition.teamname = this.selectedEquipmentManagementDetail.teammember.team.name;
            this.selectedTeamPosition.region = this.selectedEquipmentManagementDetail.teammember.team.region;
            this.selectedTeamPosition.positioncode = this.selectedEquipmentManagementDetail.teammember.positioncode;
            this.selectedTeamPosition.effectivedate = this.selectedEquipmentManagementDetail.teammember.effectivedate;
            const teamMemberAssignement = this.selectedEquipmentManagementDetail
                .teammember.teammemberassignment;
            if (teamMemberAssignement && teamMemberAssignement.length) {
                this.selectedTeamPosition.displayname =
                    teamMemberAssignement[0].securityusers.userprofile.displayname;
                this.selectedTeamPosition.orgname =
                    teamMemberAssignement[0].securityusers.userprofile.orgname;
                this.selectedTeamPosition.orgnumber =
                    teamMemberAssignement[0].securityusers.userprofile.orgnumber;
            }
        }
        this.isDeleteBtnDisabled = false;
        this.getAssignment(model.equipment.equipmentid);
    }

    getAssignment(equipmentid: any) {
        this.equipmentAssignment$ = this._equipmentAssignmentService
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.EquipmentMgmt
                    .TeamMemberEquipmentAssignmentUrl +
                    '/' +
                    equipmentid +
                    '?filter'
            ).pipe(
            map(result => result));
    }

    selectedTeamId(event: any) {
        this.teamPosition$ = this._equipmentPositionDetailService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 10,
                    method: 'get'
                }),
                AdminUrlConfig.EndPoint.EquipmentMgmt.TeamDetailUrl +
                    '/' +
                    event.node.id +
                    '?filter'
            ).pipe(
            map(result => {
                return { teamPosition: result.data };
            }),
            pluck('teamPosition'),);
    }

    getTeamPosition(model: any) {
        this.selectedRow = model.id;
        this.teamPosition = Object.assign({
            positioncode: model.positioncode
        });
        this.selectedTeamPosition = Object.assign({}, model);
    }
    addUpdateTeamPosition() {
        if (this.isReassign) {
            this.saveTeamPosition(
                this.selectedEquipmentManagementDetail.equipment.equipmentid
            );
            this.getAssignment(
                this.selectedEquipmentManagementDetail.equipment.equipmentid
            );
        } else {
            if (this.selectedTeamPosition) {
                this.isDisabled = false;
                this.isCreateBtnDisabled = true;
                this.teamPosition$.subscribe((res : any) => {
                    this.selectedTeamPosition.teamname = res.team.name;
                    this.selectedTeamPosition.region = res.team.region;
                });
                this.equipmentAssignment$ = EMPTY;
            }
        }
        (<any>$('#equipment-manage-create')).modal('hide'); // NOSONAR
    }

    deleteItem() {
        this.selectedEquipmentManagementDetail.equipment = Object.assign(
            {},
            this.selectedEquipmentManagementDetail.equipment
        );
        this.selectedEquipmentManagementDetail.equipment.activeflag = 0;
        this._service
            .patch(
                this.selectedEquipmentManagementDetail.equipmentid,
                this.selectedEquipmentManagementDetail.equipment,
                AdminUrlConfig.EndPoint.EquipmentMgmt.EquipmentDeleteUrl
            )
            .subscribe((response: any) => {
                    if (response) {
                        this._service
                            .patch(
                                this.selectedEquipmentManagementDetail
                                    .teammemberequipmentid,
                                this.selectedEquipmentManagementDetail
                                    .equipment,
                                AdminUrlConfig.EndPoint.EquipmentMgmt
                                    .TeamMemberEquipmentDeleteUrl
                            )
                            .subscribe((res: any) => {
                                if (res) {
                                    this._alertService.success(
                                        'Successfully deleted equipment'
                                    );
                                    this.equipmentSearchPageSubject$.next(
                                        this.currentPageNumber
                                    );
                                    this.equipmentAssignment$ = EMPTY;
                                }
                            });
                        this.declineDelete();
                    }
                }, (_error: any) => {
                    this.reusableALertErrorMsgFn();
                }
            );
    }
    declineDelete() {
        (<any>$('#delete-popup')).modal('hide'); // NOSONAR
    }
    confirmDelete() {
        (<any>$('#delete-popup')).modal('show'); // NOSONAR
    }

    addReassign() {
        this.addItem(true);
        (<any>$('#equipment-manage-create')).modal('show'); // NOSONAR
    }

    saveTeamPosition(equipmentid: any) {
        this.selectedTeamPosition = Object.assign({
            positioncode: this.teamPosition.positioncode
        });
        this.selectedTeamPosition.equipmentid = equipmentid;
        this.selectedTeamPosition.activeflag = 1;
        this.selectedTeamPosition.effectivedate = new Date();
        this.selectedTeamPosition.insertedby = 'Default';
        this.selectedTeamPosition.updatedby = 'Default';
        this._equipmentTeamPositionService
            .create(
                this.selectedTeamPosition,
                AdminUrlConfig.EndPoint.EquipmentMgmt
                    .TeamMemberEquipmentAddUpdateUrl
            )
            .subscribe(
                () => { 
                    // No data to add or return
                },
                () => {
                    this.reusableALertErrorMsgFn();
                }
            );
    }
    cancelItem() {
        if (!this.isDisabled) {
            this.isDisabled = false;
            this.selectedTeamPosition = Object.assign({}, new TeamPosition());
        }
        this.clearItem();
    }

    clearItem() {
        this.isCreateBtnDisabled = false;
        this.selectedRow = null;
        this.isDisabled = true;
        this.equipmentAssignment$ = EMPTY;
        $('#collapseTwo').removeClass('in');
    }
}
