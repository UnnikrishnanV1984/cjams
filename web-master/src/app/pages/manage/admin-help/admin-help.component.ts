
import {EMPTY,  Observable ,  Subject } from 'rxjs';
import { Component, OnInit, Input } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService} from '../../../../app/@core/services';
import { PaginationInfo, DynamicObject } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES, REGEX} from '../../../@core/entities/constants';
import { AlertService, GenericService, AuthService } from '../../../@core/services';
import {  HelpDocuments } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { AppConfig } from '../../../app.config';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { HttpHeaders } from '@angular/common/http';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AttachmentUpload } from '../../provider-applicant/new-public-applicant/_entities/newApplicantModel';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'admin-help',
    templateUrl: './admin-help.component.html',
    styleUrls: ['./admin-help.component.scss'],
    standalone: false
})
export class AdminHelpComponent implements OnInit {
    addEditLabel!: string;
    saveButton!: boolean;
    helpDocumentsForm: FormGroup;
    helpDocuments$!: Observable<HelpDocuments[]>;
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    helpDocument = new HelpDocuments();
    paginationInfo: PaginationInfo = new PaginationInfo();
    helpDocumentControl!: AbstractControl | null;
    eventIdControl!: AbstractControl | null;
    private pageSubject$ = new Subject<number>();
    private dynamicObject: DynamicObject = {};
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    uploadedFile: any[] = [];
    isAttachType = '';   
    isCate = '';
    issubCate='';
    private token: AppUser;
    attachmentResponse!: AttachmentUpload;
    fileToSave: any = [];
    helpDocumentsList: any[] = [];
    myFileSelected:any;
    @Input()
    intakeNumber!: string;
    deletepopupid = '#delete-popup';
    helpEvents: any[] = [];
    constructor(private formBuilder: FormBuilder, 
        private _service: GenericService<HelpDocuments>, 
        private _alertService: AlertService, 
        private _uploadService: NgxfUploaderService,
        private _authService: AuthService,
        private _commonHttpService: CommonHttpService,) {
    
       
        this.token = this._authService.getCurrentUser();
        
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.getHelpDocuments;
        this.helpDocumentsForm = this.formBuilder.group(
            {
                filename: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                title: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                category: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]],
                subcategory: ['', [Validators.required, REGEX.NOT_EMPTY_VALIDATOR]]
            }
        );
    }

    ngOnInit() {
        this.paginationInfo.sortBy = 'servicerequestincidenttypekey asc';
        this.getPageData();
        this.helpDocumentControl = this.helpDocumentsForm.get(['servicerequestincidenttypekey']);
        this.eventIdControl = this.helpDocumentsForm.get(['datavalue']);
    }
    getPage(){
        this.helpDocuments$ = EMPTY;
    }
    getPageData() {
        this._service.getAll(ManageUrlConfig.EndPoint.Manage.getHelpDocuments).subscribe(result => {
            this.helpDocumentsList = result;
                    });
    }
    saveEvent(helpDocuments: HelpDocuments) {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.saveHelpDocuments;
        if (this.helpDocumentsForm.dirty && this.helpDocumentsForm.valid) {
            this.helpDocument = Object.assign(new HelpDocuments(), helpDocuments);
            this.helpDocument.type = 'save';
            this._service.create(this.helpDocument, this._service.endpointUrl).subscribe(
                (_result: any) => {
                   this._alertService.success('Help Document saved successfully!');
                        this.paginationInfo.sortBy = 'insertedon asc';
                        this.pageStream$.next(1);
                  },
                (_error: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
           
        }
        this.cancelEvent();
    }
    updateEvent(helpDocument: HelpDocuments) {
       this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.saveHelpDocuments;
        if (this.helpDocumentsForm.dirty && this.helpDocumentsForm.valid) {
            if (this.helpDocument.filename) {
                this.helpDocument.filename = helpDocument.filename;
                this.helpDocument.title = helpDocument.title;
                this.helpDocument.category = helpDocument.category;
                this.helpDocument.subcategory = helpDocument.subcategory;
                this.helpDocument.type = 'update';
                this._service.create(this.helpDocument, this._service.endpointUrl).subscribe(
                    (result: any) => {
                        if (result) {
                            this._alertService.success('HelpDocument updated successfully!');
                            this.pageStream$.next(this.paginationInfo.pageNumber);
                            this.cancelEvent();
                        }
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
            }
        }
        this.cancelEvent();
    }
    editEvent(helpDocuments: HelpDocuments) {       
        this.saveButton = true;
        this.showAddEdit('Edit');
        this.helpDocument = Object.assign({}, helpDocuments);

        this.helpDocumentsForm.patchValue({
            filename: this.helpDocument.filename,
            title: this.helpDocument.title,
            category: this.helpDocument.category,
            subcategory: this.helpDocument.subcategory            
        });
        this.helpDocumentControl?.disable();
        this.eventIdControl?.disable();
        this.helpDocumentsForm.value.effectivedate = new Date();
    }
    deleteEvent() {
        this._service.endpointUrl = ManageUrlConfig.EndPoint.Manage.deleteHelpDocuments;
        this._service.remove(this.helpDocument.helpdocumentsid, this._service.endpointUrl).subscribe(
            (result: any) => {
                if (result) {
                    this._alertService.success('HelpDocument deleted successfully!');
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide'); /* //NOSONAR */
                }
            },
            (_error: any) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
        this.helpDocumentsForm.reset();
        this.helpDocumentControl?.enable();
        this.eventIdControl?.enable();
    }

    declineDelete() {
        $(this.deletepopupid).modal('hide'); /* //NOSONAR */
    }
    confirmDelete(helpDocument: HelpDocuments) {
        this.helpDocument = helpDocument;
        $(this.deletepopupid).modal('show'); /* //NOSONAR */
        this.cancelEvent();
    }
    cancelEvent() {
        $('#myModal-add-edit-events').modal('hide'); /* //NOSONAR */
        this.helpDocumentsForm.reset();
        this.helpDocumentControl?.enable();
        this.eventIdControl?.enable();
    }
    showAddEdit(addEdit: any) {
        this.addEditLabel = addEdit;
        if (addEdit === 'Add') {
            this.saveButton = false;
            this.helpDocumentsForm.value.effectivedate = new Date();
            this.helpDocument = Object.assign({}, new HelpDocuments());
        }
    }
    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSearch(field: string, value: string) {
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
            this.pageStream$.next(this.paginationInfo.pageNumber);
        }
        this.searchTermStream$.next(this.dynamicObject);

    }

    
    uploadFile(file: any | FileError): void {
        const headers: any = new HttpHeaders();
        headers.set('Content-Type', null);
        const fileD = file.target.files[0];
        this.myFileSelected = new FormData();
        this.myFileSelected.append('filecontent', fileD);

        if (!(this.myFileSelected instanceof Array)) {
            this._alertService.error('Please enter a valid file');
        }
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
                } else {
                    ////No operation needed here
                }
           // }
          }, 1000);
    }
    processResponseData(index: any) {
        let uploadUrl = AppConfig.baseUrl  +  '/' + NewUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.intakeNumber;
        

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
                (err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.uploadedFile.splice(index, 1);
                }
            );
    }
}
