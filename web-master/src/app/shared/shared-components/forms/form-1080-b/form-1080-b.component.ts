
import { Component, OnInit, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Observable } from 'rxjs';
import { DropdownModel, DynamicObject, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonDropdownsService, GenericService, SessionStorageService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../pages/case-worker/case-worker-url.config';
import { Form1080b } from '../../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { UserInfo } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services/auth.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { AppConfig } from '../../../../app.config';
import { AppConstants } from '../../../../@core/common/constants';
declare var $: any;
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../../../pages/case-worker/_entities/caseworker.data.constants';
import { DsdsService } from '../../../../pages/case-worker/dsds-action/_services/dsds.service';
import moment from 'moment';
import { AttachmentService } from '../../../../pages/case-worker/dsds-action/attachment/attachment.service';
import { IntakeStoreConstants } from '../../../../pages/newintake/my-newintake/my-newintake.constants';
import { MatSelectChange } from '@angular/material/select';


@Component({
    // tslint:disable-next-line:component-selector
    selector: "form-1080-b",
    templateUrl: "./form-1080-b.component.html",
    styleUrls: ["./form-1080-b.component.scss"],
    standalone: false
})
export class Form1080BComponent implements OnInit {
    formType: string = 'form1080b';
    successpopupid: string = '#success-popup';
    jurisdictionwithchildresponsibility!: string;
    sex!: string;
    race!: string;
    enthnicity!: string;
    locationtypewhereincidentoccurred!: string;
    placementprovideratthetimeoftheincident!: string;
    countyjurisdictionwheretheincidentoccurred!: string;
    signatureofpersoncompletingthisreport!: string;
    form1080b!: FormGroup;
    formData: any;
    userRole: any;
    deletepopupid = '#delete-attachment';
    petitions: any;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    daNumber: string;
    id: string;
    formId!: string | null;
    action!: string;
    caseNumber: string;
    userId: string;
    isSupervisor: boolean;
    baseUrl: string;
    supervisorDropdownList: any[] = [];
    currentSuperVisorId!: string;
    userDetails: UserInfo;
    yesterdayDate: Date;
    isServiceCase: any;
    selectedSupervisorId!: string;
    supervisorcomments: any;
    submitforapproval: string = 'InProcess';
    status: string = 'In Progress';
    notifymsg!: string;
    tosecurityusersid!: string;
    store: DynamicObject;
    childList: any[] = [];
    involvedPerson: any[] = [];
    childListDetails: any[] = [];
    otherChildrenDetails: any[] = [];
    supvCommentsMandatory : boolean = false;

    
    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _service: GenericService<Form1080b>;
    public _authService: AuthService;
    private _dataStoreService: DataStoreService;
    private storage: SessionStorageService;
    private _commonService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _router: Router;
    private _session: SessionStorageService;
    private _dsdsService: DsdsService;
    private _attachmentService : AttachmentService;

    constructor(private injector: Injector) {
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
        this._service = this.injector.get<GenericService<Form1080b>>(GenericService);
        this._attachmentService = this.injector.get<AttachmentService>(AttachmentService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._dataStoreService.getData("DANUMBER");
        this.userDetails = this._authService.getCurrentUser().user;
        this.userId = this._authService.getCurrentUser().user.securityusersid;
        this.store = this._dataStoreService.getCurrentStore();

        this.daNumber = this._dataStoreService.getData(
            CASE_STORE_CONSTANTS.DA_NUMBER
        );
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        let d = new Date()
        d.setDate(d.getDate() - 1)
        this.yesterdayDate = d
        this.baseUrl = AppConfig.baseUrl;
        this.getRoutingUsers();

    }

    ngOnInit() {
        const currentDate = new Date();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        this.tosecurityusersid = this.userDetails?.userprofile?.supervisorid;
        this.form1080b = this.formBuilder.group({
            form1080bid: null,          
            casenumber: [null, Validators.required],  
            personid: [null, Validators.required],
            provideasummaryoftheinvestigationandidentifyanybarriestheldss: [null, Validators.required],
            whatisthemedicalexaminerspreliminaryfinding: [{ value: null, disabled: true }, Validators.required],
            signatureofpersoncompletingthisreport: [null],
            datecompleted: currentDate,
            submitforapproval: [null],
            supervisorcomments:[{ value: null, disabled: !this.isSupervisor }],
            supervisornameVal: [null],
        });
        this.form1080b.controls['casenumber'].setValue(this.daNumber);
        if(this.isIntakeMode()) {
            this.form1080b.controls['casenumber'].setValue(this.getIntakeNumber());
        }
        this.route.queryParams.subscribe(params => {
            this.action = params.action;
            if (this.action === 'view') {
                this.form1080b.disable();
            } else {
                this.form1080b.enable();
                // enabling and disabling whatisthemedicalexaminerspreliminaryfinding field based on child fatility value
                this.checkSDM();
                this.enableDisableSupervisorComments();
            }
        });

        // get child or alleged victim data
        this.checkinvolvedPersonroles(); 
        this.route.paramMap.subscribe(params => {
            this.formId = params.get('id');
            if (this.formId) {
                const inputRequest = {
                    form1080bid: this.formId
                }
                this._service
                    .getArrayList(
                        {
                            where: inputRequest,
                            method: "get",
                        },
                        CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.GetFormData + "?filter"
                    )
                    .subscribe(
                        (response: any) => {
                            this.formData = response;
                            this.status = response["status"];
                            this.submitforapproval = response["status"] === 'Review' ? 'InProcess': response["submitforapproval"];
                            this.supervisorcomments = response["supervisorcomments"];
                            this.form1080b.patchValue({
                                ...response
                            });

                            if(this.isSupervisor && this.status === 'Review'){
                                this.form1080b.get('submitforapproval')?.setValue(null);
                            }

                        });
            }
        });

       this.updateForm1080Validations();
    }

    updateForm1080Validations() : void {
        if(this.isSupervisor){
            this.form1080b.get('submitforapproval')?.setValidators([Validators.required]);
        } else {
            this.form1080b.get('submitforapproval')?.clearValidators();
        }
        this.form1080b.get('submitforapproval')?.updateValueAndValidity();
    }

    getRoutingUsers() {
        this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'INTR' },
                method: 'post'
            }),
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.SupervisorList
        ).subscribe(result => {
                this.supervisorDropdownList = result.data;                   
                const supervisorId = this.userDetails?.userprofile?.supervisorid;
                const name =  result?.data?.find(supervisor => 
                supervisor?.userid === supervisorId)?.username;
                if(name){
                    this.form1080b.controls['supervisornameVal'].setValue(supervisorId);
                }
            });
    }

    checkinvolvedPersonroles() {
        this.involvedPerson =  this._dataStoreService.getData('involvedPerson');
        if(this.involvedPerson) {
        this.involvedPerson.forEach(ele => {
            ele.dob =  ele.dob ? moment(ele.dob).format('MM/DD/YYYY') : null;
            if (ele.roles) {
                const childArray = ['CHILD', 'AV', 'OTHERCHILD'];
                const roles = ele.roles.map((roleid: any) => roleid.intakeservicerequestpersontypekey);
                const smallerArray = childArray.length < roles.length ? childArray : roles;
                const largerArray = childArray.length >= roles.length ? childArray : roles;
                this.updateChildList(smallerArray,largerArray, ele);
            }
        });
        }
    }

    updateChildList(smallerArray: any, largerArray: any, ele: any) {
        const isChildOrAV = smallerArray.some((val: any) => largerArray.includes(val));
        if (isChildOrAV) {
            this.childList.push({ personid: ele.personid, fullname: ele.fullname, userroles: ele.userroles });
        }
    }

    checkSDM() {
        const res = this._dataStoreService.getData('form1080SDM_Data');
        let sdm;
        if(res) {
            if (this.isServiceCase) {
                const i = res[0].getservicecasesdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getservicecasesdm[i];
            } else {
                const i = res[0].getintakeservicerequestsdm.findIndex((x: any) => x.pathwaystatus === 'Accepted')
                sdm = res[0].getintakeservicerequestsdm[i];
            }
        }

        if (this.isIntakeMode() && !res) {
            sdm = this.store[IntakeStoreConstants.intakeSDM];
        }

        if (sdm) {
            this.enableDisableMEPFindings(sdm.ischildfatality);
        }
    }

    enableDisableSupervisorComments(): void {
        const supervisorcomments = this.form1080b.get('supervisorcomments');
        if (this.isSupervisor) {
            supervisorcomments?.enable();
        } else {
            supervisorcomments?.disable();
        }
    }

    enableDisableMEPFindings(ischildfatality: any): void {
        const MEPFindings = this.form1080b.get('whatisthemedicalexaminerspreliminaryfinding');
        if (ischildfatality) {
            MEPFindings?.enable();
        } else {
            MEPFindings?.disable();
        }
    }

    onChildSelect(event: MatSelectChange) {
        const personid = event.value;      
        if (!this._attachmentService.childHavingApprovedFormAandB('form1080b',personid)) {
            this._alertService.warn('The selected child does not have an approved 1080A form record.');
            this.form1080b.get('personid')?.reset();

        } else if (this._attachmentService.childHavingInprogressOrReviewRecordsFormABC('form1080b',personid)){
            this._alertService.warn('The selected child already has an active record.');
            this.form1080b.get('personid')?.reset();

        }          
    }

    onSubmitToSupervisor() {
        if (['VALID'].includes(this.form1080b.status)) {
            const processObj = {isSubmitToSupervisor: true};
            this.saveAsDraft(processObj);
        } else {
            this._alertService.warn('Please fill the required fields.');
        }
    }
    onRouting() {
        if(this.isSupervisor) {
            if(this.status === 'ReturnToWorker'){
                this.notifymsg = 'Form 1080B Return To Worker';
            } else {
                this.notifymsg = 'Form 1080B Approved';
            }
            this.tosecurityusersid = this?.formData?.updatedby;
        } else {
            this.status = 'review'
            this.notifymsg = 'Form 1080B submitted successfully';
            this.tosecurityusersid = this.userDetails?.userprofile?.supervisorid;
            if(this.selectedSupervisorId){
                //for now just overriding it if a supervisor is selected in dropdown list
                this.tosecurityusersid = this.selectedSupervisorId;
            }
        }

        let requestObjectid = this.id;
        let requestEventcode = 'SPLR';
        if(this.isIntakeMode()) {
            requestObjectid = this.getIntakeNumber()
            requestEventcode = 'INTKFORM';
        }

        this._commonService
            .create(
                {
                    objectid: requestObjectid,
                    eventcode: requestEventcode,
                    status: this.status === 'ReturnToWorker'? 'Rejected' : this.status,
                    comments: this.notifymsg,
                    notifymsg: this.notifymsg,
                    routeddescription: this.notifymsg,
                    assessmmentName: 'form108b',
                    tosecurityusersid: this.tosecurityusersid
                },
                'routing/routingupdate'
            )
            .subscribe(
                () => {
                    this._alertService.success(this.notifymsg);
                },
                err => {
                    this._alertService.error("Routing Update failed, please contact support");
                }
            );
    }
    disableSupervisorSubmit() {
        return this.action === 'view';
    }
    navigateBack() {
        this.redirectToAttachment();
        $(this.successpopupid).modal('hide');
    }
    redirectToAttachment() {
        let url = `/pages/case-worker/${this.id}/${this.daNumber}/dsds-action/attachment`;
        if(this.isIntakeMode()) {
            url = `/pages/newintake/my-newintake/${this.getIntakeNumber()}/edit/attachment`;
        }
        this._router.navigate([url], {
            queryParams: { openFormsTab: true}
        });
    }

    onSelectSupervisor(event: MatSelectChange) {
        this.selectedSupervisorId = event.value;
    }

    onSupervisorSubmit() {
        if(this.validateIfSupervisorCommentsEntered()){
            const processObject = {isSupervisorSubmit: true};
            this.saveAsDraft(processObject);
        }
    }

    onSupervisorApprovalChange() : void {
        const selected = this.form1080b.get('submitforapproval')?.value;
        if (selected === 'ReturnToWorker') {
            this.supvCommentsMandatory = true;
        } else {
            this.supvCommentsMandatory = false;
        }
    }

    validateIfSupervisorCommentsEntered() : boolean {
        let isSelected = true;
        const selected = this.form1080b.get('submitforapproval')?.value;
        const supervisorcomments = this.form1080b.get('supervisorcomments')?.value;
        if(selected === 'ReturnToWorker') {
           if(supervisorcomments == null || supervisorcomments == '' || supervisorcomments == "" ) {
            this._alertService.warn('Please enter supervisor comments');
            isSelected = false;
           }
        } else if(selected === null){
            this._alertService.warn('Please select supervisor approval');
            isSelected = false;
        }
        return isSelected;
    }  

    saveAsDraft(processObject: any): void {      // NOSONAR
        if(this.form1080b.get('personid')?.value == null)
        {
            this._alertService.warn("Please select Alleged victim / Child");
        } else {
            if (this.formId) {
                this.form1080b.patchValue({ form1080bid: this.formId });
            } else {
                this.form1080b.patchValue({ form1080bid: null });
            }
            let formData = this.form1080b.getRawValue();
            
            //Set the objectid and objecttype based on intake or case
            formData.objecttype = 'servicerequest';
            if(this.isServiceCase) {
                formData.objecttype = 'servicecase';
            }
            formData.objectid = this.id;
            if (this.isIntakeMode()) {
                formData.objecttype = 'intake';
                formData.objectid = this.getIntakeNumber();
            }
            
            if(processObject?.isSupervisorSubmit) {
                this.submitforapproval = this.form1080b.get("submitforapproval")?.value;
                this.status = this.submitforapproval  === 'InProcess' ? this.status : this.submitforapproval;
                formData['status'] = this.status;
                formData['submitforapproval'] = this.submitforapproval;
            } else {
                if(!processObject?.isSubmitToSupervisor) {
                    this.form1080b.patchValue({submitforapproval: this.submitforapproval});
                    formData['submitforapproval'] = this.submitforapproval;
                    formData['status'] = 'In Progress';
                } else {
                    this.status = 'Review';
                    formData['status'] = this.status;
                }
            }
            formData = {...this.formData, ...formData, id: this.id}

            this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080b.AddUpdate).subscribe(
                (response: any) => {
                    if (response) {

                        const result = JSON.parse(JSON.stringify(response));
                        if (result) {
                            this.formId = result?.formid;
                            this._alertService.success(result.message);
                            if(this.status !== "In Progress") {
                                this.onRouting();
                                this.redirectToAttachment();
                            }
                          
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

    //Should abstract all this out into service and set at init level itself
    isIntakeMode() {
        return this.getIntakeNumber() ? true : false;
    }

    getIntakeNumber() {
        const intakeStore = this._dataStoreService.getObj('intake');
        if (intakeStore && intakeStore.number) {
            return intakeStore.number;
        } else {
            return null;
        }
    }

}