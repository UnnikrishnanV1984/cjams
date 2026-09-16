import { Component, OnInit, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { DynamicObject, DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService, SessionStorageService, DataStoreService, ValidationService } from '../../../../@core/services';
import { AlertService } from '../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { CaseWorkerUrlConfig } from '../../../../pages/case-worker/case-worker-url.config';
import { Form1080c } from '../../../../pages/case-worker/dsds-action/attachment/_entities/attachment.data.models';
import { UserInfo } from '../../../../@core/entities/authDataModel';
import { AuthService } from '../../../../@core/services/auth.service';
import { AppConfig } from '../../../../app.config';
import { AppConstants } from '../../../../@core/common/constants';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../../../pages/case-worker/_entities/caseworker.data.constants';
import { DsdsService } from '../../../../pages/case-worker/dsds-action/_services/dsds.service';
import moment from 'moment';
import { MatSelectChange } from '@angular/material/select';
declare var $: any;
import { AttachmentService } from '../../../../pages/case-worker/dsds-action/attachment/attachment.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: "form-1080-c",
    templateUrl: "./form-1080-c.component.html",
    styleUrls: ["./form-1080-c.component.scss"],
    standalone: false
})
export class Form1080CComponent implements OnInit {
    formType: string = 'form1080c';
    successpopupid: string = '#success-popup';
    signatureofpersoncompletingthisreport!: string;
    form1080c!: FormGroup;
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
    userDetails: UserInfo;
    yesterdayDate: Date;
    selectedSupervisorId!: string;
    supervisorcomments: any;
    submitforapproval: string = 'InProcess';
    status: string = 'In Progress';
    notifymsg!: string;
    tosecurityusersid!: string;
    store: DynamicObject;
    childList: any[] = [];
    courtOrderDetails: any[] = [];
    supervisorDropdownList: any[] = [];
    currentSuperVisorId!: string;
    selectedActions: string[] = [];
    selectedLegalOutcomes: string[] = [];
    supvCommentsMandatory : boolean = false;
    submitted = false;
    isFatalIncidentMandatory = false;
    incidentCheckbox = false;
    legalCheckbox = false;
    dispositionalfindingsMandatory = false;
    isServiceCase: any;
    ischildfatality = false;

    options1: string[] = [
        'N/A',
        'No action',
        'License suspended',
        'License revoked',
        'Investigation ongoing',
        'Other'
    ];
    
    options2: string[] = [
        'No charges filed',
        'Charges pending',
        'Charges filed',
        'Law Enforcement investigation ongoing',
        'Unknown'
    ];

    private _dropDownService: CommonHttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;
    private _service: GenericService<Form1080c>;
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
        this._service = this.injector.get<GenericService<Form1080c>>(GenericService);
        this._attachmentService = this.injector.get<AttachmentService>(AttachmentService);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.caseNumber = this._dataStoreService.getData("DANUMBER");
        // source._value.DANUMBER
        this.userDetails = this._authService.getCurrentUser().user;
        this.userId = this._authService.getCurrentUser().user.securityusersid;
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        this.store = this._dataStoreService.getCurrentStore();

