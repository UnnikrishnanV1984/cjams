
import {map, pluck, share} from 'rxjs/operators';
import { Attachment } from './../_entities/attachment.data.models';
import { Component, OnInit, Output, EventEmitter,ViewChild,ElementRef } from '@angular/core';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { forkJoin ,  Observable } from 'rxjs';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { AlertService, GenericService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DsdsService } from '../../_services/dsds.service';
import _ from 'lodash';
import { MatMenuTrigger } from '@angular/material/menu';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'edit-attachment',
    templateUrl: './edit-attachment.component.html',
    styleUrls: ['./edit-attachment.component.scss'],
    standalone: false
})
export class EditAttachmentComponent implements OnInit {
    @ViewChild('inputMenuTrigger') inputMenuTrigger!: MatMenuTrigger;
    @ViewChild('inputElement') inputElement!: ElementRef;
    attachmentClassificationTypeDropDown$!: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    fileUpdate!: FormGroup;
    token: AppUser;
    maxDocumentDate: any;
    attachmentDetail?: Attachment | null;
    @Output() attachment = new EventEmitter();
    isEditable!: boolean;
    isServiceCase = false;
    isCW!: boolean;
    attachmentClassificationSubType: any[]= [];
    enablOtherTxt!: boolean;
    mandatoryAlert_DocumentDate: boolean = false;
    current_attachmentDropDownList_parent: any[] = [];
    current_attachmentDropDownList_child: any[] = [];
    constructor(
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dropDownService: CommonHttpService,
        private _service: GenericService<Attachment>,
        private _alertService: AlertService,
        private _dsdsService: DsdsService
    ) {
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.maxDocumentDate = new Date();
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.isServiceCase = this._dsdsService.isServiceCase();
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
    }
    editForm(attachmentDetail: any, isEditable: any) {
        this.isEditable = isEditable;
        this.fileUpdate.markAsPristine();
        this.patchFileUpdate1(attachmentDetail);
        if (Array.isArray(attachmentDetail.documentattachment) && attachmentDetail.documentattachment.length) {
            const documentattachment = attachmentDetail.documentattachment[0];
            attachmentDetail.documentattachment = Object.assign(documentattachment);
            if(documentattachment.attachmentclassificationtypekey){
                for(let {typedescription, subcategory} of this.attachmentClassificationtypelookup) {
                    if (typedescription === documentattachment.attachmentclassificationtypekey) {
                        this.attachmentClassificationSubType.push({ subcategory : subcategory});
                    }
                }
            }
            this.patchFileUpdate2(documentattachment);
            this.fileUpdate.controls.attachmentClassificationTypeKey.disable();
            this.fileUpdate.controls.attachmentClassificationSubTypeKey.disable();
            this.parentVal =  documentattachment.attachmentclassificationtypekey;
            this.selectChildMenu(documentattachment.attachmentclassificationsubtypekey,false);
        } else {
            attachmentDetail.documentattachment = Object.assign({});
        }
        this.attachmentDetail = attachmentDetail;
        if(this.isEditable) {
            this.fileUpdate.enable();
        } else {
            this.fileUpdate.disable();
        }
        this.fileUpdate.controls.attachmentTypeKey.disable();
    }

