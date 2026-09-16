
import {map} from 'rxjs/operators';
import { Component, OnInit, ViewChild, AfterViewInit, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';
import _ from 'lodash';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { GenericService, SessionStorageService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { Attachment } from './_entities/attachment.data.models';
import { EditAttachmentComponent } from './edit-attachment/edit-attachment.component';  
import { AppUser, UserInfo} from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services/auth.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { AppConfig } from '../../../../app.config';
import { config } from '../../../../../environments/config';
import { AppConstants } from '../../../../@core/common/constants';
const SCREENING_WORKER = 'SCRNW';
const SUPERVISOR = 'apcs';
const CLW = 'Court Liaison Worker';
const CASE_WORKER = 'Case Worker';
declare var $: any;
import { FormBuilder, FormGroup, FormArray, Validators } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { DsdsService } from '../_services/dsds.service';
import moment from 'moment';
import jsPDF from 'jspdf';
// import html2canvas from 'html2canvas';
import { AttachmentService } from './attachment.service';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
import { AttachmentResolverService } from './attachment-resolver-service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'attachment',
    templateUrl: './attachment.component.html',
    styleUrls: ['./attachment.component.scss'],
    standalone: false
})
export class AttachmentComponent implements OnInit, AfterViewInit {
    petitions: any;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    daNumber: string;
    id: string;
    caseNumber: string ;
    userId: string;
    baseUrl: string;
    filteredAttachmentGrid!: any;
    userfilteredAttachmentGrid!: any;
    @ViewChild(EditAttachmentComponent)
    editAttach!: EditAttachmentComponent;
    documentPropertiesId: any;
    documentId: any;
    isSupervisor: boolean;
    isAdoptionCase: boolean = false;
    token!: AppUser;
    config = { isGenerateUploadTabNeeded: false };
    downldSrcURL: any;
    isServiceCase = false;
    isAppealUser = false;
    selectedDocument: any;
    isGenerateByVictim!: boolean;
    isGenerateByComplaint!: boolean;
    isGenerateByPetition!: boolean;
    complaints: any[] = [];
    victims: any[] = [];
    generateDocForm!: FormGroup;
    intakeNumber!: string;
    involvedPerson: any[] = [];
    involvedChildren: any[] = [];
    involvedUnkPerson: any[] = [];
    selectedPerson: any;
    selectedPersonName = "";
    tab_type = "case";
    contactrecording: any[] = [];
    reasonForContact: any;
    isClosed = false;
    documentFilterForm!: FormGroup;
    personDocumentFilterForm!: FormGroup;
    affidavitForm!: FormGroup;
    categories: any[] = [];
    subCategories: any[] = [];
    paginationInfo: PaginationInfo = new PaginationInfo();
    paginationInfoperson: PaginationInfo = new PaginationInfo();
    totalRecords = 0;
    totalRecordsperson = 0;
    moduleview: any;
    affidavitList: any;
    formList: any = { form1080a: [], form1080b: [], form1080c: [] };
    showAffidavitForm: boolean = false;
    serviceCaseAffidavitId: any;
    isViewAffidavitForm: boolean = false;
    showAffidavitList: boolean = false;
    childrendata: any;
    signatures: any;
    maxAffidavitDate: any;
    showIntendedForm: boolean = false;
    intendedForm!: FormGroup;
    isViewsintendedForm : boolean = false;
    serviceintendedactionid :any;
    showIntendedList: boolean = false;
    intendedList: any;
    houseHoldPerson: any[] = [];
    collateralPerson: any[] = [];
    userDetails: UserInfo;
    serviceIntendedactionid: any;
    templateForm!: FormGroup;
    supervisorDetails: any;
    templateDownloadList: any;
    isReadonly:boolean = false;
    showDelBtn!: boolean;
    unsavedattachmentscount!: number;
    unsavedpersonattachmentscount!: number;
    checkmandatory: boolean = false;
    saveType!: string;
    disableplay:boolean=false;
    activeModuleRole:any;
    userRole: any;
    formType!: string;
    form: any;
    formHistoryData: any[] = [];
    formhistory: any[] = [{ type: "form1080a", items: [] },    
    { type: "form1080b", items: [] },
    { type: "form1080c", items: [] }];
    deletepopupid = '#delete-attachment';
    maxDate: any;
    minDate: any;
    forms: any[] = [{ type: "form1080a", name: "1080 A Form", items: [], expanded: false },
    { type: "form1080b", name: "1080 B Form", items: [], expanded: false },
    { type: "form1080c", name: "1080 C Form", items: [], expanded: false }];
    getFormsListUrlMap: any = {
        "form1080a" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080a.List,
        "form1080b" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.List,
        "form1080c" :  CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.List
    }
    confirmCopyPopupId = '#copy-version';
    form1080HistoryModal = '#form1080-history-modal'
    copiedData : any;
    isCW!: boolean;
    agency!: string;
    form1080HistoryPopupHeader : string = "";
    isSameCountySupervisor = false;
    maxlargefilesize!: string;
    uploadNumber: any;

    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _service: GenericService<Attachment>;
    public _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _router: Router;
    private _session: SessionStorageService;
    private _dsdsService: DsdsService;
    private _attachmentService : AttachmentService;
    isLastAssignedCW = false;
    iscaseexpunged: any;

	constructor(private injector : Injector, private html2canvas:Html2CanvasService,private attachmentResolverService: AttachmentResolverService){
        this._dropDownService = this.injector.get<CommonHttpService>(CommonHttpService);    
		this.route = this.injector.get<ActivatedRoute>(ActivatedRoute); 
        this._router = injector.get<Router>(Router);          
        this._authService = this.injector.get<AuthService>(AuthService);    
	    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);   
        this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._service = this.injector.get<GenericService<Attachment>>(GenericService);
        this._attachmentService = this.injector.get<AttachmentService>(AttachmentService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber =this._dataStoreService.getData("DANUMBER");
        this.userDetails = this._authService.getCurrentUser().user;
        this.userId = this._authService.getCurrentUser().user.securityusersid;
        this.daNumber = this._dataStoreService.getData(
            CASE_STORE_CONSTANTS.DA_NUMBER
        );
        this.baseUrl = AppConfig.baseUrl;
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         this._authService.setAuthDetail('documents',data.result);
        //     }
        // });

        if (this.route.snapshot.params['type']) {
            this.tab_type = this.route.snapshot.params['type'];
        }
    }