        let d = new Date();
        d.setDate(d.getDate() - 1);
        this.yesterdayDate = d;
        this.baseUrl = AppConfig.baseUrl;
        this.getRoutingUsers();

    }
    ngOnInit() {        // NOSONAR
        const currentDate = new Date();
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');        
        this.form1080c = this.formBuilder.group({
            form1080cid: null,
            doesmaltreatmentappeartohavebeenacontributingfactor: [null, Validators.required],
            ifincidentoccurredinlicensedsettingindicateactiontaken: [[], Validators.required],
            specify: [null],
            legaloutcomeinthisincident: [[]],
            wasthisincidentrelatedtosleeporanunsafesleepenvironment: [null, Validators.required],
            inthe72hoursbeforethefatalincidentwasthechildinjured: [null, Validators.required],
            // Maltreatment types with checkboxes and radio buttons
            physicalabuse: [null],
            physicalabuseradio: [null],
            sexualabuse: [null],
            sexualabuseradio: [null],
            neglect: [null],
            neglectradio: [null],
            mentalinjuryabuse: [null],
            mentalinjuryabuseradio: [null],
            mentalinjuryneglect: [null],
            mentalinjuryneglectradio: [null],
            summaryoffactsandfindingincludingtheeventdateinthecase: [null, Validators.required],
            // CINA questions
            theallegedlymaltreatedchild: [null, Validators.required],
            siblingsoftheallegedlymaltreatedchild: [null, Validators.required],
            otherchildinhouseholdfamilyorincaseofallegedmaltreater: [null, Validators.required],
            // Risk factors - Child
            substanceusechild: [null],
            mentalillnesschild: [null],
            domesticviolencechild: [null],
            prenatalexposurechild: [null],
            noprenatalcarechild: [null],
            childfatalitychild: [null],
            medicalconditionchild: [null],
            healthinsurancechild: [null],
            otherchild: [null],
            
            // Risk factors - Family
            substanceusefamily: [null],
            mentalillnessfamily: [null],
            domesticviolencefamily: [null],
            prenatalexposurefamily: [null],
            noprenatalcarefamily: [null],
            childfatalityfamily: [null],
            medicalconditionfamily: [null],
            healthinsurancefamily: [null],
            otherfamily: [null],
            
            // Risk factors - Caregiver
            substanceusecaregiver: [null],
            mentalillnesscaregiver: [null],
            domesticviolencecaregiver: [null],
            prenatalexposurecaregiver: [null],
            noprenatalcarecaregiver: [null],
            childfatalitycaregiver: [null],
            medicalconditioncaregiver: [null],
            healthinsurancecaregiver: [null],
            othercaregiver: [null],
            describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc: [null, Validators.required],
            // Signature and contact information
            signatureofpersoncompletingthisreport: [null],
            personcompletingthisreport: [null],
            supervisor: [null],
            phonenumber: [null],
            supervisorphonenumber: [null],
            email:  [null, [ValidationService.mailFormat]],
            supervisoremail: [null, ValidationService.mailFormat],
            datecompleted: currentDate,
            submitforapproval: [null],
            supervisorcomments: [null],
            personid: [null, Validators.required],
            supervisornameVal: [null],
            //Other custom risk factor rows
            otherriskfactors : this.formBuilder.array([])
        });
        this.tosecurityusersid = this.userDetails?.userprofile?.supervisorid;

        this.form1080c.get('ifincidentoccurredinlicensedsettingindicateactiontaken')?.valueChanges.subscribe(value => {
            this.selectedActions = value || [];
            const specifyControl = this.form1080c.get('specify');
            if (this.selectedActions.includes('Other')) {
                specifyControl?.setValidators([Validators.required]);
            } else {
                specifyControl?.clearValidators();
                specifyControl?.setValue(null);
            }
            specifyControl?.updateValueAndValidity();
        });
        // Load existing form data if editing
        this.route.paramMap.subscribe(params => {
            this.formId = params.get('id');
            if (this.formId) {
                this._service
                    .getById(this.formId, this.formType)
                    .subscribe((response: any) => {
                        this.formData = response;
                        this.status = response["status"];
                        // Handle array fields for checkboxes
                        if (response.ifincidentoccurredinlicensedsettingindicateactiontaken) {
                            const selActions = response.ifincidentoccurredinlicensedsettingindicateactiontaken;
                            this.selectedActions = Array.isArray(selActions) ? selActions : JSON.parse(selActions);
                        }
                        
                        if (response.legaloutcomeinthisincident) {
                            const selIncident = response.legaloutcomeinthisincident;
                            this.selectedLegalOutcomes = Array.isArray(selIncident) ? selIncident : JSON.parse(selIncident);
                        }
                        
                        
                        this.form1080c.patchValue({
                            ...response, 
                            ifincidentoccurredinlicensedsettingindicateactiontaken: this.selectedActions,
                            legaloutcomeinthisincident: this.selectedLegalOutcomes
                        });

                        const riskArray = response.otherriskfactors || [];
                        this.otherRiskFactors.clear();
                        riskArray.forEach((risk: any) => {
                            this.otherRiskFactors.push(this.formBuilder.group({
                                description: [risk.description || ''],
                                child: [risk.child || false],
                                family: [risk.family || false],
                                caregiver: [risk.caregiver || false]
                            }));
                        });

                        if(this.isSupervisor && this.status === 'Review'){
                            this.form1080c.get('submitforapproval')?.setValue(null);
                        }
                    });
            }
        });
        this.route.queryParams.subscribe(params => {
            this.action = params.action;
            if (this.action === 'view') {
                this.form1080c.disable();
            } else {
                this.form1080c.enable();
            }
        });
        setTimeout(() => {
            this.getInvolvedPerson();
        }, 0)

        if(this.isSupervisor){
            this.form1080c.get('submitforapproval')?.setValidators([Validators.required]);
        } else {
            this.form1080c.get('submitforapproval')?.clearValidators();
        }
        this.form1080c.get('submitforapproval')?.updateValueAndValidity();

        //checkIsChildFatality
        this.checkIsChildFatality();
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
                    this.form1080c.controls['supervisornameVal'].setValue(supervisorId);
                }
            });
    }



    getInvolvedPerson() {       // NOSONAR
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        let url = '';
    
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        let inputRequest: Object;
        let courtReqObj: any;
        let isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase) {
            inputRequest = {
                objectid: this.id,
                objecttypekey: 'servicecase',
                servicecaseid: this.id,
                isExpungementSuperUser: isExpungementSuperUser,
            };
            courtReqObj = {
                objectid: this.id,
                objecttype: 'servicecase',
                isExpungementSuperUser: isExpungementSuperUser,
                'iscaseexpunged': iscaseexpunged
            };
        }
        else {
            inputRequest = {
                intakeserviceid: this.id
            };
            courtReqObj = { intakeserviceid: this.id };
        }

        if (this.isIntakeMode()) {
            inputRequest = { intakenumber: this.getIntakeNumber() };
        }

        forkJoin([
            this._service.getArrayList(
                {
                    method: 'get',
                    where: inputRequest
                },
                url + '?filter'
            ),
            this._service.getArrayList(
                {
                    method: 'get',
                    where: courtReqObj
                },
                `${CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.GetCourtOrderUrl}?filter`
            )])
            .subscribe((data: any) => {
                let personRespones = data[0];
                this.courtOrderDetails = data[1];
                if (personRespones && personRespones.data && personRespones.data.length > 0) {
                    personRespones = personRespones.data;
                    let isFatalIncident = (personRespones.filter((person: any) => (person.dateofdeath && ['OTHERCHILD', 'CHILD', 'AV'].indexOf(person.rolename) > -1)));
                    const control = this.form1080c.get('inthe72hoursbeforethefatalincidentwasthechildinjured');
                    if (isFatalIncident.length === 0) {
                        control?.clearValidators();
                        control?.disable();
                        this.isFatalIncidentMandatory = false;
                    } else {
                        control?.setValidators(Validators.required);
                        control?.enable();
                        this.isFatalIncidentMandatory = true;
                    }
                    control?.updateValueAndValidity();
                    personRespones.forEach((ele: any) => {
                        ele.dob =  ele.dob ? moment(ele.dob).format('MM/DD/YYYY') : null;
                        if (ele.roles) {
                            const childArray = ['CHILD', 'AV', 'OTHERCHILD'];
                            const roles = ele.roles.map((roleid: any) => roleid.intakeservicerequestpersontypekey);
                            const smallerArray = childArray.length < roles.length ? childArray : roles;
                            const largerArray = childArray.length >= roles.length ? childArray : roles;
                            const isChildOrAV = smallerArray.some((val: any) => largerArray.includes(val));
                            if (isChildOrAV) {
                                this.childList.push({ personid: ele.personid, fullname: ele.fullname, userroles: ele.userroles, relationshiparray : ele.relationshiparray });
                            }
                        }
                    });
                }
            });
    }
    isOtherActionSelected(): boolean {
        return this.selectedActions.includes('Other');
    }

    isValidateMultiCheckbox () {
        let response: boolean = true;
        const incCheckbox: any =  this.form1080c.get('ifincidentoccurredinlicensedsettingindicateactiontaken')?.value;
        const legCheckbox: any = this.form1080c.get('legaloutcomeinthisincident')?.value;

        if(incCheckbox.length > 0) {
            this.incidentCheckbox = false;
        } else {
            this.incidentCheckbox = true;
            response = false;
        }

        if(legCheckbox.length > 0) {
            this.legalCheckbox = false;
        } else {
            this.legalCheckbox = true;
            response = false;
        }

        //Disclosure of information validation 
        //physicalabuse
       if(this.form1080c.get('physicalabuse')?.value === null && 
            this.form1080c.get('sexualabuse')?.value === null &&
            this.form1080c.get('neglect')?.value === null && 
            this.form1080c.get('mentalinjuryabuse')?.value === null &&
            this.form1080c.get('mentalinjuryneglect')?.value === null) {
         response = false;
         this.dispositionalfindingsMandatory = true;
       } else {
            this.dispositionalfindingsMandatory = false;
       }
        return response;
    }

    onSubmitToSupervisor() {
        this.submitted = true;
        if(this.isValidateMultiCheckbox()) {

            if (['VALID'].includes(this.form1080c.status)) {
                const processObj = {isSubmitToSupervisor: true};
                this.saveAsDraft(processObj);
            } else {
                this._alertService.warn('Please fill the required fields.');
            }
        } else {
            this._alertService.warn('Please fill the required fields.');
        }
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

    validateIfSupervisorCommentsEntered() : boolean {
        let isSelected = true;
        const selected = this.form1080c.get('submitforapproval')?.value;
        const supervisorcomments = this.form1080c.get('supervisorcomments')?.value;
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

    saveAsDraft(processObject: any = null): void {   // NOSONAR
        if(this.form1080c.get('personid')?.value == null)
        {
            this._alertService.warn("Please select Alleged victim / Child");
        } else {
        if (this.formId) {
            this.form1080c.patchValue({ form1080cid: this.formId });
        } else {
            this.form1080c.patchValue({ form1080cid: null });
        }
        
        let formData = this.form1080c.getRawValue();

        //Set the objectid and objecttype based on intake or case
        formData.objecttype = 'servicerequest';
        if(this.isServiceCase) {
            formData.objecttype = 'servicecase';
        }
        formData.objectid = this.id;
        formData.casenumber = this.caseNumber;
        if (this.isIntakeMode()) {
            formData.objecttype = 'intake';
            formData.objectid = this.getIntakeNumber();
            formData.casenumber = this.getIntakeNumber();
        }
        
        if(processObject?.isSupervisorSubmit) {
            this.submitforapproval = this.form1080c.get("submitforapproval")?.value;
            this.status = this.submitforapproval  === 'InProcess' ? this.status : this.submitforapproval;
            formData['status'] = this.status;
            formData['submitforapproval'] = this.submitforapproval;
        } else {
            if(!processObject?.isSubmitToSupervisor) {
                this.form1080c.patchValue({submitforapproval: this.submitforapproval});
                formData['submitforapproval'] = this.submitforapproval;
                formData['status'] = 'In Progress';
            } else {
                this.status = 'Review';
                formData['status'] = this.status;
            }
        }
        formData = {...this.formData, ...formData, id: this.id};

        this._service.create(formData, CaseWorkerUrlConfig.EndPoint.DSDSAction.Form1080c.AddUpdate).subscribe(
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
    onLegalOutcomeCheckboxChange(event: any, option: string): void {

        if (event.checked) {
            if (!this.selectedLegalOutcomes.includes(option)) {
              this.selectedLegalOutcomes.push(option);
            }
          } else {
            this.selectedLegalOutcomes = this.selectedLegalOutcomes.filter(a => a !== option);
          }

        this.form1080c.patchValue({
            legaloutcomeinthisincident: [...this.selectedLegalOutcomes]
        });
    }
    onRouting() {
        if(this.isSupervisor) {
            if(this.status === 'ReturnToWorker'){
                this.notifymsg = 'Form 1080C Return To Worker';
            } else {
                this.notifymsg = 'Form 1080C Approved';
            }
            
            this.tosecurityusersid = this?.formData?.updatedby;
        } else {
            this.status = 'review'
            this.notifymsg = 'Form 1080C submitted successfully ';
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
                    assessmmentName: 'form1080c',
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
    private prepareFormData() {
        const formValue = this.form1080c.value;
        if (!this.selectedActions.includes('Other')) {
            formValue.specify = null;
        }
        
        const booleanFields = [
            "doesmaltreatmentappeartohavebeenacontributingfactor"
          
        ];
        
        const convertedData = { ...formValue };
        booleanFields.forEach(field => {
            if (convertedData[field] === "1") {
                convertedData[field] = true;
            } else if (convertedData[field] === "0") {
                convertedData[field] = false;
            }
        });
        
        return convertedData;
    }

    disableSupervisorSubmit() {
        return this.action === 'view';
    }

    onSupervisorApprovalChange() : void {
        const selected = this.form1080c.get('submitforapproval')?.value;
        if (selected === 'ReturnToWorker') {
            this.supvCommentsMandatory = true;
        } else {
            this.supvCommentsMandatory = false;
        }
    }


    onActionCheckboxChange(event: any, option: string): void {
          if (event.checked) {
          if (!this.selectedActions.includes(option)) {
            this.selectedActions.push(option);
          }
        } else {
          this.selectedActions = this.selectedActions.filter(a => a !== option);
        }
        
        this.form1080c.patchValue({
            ifincidentoccurredinlicensedsettingindicateactiontaken: [...this.selectedActions]
        });
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

    checkIsChildFatality() {
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
            this.ischildfatality = sdm?.ischildfatality;
        }
    }

    onChildSelect(child: any): void {       // NOSONAR
        const personid = child?.personid;
        if (!this._attachmentService.childHavingApprovedFormAandB('form1080c',personid)) {
            this._alertService.warn('The selected child does not have an approved 1080B form record.');
            this.form1080c.get('personid')?.reset();

        } else if(this._attachmentService.childHavingInprogressOrReviewRecordsFormABC('form1080c',personid)){
            this._alertService.warn('The selected child already has an active record.');
            this.form1080c.get('personid')?.reset();

        }         
        else {

            // contributing factor check
            if(this.ischildfatality){
                this.getForm1080CContributingFactorValidationData(personid);
            }

            const control = this.form1080c.get('theallegedlymaltreatedchild');
            if (!this.courtOrderDetails?.length || !control) return;
        
            // Helper to check for CHIFOUCIN outcome
            const hasCHIFOUCINOutcome = (personId: any): boolean => {
                const selectedItem: any = this.courtOrderDetails.filter(
                    (item: any) => item?.personid === personId && item?.isactivehearing === true
                );               
                return selectedItem.some((item: any) =>
                    item.hearingoutcome.some((e: any) => e.hearingoutcometypekey?.includes('CHIFOUCIN'))
                ) || false;
            };

            // Helper to check sibling relationship types
            const isSiblingRelationPerson = (description: string): boolean => {
                return [
                    'Biological Brother',
                    'Biological Sister',
                    'Half Brother',
                    'Half Sister',
                    'Legal Brother',
                    'Legal Sister'
                ].includes(description);
            };
        
        
            // Process the allegedly maltreated child
            const hasRelevantOutcome = hasCHIFOUCINOutcome(personid);
            if (hasRelevantOutcome) {
            control.setValidators(Validators.required);
            control.setValue('1');
            } else {
            control.clearValidators();
            control.setValue('0');
            }
            control.updateValueAndValidity();
        
            const getRelationshipDescription = (relationshipData : any ,primaryId: string, secondaryId: string): string | null => {
                const relation = relationshipData.find(
                    (item: any) =>
                        item.primaryuserid === primaryId &&
                        item.secondaryuserid === secondaryId
                );
                return relation?.description || null;
            };

                // Process siblings of the allegedly maltreated child
                let isSiblingsoftheallegedlymaltreatedchild = false;

                for (const e of this.childList) {
                    if (personid === e.personid) continue; // Skip the selected child itself

                    // Check if the child has CHIFOUCIN outcome
                    const cinaFound = hasCHIFOUCINOutcome(e.personid);
                    if (cinaFound) {
                        
                    const relation: any = getRelationshipDescription(e.relationshiparray,personid, e.personid);

                    // Only check for sibling relationship if CHIFOUCIN outcome exists
                    if (isSiblingRelationPerson(relation)) {
                        isSiblingsoftheallegedlymaltreatedchild = true;
                        break; // Exit early if condition is met
                    }
                }
                }
        
            const control2: any = this.form1080c.get('siblingsoftheallegedlymaltreatedchild');
            if (isSiblingsoftheallegedlymaltreatedchild) {
            control2.setValidators(Validators.required);
            control2.setValue('1');
            } else {
            control2.clearValidators();
            control2.setValue('0');
            }
            
            control2.updateValueAndValidity();
        
            // Process other children in household/family or case of alleged maltreater
            let isOtherchildinhouseholdfamilyorincaseofallegedmaltreater = false;
            for (const e of this.childList) {
                if (personid === e.personid) continue; // Skip the selected child itself

                // Check if the child has CHIFOUCIN outcome
                const cinaFound = hasCHIFOUCINOutcome(e.personid);
                if (cinaFound) {
                    isOtherchildinhouseholdfamilyorincaseofallegedmaltreater = true;
                 }
            }
        
            const control3: any = this.form1080c.get('otherchildinhouseholdfamilyorincaseofallegedmaltreater');
            if (isOtherchildinhouseholdfamilyorincaseofallegedmaltreater) {
            control3.setValidators(Validators.required);
            control3.setValue('1');
            } else {
            control3.clearValidators();
            control3.setValue('0');
            }
            control3.updateValueAndValidity();
        }
    }  

    get otherRiskFactors(): FormArray {
        return this.form1080c.get('otherriskfactors') as FormArray;
    }
      
    createRiskRow(): FormGroup {
        return this.formBuilder.group({
          description: [''], // optional label
          child: [false],
          family: [false],
          caregiver: [false],
        });
    }
      
    addRiskRow() {
        this.otherRiskFactors.push(this.createRiskRow());
    }
      
    removeRiskRow(index: number) {
        this.otherRiskFactors.removeAt(index);
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

    getForm1080CContributingFactorValidationData(personId : any) {
        this._commonService
        .getArrayList(
            {
                where: { personId: personId, intakeServiceId  : this.id },
                method: 'get'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.InvestigationContributingFactor + '?filter'
        ).subscribe((data) => {
            if(data[0]){
                const contributingValue = data[0]['value'];
                this.form1080c.patchValue({ doesmaltreatmentappeartohavebeenacontributingfactor: String(contributingValue) });
            }
        });
    }

    get otherRiskFactorGroups(): FormGroup[] {
        return this.otherRiskFactors.controls as FormGroup[];
    }
    
}