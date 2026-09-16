import { Component, Injector, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { GenericService, SessionStorageService } from '../../../@core/services';
import { AlertService } from '../../../@core/services/alert.service';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { Attachment, GeneratedDocuments } from './_entities/attachment.data.models';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AuthService } from '../../../@core/services/auth.service';
import { DataStoreService } from '../../../@core/services/data-store.service';
import { AppConfig } from '../../../app.config';
import { config } from '../../../../environments/config';

const SCREENING_WORKER = 'SCRNW';
const SUPERVISOR = 'apcs';
const CLW = 'Court Liaison Worker';
const CASE_WORKER = 'Case Worker';
declare let $: any;
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment',
    templateUrl: './attachment.component.html',
    styleUrls: ['./attachment.component.scss'],
    standalone: false
})
export class AttachmentComponent implements OnInit {
    petitions: any;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    daNumber: string;
    id: string;
    baseUrl: string;
    filteredAttachmentGrid: Attachment[] = [];
    @ViewChild(EditAttachmentComponent) editAttach!: EditAttachmentComponent;
    documentPropertiesId: any;
    documentId: any;
    generatedDocuments: GeneratedDocuments[] = [];
    token!: AppUser;
    config = { isGenerateUploadTabNeeded: false };
    downldSrcURL: any;
    isServiceCase: string='';
    selectedDocument: any;
    isGenerateByVictim: boolean=false;
    isGenerateByComplaint: boolean=false;
    isGenerateByPetition: boolean=false;
    complaints = [];
    victims = [];
    generateDocForm!: FormGroup;
    intakeNumber!: string;
    deleteattachmentpopupid = '#delete-attachment';
    generatedetailspopupid = '#generate-details';
   
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;

        constructor( private injector : Injector, private _service: GenericService<Attachment> ) {

            this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
            this._alertService = this.injector.get<AlertService>(AlertService);
            this._authService = this.injector.get<AuthService>(AuthService);
            this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
            this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
            this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
            this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);

