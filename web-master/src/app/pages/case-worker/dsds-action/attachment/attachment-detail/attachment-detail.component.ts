
import {map, pluck, share} from 'rxjs/operators';
import { Component, EventEmitter, Injector, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin,  Observable } from 'rxjs';

import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../../@core/entities/constants';
import { AlertService, AuthService, DataStoreService } from '../../../../../@core/services';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { GenericService } from '../../../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { Attachment } from '../_entities/attachment.data.models';
import { AttachmentUpload } from '../../../_entities/caseworker.data.model';
import { DsdsService } from '../../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment-detail',
    templateUrl: './attachment-detail.component.html',
    styleUrls: ['./attachment-detail.component.scss'],
    standalone: false
})
export class AttachmentDetailComponent implements OnInit {
    daNumber: string;
    id: string;
    attachmentDetail!: FormGroup;
    // attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup: any[]  = [];
    attachmentClassificationtype: any[]  = [];
    attachmentClassificationsubtype: any[]  = [];
    from_type= '';
    isAttachType = '';
    isCate = '';
    issubCate= '';
    @Output() modalDismiss = new EventEmitter();
    private token: AppUser;
    isServiceCase = false;
    personid= '';
    attachment_type= 'case';
    isCW!: boolean;
    private readonly _dropDownService: CommonHttpService;
    private readonly _authService: AuthService;
    private readonly _alertService: AlertService;
    private readonly _dsdsService: DsdsService;
    private readonly _dataStoreService: DataStoreService;

