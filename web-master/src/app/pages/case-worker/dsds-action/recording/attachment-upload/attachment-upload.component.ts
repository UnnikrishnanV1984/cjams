
import {map, pluck, share} from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, OnInit, Input, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FileError, NgxfDirectoryStructure, NgxfUploaderService } from 'ngxf-uploader';
import { forkJoin ,  Observable } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { AttachmentUpload } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Attachment } from '../../attachment/_entities/attachment.data.models';
import { DsdsService } from '../../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

declare const $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-upload',
    templateUrl: './attachment-upload.component.html',
    styleUrls: ['./attachment-upload.component.scss'],
    standalone: false
})
export class AttachmentUploadComponent implements OnInit {
    curDate!: Date;
    fileToSave: any[]= [];
    fileToSaveContact: any[] = [];
    uploadedFile: any[] = [];
    tabActive = false;
    daNumber: string;
    saveDisabled: boolean = false;
    id: string;
    attachmentResponse!: AttachmentUpload;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    token: AppUser;
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    isAttachType = '';
    isCate = '';
    issubCate= '';
    isServiceCase = false;
    @Input() uploadedDocuments: any[] = [];
    @Input() uploadType!: any;
    personid: any;
    attachmenttype: any;
    isDataFilled: any[] = [];
    agency;
    isCW!: boolean;
    private router: Router;
    private _service: GenericService<Attachment>;
    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _dsdsService: DsdsService;
    private _dataStoreService: DataStoreService;

    constructor(private injector: Injector) {
        this.router = this.injector.get<Router>(Router);
        this._service = this.injector.get<GenericService<Attachment>>(GenericService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        this.agency = this._authService.getAgencyName();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.curDate = new Date();
        this.loadAttachmentDropDown();
    }
    uploadFile(file: File | File[] | NgxfDirectoryStructure[] | FileError): void {
        this.attachmenttype = this._dsdsService.getField('attachmenttype') || 'case';
        this.personid = this._dsdsService.getField('personid') || '';

        if (!(file instanceof Array)) {
            return;
        }
        file.map((item: any, index: any) => {
            const fileExt = item.name
                .toLowerCase()
                .split('.')
                .pop();
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
                const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
                const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
                if ( audio_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Audio'
                } else if ( video_ext.indexOf(fileExt) >= 0) {
                    this.uploadedFile[index].attachmenttypekey = 'Video';
                } else {
                    this.uploadedFile[index].attachmenttypekey = 'Document';
                }
                this.isAttachType = this.uploadedFile[index].attachmenttypekey;
            } else {
                this._alertService.error(fileExt + " format can't be uploaded");
            }
        });
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
        this.isDataFilled[index] =  setInterval(function() {
            if (_self.isAttachType !== '' && _self.isCate !== ''  &&  _self.issubCate !== ''  ) {
                clearInterval(_self.isDataFilled[index]);
                _self.processResponseData(index);
            }
        }, 1000);
    }