            this.id = this.route?.snapshot?.parent?.parent?.parent?.parent?.params['id'];
            this.daNumber = this.route?.snapshot?.parent?.parent?.parent?.parent?.params['daNumber'];
            this.baseUrl = AppConfig.baseUrl;
    }

    ngOnInit() {
        this.intakeNumber = this._dataStoreService.getData('da_intakenumber');
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        this.token = this._authService.getCurrentUser();

        if (this.isServiceCase) {
            this.serviceCaseAttachmentList();
        } else {
            this.attachment();

        }

        this.prepareConfig();
        if (this.config.isGenerateUploadTabNeeded) {
            this.loadGeneratedDocumentList(true);
            this._dataStoreService.currentStore.subscribe((store) => {
                if (store['caseSummary']) {
                    const actionSummary = store['caseSummary'];
                    const jsonData = actionSummary['intake_jsondata'];
                    this.generatedDocuments = jsonData['generatedDocuments'] ? jsonData['generatedDocuments'] : [];
                }
                this.loadGeneratedDocumentList(false);
            });
        }
        this.initGenerateDocForm();

    }
    checkFileType(file: string, accept: string): boolean {
        if (accept && file) {
            const acceptedFilesArray = accept.split(',');
            return acceptedFilesArray.some(type => {
                const validType = type.trim();
                if (validType.charAt(0) === '.') {
                    return file.toLowerCase().endsWith(validType.toLowerCase());
                }
                return false;
            });
        }
        return true;
    }
    editAttachment(modal:any) {
        this.editAttach.editForm(modal);
        $('#edit-attachment').modal('show');
    }
    confirmDelete(modal:any) {
        this.documentPropertiesId = modal.documentpropertiesid;
        this.documentId = modal.filename;
        $(this.deleteattachmentpopupid).modal('show');
    }
    deleteAttachment() {
        const workEnv = config.workEnvironment;
        this.handledeleteAttachment((workEnv === 'state') ? (this.documentPropertiesId + '&' + this.documentId) : this.documentPropertiesId);

    }
    handledeleteAttachment(id:any) {
        this._service.endpointUrl =
        NewUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
    this._service.remove(id).subscribe(
        result => {
            $(this.deleteattachmentpopupid).modal('hide');
            if (this.isServiceCase) {
                this.serviceCaseAttachmentList();
            } else {
                this.attachment();
            }
            this._alertService.success('Attachment Deleted successfully!');
        },
        err => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
    );
    }

    downloadFile(s3bucketpathname:any) {
            // 4200
            s3bucketpathname = s3bucketpathname.replace(/,/g, '');
            this.downldSrcURL =  '/api' + s3bucketpathname;
        
        window.open(this.downldSrcURL, '_blank');
    }

    private attachment() {
        this._commonService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: 'get'
                }),
                NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '/' + this.id + '?data'
            )
            .subscribe((result) => {
                result.forEach(item => {
                    item.numberofbytes = this.humanizeBytes(item.numberofbytes);
                });
                this.filteredAttachmentGrid = result;
            });
    }

    private serviceCaseAttachmentList() {
        const inputreq = {
            objectid: this.id,
            page: 1,
            limit: 10
        };

        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                }),
                NewUrlConfig.EndPoint.DSDSAction.Attachment.serviceCaseAttachmentGridUrl + '?filter').subscribe((result: any) => {
                    if (result) {
                        result.map((item:any) => {
                            item.numberofbytes = this.humanizeBytes(item.numberofbytes);
                        });
                        this.filteredAttachmentGrid = result;
                    }
                });
    }
    private humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return '0 Byte';
        }
        if (!bytes) {
            return '';
         }
        const k = 1024;
        const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    private loadGeneratedDocumentList(loadAPI: boolean) {
        const isDJS = this._authService.isDJS();
        this.generatedDocuments = [];
        setTimeout(() => {
            if (isDJS && loadAPI) {
                this._service.getAllPaged({
                    where: {
                        roletypekey: this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.roletypekey,
                        intakeserviceid: this.id
                    },
                    limit: 10,
                    nolimit: true,
                    page: 1
                },
                    NewUrlConfig.EndPoint.Intake.GenerateDocumentList).subscribe((res: any) => {
                        const generatedDocuments = res;
                        generatedDocuments.forEach((document: any) => {
                            document.isGenerated = document.generatedDateTime ? true : false;
                            document.fromAPI = true;
                        });
                        this.generatedDocuments = [...generatedDocuments, ...this.generatedDocuments];
                    });
            }
        }, 1000);
    }

    downloadDocument(document:any) {
        if (document.documentpath) {
            window.open(document.documentpath, '_blank');
        } else {
            this._dataStoreService.setData('documentsToDownload', [document.key]);
        }
    }

    downloadSelectedDocuments() {
        const selectedDocuments = this.getSelectedDocuments();
        if (selectedDocuments) {
            this._dataStoreService.setData('documentsToDownload', selectedDocuments.map(document => document.key));

        }

    }

    getSelectedDocuments() {
        return this.generatedDocuments.filter(document => document.isSelected);
    }

    isFileSelected() {
        const selectedDocuments = this.getSelectedDocuments();
        if (selectedDocuments) {
            return selectedDocuments.length > 0;
        }

        return false;
    }

    generateNewDocument(document: any) {
        if (document.fromAPI) {
            this.generateDocumentFromAPI(document);
        } else {
            document.isInProgress = true;
            setTimeout(() => {
                document.isGenerated = true;
                document.generatedBy = this.token.user.userprofile.displayname;
                document.generatedDateTime = new Date();
                document.isInProgress = false;
            }, 1000);
        }
    }

    initGenerateDocForm() {
        this.generateDocForm = this.formBuilder.group({
            complaint: [null],
            victim: [null],
            petition: [null]
        });
    }

    generateDocumentFromAPI(document: any) {
        this.selectedDocument = document;
        document.isInProgress = true;
        if (document.inputfields === 'intakeserviceid') {
            this.generateDocumnet(document);
        } else {
            this.initGenerateDocForm();
            this.isGenerateByVictim = false;
            const inputs = document.inputfields.split(',');
            if (inputs.includes('complaintid')) {
                this.generateDocForm?.get('complaint')?.setValidators(Validators.required);
                this._commonService.getArrayList({
                    where: {
                        intakeserviceid: this.id
                    },
                    limit: 10,
                    nolimit: true,
                    page: 1,
                    method: 'get'
                },
                    NewUrlConfig.EndPoint.DSDSAction.Attachment.CompaintFromCase)
                    .subscribe((res: any) => {
                        this.complaints = res;
                    });
                    this.isGenerateByComplaint = true;
            } else {
                this.isGenerateByComplaint = false;
                this.generateDocForm?.get('complaint')?.clearValidators();
            }
            this.generateDocForm?.get('complaint')?.updateValueAndValidity();

            if (inputs.includes('victimid')) {
                this.isGenerateByVictim = true;
                this.generateDocForm?.get('victim')?.setValidators(Validators.required);
            } else {
                this.isGenerateByVictim = false;
                this.generateDocForm?.get('victim')?.clearValidators();
            }
            this.generateDocForm?.get('victim')?.updateValueAndValidity();

            if (inputs.includes('petitionid')) {
                this.isGenerateByPetition = true;
                this.generateDocForm?.get('petition')?.setValidators(Validators.required);
                this._commonService.getArrayList({
                    page: 1,
                    limit: 10,
                    nolimit: true,
                    sortcolumn: 'intakenumber',
                    sortorder: 'asc',
                    where: {
                        intakenumber: this.intakeNumber
                    },
                    method: 'get'
                }, NewUrlConfig.EndPoint.Intake.getAddedPetitions).subscribe(
                    (response) => {
                        this.petitions = response;
                    });
            } else {
                this.isGenerateByPetition = false;
                this.generateDocForm?.get('petition')?.clearValidators();
            }
            $(this.generatedetailspopupid).modal('show');
            $(this.generatedetailspopupid).on('hidden.bs.modal', function () {
                document.isInProgress = false;
            });
        }
    }

    loadVictims() {
        const complaintid = this.generateDocForm?.get('complaint')?.value;
        this._commonService
            .getArrayList({
                where: {
                    intakeservicerequestevaluationid: complaintid
                },
                method: 'post'
            }, NewUrlConfig.EndPoint.Intake.getComplaintDetails).subscribe((response: any) => {
                const victims:any = [];
                response.data.forEach((complaint:any ) => {
                    complaint.victim.forEach((victim:any ) => {
                        victims.push(victim);
                    });
                });
                this.victims = Array.from(new Set(victims));
            });
    }

    generateDocumnet(document: any) {
        const documentKey = [];
        documentKey.push(document.documenttemplatekey);
        const generateDocDetails = this.generateDocForm?.getRawValue();
        const complaintid = generateDocDetails.complaint ? [].concat(generateDocDetails.complaint) : [];
        const victimid = generateDocDetails.victim ? [].concat(generateDocDetails.victim) : [];
        const petitionid = generateDocDetails.petition ? [].concat(generateDocDetails.petition) : [];
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: {
                intakenumber: this.intakeNumber,
                intakeserviceid: this.id,
                documenttemplatekey: documentKey,
                reportername: this.token.user.userprofile.displayname,
                reporteddate: new Date(),
                screenername: this.token.user.userprofile.displayname,
                isdraft: false,
                downloadtype: document.downloadtype,
                intakeservicerequestevaluationid: complaintid,
                victim: victimid,
                isheaderrequired: document.isheaderrequired,
                petition: petitionid
            },
            method: 'post'
        }), 'evaluationdocument/generateintakedocument')
            .subscribe(res => {
                if (res.data && res.data.length) {$(this.generatedetailspopupid).modal('hide');
                    this.loadGeneratedDocumentList(true);
                }
            }, (err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                document.isInProgress = false;
            });
    }

    generateSelectedDocuments() {
        this.generatedDocuments.forEach(document => {
            if (document.isSelected) {
                this.generateNewDocument(document);
            }

        });
    }

    prepareConfig() {
        const isDjs = this._authService.isDJS();
        if (isDjs) {
            this.config.isGenerateUploadTabNeeded = true;
        } else {
            this.config.isGenerateUploadTabNeeded = false;
        }
    }

    toggleTable(id:any ) {
       $('#' + id).collapse('toggle');
    }
}
