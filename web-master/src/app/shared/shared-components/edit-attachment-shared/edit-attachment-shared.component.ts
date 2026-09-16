
import {map, pluck, share} from 'rxjs/operators';
import { Attachment } from '../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { DropdownModel }  from '../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../pages/case-worker/case-worker-url.config';
import { forkJoin ,  Observable } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { AlertService, GenericService, CommonHttpService, AuthService }from '../../../@core/services';
import { AppUser } from '../../../@core/entities/authDataModel';
import _ from 'lodash';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'edit-attachment-shared',
    templateUrl: './edit-attachment-shared.component.html',
    styleUrls: ['./edit-attachment-shared.component.scss'],
    standalone: false
})
export class EditAttachmentSharedComponent implements OnInit {
    attachmentClassificationTypeDropDown$!: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    fileUpdate!: FormGroup;
    token: AppUser;
    maxDocumentDate: any;

    attachmentDetail: Attachment = new Attachment();
    @Output() attachment = new EventEmitter();
    @Output() FileUploaded = new EventEmitter<any>();
    isEditable!: boolean;
    isServiceCase = false;
    isCW!: boolean;
    attachmentClassificationSubType: any[] = [];
    enablOtherTxt!: boolean;
    existingDocumentCategory: any;
    existingDocumentType: any;
    mandatoryAlert_DocumentDate: boolean = false;
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
            other: [''],
            attachmentTypeKey: [''],
            attachmentClassificationTypeKey: [''],
            attachmentClassificationSubTypeKey:[''],
            actualdocumentdate: null,
            attachmentClassificationTyps: [''],

        });
        this.loadAttachmentDropDown();
        this.maxDocumentDate = new Date();
    }
    editForm(attachmentDetail: any, isEditable: any) {
        if (attachmentDetail?.documentattachment) { this.setExistingValue(attachmentDetail); }
        this.isEditable = isEditable;
        this.fileUpdate.markAsPristine();
        this.fileUpdate.patchValue({
            title: attachmentDetail.title ? attachmentDetail.title : '',
            description: attachmentDetail.description ? attachmentDetail.description : '',
            other: attachmentDetail.other ? attachmentDetail.other : '',
            attachmentTypeKey: '',
            attachmentClassificationTypeKey: '',
            attachmentClassificationSubTypeKey:'',
            actualdocumentdate: attachmentDetail.actualdocumentdate ? new Date(attachmentDetail.actualdocumentdate) : null
        });
        if (attachmentDetail?.documentattachment?.length) { attachmentDetail.documentattachment = attachmentDetail?.documentattachment[0] }
        this.returnEditFormFn(attachmentDetail);
    }
    private setExistingValue(attachmentDetail: any) {
        if(attachmentDetail.documentattachment && attachmentDetail.documentattachment.length) {
         this.existingDocumentCategory = attachmentDetail.documentattachment[0]?.attachmentclassificationtypekey;
         this.existingDocumentType = attachmentDetail.documentattachment[0]?.attachmentclassificationsubtypekey;
        } else {
            this.existingDocumentCategory = attachmentDetail.documentattachment?.attachmentclassificationtypekey;
            this.existingDocumentType = attachmentDetail.documentattachment?.attachmentclassificationsubtypekey;
        }
    }
    private returnEditFormFn(attachmentDetail: any) {
        if (attachmentDetail.documentattachment) {
            this.documentattachmentFn(attachmentDetail);
        } else {
            attachmentDetail.documentattachment = Object.assign({});
        }
        this.attachmentDetail = attachmentDetail;
        if (this.isEditable) {
            this.fileUpdate.enable();
        } else {
            this.fileUpdate.disable();
        }
        this.fileUpdate.controls.attachmentTypeKey.disable();
    }

    private documentattachmentFn(attachmentDetail: any) {
        const documentattachment = attachmentDetail.documentattachment;
        attachmentDetail.documentattachment = Object.assign(documentattachment);
        if (documentattachment.attachmentclassificationtypekey) {
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === documentattachment.attachmentclassificationtypekey) {
                    this.attachmentClassificationSubType.push({ subcategory: element.subcategory });
                }
            }
        }
        this.patchFileUpdatedDataFn(documentattachment);

    }

    private patchFileUpdatedDataFn(documentattachment: any) {
        this.fileUpdate.patchValue({
            attachmentTypeKey: documentattachment.attachmenttypekey ? documentattachment.attachmenttypekey : this.returnAttachmentTypeKeyFn(documentattachment),
            attachmentClassificationTypeKey: documentattachment.attachmentclassificationtypekey ? documentattachment.attachmentclassificationtypekey : this.returnAttachmentClassificationTypeKeyFn(documentattachment),
            attachmentClassificationSubTypeKey: documentattachment.attachmentclassificationsubtypekey ? documentattachment.attachmentclassificationsubtypekey : this.returnAttachmentClassificationSubTypeKeyFn(documentattachment),
        });
        this.parentVal = documentattachment.attachmentclassificationtypekey ? documentattachment.attachmentclassificationtypekey : '';
        this.fileUpdate.controls.attachmentClassificationTypeKey.disable();
        this.fileUpdate.controls.attachmentClassificationSubTypeKey.disable();
        let attachmentclassificationsubtypekey = documentattachment.attachmentclassificationsubtypekey ? documentattachment.attachmentclassificationsubtypekey : this.returnAttachmentclassificationsubtypekeyFn(documentattachment);
        this.selectChildMenu(attachmentclassificationsubtypekey);
    }

    private returnAttachmentclassificationsubtypekeyFn(documentattachment: any) {
        return documentattachment[0] ? documentattachment[0].attachmentclassificationsubtypekey : "";
    }

    private returnAttachmentClassificationSubTypeKeyFn(documentattachment: any): any {
        return documentattachment[0].attachmentclassificationsubtypekey ? documentattachment[0].attachmentclassificationsubtypekey : "";
    }

    private returnAttachmentClassificationTypeKeyFn(documentattachment: any): any {
        return documentattachment[0].attachmentclassificationtypekey ? documentattachment[0].attachmentclassificationtypekey : "";
    }

    private returnAttachmentTypeKeyFn(documentattachment: any): any {
        return documentattachment[0].attachmenttypekey ? documentattachment[0].attachmenttypekey : "";
    }

    saveAttachmentDetails() {
        if (this.fileUpdate.value.actualdocumentdate === '' || this.fileUpdate.value.actualdocumentdate === null) {
            this.mandatoryAlert_DocumentDate = true;
        } else {
            this.mandatoryAlert_DocumentDate = false;
            if (this.fileUpdate.value.attachmentTypeKey !== ''
                && this.fileUpdate.value.attachmentClassificationTypeKey !== '' && this.fileUpdate.value.attachmentClassificationSubTypeKey) {
                this.attachmentDetail.title = this.fileUpdate.value.attachmentClassificationSubTypeKey;
                this.attachmentDetail.actualdocumentdate = this.fileUpdate.value.actualdocumentdate;
                this.attachmentDetail.description = this.fileUpdate.value.description;
                this.attachmentDetail.other = this.fileUpdate.value.other;
                this.attachmentDetail.insertedby = this.token.user.userprofile.securityusersid;
                this.attachmentDetail.updatedby = this.token.user.userprofile.securityusersid;
                this.attachmentDetail.documentattachment.attachmenttypekey = this.fileUpdate.value.attachmentTypeKey;
                this.attachmentDetail.documentattachment.attachmentclassificationtypekey = this.fileUpdate.value.attachmentClassificationTypeKey;
                this.attachmentDetail.documentattachment.attachmentclassificationsubtypekey = this.fileUpdate.value.attachmentClassificationSubTypeKey;
                this.attachmentDetail.documentattachment.updatedby = this.token.user.userprofile.securityusersid;
                this.attachmentDetail.documentattachment.attachmentdate = new Date();
                this.attachmentDetail.documentdate = new Date();
                this.attachmentDetail.existingDocumentCategory = this.existingDocumentCategory;
                this.attachmentDetail.existingDocumentType = this.existingDocumentType;
                if(this.attachmentDetail.editfiletype == 'largeFileEdit') {
                    this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UpdateLargeFileUploadedUrl;  
                 } else {
                    this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UpdateFileUploadedUrl;
                }                
                this._service.createArrayList([this.attachmentDetail]).subscribe(
                    (_response: any) => {
                        this._alertService.success('Attachment updated successfully!');
                        $('#edit-attachment').modal('hide');
                        this.attachment.emit('all');
                        this.FileUploaded.emit(true);
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                this._alertService.error('Please fill all mandatory fields');
            }
        }
    }
    private handleDocumentattachmentDataFn() {
        if(this.attachmentDetail?.documentattachment) {
            this.attachmentDetail.documentattachment.attachmenttypekey = this.fileUpdate.value.attachmentTypeKey;
            this.attachmentDetail.documentattachment.attachmentclassificationtypekey = this.fileUpdate.value.attachmentClassificationTypeKey;
            this.attachmentDetail.documentattachment.attachmentclassificationsubtypekey = this.fileUpdate.value.attachmentClassificationSubTypeKey;
            this.attachmentDetail.documentattachment.updatedby = this.token.user.userprofile.securityusersid;
            this.attachmentDetail.documentattachment.attachmentdate = new Date();
        }
    }

    private loadDropdown() {
        this._dropDownService
        .getSingle(
            {},
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
        )
        .subscribe(data => {
            const dp_att_arr = [];
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                this.attachmentClassificationtypelookupLoop();
                this.attachmentClassificationtype = _.uniqBy(this.attachmentClassificationtype, 'typedescription');
                this.attachmentClassificationtype = _.sortBy(this.attachmentClassificationtype,'typedescription');

            }
        });
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
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

    private attachmentClassificationtypelookupLoop() {
        for (const element of this.attachmentClassificationtypelookup) {
            if (element.typedescription) {
                if (this.isCW) {
                    if (element.typedescription.startsWith('CW-')) {
                        this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                        this.attachmentClassificationtype.push({ typedescription: element.subcategory });
                    }
                } else {
                    this.attachmentClassificationtype.push({ typedescription: element.typedescription });
                }
            }
        }
    }

    categoryUpdate(event: any) {
        if (event.target.value) {
            this.attachmentClassificationSubType = [];
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.fileUpdate.value.attachmentClassificationTypeKey) {
                    this.attachmentClassificationSubType.push({ subcategory : element.subcategory});
                }
            }
        } else {
            this.attachmentClassificationSubType = [];
        }
    }

    attachmentDropDownList_parent: any[] = [];
    attachmentDropDownList_child: any[] = [];
    loadAttachmentDropDown() {
        this._dropDownService.getArrayList(
                {
                    method: 'get',
                    where: {
                        referencetypeid: 1000,
                        teamtypekey: 'CW',
                        order: 'displayorder ASC'
                    }
                },
                'referencetype/gettypes' + '?filter'
            )
            .subscribe((item: any) => {
                for (const element of item) {
                    if(element.parentkey === null ){
                        this.attachmentDropDownList_parent.push(element);
                    }else{
                        this.attachmentDropDownList_child.push(element);
                    }
                }
            });
    }

    childArray:any[] = [];
    parentVal = '';
    seletedVal = 'Title'
    openChildMenu(parentVal: any, ref_key: any) {
        this.parentVal = parentVal;
        this.childArray = [];
        const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
        if (isExist) {
            this.childArray = [...isExist];
        }
    }
    
    selectChildMenu(childVal: any) {
        this.seletedVal = childVal; //Placeholder
        this.fileUpdate.controls.attachmentClassificationTypeKey.patchValue(this.parentVal);
        this.fileUpdate.controls.attachmentClassificationSubTypeKey.patchValue(childVal);
        if(childVal?.includes('Other','other')){
            this.enablOtherTxt = true;
        }else{
            this.enablOtherTxt = false;
        }
    }

    getDisplayName() {
        return Array.isArray(this.attachmentDetail?.userprofile) ? this.attachmentDetail?.userprofile[0]?.displayname : '';
    }
      
    docDateAddUpdate(){
        if(this.fileUpdate.value.actualdocumentdate === '' || this.fileUpdate.value.actualdocumentdate === null){
            this.mandatoryAlert_DocumentDate = true;
        }else{
            this.mandatoryAlert_DocumentDate = false;
        }
    }
}
