
import { map, pluck, share } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, EventEmitter, OnInit, Output, ViewChild, Input, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { forkJoin, Observable } from 'rxjs';

import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { AttachmentUpload } from '../../../../case-worker/_entities/caseworker.data.model';
import { Attachment } from '../../../../case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { MatMenuTrigger } from '@angular/material/menu';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-upload',
    templateUrl: './attachment-upload.component.html',
    styleUrls: ['./attachment-upload.component.scss'],
    standalone: false
})
export class AttachmentUploadComponent implements OnInit {
    curDate!: Date;
    fileToSave: any[] = [];
    fileToSaveContact: any[] = [];
    uploadedFile: any[] = [];
    tabActive = false;
    daNumber: string;
    id: string;
    attachmentResponse!: AttachmentUpload;
    // attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    token: AppUser;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    isAttachType = '';
    isCate = '';
    issubCate = '';
    isServiceCase = false;
    @Input() uploadedDocuments: any[] = [];
    @Input() uploadType: any;
    @Input() pageType: any;
    @Input() uploadFromParent = false;
    @Output() uploadAttachmentParent = new EventEmitter<any>();
    @Output() saveAttachment = new EventEmitter<any>();
    uploadNumber!: number;
    maxDocumentDate: any;
    @Input() additionalobjectid!: string;
    @Input() additionalobjecttype: any;
    @Input() modalId = "upload-attachment";
    @Input() componentName!: string;
    personid: any;
    attachmenttype: any;
    isDataFilled: any[] = [];
    agency;
    isCW!: boolean;
    @ViewChild(MatMenuTrigger) trigger!: MatMenuTrigger;
    accesstokenparam = '?access_token=';
    attachmenttypeparam = '&attachmenttype=';
    personidparam = '&personid=';
    objecttypekeyparam = '&objecttypekey=';
    private router: Router;
    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private _alertService: AlertService;

    constructor(
        private readonly injector : Injector,
        private _service: GenericService<Attachment>,
        private _dataStoreService: DataStoreService
    ) {
        this.router = this.injector.get<Router>(Router);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        this.agency = this._authService.getAgencyName();
    }

    ngOnInit() {
        this.maxDocumentDate = new Date();
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.curDate = new Date();
        this.loadAttachmentDropDown();
    }
    fileData: any = [];
    catIndex: number = 0;
    refPageUploadFn(file: any) {
        for (let i = 0; file.length > i; i++) {
            const index = i;
            const data = {
                category: file[index]?.attachmentclassificationtypekey ? file[index]?.attachmentclassificationtypekey : '',
                subCategory: file[index]?.attachmentclassificationsubtypekey ? file[index]?.attachmentclassificationsubtypekey : '',
                file: file[index],
                date: file[index]?.actualdocumentdate ? file[index]?.actualdocumentdate : ''
            }
            this.fileData.push(data);
            this.uploadAttachmentParent.emit(data);
        }
    }
    uploadFile(file: any): void {
        if (this.uploadFromParent) {
            this.uploadFromParentTrueCondition(file);
        }
        this.uploadNumber = this._dataStoreService.getData('uploadNumber');
        this.attachmenttype = this._dataStoreService.getData('attachmenttype');
        this.personid = this._dataStoreService.getData('personid');

        if (!(file instanceof Array)) {
            return;
        }
        this.fileMapFn(file);
    }
    private fileMapFn(file: any) {
        file.map((item: any, index: any) => {
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
            this.checkExtByFilenameSplitFn(fileExt, item, index);
        });
    }

    private checkExtByFilenameSplitFn(fileExt: any, item: any, index: number) {
        if (
            fileExt === 'mp3' ||
             fileExt === 'ogg' || 
             fileExt === 'wav' || 
             fileExt === 'acc' || 
             fileExt === 'flac' || 
             fileExt === 'aiff' || 
             fileExt === 'mp4' || 
             fileExt === 'mov' || 
             fileExt === 'avi' || 
             fileExt === '3gp' || 
             fileExt === 'wmv' || 
             fileExt === 'mpeg-4' || 
             fileExt === 'pdf' || 
             fileExt === 'txt' || 
             fileExt === 'docx' || 
             fileExt === 'doc' || 
             fileExt === 'xls' || 
             fileExt === 'xlsx' || 
             fileExt === 'jpeg' || 
             fileExt === 'jpg' || 
             fileExt === 'png' || 
             fileExt === 'ppt' || 
             fileExt === 'pptx' || 
             fileExt === 'gif' || 
             fileExt === 'cr2' || 
             fileExt === 'rtf'
             ) {
            this.uploadedFile.push(item);
            index = this.uploadedFile.length - 1;
            this.uploadAttachment(index);
            this.checkFileExtFn(fileExt, index);
            this.isAttachType = this.uploadedFile[index].attachmenttypekey;
        } else {
            this._alertService.error(fileExt + " format can't be uploaded");
        }
    }

