
import {of as observableOf,  forkJoin ,  Observable } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
/// <reference types="dwt" />
import { Component, OnInit, ViewChild, Input, Output, EventEmitter, OnDestroy, Injector } from '@angular/core';
import { NgForm } from '@angular/forms';
import { DropdownModel, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { HttpHeaders } from '@angular/common/http';
import { AppConfig } from '../../../../../app.config';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { CommonHttpService, AuthService, AlertService, GenericService, DataStoreService,SessionStorageService  } from '../../../../../@core/services';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { ActivatedRoute, Router } from '@angular/router';
import { Attachment } from '../_entities/attachmnt.model';
import { NewUrlConfig } from '../../../newintake-url.config';
import { AttachmentUpload, IntakeAssessmentRequestIds, AttachmentSubCategory } from '../../_entities/newintakeModel';
import { AttachmentDetailComponent } from '../attachment-detail/attachment-detail.component';
import { config } from '../../../../../../environments/config';
import { HttpService } from '../../../../../../app/@core/services/http.service';
import { FileUtils } from '../../../../../@core/common/file-utils';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { IntakeConfigService } from '../../intake-config.service';

declare var $: any;
declare var Dynamsoft: any;
declare var EnumDWT_ImageType: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-upload',
    templateUrl: './attachment-upload.component.html',
    styleUrls: ['./attachment-upload.component.scss'],
    standalone: false
})
export class AttachmentUploadComponent implements OnInit, OnDestroy {
    curDate!: Date;
    fileToSave: any[] = [];
    // intakeNumber: any;
    uploadedFile: any[] = [];

    tabActive = false;
    daNumber!: string;
    id!: string;
    attachmentResponse!: AttachmentUpload;
    //attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    token: AppUser;
    @Input() intakeNumber!: string;
    @Output() attachment = new EventEmitter();
    @ViewChild(AttachmentDetailComponent) attachmentDetail!: AttachmentDetailComponent;
    /*Dynamo Soft */
    dwObject: any;
    DW_TotalImage: any;
    DW_CurrentImage: any;
    fileName!: string;
    isFileScanned!: boolean;
    docNames: any;
    myData: any;
    fileExistsMsg: any;
    isUploading = false;
    disableScanBtn = false;

    showDialog!: boolean;
    img_width!: string;
    img_height!: string;
    selectedInterpolation!: number;
    _iLeft: any;
    _iTop: any;
    _iRight: any;
    _iBottom: any;
    DW_PreviewMode: any;
    isAttachDetail = false;
    dwtIntakeNo: any;
    subCategoryClassificationType$!: Observable<AttachmentSubCategory[]>;
    subCategoryList$!: Observable<AttachmentSubCategory[]>;
    createdCases = [];
    private assessmentRequestDetail!: IntakeAssessmentRequestIds;
    store: any;
    showAssesment!: number;
    paginationInfo: PaginationInfo = new PaginationInfo();
    assessmentTemplateID: any;
    assessmentTemplateName: any;
    subCategoryList: any[] = [];
    subType: any[] = [];
    isAttachType = '';
    isCate = '';
    attachmentClassificationtypelookup: any[] = [];
    attachmentClassificationtype: any[] = [];
    issubCate='';
    isCW!: boolean;
    showInfo = true;
    maxDocumentDate : any;

    private router: Router;
    private _dataStoreService: DataStoreService;
    private _dropDownService: CommonHttpService;
    private _storage: SessionStorageService;
    private route: ActivatedRoute;
    private _uploadService: NgxfUploaderService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _http: HttpService;