    processResponseData(index: any) {
        let uploadUrl = '';
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber + '&attachmenttype=' + this.attachmenttype + '&personid=' + this.personid + '&objecttypekey=' + 'YTP';

        this._uploadService
            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true,
            })
            .subscribe(
                (response: any) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
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

                        this.attachmentResponse = response.data;
                        this.fileToSave.push(response.data);
                        this.fileToSave[this.fileToSave.length - 1].documentattachment = {
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
                        const objecttypekey = this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
                        this.fileToSave[this.fileToSave.length - 1].description = '';
                        this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
                        this.fileToSave[this.fileToSave.length - 1].title = '';
                        this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
                        this.fileToSave[this.fileToSave.length - 1].objecttypekey = objecttypekey;
                        this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = objecttypekey;
                        this.fileToSave[this.fileToSave.length - 1].activeflag = 1;
                        this.fileToSave[this.fileToSave.length - 1].daNumber = this.daNumber;
                        this.fileToSave[this.fileToSave.length - 1].insertedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].updatedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].securityusersid = this.token.user.userprofile.securityusersid;
                        this.fileToSave[this.fileToSave.length - 1].index = index;
                    }

                }, (_err: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                        this.uploadedFile.splice(index, 1);
                    }
                );
    }
    deleteUpload(index: any) {
        clearInterval(this.isDataFilled[index]);
        this.uploadedFile.splice(index, 1);
        this.fileToSave.splice(index, 1);
        this.fileToSaveContact.splice(index, 1);
    }
    clearAllUpload() {
        $('#upload-attachment').modal('hide');
        if(this.uploadType=='meeting') {
            $('#add-new-meeting').modal('show');
        }
        this.uploadedFile = [];
        this.fileToSave = [];
        this.fileToSaveContact = [];
    }
    descUpdate(event: any, index: any) {
        this.uploadedFile[index].description = event.target.value;
    }
    otherUpdate(event: any, index: any) {
        this.uploadedFile[index].other = event.target.value;
    }
    docDateUpdate(event: any, index: any) {
        this.uploadedFile[index].docDate = event.target.value;
    }
    docDateAddUpdate(event: any, index: any) {
        this.uploadedFile[index].actualdocumentdate = event;
    }
    typeUpdate(event: any, index: any) {
        if (event.target.value !== '')  {
            this.isAttachType  = event.target.value;
        }
        this.uploadedFile[index].attachmenttypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentType = false;
        } else {
            this.uploadedFile[index].invalidAttachmentType = true;
        }
    }
    categoryUpdate(event: any, index: any) {
        if (event.target.value !== '')  {
            this.isCate  = event.target.value;
        }
        this.issubCate  = '';
        this.uploadedFile[index].attachmentclassificationsubtypekey = '';
        this.uploadedFile[index].attachmentClassificationsubtype = [];
        this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentClassify = false;
                this.attachmentClassificationtypelookup.forEach((e: any) => {
                if (e.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                    this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory: e.subcategory});
                }
            });
        } else {
            this.uploadedFile[index].invalidAttachmentClassify = true;
        }
    }
    subcategoryUpdate(event: any, index: any) {
        if (event.target.value !== '')  {
            this.issubCate  = event.target.value;
        }
        this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentsubClassify = false;
        } else {
            this.uploadedFile[index].invalidAttachmentsubClassify = true;
        }
    }
    saveAttachmentDetails() {
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.uploadedFile.forEach((item, index) => {
                const xindex = this.fileToSave.findIndex( data => data.index === index);
                this.fileToSave[xindex].servicerequestid = this.getservicerequestid();
                this.fileToSave[xindex].servicecaseid = this.getservicecaseid();
                this.fileToSave[xindex].title = item.attachmentclassificationsubtypekey;
                this.fileToSave[xindex].attachmenttype = this.attachmenttype;
                this.fileToSave[xindex].personid = this.personid;
                this.fileToSave[xindex].description = item.description;
                this.fileToSave[xindex].other = item.other;
                this.fileToSave[xindex].enableOtherTxt = item.enableOtherTxt ? true : false;
                this.fileToSave[xindex].documentattachment.attachmenttypekey = item.attachmenttypekey;
                this.fileToSave[xindex].documentattachment.attachmentclassificationtypekey = item.attachmentclassificationtypekey;
                this.fileToSave[xindex].documentattachment.attachmentclassificationsubtypekey = item.attachmentclassificationsubtypekey;
                this.fileToSave[xindex].actualdocumentdate = item.actualdocumentdate;
            });
            this.addAttachment();
        }
    }
    getservicerequestid(){
        return this.isServiceCase ? null : this.id;
    }
    getservicecaseid(){
        return this.isServiceCase ? this.id : null;
    }
    addAttachment() {
        const AttachValidate = this.fileToSave.filter((wer) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey /*|| !wer.documentattachment.administration  || !wer.documentattachment.site */);
        if (AttachValidate.length === 0) {
            this.saveDisabled = true;
            this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            this._service.createArrayList(this.fileToSave).subscribe(
                (response: any) => {
                    response.forEach((item: any, index: any) => {
                        this.afterAddAttachment(response);
                    });
                },
                (_error: any) => {
                    this.saveDisabled = false;
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this.uploadFileError();
        }
    }
    afterAddAttachment(response: any) {
        let start = this.uploadedDocuments.length;
        response.map((item: any, index: any) => {
            if (item.documentpropertiesid) {
                this.fileToSave[index].documentpropertiesid = item.documentpropertiesid;
                this.uploadedDocuments[start] = { ...this.uploadedDocuments[start], ...this.fileToSave[index] };
                start++;
            }
            const docProp = response.filter((docId: { Documentattachment: any; }) => docId.Documentattachment);
            if (docProp.length === 0) {
                $('#upload-attachment').modal('hide');
                this.saveDisabled = false;
                if (this.uploadType == 'meeting') {
                    $('#add-new-meeting').modal('show');
                }
            }
            if (item.Documentattachment) {
                const attPos = index + 1;
                this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
            } else if (!item.documentpropertiesid) {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
            this.saveDisabled = false;
        });
    }
    uploadFileError(){
        this._alertService.error('Please fill all mandatory fields');
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
    private loadDropdown() {
        this._dropDownService
        .getSingle(
            {},
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
        )
        .subscribe(data => {
            if (data && data.length > 0) {
                this.attachmentClassificationtypelookup = data;
                this.AddAttachmentClassificationtypes();
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

    AddAttachmentClassificationtypes() {
        const dp_att_arr: any[] = [];
        this.attachmentClassificationtypelookup.forEach((e:any) => {
            if (e.typedescription && dp_att_arr.indexOf(e.typedescription) < 0) {
                if (this.isCW) {
                    if (e.typedescription.startsWith('CW-')) {
                        this.attachmentClassificationtype.push({ typedescription: e.typedescription });
                        dp_att_arr.push(e.typedescription);
                    }
                } else {
                    this.attachmentClassificationtype.push({ typedescription: e.typedescription });
                    dp_att_arr.push(e.typedescription);
                }
            }
        });
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
            .subscribe((item) => {
                item.forEach((e: any) => {
                    if(e.parentkey === null ){
                        this.attachmentDropDownList_parent.push(e);
                    }else{
                        this.attachmentDropDownList_child.push(e);
                    }
                });
            });
    }

    childArray: any[] = [];
    parentVal = '';
    seletedVal = ''
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
        if(childVal.includes('Other','other')){
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