    async ngOnInit() {
        this.attachmentResolverService.getDocuments().subscribe({
            next: (data: any) => {
                this._authService.setAuthDetail('documents',data);
            }
        })
        this.maxlargefilesize = this.humanizeBytes(config.largeUploadMaxSizeLimit);
        $('#confirm-copy').modal('show');
        this.route.queryParams.subscribe((params) => {
             if(params['openFormsTab']){
                 this.tab_type = 'affidavit';
             }
          })
        this.moduleview = this._authService.isModuleAccessable(
            "documents",
            "documents"
        );
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.intakeNumber = this._dataStoreService.getData("da_intakenumber");
        this.isServiceCase = this._dsdsService.isServiceCase();
        this.isAdoptionCase = this.storage.getItem("CASE_TYPE") == "ADOPTION";
        this.token = this._authService.getCurrentUser();
        this.activeModuleRole = this.storage.getItem('activeModuleRole');
        this.userRole = this._authService.getCurrentUser();
        this.isLastAssignedCW = this._dataStoreService.getData('IsLastAssignedCW');
        if (this.activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || this.activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || this.activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
            this.disableplay = this.compareWithResponsibleworkers(this.userRole.user.email);
        }
        this.documentFilterForm = this.formBuilder.group({
            category: [null],
            subcategory: [null],
            worker: [null],
            title: [null],
            actualdocumentdate: [null],
        });

        this.personDocumentFilterForm = this.formBuilder.group({
            category: [null],
            subcategory: [null],
            worker: [null],
            title: [null],
            actualdocumentdate: null,
        });
        this.paginationInfo.sortColumn = 'updatedon';
        this.paginationInfoperson.sortColumn = 'updatedon';
        this.paginationInfo.sortBy = 'desc';
        this.paginationInfoperson.sortBy = 'desc';
        this.getInvolvedPerson();
        this.loadAttachments();
        this.getReasonForContact();
        this.listAffidavit();
        this.listIntendeds();
        this.getcollateral();
        this.initAffidavitForm();
        this.setUserRole();
        this._authService.readonlyPage(
            "read_only_access",
            "caseworker-attachment-add",
            [this.generateDocForm]
        );
        this.loadFilterDropdowns();
        this.initIntendedForm();

        this.getListSupervisorDtls();
        const activeModuleRole = this.storage.getItem("activeModuleRole");
        this.showDelBtn = true;
        if (
            activeModuleRole == "CJAMS_SSA_FTDM_FACILITATOR" ||
            activeModuleRole == "CJAMS_SSA_QUALIFIED_INDIVIDUAL" ||
            activeModuleRole == "CJAMS_SSA_FTDM_QI_SUPERVISOR"
        ) {
            this.isReadonly = this.compareWithResponsibleworkers(
                this.token.user.email
            );
            this.showDelBtn = false;
        } else if (activeModuleRole == 'Medical Specialist') {
            this.isReadonly = true;
        } else {
            this.isReadonly = this._authService.readonlyButton(
                "read_only_access",
                "caseworker-attachment-add"
            );
            this.showDelBtn = true;
        }
        this.checkmandatory = false;
        this.onGetFormList(this.getFormsListUrlMap["form1080a"], "form1080a");
        this.onGetFormList(this.getFormsListUrlMap["form1080b"], "form1080b");
        this.onGetFormList(this.getFormsListUrlMap["form1080c"], "form1080c");

        // loading requried data for form 1080 
        this.isCW = false;
        this.agency = this._authService.getAgencyName();
        if (this.agency === 'CW') {
            this.isCW = true;
        }

        // get sdm data for form 1080
        this._attachmentService.getSDMDetailsForForm1080(this.isServiceCase,this.id);

        // get involved persion data for form 1080
        this._attachmentService.getPersonDetails(this.isCW,this.isServiceCase,this.id);
        // resetting IsNew1080FormEntry flag to false
        this._dataStoreService.setData('IsNew1080FormEntry' , false);
        this.checkSupervisorCounty();
    }

    setUserRole() : void {
        if (this._authService.selectedRoleIs(AppConstants.ROLES.APPEAL_USER)) {
            this.isClosed = false;
            this.isAppealUser = true;
        } else {
            const da_status = this.storage.getItem("da_status");
            if (da_status) {
                if (da_status === "Closed" || da_status === "Completed") {
                    this.isClosed = true;
                } else {
                    this.isClosed = false;
                }
            }
        }
    }

    // check if supervisor is from same county
    checkSupervisorCounty() {
        if(this.isSupervisor || this.userRole.role.description.includes('Supervisor')){
            this.isSameCountySupervisor = this._dataStoreService.getData('IsUserFromSameCounty');
        }
    }