    patchFileUpdate1(attachmentDetail: any) {
        this.fileUpdate.patchValue({
            title: attachmentDetail.title ? attachmentDetail.title : '',
            description: attachmentDetail.description ? attachmentDetail.description : '',
            other: attachmentDetail.other ? attachmentDetail.other : '',
            attachmentTypeKey: (attachmentDetail.documentattachment && attachmentDetail.documentattachment.length > 0
                && attachmentDetail.documentattachment[0]['attachmenttypekey']) ? attachmentDetail.documentattachment[0]['attachmenttypekey'] : '',
            attachmentClassificationTypeKey: (attachmentDetail.documentattachment && attachmentDetail.documentattachment.length > 0
                && attachmentDetail.documentattachment[0]['attachmentclassificationtypekey']) ? attachmentDetail.documentattachment[0]['attachmentclassificationtypekey'] : '',
            attachmentClassificationSubTypeKey: (attachmentDetail.documentattachment && attachmentDetail.documentattachment.length > 0
                && attachmentDetail.documentattachment[0]['attachmentclassificationsubtypekey']) ? attachmentDetail.documentattachment[0]['attachmentclassificationsubtypekey'] : '',
            actualdocumentdate: attachmentDetail.actualdocumentdate ? new Date(attachmentDetail.actualdocumentdate) : null
        });
    }
    patchFileUpdate2(documentattachment: any){
        this.fileUpdate.patchValue({
            attachmentTypeKey: documentattachment.attachmenttypekey ? documentattachment.attachmenttypekey : '',
            attachmentClassificationTypeKey: documentattachment.attachmentclassificationtypekey ? documentattachment.attachmentclassificationtypekey : '',
            attachmentClassificationSubTypeKey:  documentattachment.attachmentclassificationsubtypekey ? documentattachment.attachmentclassificationsubtypekey : ''
        });
    }
    docDateAddUpdate(){
        if(this.fileUpdate.value.actualdocumentdate === '' || this.fileUpdate.value.actualdocumentdate === null){
            this.mandatoryAlert_DocumentDate = true;
        }else{
            this.mandatoryAlert_DocumentDate = false;
        }
    }
    saveAttachmentDetails() {
    if(this.fileUpdate.value.actualdocumentdate === '' || this.fileUpdate.value.actualdocumentdate === null){
        this.mandatoryAlert_DocumentDate = true;
    }else{
        this.mandatoryAlert_DocumentDate = false;
        if (this.fileUpdate.value.attachmentTypeKey !== '' 
        &&  this.fileUpdate.value.attachmentClassificationTypeKey !== '' &&
         this.fileUpdate.value.attachmentClassificationSubTypeKey
        && ((!this.fileUpdate.value.other &&  !this.enablOtherTxt) ||  (this.fileUpdate.value.other &&  this.enablOtherTxt))&& this.attachmentDetail
        ) {
            this.attachmentDetail.title = this.fileUpdate.value.attachmentClassificationSubTypeKey;
            this.attachmentDetail.actualdocumentdate = this.fileUpdate.value.actualdocumentdate;
            this.attachmentDetail.description = this.fileUpdate.value.description;
            this.attachmentDetail.other = this.fileUpdate.value.other;
            this.attachmentDetail.updatedby = this.token.user.userprofile.securityusersid;
            this.attachmentDetail.insertedby = this.token.user.userprofile.securityusersid;
            this.handleDocumentattachmentDataFn();
            this.attachmentDetail.documentdate = new Date();
            this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            this._service.createArrayList([this.attachmentDetail]).subscribe((response: any) => {
                    this._alertService.success('Attachment updated successfully!');
                    $('#edit-attachment').modal('hide');
                    this.attachment.emit('all');
                }, (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._alertService.error('Please fill all mandatory fields');
        }
            }

        }
    handleDocumentattachmentDataFn() {
        if( this.attachmentDetail && this.attachmentDetail.documentattachment) {
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
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                this.setAttachmentClassificationtype();

            }
        });
        const source = forkJoin(
            [this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
            )]

        ).pipe(
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

    setAttachmentClassificationtype(){
        for (let {typedescription, subcategory} of this.attachmentClassificationtypelookup ) {
            if (typedescription) {
                if (this.isCW ) {
                    if(typedescription.startsWith('CW-')) {
                        this.attachmentClassificationtype.push({typedescription: typedescription});
                        this.attachmentClassificationtype.push({typedescription: subcategory});
                    }
                } else {
                    this.attachmentClassificationtype.push({typedescription: typedescription});
                }
            }
        }
        
        this.attachmentClassificationtype = _.uniqBy(this.attachmentClassificationtype, 'typedescription');
        this.attachmentClassificationtype = _.sortBy(this.attachmentClassificationtype,'typedescription');
    }

    categoryUpdate(event: any) {
        if (event.target.value) {
            this.attachmentClassificationSubType = [];
            for(let {typedescription, subcategory} of this.attachmentClassificationtypelookup ) {
                if (typedescription === this.fileUpdate.value.attachmentClassificationTypeKey) {
                    this.attachmentClassificationSubType.push({ subcategory : subcategory});
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
            .subscribe((items: any) => {
                for(let item of items) {
                    if(item.parentkey === null ){
                        this.attachmentDropDownList_parent.push(item);
                    }else{
                        this.attachmentDropDownList_child.push(item);
                    }
                }
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
            });
    }

    childArray: any = [];
    parentVal = '';
    seletedVal = ''
    openChildMenu(parentVal: any, ref_key: any) {
        this.parentVal = parentVal;
        this.childArray = [];
        const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
        if (isExist) {
            const otherElements = isExist.filter((element: any)=>element['value_text'].substring(0,5).toLowerCase().includes('other'))
         
            otherElements.forEach((otherElement) => { 
                
            const index = isExist.findIndex((element: any)=>element['value_text'] === otherElement['value_text'])
                if(index > -1) {
                isExist.splice(index,1);
                }
            })
            this.childArray = [...isExist,...otherElements];
        
        }
    }

    triggerParentMenu(value: any) {
        if (value && value.trim() && value.length > 1) {

            this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent
                .filter((list: any) => list.value_text.toLowerCase().includes(value.toLowerCase())).slice();
            const childDropDownValues: any[] = this.attachmentDropDownList_child.filter((item: any) => item.value_text.toLowerCase().includes(value.toLowerCase())).slice();
            if (this.current_attachmentDropDownList_parent.length > 0) {
                this.inputMenuTrigger.openMenu();
                this.inputElement.nativeElement.focus();
            }
            else if (childDropDownValues.length > 0) {
                const parentKeys: any[] = childDropDownValues.map((item: any) => item.parentkey);
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent
                    .filter((list: any) => parentKeys.includes(list.ref_key)).slice();
                this.inputMenuTrigger.openMenu();
                this.inputElement.nativeElement.focus();
            } else {
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
            }


        } else {
            this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
        }

    }

    oPenParentMenuOnDoubleClick() {
        this.inputMenuTrigger.openMenu();
      }
    
    selectChildMenu(childVal: any, reset: any) {
        this.seletedVal = childVal; //Placeholder
        this.fileUpdate.controls.attachmentClassificationTypeKey.patchValue(this.parentVal);
        this.fileUpdate.controls.attachmentClassificationSubTypeKey.patchValue(childVal);
        if (reset) {
            this.fileUpdate.controls.other.reset();
        }
        if (childVal.includes('Other', 'other')) {
            this.enablOtherTxt = true;
        } else {
            this.enablOtherTxt = false;
        }
    }

    getDisplayName() {
        return Array.isArray(this.attachmentDetail?.userprofile) ? this.attachmentDetail?.userprofile[0]?.displayname : '';
    }
}