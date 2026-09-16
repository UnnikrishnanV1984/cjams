
import {map, pluck, share} from 'rxjs/operators';
import { Attachment } from './../_entities/attachment.data.models';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { NewUrlConfig } from '../../newintake-url.config';
import { forkJoin ,  Observable } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { AlertService, GenericService, CommonHttpService, AuthService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'edit-attachment',
    templateUrl: './edit-attachment.component.html',
    styleUrls: ['./edit-attachment.component.scss'],
    standalone: false
})
export class EditAttachmentComponent implements OnInit {
    attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$: Observable<DropdownModel[]>;
    fileUpdate: FormGroup;
    token: AppUser;

    attachmentClassificationtypelookup = [];
    attachmentClassificationtype = [];

    attachmentDetail: Attachment;
    @Output() attachment = new EventEmitter();
    isCW: boolean;
    constructor(
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dropDownService: CommonHttpService,
        private _service: GenericService<Attachment>,
        private _alertService: AlertService
    ) {
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW(); 
        this.loadDropdown();
        this.fileUpdate = this.formBuilder.group({
            title: [''],
            description: ['', Validators.maxLength(150)],
            attachmentTypeKey: [''],
            attachmentClassificationTypeKey: ['']
        });
    }
    editForm(attachmentDetail) {
        this.fileUpdate.markAsPristine();
        this.fileUpdate.patchValue({
            title: attachmentDetail.title ? attachmentDetail.title : '',
            description: attachmentDetail.description ? attachmentDetail.description : '',
            attachmentTypeKey: '',
            attachmentClassificationTypeKey: ''
        });
        if (attachmentDetail.documentattachment) {
            this.fileUpdate.patchValue({
                attachmentTypeKey: attachmentDetail.documentattachment.attachmenttypekey ? attachmentDetail.documentattachment.attachmenttypekey : '',
                attachmentClassificationTypeKey: attachmentDetail.documentattachment.attachmentclassificationtypekey ? attachmentDetail.documentattachment.attachmentclassificationtypekey : ''
            });
        } else {
            attachmentDetail.documentattachment = Object.assign({});
        }
        this.attachmentDetail = attachmentDetail;
    }
    saveAttachmentDetails() {
        if (this.fileUpdate.value.title !== '' && this.fileUpdate.value.attachmentTypeKey !== '' && this.fileUpdate.value.attachmentClassificationTypeKey !== '') {
            this.attachmentDetail.title = this.fileUpdate.value.title;
            this.attachmentDetail.description = this.fileUpdate.value.description;
            this.attachmentDetail.documentattachment.attachmenttypekey = this.fileUpdate.value.attachmentTypeKey;
            this.attachmentDetail.documentattachment.attachmentclassificationtypekey = this.fileUpdate.value.attachmentClassificationTypeKey;
            this.attachmentDetail.documentattachment.updatedby = this.token.user.userprofile.displayname;
            this.attachmentDetail.documentattachment.attachmentdate = new Date();
            this.attachmentDetail.documentdate = new Date();
            this._service.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            this._service.createArrayList([this.attachmentDetail]).subscribe(
                (response) => {
                    this._alertService.success('Attachment updated successfully!');
                    $('#edit-attachment').modal('hide');
                    this.attachment.emit('all');
                },
                (error) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._alertService.error('Please fill all mandatory fields');
        }
    }
    private loadDropdown() {
        this._dropDownService
        .getSingle(
            {},
            NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
        )
        .subscribe(data => {
            const dp_att_arr = [];
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                for (const element of this.attachmentClassificationtypelookup) {
                    if (element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0 ) {
                        this.attachmentClassificationtypelookupLoopFn(element, dp_att_arr);
                    }
                }



            }
        });
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
            )
            ]).pipe(
            map((result) => {
                return {
                    attachmentType: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.attachmenttypekey
                            })
                    ),
                };
            }),
            share(),);
        this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
    }


    private attachmentClassificationtypelookupLoopFn(element: any, dp_att_arr: any[]) {
        if (this.isCW) {
            if (element.typedescription.startsWith('CW-')) {
                this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                dp_att_arr.push(element.typedescription);
            }
        } else {
            this.attachmentClassificationtype.push({ typedescription: element.typedescription });
            dp_att_arr.push(element.typedescription);
        }
    }
}
