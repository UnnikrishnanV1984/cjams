import { map, pluck, share } from 'rxjs/operators';
import { Component, EventEmitter, OnInit, Input, Output, ViewChild, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';

import { AppUser } from "../../../@core/entities/authDataModel";
import { DropdownModel } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from "../../../@core/entities/constants";
import { AlertService, AuthService, DataStoreService } from '../../../@core/services';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from "../../../pages/case-worker/case-worker-url.config"; //'../../../case-worker-url.config';
import { Attachment } from '../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models'  //../_entities/attachment.data.models';
import { DsdsService } from '../../../pages/case-worker/dsds-action/_services/dsds.service' //'../../../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../../pages/case-worker/_entities/caseworker.data.constants';
import { MatMenuTrigger } from '@angular/material/menu';
import { UploadSharedService } from '../../../@core/services/upload-shared.service';

@Component({
    selector: 'attachement-scan-detail',
    templateUrl: './attachement-scan-detail.component.html',
    styleUrls: ['./attachement-scan-detail.component.scss'],
    standalone: false
})
export class AttachementScanDetailComponent implements OnInit {

    @Input()
    intakeNumber: string = ""
    daNumber: string;
    id: string;
    attachmentDetail!: FormGroup;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup :any[]= [];
    attachmentClassificationtype :any[] = [];
    attachmentClassificationsubtype:any[] = [];
    attachementClassificationSubTypeList :any[] = [];
    from_type = '';
    isAttachType = '';
    isCate = '';
    issubCate = '';
    @Output() modalDismiss = new EventEmitter();
    private token: AppUser;
    isServiceCase = false;
    personid = '';
    attachment_type = 'case';
    isCW!: boolean;
    @ViewChild(MatMenuTrigger) trigger!: MatMenuTrigger;
    maxDocumentDate = new Date();
    isSaveBtnClicked = false;
    fileNameError = false;
    private formBuilder: FormBuilder;
    private router: Router;
    private _dropDownService: CommonHttpService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _dsdsService: DsdsService;
    private _dataStoreService: DataStoreService;
    private _uploadSharedService : UploadSharedService;
    uploadParams: any = {};
    file!: File;

    constructor(private injector : Injector, private _service: GenericService<Attachment> ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.router = this.injector.get<Router>(Router);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._uploadSharedService = this.injector.get<UploadSharedService>(UploadSharedService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW();
        this.isServiceCase = this._dsdsService.isServiceCase();
        const objecttypekey = this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
        this.loadData();
        this.attachmentDetail = this.formBuilder.group({
            originalfilename: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            documentpropertiesid: null, 
            title: ['', [Validators.required, Validators.minLength(4), REGEX.NOT_EMPTY_VALIDATOR]],
            documentdate: new Date(),
            description: [''],
            documentattachment: this.formBuilder.group({
                attachmenttypekey: ['', Validators.required],
                attachmentclassificationtypekey: ['', Validators.required],
                attachmentclassificationsubtypekey: ['', Validators.required],
                // administration: ['', Validators.required],
                // judistriction: ['', Validators.required],
                // site:[''],
                attachmentdate: new Date(),
                sourceauthor: [''],
                attachmentsubject: [''],
                sourceposition: [''],
                attachmentpurpose: [''],
                sourcephonenumber: [''],
                acquisitionmethod: [''],
                sourceaddress: [''],
                locationoforiginal: [''],
                insertedByUserName: [this.token.user.userprofile.displayname],
                insertedby: [this.token.user.userprofile.securityusersid],
                note: [''],
                updatedby: [this.token.user.userprofile.securityusersid],
                activeflag: 1
            }),
            objecttypekey: [objecttypekey],
            objectid: [this.id],
            mime: [''],
            numberofbytes: [''],
            s3bucketpathname: [''],
            activeflag: [1],
            rootobjectid: [this.id],
            rootobjecttypekey: [objecttypekey],
            servicecaseid: [this.id],
            actualdocumentdate: new Date(),
            insertedby: this.token.user.userprofile.securityusersid,
            updatedby: this.token.user.userprofile.securityusersid,
            intakenumber: [this.intakeNumber],
            other: [''],
            ecmsdocumentid:['']
        });
        this.loadAttachmentDropDown()
    }
    loadData() {
        this.isAttachType = '';
        this.isCate = '';
        this.issubCate = '';
        const _self = this;
        const isDataFilled = setInterval(function () {
            if (_self.isAttachType !== '' && _self.isCate !== '' && _self.issubCate !== '') {
                clearInterval(isDataFilled);
                const dynam = _self.isAttachType + '|' + _self.isCate + '|' + _self.issubCate;
                window.sessionStorage.setItem('loadedData', dynam);
                window.sessionStorage.setItem('dataLoad', 'true');
            }
        }, 1000);
    }
    isdisabled(value:any) {
        let disabled;
        if ((this.from_type == "camera" && (value == "Audio" || value == "Video")) || (this.from_type == "video" && value != "Video") || (this.from_type == "audio" && value != "Audio")) {
            disabled = true;
        } else{
            disabled = false;
        }
        return disabled;
    }
    isselected(value:any) {
        if (this.from_type == "video" && value == "Video") {
            return true
        } else if (this.from_type == "audio" && value == "Audio") {
            return true;
        } else {
            return false;
        }
    }
    
    loadDropdown() {
        this._dropDownService
            .getSingle(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
            )
            .subscribe(data => {
                const dp_att_arr = [];
                if (data && data.length > 0) {
                    this.attachmentClassificationtypelookup = data;
                }
            });
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
            ),
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
    private loadDropdownRespLoop(dp_att_arr: any[]) {
        for (const element of this.attachmentClassificationtypelookup) {
            if (element?.typedescription && dp_att_arr.indexOf(element.typedescription) < 0) {
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
    }

    setAttachmentType(filetype:any) {
        if (filetype == 'camera') {
            this.from_type = 'camera';
        } else if (filetype == 'video') {
            this.from_type = 'video';
            this.attachmentDetail.patchValue({ documentattachment: { attachmenttypekey: 'Video' } });
            this.isAttachType = 'Video';
        } else if (filetype == 'audio') {
            this.from_type = 'audio';
            this.attachmentDetail.patchValue({ documentattachment: { attachmenttypekey: 'Audio' } });
            this.isAttachType = 'Audio';
        }
    }

    categoryUpdate(event:any) {
        if (event.target.value !== '') {
            this.isCate = event.target.value;
            this.issubCate = '';
            this.attachmentDetail.patchValue({ documentattachment: { attachmentclassificationsubtypekey: '' } });
            this.attachmentClassificationsubtype = [];
            const selectedClassifictionType = this.attachmentClassificationtype.filter((type) => type.value_text === this.isCate)

            this.attachmentClassificationsubtype = this.attachementClassificationSubTypeList.filter(subtype => subtype['parentkey'] === selectedClassifictionType[0]['ref_key'])
        }
    }
    subcategoryUpdate(event:any) {
        if (event.target.value !== '') {
            this.issubCate = event.target.value;
        }
    }
    typeUpdate(event:any) {
        if (event.target.value !== '') {
            this.isAttachType = event.target.value;
        }
    }

    patchAttachmentDetail(uploadParams: any, file: File, attachment_type = 'case', personid = '') {
        this.personid = personid;
        this.uploadParams = uploadParams;
        this.file = file;
        this.attachment_type = attachment_type;
    }
    async saveAttachmentDetails() {
        this.fileNameError = false;
        this.isSaveBtnClicked = true;
        if(this.file.name.substring(this.file.name.length - 4) !== ".pdf") {
            this.fileNameError = true;
            return;
        }
        const dynam  = this.isAttachType + '|' + this.isCate + '|' + this.issubCate;
        const fileSha256Hashvalue = await this.hash256(this.file);
        // the upload metadata goes in the request body as a JSON payload instead of the query string
        const payload = { ...this.uploadParams, docsInfo: dynam, fileSha256Hash: fileSha256Hashvalue };
        this._dropDownService
        .create(payload, CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.LargeFileUploadAttachmentUrl)
        .subscribe(
         async (response) => {
            response.fileSha256Hash =  fileSha256Hashvalue;
            this._uploadSharedService.presignUrlcallupload(response, this.file); 
            if (response && response.documentpropertiesid) {
                this._alertService.success('Attachment added successfully!');
                let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment'
                if (this.intakeNumber) {
                    this.modalDismiss.emit();
                    return;
                }
                this.modalDismiss.emit();
                if (this.attachment_type == 'person') {
                    currentUrl = currentUrl + '/person';
                }
                this.router.navigate([currentUrl]);
            } else if (response && response.Documentattachment) {
                this._alertService.error(response.Documentattachment);
            } else {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
            },
        (error:any) => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
        );
    }

    private async hash256(file: File): Promise<string> {
        const buffer = await file.arrayBuffer();
        const hashBuffer = await crypto.subtle.digest('SHA-256', buffer);
        // Convert hash to Base64 (NOT hexadecimal)
        let binary = '';
        const bytes = new Uint8Array(hashBuffer);
        bytes.forEach(b => binary += String.fromCharCode(b));
        const fileSha256Hash = btoa(binary)
        return fileSha256Hash; // Base64-encoded hash string
    }

    
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
            .subscribe((item) => {
                for (const element of item) {
                    if (element.parentkey === null) {
                        this.attachmentClassificationtype.push(element);
                    } else {
                        this.attachementClassificationSubTypeList.push(element);
                    }
                }
            });
    }
    setChildMenu(patentKey: any) {
        this.attachmentClassificationsubtype = [];
        const isExist = this.attachmentClassificationtype.filter((item: any) => (item.parentkey === patentKey));
        if (isExist) {
            this.attachmentClassificationsubtype = [...isExist];
        }
    }
    seletedVal: string='';
    selectedItem() {
        this.seletedVal = "Title ";
        return this.seletedVal
    }
    parentVal: string='';
    childArray: any = [];
    openChildMenu(parentVal:any, ref_key:any) {
        this.parentVal = parentVal;
        this.attachmentDetail?.get('documentattachment')?.get('attachmentclassificationtypekey')?.patchValue(this.parentVal)
        this.childArray = [];
        const isExist = this.attachementClassificationSubTypeList.filter((item: any) => (item.parentkey === ref_key));
        if (isExist) {
            this.childArray = [...isExist];
        }
    }
    enablOtherTxt: boolean = false;

    selectChildMenu(childVal:any) {
        this.enablOtherTxt = false;
        const parentEvent = {
            'target': {
                'value': this.parentVal
            }
        }
        this.categoryUpdate(parentEvent);
        const childEvent = {
            'target': {
                'value': childVal
            }
        }
        this.attachmentDetail?.get('documentattachment')?.get('attachmentclassificationsubtypekey')?.patchValue(childVal)
            this.attachmentDetail?.get('title')?.patchValue(childVal)
        this.subcategoryUpdate(childEvent);
        if (childVal.includes('Other', 'other')) {
            this.enablOtherTxt = true;
            this.attachmentDetail?.get('other')?.patchValue(childVal)
        }
    }


    docDateAddUpdate(event:any) {
        this.attachmentDetail?.get('actualdocumentdate')?.patchValue(event)

    }

}