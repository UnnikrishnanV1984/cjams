
import {map, pluck, share} from 'rxjs/operators';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin ,  Observable } from 'rxjs';

import { AppUser } from '../../../../@core/entities/authDataModel';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX } from '../../../../@core/entities/constants';
import { AlertService, AuthService } from '../../../../@core/services';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { NewUrlConfig } from '../../newintake-url.config';
import { Attachment, AttachmentUpload } from '../_entities/attachment.data.models';

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
    attachmentDetail: FormGroup;
    //attachmentClassificationTypeDropDown$: Observable<DropdownModel[]>;
    attachmentTypeDropdown$: Observable<DropdownModel[]>;
    attachmentClassificationtypelookup = [];
    attachmentClassificationtype = [];
    attachmentClassificationsubtype = [];
    from_type= '';
    isAttachType = '';
    isCate = '';
    issubCate='';
    @Output() modalDismiss = new EventEmitter();
    private token: AppUser;
    isCW: boolean;
    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private _service: GenericService<Attachment>,
        private _dropDownService: CommonHttpService,
        private _authService: AuthService,
        private _alertService: AlertService
    ) {
        this.id = route.snapshot.parent.parent.parent.parent.parent.params['id'];
        this.daNumber = route.snapshot.parent.parent.parent.parent.parent.params['daNumber'];
        this.token = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.isCW = this._authService.isCW();
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
                //administration: ['', Validators.required],
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
    isdisabled(value){
        let disabled;
        if(this.from_type=="camera" && (value=="Audio" || value=="Video")){
            disabled=true;
        }else if((this.from_type=="video" && value!="Video") || (this.from_type=="audio" && value!="Audio")) {
            disabled=true;
        }else{
            disabled = false;
        }
        return disabled;
    }
    isselected(value){
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
            NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
        )
        .subscribe(data => {
            const dp_att_arr = [];
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
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl
            ),
            // this._dropDownService.getArrayList(
            //     {
            //         nolimit: true
            //     },
            //     NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl
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
    setAttachmentType(filetype){
        if(filetype == 'camera'){
            this.from_type='camera';
        }else if(filetype == 'video'){
            this.from_type='video';
            this.attachmentDetail.patchValue({documentattachment:{attachmenttypekey: 'Video'}});
            this.isAttachType='Video';
        }else if(filetype == 'audio'){
            this.from_type='audio';
            this.attachmentDetail.patchValue({documentattachment:{attachmenttypekey: 'Audio'}});
            this.isAttachType='Audio';
        }
    }
    // AdministrationUpdate(event) {
    //     console.log('event', event);
    //     if (event.target.value !== '')  {
    //         console.log('admin');
    //         this.isAdministration  = event.target.value;
    //     }
    // }

    categoryUpdate(event) {
        if (event.target.value !== '')  {
            this.isCate  = event.target.value;
            this.issubCate  = '';
            this.attachmentDetail.patchValue({documentattachment:{attachmentclassificationsubtypekey: ''}});
            this.attachmentClassificationsubtype = [];
            for (const element of this.attachmentClassificationtypelookup){
                if(element.typedescription==this.isCate){
                    this.attachmentClassificationsubtype.push({subcategory:element.subcategory});
                }
            } 
        }
    }
    subcategoryUpdate(event) {
        if (event.target.value !== '')  {
            this.issubCate  = event.target.value;
        }
    }
    typeUpdate(event) {
        if (event.target.value !== '')  {
            this.isAttachType  = event.target.value;
        }
    }

    // SiteUpdate(event, index) {
    //     if (event.value !== '') {
    //         this.isSite = event.target.value;
    //     }
    // }
    patchAttachmentDetail(fileInfo: AttachmentUpload) {
        this.attachmentDetail.patchValue({
            filename: fileInfo.filename,
            mime: fileInfo.mime,
            numberofbytes: fileInfo.numberofbytes,
            s3bucketpathname: fileInfo.s3bucketpathname
        });
    }
    saveAttachmentDetails() {
        this.router.routeReuseStrategy.shouldReuseRoute = function() {
            return false;
        };
        const attachmentDetail = [];
        attachmentDetail.push(this.attachmentDetail.value);
        this._service.endpointUrl = NewUrlConfig.EndPoint.DSDSAction.Attachment.SaveAttachmentUrl;
      //  this._service.create(this.attachmentDetail.value).subscribe(

        this._service.createArrayList(attachmentDetail).subscribe(
            (response) => {
                if (response[0] && response[0].documentpropertiesid) {
                    this._alertService.success('Attachment added successfully!');
                    this.modalDismiss.emit();
                    const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/attachment';
                    // this.router.navigateByUrl(currentUrl).then(() => {
                      //  this.router.navigated = false;
                        this.router.navigate([currentUrl]);
                    // });
                } else if (response[0] && response[0].Documentattachment) {
                    this._alertService.error(response[0].Documentattachment);
                } else {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            },
            (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
}