    constructor(private injector : Injector, private _service: GenericService<Attachment>, private _intakeConfig: IntakeConfigService) {
        this.router = this.injector.get<Router>(Router);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._uploadService = this.injector.get<NgxfUploaderService>(NgxfUploaderService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._http = this.injector.get<HttpService>(HttpService);

        this.docNames = [];
        this.id = this.route.snapshot.parent?.params['id'];
        this.token = this._authService.getCurrentUser();
        this.store = this._dataStoreService.getCurrentStore();
    }

    ngOnInit() {
        this.maxDocumentDate = new Date();
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.curDate = new Date();
        this.createdCases = this._dataStoreService.getData(IntakeStoreConstants.createdCases);
        this._intakeConfig.scanConfig$.subscribe(_data => {
            this.loadDynamsoft();
        });
        this.loadAttachmentDropDown();
    }

    loadDynamsoft() {
        Dynamsoft.DWT.Load();
        Dynamsoft.DWT.Trial = false;
        Dynamsoft.DWT.ProductKey = decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey')))  ? decodeURIComponent(atob(this._storage.getItem('dynamsoftProductKey'))):null;
        Dynamsoft.DWT.ResourcesPath = 'assets/images/dwt/scanner';
    }

    ngOnDestroy() {
        Dynamsoft.DWT.Unload();
    }

    uploadFile(file: any): void {
        if (!(file instanceof Array)) {
            this._alertService.error('Please enter a valid file');
            return;
        }
        file.map((item, index) => {
            const size = this.humanizeBytes(item.size);
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
                if (item.size <= config.uploadMaxSizeLimit) {
                    this.uploadedFile.push(item);
                    index = this.uploadedFile.length - 1;
                    this.uploadAttachment(index);
                    const audio_ext = ['mp3', 'ogg', 'wav', 'acc', 'flac', 'aiff'];
                    const video_ext = ['mp4', 'avi', 'mov', '3gp', 'wmv', 'mpeg-4'];
                    if (audio_ext.indexOf(fileExt) >= 0) {
                        this.uploadedFile[index].attachmenttypekey = 'Audio';
                    } else if (video_ext.indexOf(fileExt) >= 0) {
                        this.uploadedFile[index].attachmenttypekey = 'Video';
                    } else {
                        this.uploadedFile[index].attachmenttypekey = 'Document';
                    }
                    this.isAttachType = this.uploadedFile[index].attachmenttypekey;
                } else {
                    this._alertService.error("Uploaded file size " + size + " exceeds the maximum file size limit of " + Math.floor(config.uploadMaxSizeLimit / 1048576) + "MB.");
                }
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error(fileExt + " format can't be uploaded. Accepted file formats are mp3, ogg, wav, acc, flac, aiff, mp4, mov, avi, 3gp, wmv, mpeg-4, pdf, txt, docx, doc, xls, xlsx, jpeg, jpg, png, ppt, pptx, gif, cr2, rtf.");
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
        this.issubCate = '';
        const _self = this;
        const isDataFilled =  setInterval(function() {
                if (_self.isAttachType !== '' && _self.isCate !== ''  && _self.issubCate !== '') {
                    clearInterval(isDataFilled);
                    _self.processResponseData(index);
                }
          }, 1000);
    }
    processResponseData(index: any) {
        let uploadUrl = AppConfig.baseUrl  +  '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.intakeNumber + '&objecttypekey=' + 'ServiceRequest';
        this._uploadService

            .upload({
                url: uploadUrl,
                headers: new HttpHeaders().set('ctype', 'file'),
                filesKey: ['file'],
                files: this.uploadedFile[index],
                process: true
            })
            .subscribe(
                (response) => {
                    if (response.status) {
                        this.uploadedFile[index].percentage = response.percent;
                    }
                    if (response.status === 1 && response.data) {
                        this.attachmentResponse = response.data;
                        this.fileToSave.push(response.data);
                        this.fileToSave[this.fileToSave.length - 1].documentattachment = {
                            assessmenttemplateid: '',
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
                        this.fileToSave[this.fileToSave.length - 1].description = '';
                        this.fileToSave[this.fileToSave.length - 1].documentdate = new Date();
                        this.fileToSave[this.fileToSave.length - 1].title = '';
                        this.fileToSave[this.fileToSave.length - 1].intakenumber = this.intakeNumber;
                        this.fileToSave[this.fileToSave.length - 1].objecttypekey = 'ServiceRequest';
                        this.fileToSave[this.fileToSave.length - 1].rootobjecttypekey = 'ServiceRequest';
                        this.fileToSave[this.fileToSave.length - 1].activeflag = 1;
                        this.fileToSave[this.fileToSave.length - 1].intakenumber = this.intakeNumber;
                        this.fileToSave[this.fileToSave.length - 1].insertedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].updatedby = this.token.user.userprofile.displayname;
                        this.fileToSave[this.fileToSave.length - 1].securityusersid = this.token.user.userprofile.securityusersid;
                        // @Simar this is experimental
                        // Saving the index to match the upload response from ECMS to files list
                        this.fileToSave[this.fileToSave.length - 1].index = index;
                    }
                },
                (_err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }
    formTab() {
        this.attachmentDetail.patchAttachmentDetail(this.attachmentResponse);
        this.attachmentDetail.loadDropdown();
        this.tabActive = true;
        $('#step1').removeClass('active');
        $('#complete').addClass('active');
    }
    modalDismiss() {
        (<any>$('#upload-attachment')).modal('hide'); // NOSONAR
    }
    deleteUpload(index: any) {
        this.uploadedFile.splice(index, 1);
        this.fileToSave.splice(index, 1);
    }
    clearAllUpload() {
        this.uploadedFile = [];
        this.fileToSave = [];
    }
    descUpdate(event: any, index: any) {
        this.uploadedFile[index].description = event.target.value;
    }
    otherUpdate(event: any, index: any) {
        this.uploadedFile[index].other = event.target.value;
    }
    docDateAddUpdate(event: any, index: any) {
        this.uploadedFile[index].actualdocumentdate = event;
    }
    docDateUpdate(event: any, index: any) {
        this.uploadedFile[index].docDate = event.target.value;
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
        this.issubCate  ='';
        this.uploadedFile[index].attachmentclassificationsubtypekey ='';
        this.uploadedFile[index].attachmentClassificationsubtype = [];
        this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
        if (event.target.value) {
            this.uploadedFile[index].invalidAttachmentClassify = false;
            for (const element of this.attachmentClassificationtypelookup){
                if(element.typedescription==this.uploadedFile[index].attachmentclassificationtypekey){
                    this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory:element.subcategory});
                }
            } 
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
    getSubCategory() {
        if (this.store[IntakeStoreConstants.purposeSelected]) {
            const purpose = this.store[IntakeStoreConstants.purposeSelected];
            this.subType = this.store[IntakeStoreConstants.createdCases];
            if (this.subType && this.subType.length > 0) {
                const purposeSubType = this.subType[0].subServiceTypeID;
                this.subCategoryClassificationType$ = this._dropDownService
                    .getArrayList(
                        {
                            where: {
                                intakeservicerequesttypeid: purpose.value,
                                intakeservicerequestsubtypeid: purposeSubType,
                                agencycode: 'AS',
                                target: 'Intake'
                            },
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

    onSubcategory(categoryid: any) {
        this.assessmentTemplateID = categoryid.target.value;
    }



    saveAttachmentDetails() {
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.uploadedFile.forEach((item, index) => {
                // Getting the correct index by matching the filename ,as values in uploadedFile and fileToSave are not matching sequencially
                // const xindex = this.fileToSave.findIndex( data => data.originalfilename === this.uploadedFile[index].name);

                // @Simar this is experimental to allow uploading of files with same names
                // We can use the index  instead of the filename to match the upload response from ECMS to files list
                const xindex = this.fileToSave.findIndex( data => data.index === index);

                this.fileToSave[xindex].title = item.attachmentclassificationsubtypekey;
                this.fileToSave[xindex].description = item.description;
                this.fileToSave[xindex].actualdocumentdate = item.actualdocumentdate;
                this.fileToSave[xindex].documentattachment.attachmenttypekey = item.attachmenttypekey;
                this.fileToSave[xindex].documentattachment.attachmentclassificationtypekey = item.attachmentclassificationtypekey;
                this.fileToSave[xindex].documentattachment.attachmentclassificationsubtypekey = item.attachmentclassificationsubtypekey;
                this.fileToSave[xindex].enableOtherTxt = this.returnEnableOtherTxtDataFn(item);
                this.fileToSave[xindex].other = item.other;
                this.fileToSave[xindex].documentattachment.assessmenttemplateid = this.assessmentTemplateID;
            });
            const AttachValidate = this.fileToSave.filter((wer) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey);
            if (AttachValidate.length === 0) {
                this._service.endpointUrl = NewUrlConfig.EndPoint.Intake.SaveAttachmentUrl;
                this._service.createArrayList(this.fileToSave).subscribe(
                    (response: any[]) => {
                        response.forEach((item, index) => {
                            const docProp = response.filter((docId) => docId.Documentattachment);
                            this.fileToSaveResponseIfFn(docProp, item, index);
                        });
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            } else {
                // tslint:disable-next-line:quotemark
                this._alertService.error('Please fill all mandatory fields');
                this.uploadedFile.forEach((item) => {
                    this.attachValidateElseCondFn(item);
                });
            }
        }
    }

    private attachValidateElseCondFn(item: any) {
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
    }

    private fileToSaveResponseIfFn(docProp: Attachment[], item: Attachment, index: number) {
        if (docProp.length === 0) {
            this._alertService.success('Attachment(s) added successfully!');
            this.attachment.emit('all');
            (<any>$('#upload-attachment')).modal('hide'); // NOSONAR
            (<any>$('#upload-scanner-attachment')).modal('hide'); // NOSONAR
            this.fileToSave = [];
            this.uploadedFile = [];
            this.dynamoScanReset();
        }
        if (item.Documentattachment) {
            const attPos = index + 1;
            this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
        } else if (!item.documentpropertiesid) {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    }

    private returnEnableOtherTxtDataFn(item: any): any {
        return item.enableOtherTxt ? true : false;
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
                for(const element of this.attachmentClassificationtypelookup){
                    if(element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0 ){
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
                    )
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

    /*Dynamo Soft Implementation */
   wObject = Dynamsoft.DWT.GetWebTwain('dwtcontrolContainer');
    //     const bSelected = this.dwObject.SelectSource();
    //     if (bSelected) {
    //       const onAcquireImageSuccess = () => { this.dwObject.CloseSource(); };
    //       const onAcquireImageFailure = onAcquireImageSuccess;
    //       this.dwObject.OpenSource();
    //       this.dwObject.AcquireImage({}, onAcquireImageSuccess, onAcquireImageFailure);
    //     }
    //   }
    //   onSubmit(scanFileForm: NgForm) {
    //        if (scanFileForm.valid) {
    //       console.log(scanFileForm.controls.fileName.value);
    //       this.fileName = scanFileForm.controls.fileName.value;
    //       console.log("fileName::"   + this.fileName);
    //       this.upLoad();
    //       // ...our form is valid, we can submit the data
    //     }
    //   } // acquireImage1(): void {
    //     this.d
    acquireImage(): void {
        this.dwObject = Dynamsoft.DWT.GetWebTwain('dwtcontrolContainer');
        this.dwObject.RegisterEvent('OnTopImageInTheViewChanged', this.Dynamsoft_OnTopImageInTheViewChanged);
        this.dwObject.RegisterEvent('OnMouseClick', this.Dynamsoft_OnMouseClick);
        this.dwObject.RegisterEvent('OnPostTransfer', this.Dynamsoft_OnPostTransfer);
        this.dwObject.RegisterEvent('OnPostLoad', this.Dynamsoft_OnPostLoadfunction);
        this.dwObject.RegisterEvent('OnPostAllTransfers', this.Dynamsoft_OnPostAllTransfers);
        this.dwObject.RegisterEvent('OnImageAreaSelected', this.Dynamsoft_OnImageAreaSelected);
        this.dwObject.RegisterEvent('OnImageAreaDeSelected', this.Dynamsoft_OnImageAreaDeselected);
        this.dwObject.RegisterEvent('OnGetFilePath', this.Dynamsoft_OnGetFilePath);
        const bSelected = this.dwObject.SelectSource();
        if (bSelected) {
            const onAcquireImageSuccess = () => {
                this.isFileScanned = true;
                this.disableScanBtn = true;
            };
            const onAcquireImageFailure = onAcquireImageSuccess;
            this.dwObject.OpenSource();
            this.dwObject.AcquireImage({}, onAcquireImageSuccess, onAcquireImageFailure);
        }
    }

    uploadScannedFile(file: File | FileError): void {
        if (!(file instanceof Array)) {
            return;
        }
        file.map((item, index) => {
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
                this.uploadAttachment(index);
                const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
                const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
                if ( audio_ext.indexOf(fileExt) >= 0){
                    this.uploadedFile[index].attachmenttypekey = 'Audio';
                } else if ( video_ext.indexOf(fileExt) >= 0){
                    this.uploadedFile[index].attachmenttypekey = 'Video';
                } else {
                    this.uploadedFile[index].attachmenttypekey = 'Document';
                }
                this.isAttachType = this.uploadedFile[index].attachmenttypekey;
            } else {
                this._alertService.error(fileExt + ' format can\'t be uploaded');
            }
        });
    }

    scanDocuments() {
        this.isAttachDetail = true;
        const scanDocs: any[] = [];
        const len = this.dwObject.HowManyImagesInBuffer;
        if (len === 0) {
            scanDocs.push(0);
        } else {
            for (let i = 0; i < len; i++) {
                scanDocs.push(i);
            }
        }
        this.dwObject.ConvertToBlob(scanDocs, EnumDWT_ImageType.IT_PDF, (res: any) => {
            this.updatePageInfo();
            const fileName = FileUtils.getFileName('pdf');
            const fileObject = new File([res], fileName, {
                type: 'application/pdf'
            });
            this.uploadScannedFile(fileObject);
            this.uploadedFile.push(fileObject);
            this.uploadAttachment(0);
        }, (_num: any, _err: any) => {
        });
    }


    private createJsonBlob<T>(content: T) {
        return new Blob([JSON.stringify(content)], { type: 'application/json' });
    }
    public blobToFile(theBlob: Blob, fileName: string): File {
        const b: any = theBlob;
        b.lastModifiedDate = new Date();
        b.name = fileName;
        return <File>b;
    }
    upLoad() {
        this.dwObject.ConvertToBlob([0], Dynamsoft.DWT.EnumDWT_ImageType.IT_PDF, (_res: any) => {
            // No data to add
        }, (_num: any, _err: any) => {
        });
    }

    checkIfImagesInBuffer() {
        if (this.dwObject !== undefined) {
            if (this.dwObject.HowManyImagesInBuffer === 0) {
                return false;
            } else {
                return true;
            }
        }
    }

    updatePageInfo() {
        if (document.getElementById('DW_TotalImage')) {
            (<HTMLInputElement>document.getElementById('DW_TotalImage')).value = this.dwObject.HowManyImagesInBuffer + '';
        }
        const currImgIndex: number = this.dwObject.CurrentImageIndexInBuffer + 1;
        if (document.getElementById('DW_CurrentImage')) {
            (<HTMLInputElement>document.getElementById('DW_CurrentImage')).value = currImgIndex + '';
        }
    }
    // ************************** Edit Image ******************************
    btnShowImageEditor_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.ShowImageEditor();
    }

    btnRotateLeft_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.RotateLeft(this.dwObject.CurrentImageIndexInBuffer);
    }

    btnRotateRight_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.RotateRight(this.dwObject.CurrentImageIndexInBuffer);
    }

    btnRotate180_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.Rotate(this.dwObject.CurrentImageIndexInBuffer, 180, true);
    }

    btnMirror_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.Mirror(this.dwObject.CurrentImageIndexInBuffer);
    }

    btnFlip_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.Flip(this.dwObject.CurrentImageIndexInBuffer);
    }

    btnRemoveCurrentImage_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.RemoveAllSelectedImages();
        if (this.dwObject.HowManyImagesInBuffer === 0) {
            if (document.getElementById('DW_TotalImage')) {
                (<HTMLInputElement>document.getElementById('DW_TotalImage')).value = this.dwObject.HowManyImagesInBuffer + '';
                this.isFileScanned = false;
            }
            if (document.getElementById('DW_CurrentImage')) {
                (<HTMLInputElement>document.getElementById('DW_CurrentImage')).value = 0 + '';
            }
        } else {
            this.updatePageInfo();
        }
    }

    dynamoScanReset() {
        this.btnRemoveCurrentImage_onclick();
        this.isAttachDetail = false;
        this.uploadedFile = [];

    }

    btnRemoveAllImages_onclick() {
        this.isAttachDetail = false;
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.RemoveAllImages();
        this.isFileScanned = false;
        if (document.getElementById('DW_TotalImage')) {
            (<HTMLInputElement>document.getElementById('DW_TotalImage')).value = 0 + '';
        }
        if (document.getElementById('DW_CurrentImage')) {
            (<HTMLInputElement>document.getElementById('DW_CurrentImage')).value = 0 + '';
        }
    }
    /*----------------Change Image Size--------------------*/
    btnChangeImageSize_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        if (this.dwObject !== undefined) {
            this.showDialog = true;
            this.img_width = this.dwObject.GetImageWidth(this.dwObject.CurrentImageIndexInBuffer) + '';
            this.img_height = this.dwObject.GetImageHeight(this.dwObject.CurrentImageIndexInBuffer) + '';
        } else {
            alert('Please scan a document');
            this.showDialog = false;
        }
    }

    btnChangeImageSizeOK_onclick(_changeImageSizeForm: NgForm) {
        this.dwObject.ChangeImageSize(this.dwObject.CurrentImageIndexInBuffer, parseInt(this.img_width), parseInt(this.img_height), this.selectedInterpolation);
        this.showDialog = false;
    }

    selectInterpolcationChangeHandler(event: any) {
        this.selectedInterpolation = event.target.value;
    }

    /*----------------Crop Image--------------------*/
    btnCrop_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        
        if (this._iLeft !== 0 || this._iTop !== 0 || this._iRight !== 0 || this._iBottom !== 0) {
            this.dwObject.Crop(
                this.dwObject.CurrentImageIndexInBuffer,
                this._iLeft, this._iTop, this._iRight, this._iBottom
            );
            this._iLeft = 0;
            this._iTop = 0;
            this._iRight = 0;
            this._iBottom = 0;
        } else {
            alert('Please select the area you\'d like to crop');
        }
    }

    /* Navigator Dynamo Soft*/
    setlPreviewMode() {
        let varNum = (<HTMLSelectElement>document.getElementById('DW_PreviewMode')).selectedIndex;
        varNum = varNum + 1;
        const btnCrop1 = (<HTMLImageElement>document.getElementById('btnCrop'));
        if (btnCrop1) {
            let tmpstr = btnCrop1.src;
            if (varNum > 1) {
                tmpstr = tmpstr.replace('Crop.', 'Crop_gray.');
                btnCrop1.src = tmpstr;
                btnCrop1.onclick = function () {
                    // No content to add or call
                };
            } else {
                tmpstr = tmpstr.replace('Crop_gray.', 'Crop.');
                btnCrop1.src = tmpstr;
                btnCrop1.onclick = () => {
                    this.btnCrop_onclick();
                };
            }
        }
        this.dwObject.SetViewMode(varNum, varNum);
        if (Dynamsoft.Lib.env.bMac || Dynamsoft.Lib.env.bLinux) {
            return;
        } else if (this.DW_PreviewMode.selectedIndex !== 0) {
            this.dwObject.MouseShape = true;
        } else {
            this.dwObject.MouseShape = false;
        }
    }

    private Dynamsoft_OnMouseClick = (_index: any) => {
        this.updatePageInfo();
    };

    private Dynamsoft_OnPostTransfer = () => {
        this.updatePageInfo();
    };

    private Dynamsoft_OnPostLoadfunction = (_path: any, _name: any, _type: any) => {
        this.updatePageInfo();
    };

    private Dynamsoft_OnPostAllTransfers = () => {
        if (this.dwObject !== undefined) {
            this.dwObject.CloseSource();
        }
        this.updatePageInfo();
    };

    private Dynamsoft_OnTopImageInTheViewChanged = (index: any) => {
        this._iLeft = 0;
        this._iTop = 0;
        this._iRight = 0;
        this._iBottom = 0;
        this.dwObject.CurrentImageIndexInBuffer = index;
        this.updatePageInfo();
    };

    private Dynamsoft_OnImageAreaSelected = (_index: any, left: any, top: any, right: any, bottom: any) => {
        this._iLeft = left;
        this._iTop = top;
        this._iRight = right;
        this._iBottom = bottom;
    };

    private Dynamsoft_OnImageAreaDeselected = (_index: any) => {
        this._iLeft = 0;
        this._iTop = 0;
        this._iRight = 0;
        this._iBottom = 0;
    };

    private Dynamsoft_OnGetFilePath = (_bSave: any, _count: any, _index: any, _path: any, _name: any) => {
        // No content to add or call
    };


    btnFirstImage_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.CurrentImageIndexInBuffer = 0;
        this.updatePageInfo();
    }

    btnLastImage_onclick() {
        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        const k: number = this.dwObject.HowManyImagesInBuffer - 1;
        this.dwObject.CurrentImageIndexInBuffer = k;
        this.updatePageInfo();
    }
    btnPreImage_onclick() {
        this.dwObject.CurrentImageIndexInBuffer = this.dwObject.CurrentImageIndexInBuffer - 1;
        this.updatePageInfo();
    }

    btnNextImage_onclick() {
        let j: number = 0;
        if (this.dwObject !== undefined) {
            j = this.dwObject.CurrentImageIndexInBuffer;
        }

        if (!this.checkIfImagesInBuffer()) {
            return;
        }
        this.dwObject.CurrentImageIndexInBuffer = j + 1;
        this.updatePageInfo();
    }

    btnPreImage_wheel() {
        if (this.dwObject.HowManyImagesInBuffer !== 0) {
            this.btnPreImage_onclick();
        }
    }
    btnNextImage_wheel() {
        if (this.dwObject.HowManyImagesInBuffer !== 0) {
            this.btnNextImage_onclick();
        }
    }

    switchInfo() {
        this.showInfo = !this.showInfo;
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
                for (const element of item) {
                    if(element.parentkey === null ){
                        this.attachmentDropDownList_parent.push(element);
                    }else{
                        this.attachmentDropDownList_child.push(element);
                    }
                }
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
        return this.seletedVal;
    }

    titleUpdate($event: any, i: any) {
        // No data or function to call 
    }

    onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}