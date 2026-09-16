
import {map} from 'rxjs/operators';
import { Component, OnInit, ViewChild, AfterViewInit, OnDestroy, Injector  } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
 import { Observable } from 'rxjs';
 import jsPDF from 'jspdf';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import { HttpHeaders } from '@angular/common/http';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { AlertService, CommonHttpService, GenericService, DataStoreService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { NewUrlConfig } from '../../newintake-url.config';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';
import { Attachment } from './_entities/attachmnt.model';
import { GeneratedDocuments } from '../_entities/newintakeSaveModel';
import { HttpService } from '../../../../@core/services/http.service';
import { AppConfig } from '../../../../app.config';
import { config } from '../../../../../environments/config';
// import html2canvas from 'html2canvas';
import _ from 'lodash';
const CLW = 'Court Liaison Worker';
declare var $: any;
import * as ALL_DOCUMENTS from './_configurtions/documents.json';
import { SafeResourceUrl } from '@angular/platform-browser';
import { IntakeStoreConstants } from '../my-newintake.constants';
import { IntakeConfigService } from '../intake-config.service';
import moment from 'moment';
import { AttachmentService } from '../../../case-worker/dsds-action/attachment/attachment.service';
import { AppConstants } from '../../../../@core/common/constants';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'intake-attachments',
    host: {
        class: 'intake-attachments'
    },
    templateUrl: './intake-attachments.component.html',
    styleUrls: ['./intake-attachments.component.scss'],
    standalone: false
})
export class IntakeAttachmentsComponent implements OnInit, AfterViewInit, OnDestroy  {
    beforeSubmit!: boolean;
    fileToSave = [];
    uploadedFile = [];
    petitions: any;
    documentPropertiesId: any;
    documentId: any;
    filteredAttachmentGrid: any[] =[];
    intakeNumber!: string;
    // formAdd: AddForm;
    token!: AppUser;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    daNumber!: string;
    reviewStatus!: string;
    id: string;
    attachmentType!: FormGroup;
    generateDocForm!: FormGroup;
    baseUrl: string;
    showScreens = { uploadDocument: false, uploadedDocument: false, createDocument: true };
    searchText = '';
    private allAttachmentGrid: Attachment[] = [];
    @ViewChild(EditAttachmentComponent) editAttach!: EditAttachmentComponent;
    generatedDocuments: GeneratedDocuments[] = [];
    allDocuments = <any>ALL_DOCUMENTS;
    config = { isGenerateUploadTabNeeded: false };
    downldSrcURL: any;
    generatedDocListCW: any[] = [];
    generatedCWDocUrl!: SafeResourceUrl;
    generatedDocUrl!: SafeResourceUrl;
    isCLW!: boolean;
    complaints: any[] = [];
    isGenerateByVictim!: boolean;
    isGenerateByComplaint!: boolean;
    isGenerateByPetition!: boolean;
    victims: any[] = [];
    selectedDocument: any;
    isacknowledgementletter: any;
    selectedComplaint: any;
    offenceCategoryList: any;
    reviewstatus!: string;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];

    private store: any;
    contactrecording: any[] = [];
    reasonForContact: any[] = [];
    isClosed = false;
    documentFilterForm!: FormGroup;
    categories: any = [];
    subCategories: any = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalRecords = 20;
    isApproved = false;
    maxDocumentDate: any;
    disableIntakeServicesType: boolean =false;
    unsavedattachmentscount!: number;
    deleteattachmentintakepopupid = '#delete-attachment-intake';
    generatedetailspopupid = '#generate-details';
    dtformat = 'MM-DD-YYYY';

    //1080 Refinement
    formType!: string;
    form: any;
    isSupervisor: boolean;
    forms: any[] = [{ type: "form1080a", name: "1080 A Form", items: [], expanded: false },
            { type: "form1080b", name: "1080 B Form", items: [], expanded: false },
            { type: "form1080c", name: "1080 C Form", items: [], expanded: false }];
    formList: any = { form1080a: [], form1080b: [], form1080c: [] };

    getFormsListUrlMap: any = {
        "form1080a" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.List,
        "form1080b" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.List,
        "form1080c" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.List
    }

    confirmCopyPopupId = '#copy-version';
    form1080HistoryModal = '#form1080-history-modal';
    copiedData : any;
    form1080HistoryPopupHeader : string = "";
    formHistoryData: any[] = [];
    formhistory: any[] = [{ type: "form1080a", items: [] },    
                    { type: "form1080b", items: [] },
                    { type: "form1080c", items: [] }];
    //Tabs config
    tab_type = 'upload'; //Setting default as the first one i.e. upload

    private formBuilder: FormBuilder;
    private _commonService: CommonHttpService;
    private route: ActivatedRoute;
    private router:Router;
    private _alertService: AlertService;
    public _authService: AuthService;
    private _attachmentService : AttachmentService;
    private html2canvas:Html2CanvasService;
    maxlargefilesize!: string;
    uploadNumber: any;
    paginationInfoperson: any;

    constructor(
        private readonly injector: Injector,
        private _http: HttpService,
        private _service: GenericService<Attachment>,
        private _store: DataStoreService,
        private _intakeConfig: IntakeConfigService
    ) {
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.router = this.injector.get<Router>(Router);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._attachmentService = this.injector.get<AttachmentService>(AttachmentService);
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);

        this.id = this.route.snapshot.params['id'];
        this.baseUrl = AppConfig.baseUrl;
        this.store = this._store.getCurrentStore();
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    }
    navigationSubscription: any;
    async ngOnInit() {
        this.maxlargefilesize = this.humanizeBytes(config.largeUploadMaxSizeLimit);
        this.route.queryParams.subscribe(params => {
            if(params['retrydocument']) {
                this.uploadLargeFile();
                this.router.navigate([], 
                {
                    relativeTo: this.route,
                    queryParams: { retrydocument:false},
                    queryParamsHandling: 'merge'
                }
                );
            }
        });
        this.navigationSubscription = this.router.events.subscribe((e: any) => {
            if(e.url && e.url.includes("/edit/attachment")){
                this.loadAttachmentList()
                this.onGetFormList(this.getFormsListUrlMap["form1080a"], "form1080a");
                this.onGetFormList(this.getFormsListUrlMap["form1080b"], "form1080b");
                this.onGetFormList(this.getFormsListUrlMap["form1080c"], "form1080c");
            }
          });
        this.intakeNumber = this.store[IntakeStoreConstants.intakenumber] ? this.store[IntakeStoreConstants.intakenumber] : this.route?.snapshot?.parent?.parent?.parent?.params['intakenumber'];
        this.getSupervisorApprovalInfo();
        this.maxDocumentDate = new Date();
        this.isacknowledgementletter = this.store[IntakeStoreConstants.addNarrative] ? this.store[IntakeStoreConstants.addNarrative].isacknowledgementletter : [];
        this.documentFilterForm = this.formBuilder.group({
            category: [null],
            subcategory: [null],
            worker: [null],
            title: [null],
            actualdocumentdate:[null]
        });

        this.paginationInfo.sortColumn = 'updatedon';
        this.paginationInfo.sortBy = 'desc';
        this.chooseTab(1);
        this.loadDropdown();
        this.token = this._authService.getCurrentUser();
        this.buildForms();
        this.initGenerateDocForm();
        this.generatedDocuments = this.store[IntakeStoreConstants.generatedDocuments] ? this.store[IntakeStoreConstants.generatedDocuments] : [];
        this.loadGeneratedDocumentList(this.token, true);
        this.prepareConfig();
        this.getContactRecordings();
        this.loadAttachmentList();
        this.loadUnsavedAttachmentList();
        this.getReasonForContact();
        if (this._intakeConfig.getIntakePurpose()) {
            this.listAllegations(this._intakeConfig.getIntakePurpose()?.intakeservreqtypeid);
        }
        const currentStatus = this._store.getData(IntakeStoreConstants.INTAKE_STATUS);
        this.reviewstatus = currentStatus;
        if (currentStatus === 'Closed' || currentStatus === 'Completed' || currentStatus === 'Accepted') {
            this.isClosed = true;
           } else {
            this.isClosed = false;
           }
           this.loadFilterDropdowns();

        this.onGetFormList(this.getFormsListUrlMap["form1080a"], "form1080a");
        this.onGetFormList(this.getFormsListUrlMap["form1080b"], "form1080b");
        this.onGetFormList(this.getFormsListUrlMap["form1080c"], "form1080c");
   
        this.route.queryParams.subscribe((params) => {
            if(params['openFormsTab']){
                this.tab_type = 'forms';
            }
        })
        // get involved person data for form 1080
        let isCW = true;
        let isServiceCase = false;
        this._attachmentService.getPersonDetails(isCW,isServiceCase,this.id);
    }

        loadFilterDropdowns() {
            this._commonService
            .getSingle(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
            )
            .subscribe(data => {
                if (data && data.length > 0) {
                   const categories = data.filter((item: any) => item.typedescription.startsWith('CW-'));
                   this.categories = _.uniqBy(categories, 'typedescription');
                   this.subCategories = data.filter((item: any) => item.typedescription.startsWith('CW-'));
                } else {
                    this.categories = [];
                }
                this.loadAttachmentDropDown();
            });
        }

    ngAfterViewInit() {
        if (!this._intakeConfig.getiseditIntake()) {
            (<any>$(':button')).prop('disabled', true); // NOSONAR
        }
    }

    uploadFile() {
        this.isUploadShared = true;
        this.loadAttachmentList();
        this.loadUnsavedAttachmentList();
        this._store.setData('largefileupload', false); 
        this._store.setData('openupload', true);   
        (<any>$('#upload-attachment')).modal('show'); // NOSONAR
    }
    uploadLargeFile() {
        this.isUploadShared = true;
        this.loadAttachmentList();
        this.loadUnsavedAttachmentList();
        this._store.setData('largefileupload', true); 
        this._store.setData('openupload', true);   
        (<any>$('#upload-attachment')).modal('show'); // NOSONAR
    }

    listAllegations(purposeID: any) {
        const checkInput = {
            where: { intakeservreqtypeid: purposeID },
            method: 'get',
            nolimit: true,
            order: 'name'
        };
        this._commonService
            .getArrayList(new PaginationRequest(checkInput), NewUrlConfig.EndPoint.Intake.allegationsUrl + '?filter')
            .subscribe(offenceCategories => {
                if (offenceCategories) {
                    this.offenceCategoryList = [];
                    offenceCategories.forEach(offence => {
                        this.offenceCategoryList[offence.allegationid] = offence.name;
                    });
                }
            });
    }

    buildForms() {
        this.attachmentType = this.formBuilder.group({
            selectedAttachment: ['All']
        });
    }

    initGenerateDocForm() {
        this.generateDocForm = this.formBuilder.group({
            complaint: [''],
            victim: [''],
            petition: ['']
        });
    }
    chooseTab(tabId: any) {
        if (tabId === 1) {
            this.showScreens = { uploadDocument: true, uploadedDocument: false, createDocument: false };
        } else if (tabId === 2) {
            this.showScreens = { uploadDocument: false, uploadedDocument: true, createDocument: false };
        } else if (tabId === 3) {
            this.showScreens = { uploadDocument: false, uploadedDocument: false, createDocument: true };
        }
    }

    filterAttachment(attachType: any) {
        if (attachType.selectedAttachment === 'All') {
            this.filteredAttachmentGrid = this.allAttachmentGrid;
        } else if (attachType.selectedAttachment === 'Exhibit') {
            this.filteredAttachmentGrid = this.allAttachmentGrid?.filter((item: { documenttypekey: any; }) => item.documenttypekey === attachType.selectedAttachment
            );
        } else {
            this.filteredAttachmentGrid = this.allAttachmentGrid.filter((item: any) =>
                    item.documentattachment &&
                    item.documentattachment.attachmenttypekey ===
                    attachType.selectedAttachment
            );
        }
    }
    checkFileType(file: string, accept: string): boolean {
        if (accept) {
            const acceptedFilesArray = accept.split(',');
            return acceptedFilesArray.some(type => {
                const validType = type.trim();
                if (validType && validType.charAt(0) === '.') {
                    return file.toLowerCase().endsWith(validType.toLowerCase());
                }
                return false;
            });
        }
        return true;
    }
    editAttachment(modal: any) {
        this.editAttach.editForm(JSON.parse(JSON.stringify(modal)), true);
        (<any>$('#edit-attachment')).modal('show'); // NOSONAR
    }

    viewAttachment(modal: any) {
        this.editAttach.editForm(JSON.parse(JSON.stringify(modal)), false);
        (<any>$('#edit-attachment')).modal('show'); // NOSONAR
    }
    confirmDelete(modal: any) {
        this.documentPropertiesId = modal.documentpropertiesid;
        this.documentId = modal.filename;
        (<any>$(this.deleteattachmentintakepopupid)).modal('show'); // NOSONAR
    }
    deleteAttachment() {
        const workEnv = config.workEnvironment;
        if (workEnv === 'state') {
            this._service.endpointUrl =
                NewUrlConfig.EndPoint.Intake.DeleteAttachmentUrl;
            const id = this.documentPropertiesId + '&' + this.documentId;
            this._service.remove(id).subscribe(() => { // NOSONAR
                    (<any>$(this.deleteattachmentintakepopupid)).modal('hide'); // NOSONAR
                    this.loadAttachmentList();
                    this.getContactRecordings();
                    this._alertService.success('Attachment Deleted successfully!');
                },
                err => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
        } else {
            this._service.endpointUrl =
                NewUrlConfig.EndPoint.Intake.DeleteAttachmentUrl;
            this._service.remove(this.documentPropertiesId).subscribe(() => { // NOSONAR
                    (<any>$(this.deleteattachmentintakepopupid)).modal('hide'); // NOSONAR
                    this.loadAttachmentList();
                    this.getContactRecordings();
                    this._alertService.success('Attachment Deleted successfully!');
                },
                err => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    getContactRecordings() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: {isExpungementSuperUser: isExpungementSuperUser,iscaseexpunged: iscaseexpunged},
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.intakeNumber + '?data'
            )
            .subscribe((result) => {
                this.contactrecording = result.data;
                this.setcontacttype();
            });
    }
    getReasonForContact() {
        this._commonService.getSingle({}, 'Progressnotereasontypes?filter={"nolimit":true}').pipe(map((itm) => {
            return itm;
        })).subscribe(data => {
            this.reasonForContact = data;
            this.setcontacttype();
        });
    }
    setcontacttype() {
        if (Array.isArray(this.reasonForContact) && Array.isArray(this.contactrecording)) {
            this.contactrecording.forEach(item => {
            if (!item.progressnotereasontypekey) {
                item.progressnotereasontypedescription = '';
                return;
            }
                const pr = item.progressnotereasontypekey.split(',');
                let description = '';
                pr.forEach((element: any, index: any) => {
                const reason = this.reasonForContact.find(re => re.progressnotereasontypekey === element.trim());
                if (reason) {
                    description = (index === (pr.length - 1)) ? description + reason.typedescription : description + reason.typedescription + ', ';
                }
                });
                item.progressnotereasontypedescription = description;
            });
        }
    }

    downloadFile(source: any) {
        const s3bucketpathname = (source.s3bucketpathname || '').replace(/,/g, '');
        this.downldSrcURL = '/api' + s3bucketpathname;
        this._commonService
        .downloadXml(
            'attachments/downloadFileFromECMS?docId=' + source.ecmsdocumentid + '&filename=' + source.originalfilename
        ).subscribe((result: any) => {
            const blob = new Blob([result]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = source.originalfilename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    }

    private loadDropdown() {
        this.attachmentTypeDropdown$ = this._commonService
        .getArrayList(
            {},
            NewUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl
        ).pipe(
        map(result => {
            return result.map(
                res =>
                    new DropdownModel({
                        text: res.typedescription,
                        value: res.attachmenttypekey
                    })
            );
        }));
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

    loadCWGeneratedDocumentList() {
        this._commonService.getAllPaged(
            new PaginationRequest({
                limit: 20,
                count: 1,
                page: 1,
                method: 'get'
            }),
            NewUrlConfig.EndPoint.Intake.CWGeneratedDocumentListUrl
        ).subscribe((res: any) => {
            if (res.length > 0) {
                res.data.forEach((document: { isGenerated: boolean; }) => {
                    document.isGenerated = false;
                });
                this.generatedDocListCW = res.data;
            }
        }, (err) => {
            console.error(err);
        });
    }
    generateCWDoc(document: any) {
        const documentKey: any[] = [];
        documentKey.push(document.documenttemplatekey);
        this._commonService.getPagedArrayList(
            new PaginationRequest({
                where: {
                    intakenumber: this.id,
                    documenttemplatekey: documentKey,
                    reportername: '',
                    reporteddate: new Date(),
                    screenername: this.token.user.userprofile.displayname
                },
                method: 'post'
            }), 'evaluationdocument/generateintakedocument')
            .subscribe(res => {
                if (res.data && res.data.length) {
                    this.generatedCWDocUrl = res.data[0].documentpath;
                    this.generatedDocListCW.forEach(doc => {
                        if (doc === document) {
                            doc.generatedBy = this.token.user.userprofile.displayname;
                            doc.generatedDateTime = new Date();
                            doc.isGenerated = true;
                        }
                    });
                }
            }, (err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    downloadCWDoc(document: any) {
        (<any>$('#document-view')).modal('show'); // NOSONAR
    }

    private loadGeneratedDocumentList(user: AppUser, loadAPI: boolean) {
        const isDJS = this._authService.isDJS();
        setTimeout(() => {
            if (isDJS && loadAPI) {
                this._commonService.getAllPaged({
                    where: {
                        roletypekey: this._authService.getCurrentUser().user.userprofile.teammemberassignment.teammember.roletypekey,
                        intakenumber: this.intakeNumber
                    },
                    nolimit: true
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
        this.allDocuments = this.allDocuments.default    
        if (!this._authService.isDJS()) {
            this.allDocuments = this.allDocuments
                .filter((document: { team: string; }) => document.team === 'CW')
                .filter((document: any) => this.acknowledgementletterfilter(document));
        }
        this.allDocuments.forEach((document: GeneratedDocuments) => {
            if (document.access.indexOf(user.role.name) !== -1) {
                const isExist = this.generatedDocuments.find(gDocument => document.id === gDocument.id);
                if (!isExist) {
                    this.generatedDocuments.push(document);
                }
            }

        });
    }

    acknowledgementletterfilter(document: any) {
        return true;
    }

    downloadDocument(document: any) {
        this._store.setData(IntakeStoreConstants.generatedDocumentDownloadKey, [document.key]);
        this._store.setData('loadhtml', true);
    }

    downloadSelectedDocuments() {
        const selectedDocuments = this.getSelectedDocuments();
        if (selectedDocuments) {
            this._store.setData(IntakeStoreConstants.generatedDocumentDownloadKey, selectedDocuments.map(document => document.key));
            this._store.setData('loadhtml', true);
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
        this.selectedDocument = document;
        document.isInProgress = true;
        if (document.fromAPI) {
            if (document.inputfields === 'intakenumber' || !document.inputfields) {
                this.generateDocumnet(document);
            } else {
                this.initGenerateDocForm();
                this.isGenerateByVictim = false;
                const inputs = document.inputfields.split(',');
                this.ifComplaintidIncludedFn(inputs, document);
                this.generateDocForm.get('complaint')?.updateValueAndValidity();

                if (inputs.includes('victimid')) {
                    this.isGenerateByVictim = true;
                    this.generateDocForm.get('victim')?.setValidators(Validators.required);
                } else {
                    this.generateDocForm.get('victim')?.clearValidators();
                }
                this.generateDocForm.get('victim')?.updateValueAndValidity();

                this.ifPetitionidInculdedFn(inputs);
                this.generateDocForm.get('petition')?.updateValueAndValidity();
                (<any>$(this.generatedetailspopupid)).modal('show'); // NOSONAR
                $(this.generatedetailspopupid).on('hidden.bs.modal', function () {
                    document.isInProgress = false;
                });
            }
        } else {
            setTimeout(() => {
                document.isGenerated = true;
                document.generatedBy = this.token.user.userprofile.displayname;
                document.generatedDateTime = new Date();
                document.isInProgress = false;
                this._store.setData(IntakeStoreConstants.generatedDocuments, this.generatedDocuments);
            }, 1000);
        }
    }

    private ifPetitionidInculdedFn(inputs: any) {
        if (inputs.includes('petitionid')) {
            this.isGenerateByPetition = true;
            this.generateDocForm.get('petition')?.setValidators(Validators.required);
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
            this.generateDocForm.get('petition')?.clearValidators();
        }
    }

    private ifComplaintidIncludedFn(inputs: any, document: any) {
        if (inputs.includes('complaintid')) {
            this.beforeSubmit = document.beforesubmit;
            this.victims = [];
            if (this.beforeSubmit) {
                this.complaints = this.store[IntakeStoreConstants.evalFields];
                if (this.complaints && this.complaints.length > 0) {
                    this.complaints.forEach((complaint: { intakeservicerequestevaluationid: any; complaintid: any; }) => {
                        complaint.intakeservicerequestevaluationid = complaint.complaintid;
                    });
                }
            } else {
                this.generateDocForm.get('complaint')?.setValidators(Validators.required);
                this._commonService.getArrayList({
                    where: { intakenumber: this.intakeNumber },
                    limit: 10,
                    nolimit: true,
                    page: 1,
                    method: 'get'
                },
                    NewUrlConfig.EndPoint.Intake.Intakeservicerequestevaluations)
                    .subscribe((res: any) => {
                        this.complaints = res;
                    });
            }
            this.isGenerateByComplaint = true;
        } else {
            this.isGenerateByComplaint = false;
            this.generateDocForm.get('complaint')?.clearValidators();
        }
    }

  // AppConfig.baseUrl + '/' +
    uploadAttachment(filedata: any) {
        this._http.post( CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=daNumber', {
            headers: new HttpHeaders(

            ).set('ctype', 'file'),
            filesKey: ['file'],
            files: filedata,
            process: true
        }).subscribe((response) => {
            this._alertService.success(response);
        });
    }
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById('docu-View');
        const pages = source.getElementsByClassName('pdf-page');
        let pageImages: any = [];
        for (let i = 0; i < pages.length; i++) {
             
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({ fileName: pageName, images: pageImages });
                    pageImages = [];
                }
            });
        }
       return  this.convertImageToPdf();
    }

    convertImageToPdf() {
        let doc: any = null;

        this.pdfFiles.forEach((pdfFile) => {

          doc = new jsPDF();
            const width = doc.internal['pageSize'].getWidth() - 10;
            const height = doc.internal['pageSize'].getHeight() - 10;
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 3, 5, width, height);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
        });
        this.pdfFiles = [];
        return doc;

    }
    sendMail() {
        const content = this.downloadCasePdf('acknowledgementletter');
        
        
             this._http.post('admin/assessment/sendemailattchment', {
                 tomail:  this.store.addNarrative.email,
                 subject: 'acknowledgementletter',
                 body: 'Dear Reportee',
                 filename: 'acknowledgement.pdf',
                 content: 'acknowledgementletter'
             }).subscribe((response) => {
                 this._alertService.success(response);
                this.uploadAttachment(content);
             });

            }


    loadVictims() {
        const complaintid = this.generateDocForm.get('complaint')?.value;
        if (this.beforeSubmit) {
            this.selectedComplaint = this.complaints.find((complaint: { complaintid: any; }) => complaint.complaintid === complaintid);
            this.victims = this.selectedComplaint.victims;
            this.victims.forEach((victim: any) => {
                victim.firstname = victim.firstName;
                victim.lastname = victim.lastName;
            });
        } else {
            this._commonService
                .getArrayList({
                    where: {
                        intakeservicerequestevaluationid: complaintid
                    },
                    method: 'post'
                }, NewUrlConfig.EndPoint.Intake.getComplaintDetails).subscribe((response: any) => {
                    const victims: any = [];
                    response.data.forEach((complaint: { victim: any[]; }) => {
                        complaint.victim.forEach(victim => {
                            victims.push(victim);
                        });
                    });
                    this.victims = Array.from(new Set(victims));
                });
        }
    }

    generateJSONForDocumnet(document: any) {
        switch (document.documenttemplatekey) {
            case 'VictimImpact':
                document.json = this.generateVictimImpactJSON(document);
                break;
            case 'AppointLetter':
                document.json = this.generateAppointLetterJSON(document);
                break;
            case 'CompNotif':
                document.json = this.generateCompNotifJSON(document);
                break;
        }
         
        this.generateDocumnet(document);
    }

    generateCompNotifJSON(document: any) {
        let allegationHTML = '';
        for (const offense of this.selectedComplaint.allegedoffense) {
            allegationHTML += '<tr><td>' + this.offenceCategoryList[offense.allegationid ? offense.allegationid : offense] +
                '</td><td>' + moment(this.selectedComplaint.allegedoffensedate).format(this.dtformat) + '</td></tr>';
        }
        return {
            complaintid: this.selectedComplaint.complaintid,
            complaintdate: this.selectedComplaint.complaintreceiveddate,
            policename: this.selectedComplaint.sourcefirstname + ' ' + this.selectedComplaint.sourcelastname,
            additionalcomments: '',
            allegedoffense: allegationHTML,
            agency: this.selectedComplaint.evaluationsourceagencyname,
            policenumber: '(410) 230-3333',
            policeaddress: this.selectedComplaint.sourceStreetno + ' ' + this.selectedComplaint.sourceStreet1 + ', ' + this.selectedComplaint.sourceStreet2,
            datewithaddition: moment().add(10, 'd').format(this.dtformat),
            officername: this._authService.getCurrentUser().user.userprofile.displayname,
            role: this._authService.getCurrentUser().role.name
        };
    }

    generateAppointLetterJSON(document: any) {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const youth = addedPersons.find((person: any) => person.Role === 'Youth');
        const address = this._authService.getCurrentUser().user.userprofile.userprofileaddress[0];
        const appointment = this.store[IntakeStoreConstants.intakeappointment];
        let allegationHTML = '';
        for (const offense of this.selectedComplaint.allegedoffense) {
            allegationHTML += '<tr><td>' + this.offenceCategoryList[offense.allegationid] + '</td><td>' + moment(this.selectedComplaint.allegedoffensedate).format(this.dtformat) + '</td></tr>';
        }
        return {
            complaintid: this.selectedComplaint.complaintid,
            complaintdate: this.selectedComplaint.complaintreceiveddate,
            youthname: youth.fullName,
            youthid: youth.cjamspid,
            policename: this.selectedComplaint.sourcefirstname + ' ' + this.selectedComplaint.sourcelastname,
            appointmentdate: appointment.length ? appointment.appointmentDate : new Date(),
            appointmentaddress: address.address + ', ' + address.city + ', ' + address.state + ', ' + address.county + ' ' + address.zipcode,
            additionalcomments: '',
            allegedoffense: allegationHTML,
            officername: this._authService.getCurrentUser().user.userprofile.displayname,
            role: this._authService.getCurrentUser().role.name
        };
    }

    generateVictimImpactJSON(document: any) {
        const addedPersons = this.store[IntakeStoreConstants.addedPersons];
        const youth = addedPersons.find((person: any) => person.Role === 'Youth');
        const victimid = this.generateDocForm.value.victim;
        const victim = addedPersons.find((person: any) => person.Pid === victimid);
        const vAddress = victim.personAddressInput;
        for (const address of vAddress) {
            victim.address = address.address1 + '<br>';
            if (address.Address2) {
                victim.address += address.Address2 + '<br>';
            }
            victim.address += address.city + ' ' + address.state
                + '<br>' + address.county + ' ' + address.zipcode;
            break;
        }
        for (const phone of victim.phoneNumber) {
            victim.phonenumber = phone.contactnumber;
        }
        return {
            complaintid: this.selectedComplaint.complaintid,
            complaintdate: this.selectedComplaint.complaintreceiveddate,
            youthname: youth.fullName,
            youthid: youth.cjamspid,
            victimname: victim.fullName,
            victimaddress: victim.address,
            victimphno: victim.phonenumber,
            officername: this._authService.getCurrentUser().user.userprofile.displayname,
            role: this._authService.getCurrentUser().role.name
        };
    }

    generateDocumnet(document: any) {
        const documentKey: any[] = [];
        documentKey.push(document.documenttemplatekey);
        const generateDocDetails = this.generateDocForm.getRawValue();
        const complaintid = generateDocDetails.complaint ? [].concat(generateDocDetails.complaint) : [];
        const victimid = generateDocDetails.victim ? [].concat(generateDocDetails.victim) : [];
        const petitionid = generateDocDetails.petition ? [].concat(generateDocDetails.petition) : [];
        let restitutionno = null;
        const addedPaymentSchedules = this._store.getData(IntakeStoreConstants.restitution);
        if (addedPaymentSchedules) {
            restitutionno = addedPaymentSchedules.restitutionnumber;
        }
        this._commonService.getPagedArrayList(new PaginationRequest({
            where: {
                intakenumber: this.intakeNumber,
                restitutionno: restitutionno,
                documenttemplatekey: documentKey,
                reportername: this.token.user.userprofile.displayname,
                reporteddate: new Date(),
                screenername: this.token.user.userprofile.displayname,
                isdraft: false,
                downloadtype: document.downloadtype,
                intakeservicerequestevaluationid: complaintid,
                victim: victimid,
                petition: petitionid,
                beforesubmit: document.beforesubmit,
                json: document.json,
                isheaderrequired: document.isheaderrequired
            },
            method: 'post'
        }), 'evaluationdocument/generateintakedocument')
            .subscribe(res => {
                if (res.data && res.data.length) {
                    this._store.setData(IntakeStoreConstants.generatedDocuments, this.generatedDocuments);
                    (<any>$(this.generatedetailspopupid)).modal('hide'); 
                    this.loadGeneratedDocumentList(this.token, true);
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

    isCourtLiaisonWorker() {

        if (this.token) {
            return this.token.role.name === CLW;
        }
        return false;
    }

    isCompleteVisible() {
        return this.isCourtLiaisonWorker();
    }

    prepareConfig() {
        const isDjs = this._authService.isDJS();
        if (isDjs) {
            this.config.isGenerateUploadTabNeeded = true;
        } else {
            this.config.isGenerateUploadTabNeeded = false;
        }
    }

    checkScan() {
        const _self = this;
        const scanDocs = window.setInterval(function () {
            const isScanDoc = window.localStorage.getItem('scanDoc');
            if (isScanDoc === 'true') {
                _self.loadAttachmentList();
                window.localStorage.removeItem('scanDoc');
                window.clearInterval(scanDocs);
                 
            } 
        }, 1000);
    }
    
    filterDocuments() {
        this.loadAttachmentList();

    }
    resetfilterDocuments() {
        this.documentFilterForm.reset();
        this.loadAttachmentList();
    }

    pageChanged(pageNumber: any) {
        this.paginationInfo.pageNumber = pageNumber;
        this.loadAttachmentList();
    }

    onSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.loadAttachmentList();
    }

    updated() {
        this.loadAttachmentList();
        this.loadUnsavedAttachmentList();
    }

    loadUnsavedAttachmentList(){
        this.unsavedattachmentscount = 0;
        const inputreq = {
            servicerequestid: null,
            servicecaseid: null,
            adoptioncaseid:  null,
            objecttypekey: 'ServiceRequest',
            intakenumber: this.intakeNumber,
            sortcolumn: 'updatedon' ,
            sortby: 'desc',
            activeflag: 2
        };

        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                    page: this.paginationInfo.pageNumber,
                    nolimit:true
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter').subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        const searchcaseworkerattachments =response[0].searchcaseworkerattachments ?
                        response[0].searchcaseworkerattachments.filter((attachement: any) => attachement['insertedby'] === this.token.user['securityusersid'] 
                        || attachement['insertedby'] === this.token.user.userprofile.displayname
                        || attachement['displayname'] === this.token.user.userprofile.displayname)
                         : [];
                        const result = searchcaseworkerattachments;
                        if (result) {
                            this.unsavedattachmentscount = result.length;
                        } 
                     }
                });
    }

    loadAttachmentList() {
        const documentFilter = this.documentFilterForm.getRawValue();
        let category: string | null = null;
        let subcategory: string | null = null;
        if (Array.isArray(documentFilter.category) && documentFilter.category.length) {
            category = '{' +  '"' + documentFilter.category.join('","') + '"' + '}';
        }
        if (Array.isArray(documentFilter.subcategory) && documentFilter.subcategory.length) {
            subcategory = '{' +  '"' + documentFilter.subcategory.join('","') + '"' + '}';
        }
        const inputreq = {
            servicerequestid: null,
            servicecaseid: null,
            adoptioncaseid:  null,
            objecttypekey: 'ServiceRequest',
            category: category,
            subcategory: subcategory,
            worker: documentFilter.worker,
            title: documentFilter.title,
            sortcolumn: this.paginationInfo.sortColumn ,
            sortby: this.paginationInfo.sortBy,
            intakenumber: this.intakeNumber,
            actualdocumentdate:documentFilter.actualdocumentdate
        };

        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                    page: this.paginationInfo.pageNumber,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter').subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        const result = response[0].searchcaseworkerattachments;
                        if (result) {
                            this.totalRecords = result[0].count;
                            result.map((item: any) => {
                                item.numberofbytes = this.humanizeBytes(item.numberofbytes ?? 0);
                            });
                            this.filteredAttachmentGrid = result;
                        } else {
                            this.filteredAttachmentGrid = [];
                        }
                     } else {
                        this.filteredAttachmentGrid = [];
                     }
                });
    }

    loadScanConfig() {
        this._intakeConfig.scanConfig$.next('SCAN');
    }

    getSupervisorApprovalInfo() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        this.isApproved = false;
        this._http.post( CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CpsIntakeReport, {
            'intakenumber': this.intakeNumber,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': iscaseexpunged
        }).subscribe((response) => {
            if(response.data && response.data.getsupervisorapprovaldetails && response.data.getsupervisorapprovaldetails.length
                && response.data.getsupervisorapprovaldetails[0] && response.data.getsupervisorapprovaldetails[0].status && 
                response.data.getsupervisorapprovaldetails[0].status==='Accepted'){
                    this.isApproved = true;}
            });
    }

    loadAttachmentDropDown() {
        this._commonService.getArrayList(
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
                        this.categories.push({
                                activeflag:  element.activeflag,
                                attachmentclassificationtypekey: '',
                                datavalue: 0,
                                editable: 0,
                                effectivedate: '',
                                expirationdate: '',
                                sequencenumber: 0,
                                subcategory: element.value_text,
                                typedescription: element.value_text
                            });
                    }else{
                        this.subCategories.push({
                            activeflag:  element.activeflag,
                            attachmentclassificationtypekey: '',
                            datavalue: 0,
                            editable: 0,
                            effectivedate: '',
                            expirationdate: '',
                            sequencenumber: 0,
                            subcategory: element.value_text,
                            typedescription: element.value_text
                        });
                    }
                }
            });
    }

    isUploadShared: boolean = false;
    closeUploadComponent(){
        this.isUploadShared = false;

    }

    ngOnDestroy() {
        if (this.navigationSubscription) {
          this.navigationSubscription.unsubscribe();
        }
      }

    //1080 Refinement
    toggleAccordion(item: any): void {
        item.expanded = !item.expanded;
    }

    onStartClick(formType: any) {
        if(this.isSupervisor){
            this._alertService.warn('Switch to the Worker role to enter new records');
        } else {
            const url: string = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/attachment/${formType}`;
            this.router.navigate([url], { queryParams: { action: 'start' } });
        }
    }

    viewForm(formType: any, form: any) {
        const formidKey = formType + 'id'; // "form1080a" + "id" = "form1080aid"
        const id = form?.[formidKey];      // Access form['form1080aid']
        const url = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/attachment/${formType}/${id}`;
        this.router.navigate([url], { queryParams: { action: 'view' } });
    }

    editForm(formType: any, form: any) {
        const formidKey = formType + 'id';
        const id = form?.[formidKey];
        const url = `/pages/newintake/my-newintake/${this.intakeNumber}/edit/attachment/${formType}/${id}`;
        this.router.navigate([url], { queryParams: { action: 'edit' } });
    }

    deleteForm(formType: any, form: any) {
        $("#form-delete-popup").modal("show");
        this.formType = formType;
        this.form = form;
    }

    onDeleteRecord() {
        if(this.formType == 'form1080a'){
            this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.Delete;
        } else if(this.formType == 'form1080b'){
            this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.Delete;
        }  else if(this.formType == 'form1080c'){
            this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.Delete;
        }
        const formidKey = this.formType + 'id';     
        const id = this.form?.[formidKey];
        this._service.remove(id).subscribe(
            result => {
                $("#form-delete-popup").modal("hide");
                this.onGetFormList(this.getFormsListUrlMap[this.formType], this.formType);
                this._alertService.success(`${this.formType} Deleted successfully!`);
            },
            (err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    rerouteToForm(formType: any) {
        const url = '/pages/newintake/my-newintake/' + this.intakeNumber + '/edit/attachment/' + formType;
        this.router.navigate([url]);
    }

    onGetFormList(url: any, formType: any) {
        this.formType = formType;
        const inputRequest = {
            objectid: [this.intakeNumber],
        };
        this._service
            .getArrayList(
                new PaginationRequest({
                    where: inputRequest,
                    method: "get",
                }),
                url + "?filter"
            )
            .subscribe(
                (response) => {
                    if(response) {
                        this.formList[formType] = response;
                        this.updatedFormItems(formType, response);
                    }
                },
                (error) => {
                    this._alertService.warn(
                        `Error in retreiving ${formType} data`
                    );
                }
            );
    }

    updatedFormItems(type: string, items: any): void {
        const item: any = this.forms.find(data => data.type === type);
        if (item) {
          item.items = items;
          item.items = this.updateShowHistoryFlagsFor1080(item);
          this.updateForm1080ApprovedPersons(type,item);
          item.items = this.getUniqueRecentRecords(item.items);
        } else {
          console.warn(`Item with type ${type} not found.`);
        }
    }

    getUniqueRecentRecords(items: any[]): any[] {
        const approvedMap = new Map<string, any>();
        const inProgressMap = new Map<string, any>();
    
        for (const record of items) {
            const person = record?.person;
            const status = record?.status;
            const updatedOn = new Date(record.updatedon).getTime();
    
            if (!person) continue;
    
            if (status === 'Approved') {
                const existing = approvedMap.get(person);
                if (!existing || updatedOn > new Date(existing.updatedon).getTime()) {
                    approvedMap.set(person, record);
                }
            }
    
            if (['In Progress', 'Review', 'ReturnToWorker'].includes(status)) {
                const existing = inProgressMap.get(person);
                if (!existing || updatedOn > new Date(existing.updatedon).getTime()) {
                    inProgressMap.set(person, record);
                }
            }
        }
    
        // Combine results from both maps
        return [...approvedMap.values(), ...inProgressMap.values()];
    }

    updateShowHistoryFlagsFor1080(item : any) : any[] {
        const approvedCount = item.items.filter((itemAC: any) => itemAC.status === "Approved").length;
        let result: any[] = [];
        let updatedItems : any;
        if (approvedCount >= 2) {
            updatedItems=  item.items.map((item: any) => ({    // NOSONAR
                ...item,
                showHistory: true,
            }));
        } else {
            updatedItems = item.items.map((item: any) => ({    // NOSONAR
                ...item,
                showHistory: false,
              }));
        }
        result = [...updatedItems];
        return result;
       
    }

    updateForm1080ApprovedPersons (formType : string, item: any) : void {
        // filtering appproved data list to history grid
        const form1080HistoryApprovedList = item.items
        .filter((data: any) => data.status === 'Approved');
                  
        const formhistoryitem = this.formhistory.find(data => data.type === formType);
        if (formhistoryitem && (form1080HistoryApprovedList.length > 2 || item.items.length >= 2)) {           
            formhistoryitem.items = form1080HistoryApprovedList;
        }

       // approved child list of form1080a and form1080b to display approved child list in new form b and c.
       const approveditemsform1080 = item.items
       .filter((data: any) => data.status === 'Approved')
       .map((data: any) => data.personid);

       const approvedChilds: any = this._attachmentService.approvedForm1080Persons.find(itemACH => itemACH.type === formType);
       if (approvedChilds) {
           approvedChilds.items = [...approveditemsform1080];
       }
       this._store.setData('approvedForm1080Persons',this._attachmentService.approvedForm1080Persons);

       // In progress or In review list of records for form1080 a, b and c.
       const inProgressOrReviewitemsform1080 = item.items
       .filter((data: any) => data.status === 'In Progress' || data.status === 'Review' || data.status === 'ReturnToWorker')
       .map((data: any) => data.personid);

       const inProgressOrReviewitems: any = this._attachmentService.inProgressOrReviewForm1080PersonRecords.find(itemPR => itemPR.type === formType);
       if (inProgressOrReviewitems) {
           inProgressOrReviewitems.items = [...inProgressOrReviewitemsform1080];
       }
       this._store.setData('inProgressOrReviewitemsform1080',this._attachmentService.inProgressOrReviewForm1080PersonRecords);
   }

    downloadForm(formType:any, data : any) {
        let modal = {};
        if(formType == 'form1080a' || formType == 'form1080c' ) {
                modal = {
                count: -1,
                where: {
                    documenttemplatekey: [formType],
                    [`${formType}id`]: data[`${formType}id`],
                },
                method: 'post'
                };

        } else if (formType == 'form1080b') {
            modal = {
                count: -1,
                method: 'post',
                where: {
                    documenttemplatekey: [formType],
                    data: data               
                }
            };
        }
    
        this._commonService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
            const blob = new Blob([new Uint8Array(res)]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = formType +  moment().format('MM/DD/YYYY hh:mm A') + `.pdf`;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
        $(this.form1080HistoryModal).modal('hide');  //NOSONAR
    }
    
    getCaseType(){
        return 'Intake';
    }

    //  on click of copy version this function will be called
    copyVersion(formType:any, data : any) : void {
        this.formType = formType;
        this.copiedData =  data;
        $(this.form1080HistoryModal).modal('hide');  //NOSONAR
        $(this.confirmCopyPopupId).modal('show');    //NOSONAR
    }

    // confirm popup no click
    cancelCopy(){
        (<any>$(this.confirmCopyPopupId)).modal('hide');    //NOSONAR
    }

    // confirm popup yes click, mapping data object and clone filed object
    confirmCopy() {
        (<any>$(this.confirmCopyPopupId)).modal('hide');    //NOSONAR
        const cloneData = this.mapCopyData();
        this.copyForm1080(cloneData);
    }

    // calling api to insert copy version
    copyForm1080(formData: any) : void {
        const apiURL = this.returnAPIURL();
        this._service.create(formData, apiURL).subscribe(
            (response: any) => {
                if (response) {
                    const result = JSON.parse(JSON.stringify(response));
                    if (result) {                       
                        this._alertService.success(result.message);    
                        this.fetchListAfterCopy();                 
                    } else {
                        this._alertService.warn(result.message);
                    }
                }
            },
            (_error: any) => {
                this._alertService.warn('Please try again later');
            }
        );
    }

    // mapping row data with new copy version data
    mapCopyData() : any {
        let data = this.copiedData;
        let copy_json;

        // resetting all columns which do not require copy to new version
        if(this.formType == 'form1080a') {
            copy_json = { copyofform1080a: { form1080aid: data?.form1080aid } };
            data.signatureofpersoncompletingthisreport = null;
            data.datecompleted = null;
            data.supervisorcomments = null;
            data.status = 'In Progress';
            data.submitforapproval = 'InProcess';
            data.form1080aid = null;

         } else if(this.formType == 'form1080b'){
            copy_json = { copyofform1080b: { form1080bid: data?.form1080bid } };
            data.signatureofpersoncompletingthisreport = null;
            data.datecompleted = null;
            data.supervisorcomments = null;
            data.status = 'In Progress';
            data.submitforapproval = 'InProcess';
            data.form1080bid = null;

         } else if(this.formType == 'form1080c'){
            copy_json = { copyofform1080c: { form1080cid: data?.form1080cid } };
            data.signatureofpersoncompletingthisreport = null;
            data.datecompleted = null;
            data.supervisorcomments = null;
            data.status = 'In Progress';
            data.submitforapproval = 'InProcess';
            data.form1080cid = null;
         }
         return {...data, ...copy_json};
    }

    // returing API url based on form type.
    returnAPIURL() : string {
        let apiURL: any;
        if(this.formType == 'form1080a') {
            apiURL = CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.AddUpdate;
        } else if(this.formType == 'form1080b') {
            apiURL = CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.AddUpdate;
        } else if(this.formType == 'form1080c') {
            apiURL = CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.AddUpdate;
        } 
        return apiURL;
    }

    // fetching grid list after copy version.
    fetchListAfterCopy() : any {
        if(this.formType == 'form1080a') {
            this.onGetFormList(this.getFormsListUrlMap["form1080a"], "form1080a");   
        } else if(this.formType == 'form1080b') {
            this.onGetFormList(this.getFormsListUrlMap["form1080b"], "form1080b");   
        } else if(this.formType == 'form1080c') {
            this.onGetFormList(this.getFormsListUrlMap["form1080c"], "form1080c");   
        }     
    }

    form1080historyPopup(formType:string, data:any) : void {
        this.updateHistoryPopupHeader(formType);
        const formhistoryitem = this.formhistory?.find(item => item.type === formType && item.items.find((list: any) => list.person === data.person));
        const HistoryApprovedList  = formhistoryitem?.items.map((list: any) => ({
            ...list,
            type: formType,
          }));
        this.formHistoryData = [...(HistoryApprovedList || [])];             
        (<any>$(this.form1080HistoryModal)).modal('show');  // NOSONAR
    }

    updateHistoryPopupHeader(formType : string) : void {
        if(formType == 'form1080a') {
            this.form1080HistoryPopupHeader = "Form 1080A History";   
        } else if(formType == 'form1080b') {
            this.form1080HistoryPopupHeader = "Form 1080B History"; 
        } else if(formType == 'form1080c') {
            this.form1080HistoryPopupHeader = "Form 1080C History"; 
        } 
    }

    updateLoad() {
        // No data or function to call
    }

}