    constructor(
        private readonly formBuilder: FormBuilder,
        private readonly route: ActivatedRoute,
        private readonly router: Router,
        private readonly _service: GenericService<Attachment>,
        private readonly injector : Injector
    ) {
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);

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
            filename: [''],
            title: ['', [Validators.required, Validators.minLength(4), REGEX.NOT_EMPTY_VALIDATOR]],
            documentdate: new Date(),
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
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
                insertedby: [this.token.user.userprofile.displayname],
                note: [''],
                updatedby: [this.token.user.userprofile.displayname],
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
            insertedby: this.token.user.userprofile.displayname,
            updatedby: this.token.user.userprofile.displayname
        });
    }
    loadData() {
        this.isAttachType = '';
        this.isCate = '';
        this.issubCate = '';
        const _self = this;
        const isDataFilled =  setInterval(function() {
            if (_self.isAttachType !== '' &&  _self.isCate !== ''  && _self.issubCate !== '' ) {
                clearInterval(isDataFilled);
                const dynam  =  _self.isAttachType + '|' + _self.isCate + '|' + _self.issubCate;
                window.sessionStorage.setItem('loadedData', dynam);
                window.sessionStorage.setItem('dataLoad', 'true');
            }
          }, 1000);
    }
    isdisabled(value: any) {
        let disabled = false;
        if (this.checkAndReturnFormTypeFn(value)){
            disabled=true;
        }
        return disabled;
    }
    private checkAndReturnFormTypeFn(value: any) {
        return (
          this.checkAndReturnIfCameraFn(value) ||
          this.checkAndReturnIfVideoFn(value) ||
          this.checkAndReturnIfAudioFn(value)
        );
    }

    private checkAndReturnIfAudioFn(value: any): boolean {
        return this.from_type == 'audio' && value != 'Audio';
    }

    private checkAndReturnIfVideoFn(value: any): boolean {
        return this.from_type == 'video' && value != 'Video';
    }

    private checkAndReturnIfCameraFn(value: any) {
        return this.from_type == 'camera' && (value == 'Audio' || value == 'Video');
    }

    isselected(value: any){
        if(this.from_type=="video" && value=="Video"){
            return true
        }else if(this.from_type=="audio" && value=="Audio"){
            return true;
        }else {
            return false;
        }
    }
    patchFrmData() {
        this.attachmentDetail = this.formBuilder.group({
            filename: [''],
            title: ['', [Validators.required, Validators.minLength(4), REGEX.NOT_EMPTY_VALIDATOR]],
            documentdate: new Date(),
            description: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
            documentattachment: this.formBuilder.group({
                attachmenttypekey: [this.isAttachType , Validators.required],
                attachmentclassificationtypekey: [this.isCate, Validators.required],
                attachmentclassificationsubtypekey: [this.issubCate, Validators.required],
                attachmentdate: new Date(),
                sourceauthor: [''],
                attachmentsubject: [''],
                sourceposition: [''],
                attachmentpurpose: [''],
                sourcephonenumber: [''],
                acquisitionmethod: [''],
                sourceaddress: [''],
                locationoforiginal: [''],
                insertedby: [this.token.user.userprofile.displayname],
                note: [''],
                updatedby: [this.token.user.userprofile.displayname],
                activeflag: 1
            }),
            objecttypekey: ['ServiceRequest'],
            objectid: [this.id],
            mime: [''],
            numberofbytes: [''],
            s3bucketpathname: [''],
            activeflag: [1],
            rootobjectid: [this.id],
            rootobjecttypekey: ['ServiceRequest'],
            insertedby: this.token.user.userprofile.displayname,
            updatedby: this.token.user.userprofile.displayname
        });
    }
    loadDropdown() {

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
        const source = forkJoin([
            this._dropDownService.getArrayList(
                {
                    nolimit: true,
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
            )
            // this._dropDownService.getArrayList(
            //     {
            //         nolimit: true
            //     },
            //     CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl
            // )
        ]
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

    setattachmentClassificationtype(){
        const dp_att_arr: any = [];
        for(const element of this.attachmentClassificationtypelookup){
            if(element.typedescription && dp_att_arr.indexOf(element.typedescription) < 0 ){
                if (this.isCW) {
                    if (element.typedescription.startsWith('CW-')) {
                        this.attachmentClassificationtype.push({typedescription: element.typedescription});
                        dp_att_arr.push(element.typedescription);
                    }
                } else {
                    this.attachmentClassificationtype.push({typedescription:element.typedescription});
                    dp_att_arr.push(element.typedescription);
                }
            }
        }
    }
    

    // JudistrictionUpdate(event) {
    //     const attachmentDetail = [];
    //      if (event.value !== '')  {
    //         console.log('juris');
    //         this.isJudistriction  = event.target.value;
    //     }
    //     var judistriction = this.attachmentDetail.value.documentattachment.judistriction;
    //     this.attachmentDetail.patchValue({documentattachment:{site: ''}});
    //     if (judistriction) {
    //         this.site=[];
    //         for(var i=0;i<this.judistriction_details.length;i++){
    //             if(this.judistriction_details[i].judistriction==judistriction){
    //                 this.site.push({site:this.judistriction_details[i].site});
    //             }
    //         }
    //     }
    // }
    setAttachmentType(filetype: any){
        if(filetype == 'camera'){
            this.from_type='camera';
        }else if(filetype == 'video'){
            this.from_type='video';
            this.attachmentDetail.patchValue({documentattachment:{attachmenttypekey: 'Video'}});
            this.isAttachType='Video';
        }else if(filetype == 'audio'){
            this.from_type='audio';
            this.attachmentDetail.patchValue({documentattachment:{attachmenttypekey: 'Audio'}});
            this.isAttachType = 'Audio';
        }
    }
    // AdministrationUpdate(event) {
    //     console.log('event', event);
    //     if (event.target.value !== '')  {
    //         console.log('admin');
    //         this.isAdministration  = event.target.value;
    //     }
    // }

    categoryUpdate(event: any) {
        if (event.target.value !== '')  {
            this.isCate  = event.target.value;
            this.issubCate  = '';
            this.attachmentDetail.patchValue({documentattachment: {attachmentclassificationsubtypekey: ''}});
            this.attachmentClassificationsubtype = [];
            for (const element of this.attachmentClassificationtypelookup) {
                if (element.typedescription === this.isCate) {
                    this.attachmentClassificationsubtype.push({subcategory: element.subcategory});
                }
            }
        }
    }
    subcategoryUpdate(event: any) {
        if (event.target.value !== '')  {
            this.issubCate  = event.target.value;
        }
    }
    typeUpdate(event: any) {
        if (event.target.value !== '')  {
            this.isAttachType  = event.target.value;
        }
    }

    // SiteUpdate(event, index) {
    //     if (event.value !== '') {
    //         this.isSite = event.target.value;
    //     }
    // }
    patchAttachmentDetail(fileInfo: AttachmentUpload, attachment_type= 'case', personid= '') {
        this.personid = personid;
        this.attachment_type  = attachment_type;
        this.attachmentDetail.patchValue({
            filename: fileInfo.filename,
            mime: fileInfo.mime,
            numberofbytes: fileInfo.numberofbytes,
            s3bucketpathname: fileInfo.s3bucketpathname,
         //   personid: fileInfo.personid,
          //  attachmenttype: fileInfo.attachmenttype
        });
    }
    saveAttachmentDetails() {
        this.router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const attachmentDetail: any[]  = [];
        attachmentDetail.push(this.attachmentDetail.value);
        attachmentDetail[0].attachmenttype = this.attachment_type;
        attachmentDetail[0].personid = this.personid;
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
      //  this._service.create(this.attachmentDetail.value).subscribe(

        this._service.createArrayList(attachmentDetail).subscribe((response: any) => {
                if (response[0] && response[0].documentpropertiesid) {
                    this._alertService.success('Attachment added successfully!');
                    this.modalDismiss.emit();
                    var currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
                    if(this.attachment_type=='person') {
                        currentUrl = currentUrl +'/person';
                    }
                    // this.router.navigateByUrl(currentUrl).then(() => {
                      //  this.router.navigated = false;
                        this.router.navigate([currentUrl]);
                    // });
                } else if (response[0] && response[0].Documentattachment) {
                    this._alertService.error(response[0].Documentattachment);
                } else {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            }, (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    getControlByIndexFn(index: string): FormControl {
        return this.attachmentDetail.controls[index] as FormControl;
    }
}