    private checkFileExtFn(fileExt: any, index: number) {
        const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
        const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
        if (audio_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[index].attachmenttypekey = 'Audio';
        } else if (video_ext.indexOf(fileExt) >= 0) {
            this.uploadedFile[index].attachmenttypekey = 'Video';
        } else {
            this.uploadedFile[index].attachmenttypekey = 'Document';
        }
    }

    private uploadFromParentTrueCondition(file: File | FileError) {
        if (this.pageType === 'referService') {
            this.refPageUploadFn(file);
        } else if (this.pageType === 'courtOrder') {
            this.refPageUploadFn(file);
        }
        else if (this.pageType === 'investigationFindngs') {
            this.refPageUploadFn(file);
        }
        else {
            this.uploadAttachmentParent.emit(file);
        }
    }

    humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }
    uploadAttachment(index: any) {
        this.isAttachType = '';
        this.isCate = '';
        const _self = this;
        this.isDataFilled[index] = setInterval(() => {
            if (_self.isAttachType !== '' && _self.isCate !== '' && _self.issubCate !== '') {
                clearInterval(_self.isDataFilled[index]);
                if (this.uploadFromParent) {
                    if (this.pageType !== 'referService' && this.pageType !== 'courtOrder') {
                        _self.processResponseData(index);
                    }
                } else {
                    _self.processResponseData(index)
                }

            }
        }, 1000);
    }

    processResponseData(index: any) {
        let uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.uploadNumber + this.attachmenttypeparam + this.attachmenttype + this.personidparam + this.personid + this.objecttypekeyparam + 'YTP';

        uploadUrl = this.investigationFindingsConditionFn(uploadUrl);

        if (this.router.url.includes('person-info-cw/education')) {
            const additionalobjectid = this.returnAdditionalobjectidFn();
            const additionalobjecttype = this.returnAdditionalobjecttypeFn();
            uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.uploadNumber + this.attachmenttypeparam + this.attachmenttype + this.personidparam + this.personid + this.objecttypekeyparam + 'YTP' + '&additionalobjectid=' + additionalobjectid + '&additionalobjecttype=' + additionalobjecttype;
            this.uploadedFile[index].additionalobjectid = this.returnAdditionalobjectidFn();
            this.uploadedFile[index].additionalobjecttype = this.returnAdditionalobjecttypeFn();
        }

        this._uploadServiceApiFn(uploadUrl, index);
    }

    private investigationFindingsConditionFn(uploadUrl: string): string {
        return this.pageType === 'investigationFindings' ? this.investigationFindingsUrl() : uploadUrl;
    }

    private investigationFindingsUrl(): string {
        return AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber + this.objecttypekeyparam + 'investigation';
    }

    private returnAdditionalobjecttypeFn() {
        return this.additionalobjecttype ? this.additionalobjecttype : null;
    }

    private returnAdditionalobjectidFn() {
        return this.additionalobjectid ? this.additionalobjectid : null;
    }

    private _uploadServiceApiFn(uploadUrl: string, index: any) {
        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true,
            })
            .subscribe(
                (response) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
                    this._uploadServiceResponseFn(response, index);

                }, (err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }

    private _uploadServiceResponseFn(response: any, index: any) {
        if (response.status === 1 && response.data) {
            this.attachmentResponse = response.data;
            const doucumentInfo = response.data;
            doucumentInfo.documentdate = doucumentInfo.date;
            doucumentInfo.title = doucumentInfo.originalfilename;
            doucumentInfo.objecttypekey = 'YTP';
            doucumentInfo.rootobjecttypekey = 'YTP';
            doucumentInfo.activeflag = 1;
            doucumentInfo.servicerequestid = null;
            this.fileToSaveContact[index] = { ...this.fileToSaveContact[index], ...doucumentInfo };
            //for saving to case
            this.attachmentResponse = response.data;
            this.fileToSave.push(response.data);
            this.addDataToFileToSaveFn(this.fileToSave.length - 1);
        }
    }

    private addDataToFileToSaveFn(fileToSaveLength: any) {
        this.fileToSave[fileToSaveLength].documentattachment = {
            attachmenttypekey: this.isAttachType,
            attachmentclassificationtypekey: this.isCate,
            attachmentclassificationsubtypekey: this.issubCate,
            attachmentdate: new Date(),
            sourceauthor: '',
            attachmentsubject: '',
            sourceposition: '',
            attachmentpurpose: '',
            sourcephonenumber: '',
            acquisitionmethod: '',
            sourceaddress: '',
            locationoforiginal: '',
            insertedby: this.token.user.userprofile.displayname,
            note: '',
            updatedby: this.token.user.userprofile.displayname,
            activeflag: 1
        };
        const objecttypekey = this.returnObjecttypekeyFn();
        this.fileToSave[fileToSaveLength].description = '';
        this.fileToSave[fileToSaveLength].documentdate = new Date();
        this.fileToSave[fileToSaveLength].title = '';
        this.fileToSave[fileToSaveLength].daNumber = this.uploadNumber;
        this.fileToSave[fileToSaveLength].objecttypekey = objecttypekey;
        this.fileToSave[fileToSaveLength].rootobjecttypekey = objecttypekey;
        this.fileToSave[fileToSaveLength].activeflag = 1;
        this.fileToSave[fileToSaveLength].daNumber = this.uploadNumber;
        this.fileToSave[fileToSaveLength].insertedby = this.token.user.userprofile.displayname;
        this.fileToSave[fileToSaveLength].updatedby = this.token.user.userprofile.displayname;
        this.fileToSave[fileToSaveLength].securityusersid = this.token.user.userprofile.securityusersid;
    }

    private returnObjecttypekeyFn() {
        return this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
    }

    private returnPersonIdFn() {
        return this.personid === null ? '' : this.personid;
    }

    deleteUpload(index: any) {
        clearInterval(this.isDataFilled[index]);
        this.uploadedFile.splice(index, 1);
        this.fileToSave.splice(index, 1);
        this.fileToSaveContact.splice(index, 1);
    }
    clearAllUpload() {
        $('#' + this.modalId).modal('hide');
        if (this.uploadType == 'note') {
            $('#myModal-recordings').modal('show');
        } else if (this.uploadType == 'meeting') {
            $('#add-new-meeting').modal('show');
        }
        this.uploadedFile = [];
        this.fileToSave = [];
        this.fileToSaveContact = [];
    }
    // titleUpdate(event, index) {
    //     this.uploadedFile[index].title = event.target.value;
    //     if (event.target.value) {
    //         this.uploadedFile[index].invalidTitle = false;
    //     } else {
    //         this.uploadedFile[index].invalidTitle = true;
    //     }
    // }
    descUpdate(event: any, index: any) {
        this.uploadedFile[index].description = event.target.value;
    }
    docDateUpdate(event: any, index: any) {
        this.uploadedFile[index].docDate = event.target.value;
    }
    otherUpdate(event: any, index: any) {
        this.uploadedFile[index].other = event.target.value;
    }
    docDateAddUpdate(event: any, index: any) {
        this.uploadedFile[index].actualdocumentdate = event;
        if (this.uploadFromParent && (this.pageType === 'referService' || this.pageType === 'courtOrder' || this.pageType === 'investigationFindngs')) {
            const file = this.fileData[index].file;
            const data = {
                category: file?.attachmentclassificationtypekey ? file?.attachmentclassificationtypekey : '',
                subCategory: file?.attachmentclassificationsubtypekey ? file?.attachmentclassificationsubtypekey : '',
                file: [file],
                date: file?.actualdocumentdate ? file?.actualdocumentdate : ''
            }
            this.uploadAttachmentParent.emit(data);
        }
    }
    typeUpdate(event: any, index: any) {
        if (event.target.value !== '') {
            this.isAttachType = event.target.value;
        }
        this.uploadedFile[index].attachmenttypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentType = false;
        } else {
            this.uploadedFile[index].invalidAttachmentType = true;
        }
    }
    categoryUpdate(event: any, index: any) {
        if (event.target.value !== '') {
            this.isCate = event.target.value;
        }
        this.issubCate = '';
        this.uploadedFile[index].attachmentclassificationsubtypekey = '';
        this.uploadedFile[index].attachmentClassificationsubtype = [];
        this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentClassify = false;
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                    this.uploadedFile[index].attachmentClassificationsubtype.push({ subcategory: element.subcategory });
                }
            }
        } else {
            this.uploadedFile[index].invalidAttachmentClassify = true;
        }
    }
    subcategoryUpdate(event: any, index: any) {
        if (event.target.value !== '') {
            this.issubCate = event.target.value;
        }
        this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentsubClassify = false;
        } else {
            this.uploadedFile[index].invalidAttachmentsubClassify = true;
        }
        if (this.uploadFromParent && (this.pageType === 'referService' || this.pageType === 'courtOrder' || this.pageType === 'investigationFindngs')) {
            const file = this.fileData[index].file;
            const data = {
                category: file?.attachmentclassificationtypekey ? file?.attachmentclassificationtypekey : '',
                subCategory: file?.attachmentclassificationsubtypekey ? file?.attachmentclassificationsubtypekey : '',
                file: [file],
                date: file?.actualdocumentdate ? file?.actualdocumentdate : ''
            }
            this.uploadAttachmentParent.emit(data);
            this.catIndex = index;
        }
    }
    saveAttachmentDetails() {
        if (this.uploadFromParent) {
            this.modalIdHideFn();
            this.uploadedFile = [];
            this.fileToSave = [];
            this.fileToSaveContact = [];
            this.fileData = [];
            return;
        }
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.addDataToFileToSave();
            const AttachValidate = this.fileToSave.filter((wer) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey /*|| !wer.documentattachment.administration  || !wer.documentattachment.site */);
            if (AttachValidate.length === 0) {

                this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
                this.saveAttachmentUrlFn();
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error('Please fill all mandatory fields');
                this.invalidAttachmentCheckFn();
            }
        }
    }
    private saveAttachmentUrlFn() {
        this._service.createArrayList(this.fileToSave).subscribe(
            (response: any) => {
                let start = this.uploadedDocuments.length;

                response.forEach((item: any, index: any) => {
                    if (item.documentpropertiesid) {
                        this.fileToSave[index].documentpropertiesid = item.documentpropertiesid;
                        this.uploadedDocuments[start] = { ...this.uploadedDocuments[start], ...this.fileToSave[index] };
                        start++;
                    }
                    const docProp = this.filterSaveAttachmentUrlFn(response);
                    if (docProp.length === 0) {
                        this.modalIdHideFn();
                        this.docPropLengthZeroFn();
                    }
                    if (item.Documentattachment) {
                        const attPos = index + 1;
                        this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
                    } else if (!item.documentpropertiesid) {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                });
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    private modalIdHideFn() {
        $('#' + this.modalId).modal('hide');
    }

    private docPropLengthZeroFn() {
        if (this.uploadType == 'note') {
            $('#myModal-recordings').modal('show');
        } else if (this.uploadType == 'meeting') {
            $('#add-new-meeting').modal('show');
        }
    }

    private filterSaveAttachmentUrlFn(response: Attachment[]) {
        return response.filter((docId) => docId.Documentattachment);
    }

    private invalidAttachmentCheckFn() {
        this.uploadedFile.forEach((item) => {
            if (!item.attachmentclassificationtypekey) {
                item.invalidAttachmentClassify = true;
            } else {
                item.invalidAttachmentClassify = false;
            }
            if (!item.attachmenttypekey) {
                item.invalidAttachmentType = true;
            } else {
                item.invalidAttachmentType = false;
            }
            if (!item.attachmentclassificationsubtypekey) {
                item.invalidAttachmentsubClassify = true;
            } else {
                item.invalidAttachmentsubClassify = false;
            }
        });
    }

    private addDataToFileToSave() {
        this.uploadedFile.forEach((item, index) => {
            // Getting the correct index by matching the filename ,as values in uploadedFile and fileToSave are not matching sequencially
            const xindex = this.fileToSave.findIndex(data => data.originalfilename === this.uploadedFile[index].name);
            this.fileToSave[xindex].servicerequestid = this.isServiceCase ? null : this.id;
            this.fileToSave[xindex].servicecaseid = this.isServiceCase ? this.id : null;
            this.fileToSave[xindex].title = item.attachmentclassificationsubtypekey;
            this.fileToSave[xindex].attachmenttype = this.attachmenttype;
            this.fileToSave[xindex].personid = this.personid;
            this.fileToSave[xindex].description = item.description;
            this.fileToSave[xindex].other = item.other;
            this.fileToSave[xindex].enableOtherTxt = item.enableOtherTxt ? true : false;
            this.fileToSave[xindex].actualdocumentdate = item.actualdocumentdate;
            this.fileToSave[xindex].documentattachment.attachmenttypekey = item.attachmenttypekey;
            this.fileToSave[xindex].documentattachment.attachmentclassificationtypekey = item.attachmentclassificationtypekey;
            this.fileToSave[xindex].documentattachment.attachmentclassificationsubtypekey = item.attachmentclassificationsubtypekey;
            this.fileToSave[xindex].additionalobjecttype = item.additionalobjecttype;
            this.fileToSave[xindex].additionalobjectid = item.additionalobjectid;
        });
    }

    private loadDropdown() {
        this.AttachmentGetApi();
        const source = this.loadDropdownForkJoinFn();
        this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
    }

    private loadDropdownForkJoinFn() {
        return forkJoin([
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
                        (res) => new DropdownModel({
                            text: res.typedescription,
                            value: res.attachmenttypekey
                        })
                    ),
                };
            }),
            share());
    }

    private AttachmentGetApi() {
        this._dropDownService
            .getSingle(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
            )
            .subscribe(data => {
                if (data?.length > 0) {
                    this.attachmentClassificationtypelookup = data;
                    this.attachmentClassificationtypelookupLoop();

                }
            });
    }

    private attachmentClassificationtypelookupLoop() {
        const dp_att_arr: any = [];
        for (const element of this.attachmentClassificationtypelookup) {
            if (element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0) {
                this.ifTypedescriptionCondition(element, dp_att_arr);
            }
        }
    }

    private ifTypedescriptionCondition(element: any, dp_att_arr: any[]) {
        if (this.isCW) {
            this.ifIsCW(element, dp_att_arr);
        } else {
            this.attachmentClassificationtype.push({ typedescription: element.typedescription });
            dp_att_arr.push(element.typedescription);
        }
    }

    private ifIsCW(element: any, dp_att_arr: any[]) {
        if (element.typedescription.startsWith('CW-')) {
            this.attachmentClassificationtype.push({ typedescription: element.typedescription });
            dp_att_arr.push(element.typedescription);
        }
    }
    attachmentDropDownList_parent:any[] = [];
    attachmentDropDownList_child:any[] = [];

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
                this.loadAttachmentDropDownResponse(item);
            });
    }
    
    private loadAttachmentDropDownResponse(item: any[]) {
        for (const element of item) {
            if (element.parentkey === null) {
                this.loadAttachmentDropDownElseConIfCon(element);
            } else {
                this.loadAttachmentDropDownElseCon(element);
            }
        }
    }

    private loadAttachmentDropDownElseConIfCon(element: any) {
        if (this.componentName === 'education' && element.ref_key === "edution") {
            this.attachmentDropDownList_parent.push(element);
        } else {
            this.notEducationParent(element);
        }
    }
    private notEducationParent(element: any) {
        if (this.componentName !== 'education') {
            this.attachmentDropDownList_parent.push(element);
        }
    }

    private loadAttachmentDropDownElseCon(element: any) {
        if (this.componentName === 'education' && ((element.ref_key === "eduort") || (element.ref_key === "repard"))) {
            this.attachmentDropDownList_child.push(element);
        } else {
            this.notEducationChild(element);
        }
    }
    private notEducationChild(element: any) {
        if (this.componentName !== 'education') {
            this.attachmentDropDownList_child.push(element);
        }
    }

    childArray:any[] = [];
    parentVal: any = '';
    seletedVal: any = ''
    enablOtherTxt = false;

    openChildMenu(parentVal: any, ref_key: any) {
        this.parentVal = parentVal;
        this.childArray = [];
        const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
        if (isExist) {
            this.childArray = [...isExist];
        }
    }

    selectChildMenu(childVal: any, index: any) {
        this.enablOtherTxt = false;
        this.uploadedFile[index].enableOtherTxt = false;
        const parentEvent = {
            'target': {
                'value': this.parentVal
            }
        }
        this.categoryUpdate(parentEvent, index);
        const childEvent = {
            'target': {
                'value': childVal
            }
        }
        this.subcategoryUpdate(childEvent, index);
        if (childVal.includes('Other', 'other')) {
            this.enablOtherTxt = true;
            this.uploadedFile[index].enableOtherTxt = true;
        }
    }

    selectedItem(index: any) {
        if (!this.uploadedFile[index].attachmentclassificationtypekey) {
            this.seletedVal = 'Title';
        } else {
            this.seletedVal = this.uploadedFile[index].attachmentclassificationsubtypekey;
        }
        return this.seletedVal
    }

    onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}
