
import {of as observableOf,  forkJoin ,  Observable } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Input, Output, EventEmitter,ViewChild,ElementRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { NewUrlConfig } from '../../../newintake-url.config';
import { GenericService, AlertService, CommonHttpService, AuthService, DataStoreService } from '../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { Attachment } from '../_entities/attachmnt.model';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { AttachmentSubCategory } from '../../_entities/newintakeModel';
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
    fileUpdate!: FormGroup;
    token: AppUser;

    @Input() intakeNumber!: string;
    attachmentDetail!: Attachment;
    @Output() attachment = new EventEmitter();
    subCategoryClassificationType$!: Observable<AttachmentSubCategory[]>;
    store: any;
    createdCases: any[] = [];
    subCategoryId: any;
    subCategoryList: any = [];
    subCategoryList$!: Observable<AttachmentSubCategory[]> | null;
    subType: any[]= [];
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    isCW!: boolean;
    isEditable!: boolean;
    maxDocumentDate: any;
    enablOtherTxt!: boolean;
    current_attachmentDropDownList_parent: any[] = [];
    current_attachmentDropDownList_child: any[] = [];
    constructor(
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _dropDownService: CommonHttpService,
        private _service: GenericService<Attachment>,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService
    ) {
        this.token = this._authService.getCurrentUser();
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW();
        this.maxDocumentDate = new Date();
        this.loadDropdown();
        this.fileUpdate = this.formBuilder.group({
            title: [''],
            description: ['', Validators.maxLength(150)],
            attachmentTypeKey: [''],
            other: [''],
            attachmentClassificationTypeKey: [''],
            attachmentClassificationSubTypeKey:[''],
            assessmenttemplateid: [''],
            actualdocumentdate: null
        });
        this.getSubCategory();
        this.loadAttachmentDropDown();
    }
    editForm(attachmentDetail: Attachment, isEditable: boolean) {
        this.isEditable = isEditable;
        this.fileUpdate.markAsPristine();
        this.fileUpdate.patchValue({
            title: attachmentDetail.title ? attachmentDetail.title : '',
            description: attachmentDetail.description ? attachmentDetail.description : '',
            attachmentTypeKey: '',
            attachmentClassificationTypeKey: '',
            attachmentClassificationSubTypeKey:'',
            other: attachmentDetail.other ? attachmentDetail.other : '',
            assessmenttemplateid: '',
            actualdocumentdate: attachmentDetail.actualdocumentdate ? new Date(attachmentDetail.actualdocumentdate) : null
        });
        if (Array.isArray(attachmentDetail.documentattachment) && attachmentDetail.documentattachment.length) {
            const documentattachment = attachmentDetail.documentattachment[0];
            attachmentDetail.documentattachment = Object.assign(documentattachment);
            this.fileUpdate.patchValue({
                attachmentTypeKey: documentattachment.attachmenttypekey ? documentattachment.attachmenttypekey : '',
                attachmentClassificationTypeKey: documentattachment.attachmentclassificationtypekey ? documentattachment.attachmentclassificationtypekey : '',
                attachmentClassificationSubTypeKey:  documentattachment.attachmentclassificationsubtypekey ? documentattachment.attachmentclassificationsubtypekey : ''
            });
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

    resetForm() {
        (<any>$('#edit-attachment')).modal('hide'); // NOSONAR
    }
    saveAttachmentDetails() {
        if (this.fileUpdate.value.attachmentTypeKey !== '' 
        &&  this.fileUpdate.value.attachmentClassificationTypeKey !== '' &&
         this.fileUpdate.value.attachmentClassificationSubTypeKey
        && ((!this.fileUpdate.value.other &&  !this.enablOtherTxt) ||  (this.fileUpdate.value.other &&  this.enablOtherTxt))
        )
         {
            this.attachmentDetail.title = this.fileUpdate.value.attachmentClassificationSubTypeKey;
            this.attachmentDetail.description = this.fileUpdate.value.description;
            this.attachmentDetail.actualdocumentdate = this.fileUpdate.value.actualdocumentdate;
            this.attachmentDetail.documentattachment.attachmenttypekey = this.fileUpdate.value.attachmentTypeKey;
            this.attachmentDetail.other = this.fileUpdate.value.other;
            this.attachmentDetail.insertedby = this.token.user.userprofile.securityusersid;
            this.attachmentDetail.updatedby = this.token.user.userprofile.securityusersid;                                
            this.attachmentDetail.documentattachment.attachmentclassificationtypekey = this.fileUpdate.value.attachmentClassificationTypeKey;
            this.attachmentDetail.documentattachment.attachmentclassificationsubtypekey = this.fileUpdate.value.attachmentClassificationSubTypeKey;
            this.attachmentDetail.documentattachment.assessmenttemplateid = this.fileUpdate.value.assessmenttemplateid;
            this.attachmentDetail.documentattachment.updatedby = this.token.user.userprofile.securityusersid;
            this.attachmentDetail.documentattachment.attachmentdate = new Date();
            this.attachmentDetail.documentdate = new Date();
            this._service.endpointUrl = NewUrlConfig.EndPoint.Intake.SaveAttachmentUrl;
            this._service.createArrayList([this.attachmentDetail]).subscribe(
                () => {
                    this._alertService.success('Attachment updated successfully!');
                    (<any>$('#edit-attachment')).modal('hide'); // NOSONAR
                    this.attachment.emit('all');
                },
                (_error: any) => {
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
            const dp_att_arr: any[] = [];
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                for (const element of this.attachmentClassificationtypelookup) {
                    if (element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0 ) {
                        this.attachmentClassificationtypelookupIfCondFn(element, dp_att_arr);
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
            ),
            // this._dropDownService.getArrayList(
            //     {
            //         nolimit: true
            //     },
            //     NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
            // )
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
                    // attachmentClassificationType: result[1].map(
                    //     (res) =>
                    //         new DropdownModel({
                    //             text: res.typedescription,
                    //             value: res.attachmentclassificationtypekey
                    //         })
                    // )
                };
            }),
            share(),);
        this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
    }
    private attachmentClassificationtypelookupIfCondFn(element: any, dp_att_arr: any[]) {
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

    categoryUpdate(event: any) {
        if (this._authService.getCurrentUser().role.teamtypekey === 'AS') {
            if (event.target.value === 'Assessment Document') {
                this.getSubCategory();
            } else {
                this.subCategoryList$ = null;
            }
        }
    }

    getSubCategory() {
        if (this.store[IntakeStoreConstants.purposeSelected]) {
            const purpose = this.store[IntakeStoreConstants.purposeSelected];
            this.subType = this.store[IntakeStoreConstants.createdCases];
                if (this.subType && this.subType.length > 0) {
                   const purposeSubType = this.subType[0].subServiceTypeID;
                this.subCategoryClassificationType$ = this._dropDownService
            .getArrayList(
                {
                    where: {intakeservicerequesttypeid: purpose.value,
                        intakeservicerequestsubtypeid: purposeSubType,
                        agencycode: 'AS',
                        target: 'Intake'},
                        method: 'get'
                },
                'admin/assessmenttemplate/listassessmenttemplate?filter'
                ).pipe(
                map(result => {
                    return result;
                }));
                this.subCategoryClassificationType$.subscribe(result => {
                    this.listassessmenttemplateApiResponseFn(result);
                    this._dataStoreService.setData('categorySubType', this.subCategoryList);
                    this.subCategoryList$ = observableOf(this.subCategoryList);
                });
            }
        }
    }

    private listassessmenttemplateApiResponseFn(result: AttachmentSubCategory[]) {
        if (result && result.length > 0) {
            this.subCategoryList = [];
            for (const element of result) {
                if (element.isrequired === true) {
                    this.subCategoryList.push(element);
                }
            }
        }
    }

    attachmentDropDownList_parent: any = [];
    attachmentDropDownList_child: any = [];

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
                this.current_attachmentDropDownList_parent = this.attachmentDropDownList_parent.slice()
            });
    }

    childArray: any[] = [];
    parentVal = '';
    seletedVal = ''
    openChildMenu(parentVal: string, ref_key: any) {
        this.parentVal = parentVal;
        this.childArray = [];
        const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
        if (isExist) {
            const otherElements = isExist.filter((element: any)=>element['value_text'].substring(0,5).toLowerCase().includes('other'))
         
            otherElements.forEach((otherElement: any) => { 
                
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
        if (reset) {this.fileUpdate.controls.other.reset();}
        if(childVal.includes('Other','other')){
            this.enablOtherTxt = true;
        }else{
            this.enablOtherTxt = false;
        }
    }

    getUploadedByData(attachmentDetail: any) {
        return attachmentDetail?.userprofile && attachmentDetail?.userprofile?.length && attachmentDetail?.userprofile?.[0]?.displayname
    }
}