import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../@core/entities/constants';
import { AlertService } from '../../../../@core/services';
import { GenericService } from '../../../../@core/services/generic.service';
import { AdminUrlConfig } from '../../admin-url.config';
import { ManageDAAction, ManageDAActionSubtype } from '../_entities/manage-da-action.models';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'add-edit-da-action-type',
    templateUrl: './add-edit-da-action-type.component.html',
    standalone: false
})
export class AddEditDaActionTypeComponent implements OnInit {
    daActiontypes!: ManageDAAction;
    id!: string;
    isDepartmentActionAdded = false;
    isEditMode = false;
    daActions!: ManageDAAction[];
    daAction: ManageDAAction = new ManageDAAction();
    daActionSubtypes!: ManageDAActionSubtype[];
    daActionSubtype: ManageDAActionSubtype = new ManageDAActionSubtype();
    paginationInfo: PaginationInfo = new PaginationInfo();
    formGroup: FormGroup;
    daSubTypeFormGroup: FormGroup;
    daActionTypeControl!: AbstractControl | null;
    daActionTypedescriptionControl!: AbstractControl | null;
    private daSubTypeUrl!: string;
    deletepopupid = '#delete-popup';
    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private _daActionService: GenericService<ManageDAAction>,
        private _daActionSubTypeService: GenericService<ManageDAActionSubtype>,
        private _alertService: AlertService
    ) {
        this._daActionService.endpointUrl = AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl;
        this.formGroup = this.formBuilder.group({
            intakeservreqtypekey: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
        });
        this._daActionSubTypeService.endpointUrl = AdminUrlConfig.EndPoint.General.ServiceRequestSubtypeUrl;
        this.daSubTypeFormGroup = this.formBuilder.group({
            classkey: ['', Validators.required],
            description: ['', Validators.required]
        });
    }

    ngOnInit() {
        this.id = this.route.snapshot.params['id'];
        this.daActionTypeControl = this.formGroup.get('intakeservreqtypekey');
        this.daActionTypeControl?.enable();
        this.daActionTypedescriptionControl = this.formGroup.get('description');
        this.daActionTypedescriptionControl?.enable();
        if (this.id !== '0') {
            this.isEditMode = true;
            this.daSubTypeUrl = `${AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl}/${this.id}/servicerequestsubtype`;
            this._daActionService.getById(this.id, AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl).subscribe((response: any) => {
                    this.daAction = response;
                    this.daActionTypeControl?.disable();
                    this.formGroup.setValue({
                        intakeservreqtypekey: this.daAction.intakeservreqtypekey,
                        description: this.daAction.description
                    });
                    if (this.isEditMode === true) {
                        this.dhsActionSubType();
                    }
                    this.showEditor();
                },
                (_error: any) => {
                }
            );
        }
    }
    dhsActionSubType() {
        this._daActionSubTypeService.getArrayList({}, this.daSubTypeUrl).subscribe((subtypes) => {
            this.daActionSubtypes = subtypes;
        });
    }
    saveDaSubType(daActionSubtype: ManageDAActionSubtype) {
        this._daActionSubTypeService.endpointUrl = AdminUrlConfig.EndPoint.General.ServiceRequestSubtypeUrl;
        daActionSubtype.insertedby = 'default';
        daActionSubtype.updatedby = 'default';
        daActionSubtype.workloadweight = 0;
        daActionSubtype.investigatable = true;
        if (this.daActionSubtype.servicerequestsubtypeid) {
            daActionSubtype.servicerequestsubtypeid = this.daActionSubtype.servicerequestsubtypeid;
            this._daActionSubTypeService.patch(this.daActionSubtype.servicerequestsubtypeid, daActionSubtype, 'admin/servicerequestsubtype').subscribe((response: any) => {
                if (response) {
                    this._alertService.success('DaSubType saved successfully');
                    this.dhsActionSubType();
                    this.daActionTypeControl?.disable();
                    this.daActionTypedescriptionControl?.disable();
                }
            });
        } else {
            daActionSubtype.intakeservreqtypeid = this.id;
            this._daActionSubTypeService.create(daActionSubtype, this.daSubTypeUrl).subscribe((response: any) => {
                if (response.intakeservreqtypeid) {
                    this._alertService.success('DaSubType saved successfully');
                    this.dhsActionSubType();
                }
            });
        }
        this.daActionSubtype = Object.assign({}, new ManageDAActionSubtype());
        this.daSubTypeFormGroup.reset();
    }
    editDaSubType(daActionSubtype: ManageDAActionSubtype) {
        this.daActionSubtype = Object.assign({}, daActionSubtype);
        this.daSubTypeFormGroup.setValue({
            classkey: this.daActionSubtype.classkey,
            description: this.daActionSubtype.description
        });
    }
    deleteItem() {
        this._daActionSubTypeService.remove(this.daActionSubtype.servicerequestsubtypeid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('DA activity type deleted successfully');
                    (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                }
                this.dhsActionSubType();
            },
            (error) => {
                (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    addDaType(model: ManageDAAction) {
        this._daActionService.endpointUrl = AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl;
        model.insertedby = 'default';
        model.updatedby = 'default';
        model.workloadweight = 0;
        model.investigatable = true;
        if (this.id === '0') {
            this.isDepartmentActionAdded = true;
            this._daActionService.create(model).subscribe((response: any) => {
                if (response.intakeservreqtypeid) {
                    this.daActionTypeControl?.disable();
                    this.daActionTypedescriptionControl?.disable();
                    this._alertService.success('DaType saved successfully');
                    this.daActiontypes = response;
                    this.id = this.daActiontypes.intakeservreqtypeid;
                    this.daSubTypeUrl = `${AdminUrlConfig.EndPoint.General.IntakeServiceRequestTypeUrl}/${this.id}/servicerequestsubtype`;
                }
            });
        } else {
            model.intakeservreqtypeid = this.id;
            this._daActionService.patch('', model).subscribe((response: any) => {
                if (response) {
                    this._alertService.success('DaType saved successfully');
                    this.isEditMode = true;
                }
            });
        }
        this.daAction = Object.assign({}, new ManageDAAction());
    }
    private showEditor() {
        (<any>$('#add-edit-da-action-type')).modal('show'); // NOSONAR
    }
    declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide'); // NOSONAR
    }
    confirmDelete(modelData: ManageDAActionSubtype) {
        this.daActionSubtype = modelData;
        (<any>$(this.deletepopupid)).modal('show'); // NOSONAR
    }

    get descriptionControl(): FormControl { 
        return this.daSubTypeFormGroup.get('description') as FormControl; 
    }

    get classkeyControl(): FormControl { 
        return this.daSubTypeFormGroup.get('classkey') as FormControl; 
    }

    get descriptionFormGroupControl(): FormControl { 
        return this.formGroup.get('description') as FormControl; 
    }

    get intakeservreqtypekeyControl(): FormControl { 
        return this.formGroup.get('intakeservreqtypekey') as FormControl; 
    }
        
}
