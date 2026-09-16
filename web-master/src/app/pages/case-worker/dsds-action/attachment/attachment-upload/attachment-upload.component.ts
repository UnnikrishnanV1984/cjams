
import { map, pluck, share } from 'rxjs/operators';
import { HttpHeaders } from '@angular/common/http';
import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FileError, NgxfUploaderService } from 'ngxf-uploader';
import { forkJoin ,  Observable } from 'rxjs';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService, DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { AppConfig } from '../../../../../app.config';
import { AttachmentUpload } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Attachment } from '../_entities/attachment.data.models';
import { config } from '../../../../../../environments/config';
import { DsdsService } from '../../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
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
    issubCate= '';
    attachmenttype= 'case';
    personid= '';
    isServiceCase = false;
    isCW!: boolean;
    isAdoptionCase!: boolean;
    showInfo = true;
    maxDocumentDate : any;
    uploadpopupid = '#upload-attachment';
    @ViewChild(MatMenuTrigger) trigger!: MatMenuTrigger;
    private route: ActivatedRoute;
    private router: Router;
    private _dropDownService: CommonHttpService;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _service: GenericService<Attachment>;
    private _dsdsService: DsdsService;

    constructor(private injector : Injector, private _uploadService: NgxfUploaderService) {
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.router = this.injector.get<Router>(Router);
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._service = this.injector.get<GenericService<Attachment>>(GenericService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.token = this._authService.getCurrentUser();
        if (this.route.snapshot.params) {
            this.attachmenttype = this.route.snapshot.params['attachmenttype'] || 'case';
            this.personid = this.route.snapshot.params['personid'] || '';
        }
    }

    ngOnInit() {
        this.maxDocumentDate = new Date();
        this.isCW = this._authService.isCW();
        this.loadDropdown();
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.isAdoptionCase = this.storage.getItem('CASE_TYPE') == "ADOPTION";
        this.curDate = new Date();
        $(this.uploadpopupid).modal('show');
        this.loadAttachmentDropDown();
    }

    uploadFile(file: any): void {
        if (!(file instanceof Array)) {
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
                }
                else{
                    this._alertService.error("Uploaded file size "+ size+ " exceeds the maximum file size limit of"+Math.floor(config.uploadMaxSizeLimit/1048576)+"MB.");
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
        const _self = this;
        const isDataFilled =  setInterval(function() {
                if (_self.isAttachType !== '' && _self.isCate !== ''  &&  _self.issubCate !== ''  ) {
                    clearInterval(isDataFilled);
                    _self.processResponseData(index);
                }
          }, 1000);
    }

    processResponseData(index: any) {
        let uploadUrl = '';
        const typeCheck = this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
        const objecttypekey = this.isAdoptionCase ? 'Adoptioncase' : typeCheck;                      
        const dynam  = this.isAttachType + '|' + this.isCate + '|' + this.issubCate ;
        uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl 
            + '?srno=' + this.daNumber + '&' + 'docsInfo=' + dynam + '&attachmenttype=' + this.attachmenttype + '&personid=' + this.personid + '&objecttypekey=' + objecttypekey;           

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
                    if (response.status === 1 && response.data) {
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
                        //@Simar this is experimental
                        this.fileToSave[this.fileToSave.length - 1].index = index;
                    }

                }, (err) => {
                        console.error(err);
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                        this.uploadedFile.splice(index, 1);
                    }
                );
    }
    deleteUpload(index: any) {
        this.uploadedFile.splice(index, 1);
        this.fileToSave.splice(index, 1);
    }
    clearAllUpload() {
        $(this.uploadpopupid).modal('hide');
        this.uploadedFile = [];
        this.fileToSave = [];
        let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
        if (this.attachmenttype === 'person') {
            currentUrl = currentUrl + '/person';
        }
        this.router.navigateByUrl(currentUrl).then(() => {
            this.router.navigated = false;
            this.router.navigate([currentUrl]);
        });
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
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                    this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory: element.subcategory});
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
    saveAttachmentDetails() {
        if (this.uploadedFile.length !== this.fileToSave.length) {
            this._alertService.error('Please wait till files get uploaded');
        } else {
            this.uploadedFile.forEach((item, index) => {
                // Getting the correct index by matching the filename ,as values in uploadedFile and fileToSave are not matching sequencially
                // const xindex = this.fileToSave.findIndex( data => data.originalfilename === this.uploadedFile[index].name);
                // @Simar this is experimental
                const xindex = this.fileToSave.findIndex( data => data.index === index);
                this.fileToSave[xindex].servicerequestid = this.isServiceCase ? null : this.id;
                this.fileToSave[xindex].servicecaseid = this.isServiceCase ? this.id : null;
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
            // const AttachValidate = this.fileToSave.filter((wer) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey  || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey /*|| !wer.documentattachment.administration  || !wer.documentattachment.site */ );
            // if (AttachValidate.length === 0) {
            //     this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            //     this._service.createArrayList(this.fileToSave).subscribe(
            //         (response) => {
            //             response.map((item, index) => {
            //                 if (item.documentpropertiesid) {
            //                     response.splice(index, 1);
            //                     this.fileToSave.splice(index, 1);
            //                     this.uploadedFile.splice(index, 1);
            //                 }
            //                 const docProp = response.filter((docId) => docId.Documentattachment);
            //                 if (docProp.length === 0) {
            //                     this._alertService.success('Attachment(s) added successfully!');
            //                     (<any>$(this.uploadpopupid)).modal('hide');
            //                     this.fileToSave = [];
            //                     this.uploadedFile = [];
            //                     this.router.routeReuseStrategy.shouldReuseRoute = function() {
            //                         return false;
            //                     };
            //                     let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
            //                     if (this.attachmenttype === 'person') {
            //                         currentUrl = currentUrl + '/person';
            //                     }
            //                     // this.router.navigateByUrl(currentUrl).then(() => {
            //                         // this.router.navigated = false;
            //                         this.router.navigate([currentUrl]);
            //                     // });
            //                 }
            //                 if (item.Documentattachment) {
            //                     const attPos = index + 1;
            //                     this._alertService.error(item.Documentattachment + ' for Attachment ' + attPos);
            //                 } else if (!item.documentpropertiesid) {
            //                     this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            //                 }
            //             });
            //         },
            //         (error) => {
            //             this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            //         }
            //     );
            // } else {
            //     // tslint:disable-next-line:quotemark
            //     this._alertService.error('Please fill all mandatory fields');
            //     this.uploadedFile.map((item) => {
            //         // if (!item.title) {
            //         //     item.invalidTitle = true;
            //         // } else {
            //         //     item.invalidTitle = false;
            //         // }
            //         if (!item.attachmentclassificationtypekey) {
            //             item.invalidAttachmentClassify = true;
            //         } else {
            //             item.invalidAttachmentClassify = false;
            //         }
            //         if (!item.attachmenttypekey) {
            //             item.invalidAttachmentType = true;
            //         } else {
            //             item.invalidAttachmentType = false;
            //         }
            //         if (!item.attachmentclassificationsubtypekey) {
            //             item.invalidAttachmentsubClassify = true;
            //         } else {
            //             item.invalidAttachmentsubClassify = false;
            //         }
            //     });
            // }
        }
    }

    validateAttachment() {
        const AttachValidate = this.fileToSave.filter((wer) => (!wer.other && wer.enableOtherTxt) || !wer.documentattachment.attachmentclassificationtypekey || !wer.documentattachment.attachmenttypekey || !wer.actualdocumentdate || !wer.documentattachment.attachmentclassificationsubtypekey /*|| !wer.documentattachment.administration  || !wer.documentattachment.site */);
        if (AttachValidate.length === 0) {
            this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
            this._service.createArrayList(this.fileToSave).subscribe((response: any) => {
                    response.map((item: any, index: any) => {
                        if (item.documentpropertiesid) {
                            response.splice(index, 1);
                            this.fileToSave.splice(index, 1);
                            this.uploadedFile.splice(index, 1);
                        }
                        // const docProp = response.filter((docId) => docId.Documentattachment);
                        // if (docProp.length === 0) {
                        //     this._alertService.success('Attachment(s) added successfully!');
                        //     (<any>$(this.uploadpopupid)).modal('hide');
                        //     this.fileToSave = [];
                        //     this.uploadedFile = [];
                        //     this.router.routeReuseStrategy.shouldReuseRoute = function () {
                        //         return false;
                        //     };
                        //     let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
                        //     if (this.attachmenttype === 'person') {
                        //         currentUrl = currentUrl + '/person';
                        //     }
                        //     this.router.navigate([currentUrl]);
                        // }
                        this.attachmentSuccess(response);
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
        } else {
            this.mandatoryFieldsError();
        }
    }

    attachmentSuccess(response: any) {
        const docProp = response.filter((docId: { Documentattachment: any; }) => docId.Documentattachment);
        if (docProp.length === 0) {
            this._alertService.success('Attachment(s) added successfully!');
            $(this.uploadpopupid).modal('hide');
            this.fileToSave = [];
            this.uploadedFile = [];
            this.router.routeReuseStrategy.shouldReuseRoute = function () {
                return false;
            };
            let currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
            if (this.attachmenttype === 'person') {
                currentUrl = currentUrl + '/person';
            }
            this.router.navigate([currentUrl]);
        }
    }

    mandatoryFieldsError() {
        // tslint:disable-next-line:quotemark
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
                this.setattachmentClassificationtype();
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

    setattachmentClassificationtype() {
        const dp_att_arr: any[] = [];
        for (const element of this.attachmentClassificationtypelookup) {
            if (element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0) {
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

    openSubMenu(event: any, index: any) {
        if (event !== '')  {
            this.isCate  = event;
        }
        this.issubCate  = '';
        this.uploadedFile[index].attachmentclassificationsubtypekey = '';
        this.uploadedFile[index].attachmentClassificationsubtype = [];
        this.uploadedFile[index].attachmentclassificationtypekey = event;
        if (event) {
            this.uploadedFile[index].invalidAttachmentClassify = false;
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.uploadedFile[index].attachmentclassificationtypekey) {
                    this.uploadedFile[index].attachmentClassificationsubtype.push({subcategory: element.subcategory});
                }
            }
        } else {
            this.uploadedFile[index].invalidAttachmentClassify = true;
        }
    }

    
    switchInfo() {
        this.showInfo = !this.showInfo;
    }

    closePopover(element: any) {
        element.hide();
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