    private loadUnsavedAttachmentList() {
        this.unsavedattachmentscount = 0;
        const inputreq = {
            personid: null ,
            intakenumber: this.intakeNumber,
            servicerequestid: (this.isServiceCase || this.isAdoptionCase) ? null : this.id,
            servicecaseid: this.isServiceCase ? this.id : null,
            adoptioncaseid: this.isAdoptionCase ? this.id : null,
            objecttypekey: this.getCaseType(),
            category: null,
            subcategory: null,
            worker: null,
            title: null,
            actualdocumentdate: null,
            sortcolumn: "updatedon",
            sortby: "desc",
            activeflag: 2,
        };
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: "get",
                    page: 1,
                    nolimit: true,
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment
                    .AttachmentGridUrl + "?filter"
            )
            .subscribe((response: any) => {
                if (response && Array.isArray(response) && response.length) {
                    const searchcaseworkerattachments = response[0]
                        .searchcaseworkerattachments
                        ? response[0].searchcaseworkerattachments.filter(
                            (attachement: any) =>
                            attachement["insertedby"] ===
                                this.token.user["securityusersid"] ||
                            attachement["insertedby"] ===
                                this.token.user.userprofile.displayname ||
                            attachement["displayname"] ===
                                this.token.user.userprofile.displayname
                    )
                        : [];
                    const result = searchcaseworkerattachments;
                    if (result) {
                        this.unsavedattachmentscount = result.length;
                    }
                }
            });
    }

    getCaseType(){
        if(this.isAdoptionCase) {
            return  'Adoptioncase';
        } else {
            return this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
        }
   }
    compareWithResponsibleworkers(userDetail: any){
        let activeMod = "";
        if (
            this._session.getItem("activeModuleRole") ==
            "CJAMS_SSA_FTDM_FACILITATOR"
        ) {
            activeMod = "FTDM Facilitator";
        } else if (
            this._session.getItem("activeModuleRole") ==
            "CJAMS_SSA_QUALIFIED_INDIVIDUAL"
        ) {
            activeMod = "Qualified Individual";
        } else if (
            this._session.getItem("activeModuleRole") ==
            "CJAMS_SSA_FTDM_QI_SUPERVISOR"
        ) {
            activeMod = "FTDM/QI Supervisor";
        }

        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        const tempArray = [];
        let isReadonly;
        let responsibleworkers = caseInfo?.responsibleworkers || [];
        for (let worker of responsibleworkers) {
            if (worker?.enddate == null && worker?.email == userDetail && worker?.teamname == activeMod) {
                tempArray.push(worker);
            }
            if (tempArray.length != 0) { isReadonly = true; }
            else { isReadonly = false; }
        }
        isReadonly = tempArray.length ? true : false;
        return isReadonly;
    }
    loadFilterDropdowns() {
        this._dropDownService
            .getSingle(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment
                    .AttachmentClassificationTypeUrl +
                '?filter={"nolimit": true}'
            )
            .subscribe((data) => {
                if (data && data.length > 0) {
                    const categories = data.filter((item: any) =>
                        item.typedescription.startsWith("CW-")
                    );
                    this.categories = _.uniqBy(categories, "typedescription");
                    //To accomodate the data from migration the subcategory list is being added to the categories
                    this.categories.map((item) => {
                        item.subcategory = item.typedescription;
                    });
                    this.categories.push(...categories);
                    this.categories = _.uniqBy(this.categories, "subcategory");
                    this.categories = _.sortBy(this.categories, "subcategory");
                    this.subCategories = data.filter((item: any) =>
                        item.typedescription.startsWith("CW-")
                    );
                    this.loadAttachmentDropDown();
                } else {
                    this.categories = [];
                }
            });
    }

    loadAttachments() {
        this.loadAttachmentList();
        this.loadUnsavedAttachmentList();
        this.getContactRecordings();
        this.prepareConfig();
        this.initGenerateDocForm();
        this.personattachment();
    }
    addtoCase(params: any) {
        const event = params.event; 
        const fileDetails = params.fileDetails;
        fileDetails.isSelected = event.checked;
        const casetype = (this.isServiceCase || this.isAdoptionCase) ? 'Non CPS' : 'CPS'
        this.linkPersonDocuments(this.selectedPerson, event.checked, fileDetails.documentpropertiesid, casetype);
    }
    onPersonChecked(event: any) {
        this.selectedPerson = event.value.personid;
        this._dataStoreService.setData('personIdSelectedOnDocumentsTab', this.selectedPerson);
        this.selectedPersonName = event.value.fullname;        
        this._dataStoreService.setData('personNameSelectedOnDocumentsTab', this.selectedPersonName);       
        this._dataStoreService.setData('personcjamspidSelectedOnDocumentsTab', event.value.cjamspid);
        this.totalRecordsperson = 0;
        this.personattachment();
        this.loadUnsavedPersonAttachmentList();
    }
    uploadFileforPerson(uploadtype: any) {
        if (!this.selectedPerson) {
            this._alertService.error("Please select a person");
        } else {
            const page_type = "person";
            this._router.navigate([
                "/pages/case-worker/" +
                this.id +
                "/" +
                this.daNumber +
                "/dsds-action/attachment/" +
                uploadtype +
                "/" +
                page_type +
                "/" +
                this.selectedPerson,
            ]);
        }
    }
    getInvolvedPerson() {
        let inputRequest: Object;
        const isExpungementSuperUser =  this._authService.isExpungementSuperUser();
        if (this.isServiceCase) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: "servicecase",
            };
        } else {
            inputRequest = {
                intakeserviceid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
                 'iscaseexpunged': this.iscaseexpunged
            };
        }
        this._dropDownService
            .getSingle(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    nolimit: true,
                    method: "get",
                    where: inputRequest,
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                    .PersonList + "?filter"
            )
            .subscribe(data => {
                if (data && data.data.length > 0) {
                    this.involvedPerson = data.data;
                    this.checkInvolvedPerson();


                }
            });
    }
    checkInvolvedPerson() {
        this.involvedPerson.forEach(element => {
            const checkChildExist = element.roles?.filter((item: any) => item.intakeservicerequestpersontypekey === 'CHILD')
            if (checkChildExist?.length) {
                this.involvedChildren.push(element);
            }
        })


        this.involvedPerson.forEach(element => {
            const checkChildExist = element.roles?.filter((item: { intakeservicerequestpersontypekey: string; }) => item.intakeservicerequestpersontypekey === 'LG' || item.intakeservicerequestpersontypekey === 'PARENT')
            if (checkChildExist?.length) {
                this.houseHoldPerson.push(element);
            }
        })

        const selectedPersonId = this._dataStoreService.getData('personIdSelectedOnDocumentsTab');
        if (selectedPersonId) {
            const selectedPerson = this.getSelectedPersonDetails(selectedPersonId);
            if (selectedPerson) {
                this.onPersonChecked({ 'value': selectedPerson })
            }
        }
    }
    getcollateral() {
        let inputRequest: Object;
        if (this.isServiceCase) {
            inputRequest = {
                objectid: this.id,
                objecttype: "case",
            };
        } else {
            inputRequest = {
                intakeserviceid: this.id,
                objecttype: "intake",
            };
        }
        this._dropDownService
            .getSingle(
                {
                    nolimit: true,
                    method: 'get',
                    where: inputRequest
                },
                'collateral/list?filter'
            )
            .subscribe(data => {
                if (data && data.length && data[0].getcollateraldetails && data[0].getcollateraldetails.length) {
                    data[0].getcollateraldetails.map((element: any) => {
                        element?.collateralroleconfig?.map((item: any) => {
                            if (item.description === 'Caretaker-Caregiver') {
                                this.collateralPerson.push({
                                    fullname: element.fullname,
                                    collateraladdress: element.collateraladdress
                                })
                            }
                        })
                    })
                } else {
                    this.collateralPerson = [];
                }
            });
    }
    ngAfterViewInit() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
            $(':button').prop('disabled', true);
            $('span').css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
            $('i').css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
            $('th a').css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
        }
    }
    checkFileType(file: string, accept: string): boolean {
        if (accept && file) {
            const acceptedFilesArray = accept.split(",");
            return acceptedFilesArray.some((type) => {
                const validType = type.trim();
                if (validType.charAt(0) === ".") {
                    return file.toLowerCase().endsWith(validType.toLowerCase());
                }
                return false;
            });
        }
        return true;
    }
    editAttachment(modal: any) {
        this.editAttach.editForm(JSON.parse(JSON.stringify(modal)), true);
        $('#edit-attachment').modal('show');
    }

    viewAttachment(modal: any) {
        this.editAttach.editForm(JSON.parse(JSON.stringify(modal)), false);
        $('#edit-attachment').modal('show');
    }
    confirmDelete(modal: any) {
        this.documentPropertiesId = modal.documentpropertiesid;
        this.documentId = modal.ecmsdocumentid;
        $(this.deletepopupid).modal('show');
    }
    deleteAttachment() {
        const workEnv = config.workEnvironment;
        if (workEnv === "state") {
            this._service.endpointUrl =
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
            const id = this.documentPropertiesId + '&' + this.documentId;
            this._service.remove(id).subscribe((_result: any) => {
                    $(this.deletepopupid).modal('hide');
                    this.loadAttachmentList();
                    this.getContactRecordings();
                    this._alertService.success(
                        "Attachment Deleted successfully!"
                    );
                    if (this.selectedPerson) {
                        this.personattachment();
                    }
                }, (_err: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        } else {
            this._service.endpointUrl =
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
            this._service.remove(this.documentId).subscribe((_result: any) => {
                    $(this.deletepopupid).modal('hide');

                    if (this.selectedPerson) {
                        this.personattachment();
                    }
                    this.loadAttachmentList();
                    this.getContactRecordings();
                    this._alertService.success(
                        "Attachment Deleted successfully!"
                    );
                },
                (_err: any) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }

    downloadFile(source: any) {
        const s3bucketpathname = (source.s3bucketpathname || '').replace(/,/g, '');
        this.downldSrcURL = '/api' + s3bucketpathname;
        // Download options for audio and video files
        // var audio_Extensions= ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
        // var video_Extensions= ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
        // if (audio_Extensions.includes(this.downldSrcURL.split('.')[1]) || video_Extensions.includes(this.downldSrcURL.split('.')[1])) {
        this._commonService
            .downloadXml(
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileFromECMS + '?docId=' + source.ecmsdocumentid + '&filename=' + source.originalfilename
            ).subscribe((result: any) => {
                const blob = new Blob([result]);
                const link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = source.originalfilename;
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            });
        // } else {
        //     window.open(this.downldSrcURL, '_blank');
        // }
    }

   downloadLargeFile(source: any) {
    this._commonService
        .downloadXml(
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileFromEDMS + '?docId=' + source.ecmsdocumentid + '&filename=' + source.originalfilename
        ).subscribe((payload: any) => {
            const blob = new Blob([payload]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = source.originalfilename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
}

    linkPersonDocuments(personid: any, status: any, documentpropertiesid: any, casetype: any) {
        this._service
            .getSingle(
                {},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.PersonAttachmentUpdate + '/' + this.id + '/' + personid + '/' + status + '/' + documentpropertiesid + '/' + casetype + '?data'
            )
            .subscribe((result: any) => {
                if (result.error === 0) {
                    this.loadAttachments();
                    this._alertService.success(result.message);
                } else {
                    this._alertService.success("error occured");
                }
            });
    }
    private personattachment() {
        if (this.selectedPerson) {
            this.userfilteredAttachmentGrid = [];
            const documentFilter = this.personDocumentFilterForm.getRawValue();
            let category = null;
            let subcategory = null;
            if (Array.isArray(documentFilter.category) && documentFilter.category.length) {
                category = '{' + '"' + documentFilter.category.join('","') + '"' + '}';
            }
            if (Array.isArray(documentFilter.subcategory) && documentFilter.subcategory.length) {
                subcategory = '{' + '"' + documentFilter.subcategory.join('","') + '"' + '}';
            }
            const inputreq = {
                personid: this.selectedPerson,
                intakenumber: this.id,
                servicerequestid: null,
                servicecaseid: null,
                adoptioncaseid: null,
                objecttypekey: 'Person',
                category: category,
                subcategory: subcategory,
                worker: documentFilter.worker,
                title: documentFilter.title,
                sortcolumn: this.paginationInfoperson.sortColumn,
                sortby: this.paginationInfoperson.sortBy
            };
            this.getpersonattachments(inputreq);

        }
    }

    getpersonattachments(inputreq: any) {
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: 'get',
                    page: this.paginationInfoperson.pageNumber,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter').subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        const result = response[0].searchcaseworkerattachments;
                        if (result) {
                            this.totalRecordsperson = result[0].count;
                            result.map((item: any) => {
                                item.numberofbytes = this.humanizeBytes(
                                    item.numberofbytes
                                );
                            });
                            this.userfilteredAttachmentGrid = result;
                            this.userfilteredAttachmentGrid.forEach(
                                (attach: any) => {
                                    attach.uplodeddate = moment(
                                        attach.insertedon
                                    ).format("MM/DD/YYYY hh:mm A");
                                    attach.actualdocumentdate =
                                        attach.actualdocumentdate
                                            ? moment(
                                                attach.actualdocumentdate
                                            ).format("MM/DD/YYYY")
                                            : null;
                                }
                            );
                        } else {
                            this.userfilteredAttachmentGrid = [];
                        }
                    } else {
                        this.userfilteredAttachmentGrid = [];
                    }
                });
    }

    private loadUnsavedPersonAttachmentList() {
        this.unsavedpersonattachmentscount = 0;
        const inputreq = {
            personid: this.selectedPerson,
            objecttypekey: "Person",
            activeflag: 2,
            sortcolumn: "updatedon",
            sortby: "desc",
        };

        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: "get",
                    page: this.paginationInfoperson.pageNumber,
                    nolimit: true,
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment
                    .AttachmentGridUrl + "?filter"
            )
            .subscribe((response: any) => {
                if (response && Array.isArray(response) && response.length) {
                    const result = response[0].searchcaseworkerattachments;
                    if (result) {
                        this.unsavedpersonattachmentscount = result[0].count;
                    }
                }
            });
    }

    private attachment() {
        this._dropDownService
            .getArrayList(
                new PaginationRequest({
                    nolimit: true,
                    method: "get",
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment
                    .AttachmentGridUrl +
                "/" +
                this.id +
                "?data"
            )
            .subscribe((result) => {
                result.forEach(item => {
                    item.numberofbytes = this.humanizeBytes(item.numberofbytes);
                });
                this.filteredAttachmentGrid = result;
            });
    }

    private loadAttachmentList() {
        const documentFilter = this.documentFilterForm.getRawValue();
        let category = null;
        let subcategory = null;
        if (
            Array.isArray(documentFilter.category) &&
            documentFilter.category.length
        ) {
            category =
                "{" + '"' + documentFilter.category.join('","') + '"' + "}";
        }
        if (
            Array.isArray(documentFilter.subcategory) &&
            documentFilter.subcategory.length
        ) {
            subcategory =
                "{" + '"' + documentFilter.subcategory.join('","') + '"' + "}";
        }
        let objecttypekey = this.isServiceCase ? 'Servicecase' : 'ServiceRequest';
        const inputreq = {
            personid: null,
            intakenumber: null,
            servicerequestid:
                this.isServiceCase || this.isAdoptionCase ? null : this.id,
            servicecaseid: this.isServiceCase ? this.id : null,
            adoptioncaseid: this.isAdoptionCase ? this.id : null,
            objecttypekey: this.isAdoptionCase ? 'Adoptioncase' : objecttypekey,
            category: category,
            subcategory: subcategory,
            worker: documentFilter.worker,
            title: documentFilter.title,
            actualdocumentdate: documentFilter.actualdocumentdate,
            sortcolumn: this.paginationInfo.sortColumn,
            sortby: this.paginationInfo.sortBy,
        };
        this.getAttachments(inputreq);

    }

    getAttachments(inputreq: any) {
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    where: inputreq,
                    method: "get",
                    page: this.paginationInfo.pageNumber,
                    limit: 10,
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentGridUrl + '?filter').subscribe((response: any) => {
                    if (response && Array.isArray(response) && response.length) {
                        const result = response[0].searchcaseworkerattachments;
                        if (result) {
                            this.totalRecords = result[0].count;
                            result.map((item: { numberofbytes: any; }) => {
                                item.numberofbytes = this.humanizeBytes(item.numberofbytes);
                            });
                            this.filteredAttachmentGrid = result;
                            this.filteredAttachmentGrid.forEach((attach: any) => {
                                attach.uplodeddate = moment(attach.insertedon).format('MM/DD/YYYY hh:mm A');
                                attach.actualdocumentdate = (attach.actualdocumentdate) ? moment(attach.actualdocumentdate).format('MM/DD/YYYY') : null;
                            });
                        } else {
                            this.filteredAttachmentGrid = [];
                        }
                    } else {
                        this.filteredAttachmentGrid = [];
                    }
                });
    }

    getContactRecordings() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: {'isExpungementSuperUser': isExpungementSuperUser, 'iscaseexpunged': this.iscaseexpunged},
                    method: "get",
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording
                    .GetAllDaRecordingUrl +
                "/" +
                this.id +
                "?data"
            )
            .subscribe((result) => {
                this.contactrecording = result.data;
                this.setcontacttype();
            });
    }
    getReasonForContact() {
        this._dropDownService
            .getSingle({}, 'Progressnotereasontypes?filter={"nolimit":true}')
            .pipe(
                map((itm) => {
                    return itm;
                })
            )
            .subscribe((data) => {
                this.reasonForContact = data;
                this.setcontacttype();
            });
    }

    setcontacttype() {
        if (
            Array.isArray(this.reasonForContact) &&
            Array.isArray(this.contactrecording)
        ) {
            this.contactrecording.forEach((item: any) => {
                const pr = item.progressnotereasontypekey.split(",");
                let description = "";
                pr.forEach((element: any, index: any) => {
                    const reason = this.reasonForContact.find((re: any) => re.progressnotereasontypekey === element);
                    description = (index === (pr.length - 1)) ? description + reason?.typedescription : description + reason?.typedescription + ', ';
                });
                item.progressnotereasontypedescription = description;
            });
        }
    }

    private humanizeBytes(bytes: number): string {
        if (bytes === 0) {
            return "0 Byte";
        }
        if (!bytes) {
            return "";
        }
        const k = 1024;
        const sizes: string[] = ["Bytes", "KB", "MB", "GB", "TB", "PB"];
        const i: number = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
    }

    initGenerateDocForm() {
        this.generateDocForm = this.formBuilder.group({
            complaint: [null],
            victim: [null],
            petition: [null],
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

    toggleTable(id: string) {
        $('#' + id).collapse('toggle');
    }

    filterDocuments() {
        this.loadAttachmentList();
        this.paginationInfo.pageNumber = 1;
    }

    filterPersonDocuments() {
        this.personattachment();
    }
    resetfilterDocuments() {
        this.documentFilterForm.reset();
        this.loadAttachments();
    }

    resetPersonFilterDocuments() {
        this.personDocumentFilterForm.reset();
        this.personattachment();
    }

    pageChanged(pageNumber: any) {
        this.paginationInfo.pageNumber = pageNumber;
        this.loadAttachments();
    }

    pdpageChanged(pageNumber: any) {
        this.paginationInfoperson.pageNumber = pageNumber;
        this.personattachment();
    }

    onSorted($event: any) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.loadAttachments();
    }

    onPDSorted($event: any) {
        this.paginationInfoperson.sortBy = $event.sortDirection;
        this.paginationInfoperson.sortColumn = $event.sortColumn;
        this.personattachment();
    }

    updated() {
        this.loadAttachments();
    }

    getSelectedPersonDetails(selectedPersonId: any) {
        return this.involvedPerson.find(
            (person: any) => person.personid == selectedPersonId
        );
    }

    initAffidavitForm(): void {
        this.affidavitForm = this.formBuilder.group({
            servicecaseaffidavitid: [null],
            caregivername: [""],
            caregiverdob: [null],
            caregiveraddress: [""],
            isbloodrelationship: [null],
            ischildfriend: [null],
            ischildfamilfriend: [null],
            hasstrongbondwithchild: [null],
            hasstrongbondwithfamily: [null],
            hasregularcontactwithchild: [null],
            hasregularcontactwithfamily: [null],
            description: [""],
            applicant1signature: [null],
            applicant1name: [null],
            applicant1date: [null],
            applicant2name: [null],
            applicant2signature: [null],
            applicant2date: [null],
            parent1name: [null],
            parent1signature: [null],
            parent1date: [null],
            parent2name: [null],
            parent2signature: [null],
            parent2date: [null],
            childname: [null],
            childsignature: [null],
            childdate: [null],
            isapplicantsignatureavailable: [false],
        });
        this.affidavitForm.setControl(
            "childrendata",
            this.formBuilder.array([])
        );
    }

    addChildrenToAffidavit(model: any) {
        const control = <FormArray>this.affidavitForm.controls['childrendata'];

        if (control.length > 0) {
            const temp = control.getRawValue();
            if (temp[control.length - 1].personid === "") {
                this._alertService.warn('Please fill the opened child form');
                return false;
            }
        }

        control.push(this.createChildrenDataFormGroup(model));
    }
      
    createChildrenDataFormGroup(modal: any) {
        return this.formBuilder.group({
            name: modal.fullname ? modal.fullname : "",
            dob: modal.dob ? new Date(modal.dob) : "",
            clientid: modal.cjamspid ? modal.cjamspid : "",
            personid: modal.personid ? modal.personid : "",
        });
    }

    removeChildrenFromAffidavit(index: number) {
        const control = <FormArray>this.affidavitForm.controls["childrendata"];
        control.removeAt(index);
    }
    
    openAffidavitForm() {
        const url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/attachment`;
        this._router.navigate([url]);        
        this.signatures = {
            applicant1: null,
            applicant2: null,
            parent1: null,
            parent2: null,
            child: null,
        };
        this.showAffidavitForm = true;
        this.isViewAffidavitForm = false;
        this.showIntendedForm = false;
    
    }

    viewAffidavit(data: any) {
        this.isViewAffidavitForm = true;
        this.affidavitForm.patchValue(data);
        this.affidavitForm.disable();
        this.signatures = {
            applicant1: data.applicant1signature,
            applicant2: data.applicant2signature,
            parent1: data.parent1signature,
            parent2: data.parent2signature,
            child: data.childsignature,
        };
        this.showAffidavitForm = true;
        this.showIntendedForm = false;
    }

    editAffidavit(data: any) {
        this.isViewAffidavitForm = false;
        this.affidavitForm.patchValue(data);
        this.affidavitForm.enable();
        this.signatures = {
            applicant1: data.applicant1signature,
            applicant2: data.applicant2signature,
            parent1: data.parent1signature,
            parent2: data.parent2signature,
            child: data.childsignature,
        };
        this.showAffidavitForm = true;
        this.showIntendedForm = false;
    }

    cancelAffidavit() {
        this.showAffidavitForm = false;
    }

    submitAffidavit() {
        this.checkmandatory = true;
        if (!this.affidavitForm.invalid) {
            const formData = this.affidavitForm.getRawValue();

            if (formData.childrendata.length === 0) {
                this._alertService.warn('Please enter atleast one child information');
                return false;
            }

            if (!formData.isapplicantsignatureavailable && (formData.applicant1name === null || formData.applicant1date === null || formData.applicant1signature === null || formData.applicant1signature === '')) {
                this._alertService.warn('Please enter applicant information');
                return false;
            }

            formData.objectkey = 'servicecase';
            formData.objectid = this.id;
            formData.typekey = 'CAREGIVER';

            this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.Affidavit.AddUpdate).subscribe(
                (response: any) => {
                    if (response) {

                        const result = JSON.parse(JSON.stringify(response));
                        if (result.code === 200) {
                            this._alertService.success(result.message);
                            this.listAffidavit();
                            this.showAffidavitForm = false;
                            this.checkmandatory = false;
                            this.affidavitForm.reset();
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
    }

    private listAffidavit() {

        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: { objectid: this.id },
                    method: 'post'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Affidavit.List
            )
            .subscribe((result) => {
                this.affidavitList = result;
            });

    }

    confirmDeleteAffidavit(modal: any) {
        this.serviceCaseAffidavitId = modal.servicecaseaffidavitid;
        $('#delete-affidavit').modal('show');
    }

    setChildInfo(personid: any, index: any) {
        const personInfo = this.involvedPerson.find(
            (item: any) => item.personid === personid
        );
        const control = <FormArray>this.affidavitForm.controls["childrendata"];
        control.removeAt(index);
        control.push(this.createChildrenDataFormGroup(personInfo));
    }
    deleteAffidavit() {
        this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Affidavit.Delete;
        this._service.remove(this.serviceCaseAffidavitId).subscribe(
            _result => {
                $('#delete-affidavit').modal('hide');
                this.listAffidavit();
                this._alertService.success('Affidavit Deleted successfully!');
            },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    generatePDF(data: any) {
        this.isViewAffidavitForm = true;
        this.affidavitForm.patchValue(data);
        this.affidavitForm.disable();
        this.signatures = {
            applicant1: data.applicant1signature,
            applicant2: data.applicant2signature,
            parent1: data.parent1signature,
            parent2: data.parent2signature,
            child: data.childsignature,
        };
        this.showAffidavitForm = true;

        const doc: any = new jsPDF('p', 'mm', 'a4');
        const affForm: any = document.getElementById('affidavit-form');
        this.html2canvas.capture(affForm).then((canvas: any) => {
            const imgData = canvas.toDataURL('image/png');
            const pageHeight = 300;
            const imgWidth = 205;
            const imgHeight = (canvas.height * imgWidth) / canvas.width;
            let heightLeft = imgHeight;
            let position = 0;

            doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            while (heightLeft >= 0) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, "PNG", 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            doc.save("kinship_caregiver_affidavit.pdf");
            this.showAffidavitForm = false;
        });
    }
    public initIntendedForm(): void {
        this.intendedForm = this.formBuilder.group({
            serviceintendedactionid: [null],
            actiondate: [null],
            caregivername: [null],
            caregiverid: [null],
            collateral: [null],
            addresslineone: [null],
            addresslinetwo: [null],
            servicecaseid: [null],
            specificregulationsupportingdecision: [null],
            servicestofamilieswithchildren: [null],
            familypreservationservices: [null],
            riskofharmservices: [null],
            interagencyfamilypreservationldssbased: [null],
            requestofanotheragencyroa: [null],
            voluntaryplacementrequesttimelimited: [null],
            voluntaryplacementrequestchilddisability: [null],
            voluntaryplacementrequestenhancedaftercare: [null],
            permanencyservices: [null],
            independentlivingaftercareservices: [null],
            gap: [null],
            adoptionsubsidy: [null],
            adoptionservices: [null],
            kinshipnavigationservices: [null],
            resourcehomes: [null],
            interstatecompact: [null],

            childassessedtobesafe: [null],
            serviceobjectiveshavebeenachieved: [null],
            familynolongerwantsservice: [null],
            familyisnotactivelyprogressingtoward: [null],
            agencyrelatedcourtinvolvementhasbeenterminated: [null],
            familyhasmovedtoanotherjurisdiction: [null],
            referralmadetoanotherserviceprogram: [null],
            familycannotbelocated: [null],
            other: [null],
            otherspecify: [null],

            closecase: [null],
            transfercase: [null],
            transfercasespecify: [null],
            actiontobetakenother: [null],
            actiontobetakenspecify: [null],

            dsrdes: [null],

            insertedby: [null],
        });
        this.templateForm = this.formBuilder.group({
            selecttemplate: [null, Validators.required],
        });
    }
    

    submitIntendedForm() {
        this.checkmandatory = true;
        if (!this.intendedForm.invalid) {
            const formData = this.intendedForm.getRawValue();

            formData.objectkey = "servicecase";
            formData.objectid = this.id;
            formData.typekey = "CAREGIVER";

            this._service
                .create(
                    formData,
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Intended.AddUpdate
                )
                .subscribe(
                    (response: any) => {
                        if (response) {
                            let result = JSON.parse(JSON.stringify(response));
                            if (result.code === 200) {
                                this._alertService.success(result.message);
                                this.listIntendeds();
                                this.showIntendedForm = false;
                                this.checkmandatory = false;
                                this.intendedForm.reset();
                                $("#submit-Intended").modal("show");
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
    }
    
    private listIntendeds() {
            this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    where: { objectid: this.id },
                    method: "post",
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Intended.List
            )
            .subscribe((result) => {
                this.intendedList = result;
            });
    }

    /**
     * Open Intended form
     */
    public openIntendedForm(): void {
        const url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/attachment`;
        this._router.navigate([url]);
        this.isViewsintendedForm = false;
        this.showAffidavitForm = false;
        this.isViewAffidavitForm = false;
        this.showIntendedForm = true;
        this.intendedForm.reset();

        this.intendedForm.patchValue({
            servicecaseid: this.daNumber
        });
    }
    
    /**
     * Close Intended form
     */
    public cancelIntended(): void {
        this.showIntendedForm = false;
    }
    viewIntended(data: any) {
        this.isViewsintendedForm = true;
        this.showIntendedForm = true;
        this.intendedForm.patchValue(data);
        this.intendedForm.disable();
        this.showAffidavitForm = false;

    }

    editIntended(data: any) {
        this.isViewsintendedForm = false;
        this.showIntendedForm = true;
        this.intendedForm.patchValue(data);
        this.intendedForm.enable();
        this.showAffidavitForm = false;

    }

    fetchCaregiverAddress(id: any) {
        this.intendedForm.patchValue({
            addresslineone: null,
            addresslinetwo: null,
        });
        const personData = this.houseHoldPerson.find(
            (item) => item.personid === id
        );
        if (personData && personData.address) {
            this.intendedForm.patchValue({
                addresslineone: personData.address,
                addresslinetwo: this.addAddress(personData),
            });
        }
    }

    fetchCollateralCaregiverAddress(fullname: any) {
        this.intendedForm.patchValue({
            addresslineone: null,
            addresslinetwo: null,
        });
        const personData = this.collateralPerson.find(
            (item) => item.fullname === fullname
        );
        if (personData && personData.collateraladdress.length) {
            const address = personData.collateraladdress[0];
            this.intendedForm.patchValue({
                addresslineone: address.address1,
                addresslinetwo: this.addCollateralAddress(address),
            });
        }
    }

    addCollateralAddress(data: any): string {
        let address = "";
        if (data.address2) {
            address = data.address2;
        }
        if (data.cityname) {
            address = address ? address + ", " + data.cityname : data.cityname;
        }
        if (data.statetypekey) {
            address = address
                ? address + ", " + data.statetypekey
                : data.statetypekey;
        }
        if (data.zip5no) {
            address = address ? address + ", " + data.zip5no : data.zip5no;
        }
        return address;
    }

    addAddress(data: any): string {
        let address = "";
        if (data.addAddress2) {
            address = data.addAddress2;
        }
        if (data.city) {
            address = address ? address + ", " + data.city : data.city;
        }
        if (data.state) {
            address = address ? address + ", " + data.state : data.state;
        }
        if (data.zipcode) {
            address = address ? address + ", " + data.zipcode : data.zipcode;
        }
        return address;
    }

    intendedActionsTaken(data: any, modal: any) {
        if(modal) {
            if(data === 'closecase') {
                this.intendedForm.patchValue({
                    transfercase: null,
                    transfercasespecify: null,
                    actiontobetakenother: null,
                    actiontobetakenspecify: null,
                });
            } else if (data === "transfercase") {
                this.intendedForm.patchValue({
                    closecase: null,
                    actiontobetakenother: null,
                    actiontobetakenspecify: null,
                });
            } else if (data === "actiontobetakenother") {
                this.intendedForm.patchValue({
                    closecase: null,
                    transfercase: null,
                    transfercasespecify: null,
                });
            }
        }
    }
    confirmDeleteIntended(modal: any):void {
        this.serviceintendedactionid = modal.serviceintendedactionid;
        $('#delete-Intended').modal('show');
    }

    deleteIntended(): void {
        this._service.endpointUrl =
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Intended.Delete;
        this._service.remove(this.serviceintendedactionid).subscribe(
            _result => {
                $('#delete-Intended').modal('hide');
                this.listIntendeds(); 
                this._alertService.success('Intended Deleted successfully!');
            },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    generateIntendedPDF(data: any): void{
        this.serviceintendedactionid = data.serviceintendedactionid;
        this.templateDownloadList = [
            {
                name: "Blank Template",
                value: "Blank_Template",
            },
        ];
        this.templateForm.reset();
        $('#Intended-pdf').modal('show');
    }
    printPDF() {

        const pageRequest ={
            "count": -1,
            "where": {
                "documenttemplatekey": [
                    "serviceintendedaction"
                ],
                "serviceintendedactionid": this.serviceintendedactionid
            },
            "method": "post"
        }
        const endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Intended.download;
        this._commonService.download(endpointUrl, pageRequest).subscribe(
            response => {
                $('#Intended-pdf').modal('hide');
                const pdfData = response && response !== null  ?   response : '';
                const blob = new Blob([new Uint8Array(pdfData)]);
                const link = document.createElement("a");
                link.href = window.URL.createObjectURL(blob);
                link.download = 'Intended_Action_Letter.pdf';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            },
            _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    getListSupervisorDtls(){
        
        this._dropDownService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                    securityuserid: this.userId,
                    method: "post",
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Intended.details
            )
            .subscribe((result: any) => {
                this.supervisorDetails = result[0];
            });
    }
    loadAttachmentDropDown() {
        this._dropDownService
            .getArrayList(
                {
                    method: "get",
                    where: {
                        referencetypeid: 1000,
                        teamtypekey: "CW",
                        order: "displayorder ASC",
                    },
                },
                "referencetype/gettypes" + "?filter"
            )
            .subscribe((items) => {
                for (let {parentkey = null, activeflag, value_text} of items ) {
                    let obj = {
                        activeflag:  activeflag,
                        attachmentclassificationtypekey: '',
                        datavalue: 0,
                        editable: 0,
                        effectivedate: '',
                        expirationdate: '',
                        sequencenumber: 0,
                        subcategory: value_text,
                        typedescription: value_text,   
                    };
                    if(parentkey === null) {
                        this.categories.push(obj);
                    } else {
                        this.subCategories.push(obj);
                    }
                }
            });
    }
    getChildrenDataFn() {
        this.affidavitForm.get('childrendata')?.get('controls')
        const childrenData = this.affidavitForm.get('childrendata') as FormArray;
        return childrenData ? childrenData.controls : [];
    }
    onGetFormList(url: any, formType: any) {
        this.formType = formType;
        const inputRequest = {
            objectid: [this.id,this.intakeNumber],
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
                (_error) => {
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
        const approvedCount = item.items.filter((item1: any) => item1.status === "Approved").length;
        let result: any[] = [];
        let updatedItems : any;
        if (approvedCount >= 2) {
            updatedItems=  item.items.map((item2: any) => ({
                ...item2,
                showHistory: true,
            }));
        } else {
            updatedItems = item.items.map((item3: any) => ({
                ...item3,
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

        const approvedChilds: any = this._attachmentService.approvedForm1080Persons.find(item1 => item1.type === formType);
        if (approvedChilds) {
            approvedChilds.items = [...approveditemsform1080];
        }
        this._dataStoreService.setData('approvedForm1080Persons',this._attachmentService.approvedForm1080Persons);

        // In progress or In review list of records for form1080 a, b and c.
        const inProgressOrReviewitemsform1080 = item.items
        .filter((data: any) => data.status === 'In Progress' || data.status === 'Review' || data.status === 'ReturnToWorker')
        .map((data: any) => data.personid);

        const inProgressOrReviewitems: any = this._attachmentService.inProgressOrReviewForm1080PersonRecords.find(item2 => item2.type === formType);
        if (inProgressOrReviewitems) {
            inProgressOrReviewitems.items = [...inProgressOrReviewitemsform1080];
        }
        this._dataStoreService.setData('inProgressOrReviewitemsform1080',this._attachmentService.inProgressOrReviewForm1080PersonRecords);
    }

    toggleAccordion(item: any): void {
        item.expanded = !item.expanded;
    }

    onStartClick(formType: any) {
        if(this.isSupervisor){
            this._alertService.warn('Switch to the Case Worker role to enter new records');
        } else {
            const url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/${formType}`;
            this._router.navigate([url], { queryParams: { action: 'start' } });
        }
    }

    viewForm(formType: any, form: any) {
        const formidKey = formType + 'id'; // "form1080a" + "id" = "form1080aid"
        const id = form?.[formidKey];      // Access form['form1080aid']
        const url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/${formType}/${id}`;
        this._router.navigate([url], { queryParams: { action: 'view' } });
        $(this.form1080HistoryModal).modal('hide');
    }

    editForm(formType: any, form: any) {
        const formidKey = formType + 'id';
        const id = form?.[formidKey];
        const url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/${formType}/${id}`;
        this._router.navigate([url], { queryParams: { action: 'edit' } });
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
            _result => {
                $("#form-delete-popup").modal("hide");
                this.onGetFormList(this.getFormsListUrlMap[this.formType], this.formType);
                this._alertService.success(`${this.formType} Deleted successfully!`);
            },
            (_err) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );

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
        $(this.form1080HistoryModal).modal('hide');
    }

     //  on click of copy version this function will be called
      copyVersion(formType:any, data : any) : void {
            this.formType = formType;
            this.copiedData =  data;
            $(this.form1080HistoryModal).modal('hide');
            $(this.confirmCopyPopupId).modal('show');
      }
   
      // confirm popup no click
      cancelCopy(){
        $(this.confirmCopyPopupId).modal('hide');
      }

      // confirm popup yes click, mapping data object and clone filed object
      confirmCopy() {
        $(this.confirmCopyPopupId).modal('hide');
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
            $(this.form1080HistoryModal).modal('show');
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
    handleTabTypeChange(tabType: any){
        this.tab_type = tabType;
    }

    updateLoad() {
        // No data or function to call or add
    }
}