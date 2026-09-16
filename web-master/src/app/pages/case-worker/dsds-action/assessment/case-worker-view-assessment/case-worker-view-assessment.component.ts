
import {timer as observableTimer,  Observable, Subject, of } from 'rxjs';
import { Location } from '@angular/common';
import moment from 'moment';
import { AfterViewChecked, AfterViewInit, ChangeDetectorRef, Component, OnInit, OnDestroy, Injector } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import _ from 'lodash';

import { environment } from '../../../../../../environments/environment';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService, CommonDropdownsService } from '../../../../../@core/services';
import { HttpService } from '../../../../../@core/services/http.service';
import { DSDSActionSummary, GetintakAssessment, RoutingInfo } from '../../../_entities/caseworker.data.model';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { ChildRoles } from '../../child-removal/_entities/childremoval.model';
import { InvolvedPerson, Relationship, YouthInvolvedPersons } from '../../involved-persons/_entities/involvedperson.data.model';
import { Placement } from '../../service-plan/_entities/service-plan.model';
import { AssessmentPreFill } from '../assessment-prefill';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { concatMap } from 'rxjs/operators';
declare var Formio: any;
declare var FormioExport: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-worker-view-assessment',
    host: {
        class: 'case-worker-view-assessment'
    },
    templateUrl: './case-worker-view-assessment.component.html',
    styleUrls: ['./case-worker-view-assessment.component.scss'],
    standalone: false
})
export class CaseWorkerViewAssessmentComponent implements OnInit, AfterViewInit, AfterViewChecked, OnDestroy {
    private formDataSubject = new Subject<any>();
    private formData$ = this.formDataSubject.asObservable();
    id: string;
    serviceCaseId!: string | null;
    daNumber: string;
    assessmmentName!: string;
    
    isAppla = false;
    isShelterForm = false;
    bestIntrestSchoolInitialCheck = true;
    private token!: AppUser;
    private servicereqid!: string;
    private templateId!: string;
    private submissionId!: string;
    selectedSafeCDangerInfluence: any[] = [];
    currentTemplateId!: string;
    disableSubmitforApproval= false;
    isChildSafe = true;
    safeCKeys: string[];
    involvedPersons!: InvolvedPerson[];
    youthInvolvedPersons!: YouthInvolvedPersons[];
    routingInfo!: RoutingInfo[];
    routingSupervisors!: any[];
    placement!: Placement[];
    childDetail!: ChildRoles[];
    submission: any;
    formioOptions!: {
        formio: {
            ignoreLayout: true;
            emptyValue: '-';
        };
    };
    isReadOnlyForm = false;
    intakAssessment = new GetintakAssessment();
    dsdsActionsSummary = new DSDSActionSummary();
    isInitialized = false;
    private formTriggered = false;
    childRemovalInfo: any;
    baseLocation: any;
    intakeFormDRAIData = null;
    isServiceCase!: string;
    placementInfo: any;
    eductionDetatils!: any[];
    personRelations: any;
    removalChildList: any;
    assesmentStatus!: string | null;
    addasssessmenturl = 'admin/assessment/Add';
    savedsuccessmsg = ' saved successfully.';
    safecohp = 'SAFE-C OHP';
    marylandfamilyriskreassessment = 'MARYLAND FAMILY RISK REASSESSMENT';
    bestinterestdeterminationforeducationalplacement = 'BEST INTEREST DETERMINATION FOR EDUCATIONAL PLACEMENT';
    transportationplanformattendingschooloforiginfromoutofhomeplacement = 'TRANSPORTATION PLAN FORM ATTENDING SCHOOL OF ORIGIN FROM OUT-OF-HOME PLACEMENT';
    cansoutofhomeplacementservice = 'CANS-OUT OF HOME PLACEMENT SERVICE';
    notificationofplacemententryandexitreceipt = 'NOTIFICATION OF PLACEMENT-ENTRY AND EXIT RECEIPT';
    homehealthreport = 'HOME HEALTH REPORT';
    domesticviolencelethalityscreenfordhs = 'DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS LEGACY';
    dtformat = 'MM/DD/YYYY';
    assessmentpopupid = '#assessment-popup';
    cssclassname = 'formio-component-Complete';
    caseworkerurl = '/pages/case-worker/';
    private readonly route: ActivatedRoute;
    private readonly _authService: AuthService;
    private readonly storage: SessionStorageService;
    private readonly _commonService: CommonHttpService;
    private readonly _alertService: AlertService;
    private readonly _http: HttpService;

    constructor(
        private _router: Router,
        private readonly _dataStoreService: DataStoreService,
        private readonly _changeDetect: ChangeDetectorRef,
        private readonly location: Location,
        private readonly _commonDDService: CommonDropdownsService,
        private readonly injector : Injector
    ) {
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._http = this.injector.get<HttpService>(HttpService);

        this.safeCKeys = [
            'caregiverdescribes',
            'caregiverfailstoprotect',
            'caregivermadeaplausible',
            'caregiverrefuses',
            'caregiversemotionalinstability',
            'caregiversexplanation',
            'caregiversjustification',
            'caregiverssuspected',
            'childscurrentimminent',
            'childsexualabuse',
            'childswhereabouts',
            'currentactofmaltreatment',
            'domesticviolence',
            'extremelyanxious',
            'multiplereports',
            'servicestothecaregiver',
            'specialneeds',
            'unabletoprotect',
            'servicestothecaregiver2'
        ];
        this.id = this._commonDDService.getStoredCaseUuid();

        this.daNumber = this._commonDDService.getStoredCaseNumber();
        this._commonDDService.getCountyList('MD').subscribe(data => {
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.COUNTY_LIST, data);
        });
        // Subscribe to the formData$ observable and handle the formDataClone with safeCProcess
    this.formData$.pipe(
        // Use concatMap for sequential execution if safeCProcess is asynchronous
        concatMap(async (formData) => this.safeCProcess1(formData))
      ).subscribe({
        next: (result) => {
          // Handle the result of safeCProcess
        },
        error: (error) => {
          // Handle any errors from safeCProcess
          console.error('Error processing form data', error);
        }
      });
    }

    ngOnInit() {
        this.isServiceCase = this.storage.getItem('ISSERVICECASE');
        if (this.isServiceCase) {
            this.serviceCaseId = this._commonDDService.getStoredCaseUuid();
        } else {
            this.serviceCaseId = null;
        }
        this.token = this._authService.getCurrentUser();
        this.isInitialized = true;
        if (this._authService.isDJS()) {
            this.intakeFormDRAIData = this._dataStoreService.getData('DRAI_PREFILL');
        }
    }

    ngAfterViewInit() {
        if (this.isInitialized ) {
            this.involvedPersons = this._dataStoreService.getData('CASEWORKER_INVOLVED_PERSON');
            this.personRelations = this._dataStoreService.getData('CASEWORKER_PERSON_RELATIONS');
            this.youthInvolvedPersons = this._dataStoreService.getData('CASEWORKER_YOUTH_INVOLVED_PERSON');
            this.routingInfo = this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') ? this._dataStoreService.getData('CASEWORKER_ROUTING_INFO') : [];
            this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS') ? this._dataStoreService.getData('CASEWORKER_SUPERVISORS') : [];
            this.placement = this._dataStoreService.getData('CASEWORKER_PLACEMENT');
            this.placementInfo = this._dataStoreService.getData('CASEWORKER_PLACEMENT_INFO');
            this.intakAssessment = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
            const sd = this?.intakAssessment?.submissiondata;
            if(sd) { 
                this.sdcheck(sd);
            }
            this.childDetail = this._dataStoreService.getData('CASEWORKER_CHILD_DETAIL');
            this.childRemovalInfo = this._dataStoreService.getData('CHILD_REMOVAL_INFO');
            this.eductionDetatils = this._dataStoreService.getData('CASEWORKER_EDUCATION_INFO');
            this.removalChildList = this._dataStoreService.getData('REMOVAL_CHILD_LIST');
            const intakestudentname = this.intakAssessment?.submissiondata?.studentname;
            const personInfo = this.involvedPersons && this.involvedPersons.find(item => item.firstname + ' ' + item.lastname === intakestudentname);
            if(personInfo) {
                this.eductionDetatils = this.eductionDetatils.filter(item => item.Pid === personInfo.personid);
            }
            if (this.intakAssessment) {
                this.intakAssessment?.submissiondata && this.formatIntakeAssesmentAddress();
                this.intakAssessmentcheck();

            } else {
                this.redirectToAssessment();
            }
            this.isInitialized = false;
        }
        this.handleIntakeCaseStoreCheckFn();
    }
    // Assosaited to ngAfterViewInit method
    private handleIntakeCaseStoreCheckFn() {
        const intakeCaseStore = this._dataStoreService.getData('IntakeCaseStore');
        if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
            (<any>$(':button')).prop('disabled', true);
            (<any>$('span')).css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
            (<any>$('i')).css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
            (<any>$('th a')).css({
                'pointer-events': 'none',
                'cursor': 'default',
                'opacity': '0.5',
                'text-decoration': 'none'
            });
        }
    }

    sdcheck(sd: any){
        if(sd?.childs_info_json && JSON.parse(sd?.childs_info_json) && JSON.parse(sd?.childs_info_json).length >0){
            const x = JSON.parse(sd?.childs_info_json);
            const y = sd?.clientid ? x.filter((e: { clientid: any; })=>e.clientid == sd?.clientid) : [];
            const cf =y[0];
            if(cf) {
                sd.addressline1 = this.formAddress(cf?.providerInfo, ['adr_street_no', 'adr_box_no','adr_street_tx', 'adr_street_nm', 'adr_street_suffix_cd']);
                sd.addressline2 = this.formAddress(cf?.providerInfo, ['adr_unit_no_tx','adr_city_nm', 'adr_state_cd'], ", ");
                sd.zipcode = cf?.providerInfo?.adr_zip5_no;
                const pd = cf?.placementDetails;
                
                this.handlePdInSdcheckFn(pd);
            }
        }
    }
    // Assosiated with sdcheck method
    private handlePdInSdcheckFn(pd: any) {
        if (pd) {
            const cpah = pd?.cpahomerevision;
            if (cpah && cpah.length > 0) {
                cpah.forEach((e: { exit_dt: null; provideraddress: any; }) => {
                    if (e.exit_dt == null) {
                        this.intakAssessment.submissiondata.provideraddress = e?.provideraddress;
                    }
                });
            }
        }
    }

    intakAssessmentcheck(){
        if (this.intakAssessment.description === 'Shelter Care Authorization and Date of Hearing' || 
        this.intakAssessment.name === 'shelterCareAuthorizationAndDateOfHearing') {
        this.isShelterForm = true;
    }
    if (this.intakAssessment.mode === 'start') {
        if (this.childRemovalInfo) {
            this.startAssessment(this.intakAssessment, this.childRemovalInfo);
        } else {
            this.startAssessment(this.intakAssessment);
        }
    } else if (this.intakAssessment.mode === 'submit') {
        this.submittedAssessment(this.intakAssessment);
    } else if (this.intakAssessment.mode === 'update') {
        if (this.childRemovalInfo) {
            this.updateAssessment(this.intakAssessment, this.childRemovalInfo);
        } else {
            this.updateAssessment(this.intakAssessment);
        }
    } else if (this.intakAssessment.mode === 'print') {
        this.assessmentPrintView(this.intakAssessment);
    }
    }

    formAddress(obj: any, keyArray: any, joinString: any = " "){
       return obj ? keyArray?.map((key: string | number) => obj[key]).filter((value: any) => value).join(joinString) : "";
    }

    formatIntakeAssesmentAddress(){
        if (this.intakAssessment?.submissiondata?.childs_info_json) {
            const childInfo = JSON.parse(this.intakAssessment?.submissiondata?.childs_info_json || '[]');
            const childData = childInfo.filter((x: { clientid: any; }) => x.clientid === this.intakAssessment?.submissiondata?.clientid)[0];
            const providerInfo = childData?.providerInfo ? childData?.providerInfo : (childData?.placementDetails?.providerdetails ?? null);
            const addressline1 = providerInfo ? this.formAddress(providerInfo, ['adr_street_no', 'adr_box_no','adr_street_tx', 'adr_street_nm', 'adr_street_suffix_cd']) : null;
            const addressline2 = providerInfo ? this.formAddress(providerInfo, ['adr_unit_no_tx','adr_city_nm', 'adr_state_cd'], ", ") : null;
            this.intakAssessment = { ...this.intakAssessment, ...{submissiondata: {...this.intakAssessment?.submissiondata, ...{ addressline1, addressline2}}}};
        }
    }

    ngAfterViewChecked(): void {
        this._changeDetect.detectChanges();
    }

    // getChildArray() {
    //     const CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
    //     return this.involvedPersons.filter(child => {
    //         let childFound = false;
    //         child.roles.forEach(role => {
    //             const childCategory = CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
    //             if (childCategory) {
    //                 childFound = true;
    //                 return;
    //             }
    //         });
    //         return childFound;
    //     });
    // }
    // getRemovalChilds(childArray) {
    //     let childList = [];
    //     childList = this.involvedPersons.map(person => {
    //     childArray.forEach(child => {
    //         if (child.intakeservicerequestactorid  === person.intakeservicerequestactorid) {
    //             return {
    //                 'childname': person.firstname + ' ' + person.lastname,
    //                 'clientid': person.cjamspid,
    //                 'age': this.getAge(person.dob)
    //             };
    //         }
    //       });
    //     });
    //    return childList ? childList : [];
    // }

    processChildDetailsSubmission(submission: any) {
        const assessmentactorArray: any[] = [];
        let childIsUnsafe = null;
        if(submission ){
            childIsUnsafe = submission.dangerInfluencesIdentified === 'childIsUnsafe';
        }
        const issafe = childIsUnsafe ? 0 : 1;
        if (this.getChildList) {
            this.getChildList.forEach((data) => {   //SonarQube fix - Consider using "forEach" instead of "map" as its return value is not being used here.
                const childname = data.firstname + ' ' + data.lastname;

                this.handleIfChilddatagridProcessChildDetailsSubmissionFn(submission, data, issafe, childname, assessmentactorArray);


                this.handleIfAddchildrenInProcessChildDetailsSubmissionFn(submission, data, issafe, childname, assessmentactorArray);

            });
            return assessmentactorArray;
        }
        return {};
    }
    // Assosiated with processChildDetailsSubmission method
    private handleIfAddchildrenInProcessChildDetailsSubmissionFn(submission: any, data: InvolvedPerson, issafe: number, childname: string, assessmentactorArray: any[]) {
        if (submission && submission.addchildren) {
            submission.addchildren.forEach((child: { seconename: any; }) => {
                const formchildname = child.seconename;
                const assessmentactor = {
                    'intakeservicerequestactorid': data.intakeservicerequestactorid,
                    'issafe': issafe
                };
                if (childname.toLowerCase().trim() === formchildname.toLowerCase().trim()) {
                    if (assessmentactorArray.find(x => x.intakeservicerequestactorid === assessmentactor.intakeservicerequestactorid) === undefined) {
                        assessmentactorArray.push(assessmentactor);
                    }
                }
            });
        }
        
    }
    // Assosiated with processChildDetailsSubmission method
    private handleIfChilddatagridProcessChildDetailsSubmissionFn(submission: any, data: InvolvedPerson, issafe: number, childname: string, assessmentactorArray: any[]) {
        if (submission && submission.childdatagrid) {
            submission.childdatagrid.forEach((child: { childname: any; }) => {
                const formchildname = child.childname;
                const assessmentactor = {
                    'intakeservicerequestactorid': data.intakeservicerequestactorid,
                    'issafe': issafe
                };
                if (childname.toLowerCase().trim() === formchildname.toLowerCase().trim()) {
                    assessmentactorArray.push(assessmentactor);
                }
            });
        }
    }

    saveAsDraftSAFEC(submission: any){
        if(submission.safetyassessmentapprovaldate !== '' && submission.safetyassessmentcompletiondate !==''){
            const approvalDate = moment(submission.safetyassessmentapprovaldate);
            const completionDate = moment(submission.safetyassessmentcompletiondate);
            if(!approvalDate.isSameOrAfter(completionDate)){
                this._alertService.error('Approval date should be greater than the completion date');
                return;
            }
        }
        let assessmentactor = {};
        if((this.submission === null || this.submission === undefined) && (submission._id !== null && submission._id !== undefined) ){
            this.submission = submission._id;
        }

        let data = {};
        const childdata = (this.isAppla ? this._dataStoreService.getData('placed_child') : null);
        if (this.assessmmentName === 'SAFE-C') {
            assessmentactor = this.processChildDetailsSubmission(submission);
            data = {
                ...submission,
                safeCDangerInfluence: this.selectedSafeCDangerInfluence,
                isChildSafe: this.isChildSafe,
                assessmentactor: assessmentactor,
                child: childdata
            };
        }
        
        
        this._http
            .post(this.addasssessmenturl, {
                externaltemplateid: this.currentTemplateId,
                objectid: this.id,
                submissionid: this.submission,
                submissiondata: data,
                form: submission.form ? submission.form : null,
                score: submission.score ? submission.score : 0,
                ischildsafe: this.isChildSafe,
                assessmentstatustypekey1: 'InProcess',
                assessmentactor: assessmentactor ,
                servicecaseid: (this.isServiceCase ? this.id : this.serviceCaseId), 
                comments: (submission.caseworkercomments ? submission.caseworkercomments : null)
            })
            .subscribe(response => {
                    if(response?.data?.submissionid){
                        this.submission  = response.data.submissionid;
                    }
                    this._alertService.success(this.assessmmentName + this.savedsuccessmsg, true);
                    setTimeout(() => 
                        {
                            this.redirectToAssessment();
                        },
                        1500);
            });
    }

    startAssessment(assessment: any, childRemovalInfo?: any) {
        this.assessmmentName = assessment.description;
        this.currentTemplateId = assessment.external_templateid;
        if (assessment.description === 'APPLA') {
            this.isAppla = true;
        }

        Formio.baseUrl = environment.formBuilderHost;
        Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`, {
             icons:'fontawesome',            
            hooks: {
                beforeSubmit: (submission: any, next: any) => {
                    if (!Formio.token) {
                        Formio.token = this.storage.getObj('fbToken');
                    }
                    next();
                }
            }
        }).then((form: any) => {
            form.nosubmit = false;
            form.components = form.components.map((item: any) => {
                if (item.key === 'Complete' && item.type === 'button') {
                    item.action = 'submit';
                }
                return item;
            });


            form.submission = {
                data: this.getFormPrePopulation(this.assessmmentName, form.data)
            };

            form.on('saveAsDraftSAFEC', (submission: any) => {
                this.saveAsDraftSAFEC(submission);
            });
            this.handleIfFormSubmitInStartAssessmentFn(form, assessment);
            this.handleIfFormChangeIfStartAssessmentFn(form);
            form.on('render', (formData: any) => {
                /// (<any>$('#iframe-popup')).modal('show');
                if(this.assessmmentName === 'SAFE-C')
                {
                    const dateassessmentinitiated = (<any>$(`[name="data[dateassessmentinitiated]"]`)[0])._flatpickr;
                    dateassessmentinitiated.set('maxDate', new Date());
                }
                if (this.assessmmentName === this.homehealthreport) {
                    const datetimeField = (<any>$(`[name="data[datetimefield1]"]`)[0])._flatpickr;
                    const currentDateTime = new Date();
                    this.setMaxDateTime(datetimeField, currentDateTime);
                    // Attach the onChange handler for updating maxTime when user selects a date/time
                    datetimeField.config.onChange.push((selectedDates: any) => this.updateMaxTime(datetimeField, selectedDates, currentDateTime));
                    let updateInterval: any;
                    // Periodically update maxTime every minute while the calendar is open
                    datetimeField.config.onOpen.push(() => {
                        updateInterval = this.startAutoUpdate(datetimeField, currentDateTime);
                    });
                    // Stop the interval when the calendar is closed
                    datetimeField.config.onClose.push(() => clearInterval(updateInterval));
                }
                setTimeout(() => {
                    $(this.assessmentpopupid).scrollTop(0);
                }, 200);
                });

            form.on('error', (error: any) => {
                setTimeout(() => {
                    $(this.assessmentpopupid).scrollTop(0);
                }, 200);
                this._alertService.error('Unable to save ' + this.assessmmentName + '. Please try again.');
            });
        });
    }
    // Assosiated to startAssessment method
    private handleIfFormChangeIfStartAssessmentFn(form: any) {
        form.on('change', (formData: any) => {
            this.safeCProcess(formData);

            // Begin - D-06446 , D-06602 Fix
            if (formData.changed) {
                /// D-10437 Start
                const changedKey = formData.changed.component.key;

                this.handleIfFormChangeCond1IfStartAssessmentFn(changedKey, form, formData);

                /// D-10437 End
                this.handleIfFormChangeCond2IfStartAssessmentFn(form, formData, changedKey);

                if (this.assessmmentName === this.marylandfamilyriskreassessment) {

                    if (!(changedKey === 'childrenname' || changedKey === 'childrenage' || changedKey === 'childrenrelationship')) {
                        form.submission = {
                            data: formData.data
                        };
                    }
                    this.handleIfReroutesupervisorFn(changedKey, form);
                }

                this.checkAssessmentnameInStartAssessmentFn(form, formData, changedKey);

                this.handleIfSeconenameorChildnameInStartAssessmentFn(changedKey, form, formData);

                this.handleAssessmentreviewedIfRoleNotAPCSInStartAssessmentFn(changedKey, form, formData);


            }
        });
    }
    // Assosiated to startAssessment method
    private handleIfSeconenameorChildnameInStartAssessmentFn(changedKey: any, form: any, formData: any) {
        this.handleIfTransportationplanformattendingschooloforiginfromoutofhomeplacementInStartAssessFn(changedKey, form, formData);

        if (this.assessmmentName === 'SAFE-C' && (changedKey === 'seconename' || changedKey === 'childname')) {

            form.submission = {
                data: formData.data // this.setChildDetails(formData)
            };
            this.handleOtherChildsInfoWithCommaFn(form, changedKey);

            let allChilds: any;
            if (form.submission.data.all_childs_json) {
                allChilds = JSON.parse(form.submission.data.all_childs_json);
            }

            if (changedKey === 'childname') {
                allChilds.forEach((childInfo: any) => {
                    form.submission.data.childdatagrid.forEach((childdata: any) => {
                        this.handleIfNameMatchesFn(childdata, childInfo);
                    });
                });
            }
        }
    }

    // Assosiated to startAssessment method
    private handleOtherChildsInfoWithCommaFn(form: any, changedKey: any) {
        let otherChildsInfoWithComma: any;
        if (form.submission.data.other_childs_json) {
            otherChildsInfoWithComma = JSON.parse(form.submission.data.other_childs_json);
        }

        if (changedKey === 'seconename') {
            otherChildsInfoWithComma.forEach((childInfo: any) => {
                form.submission.data.addchildren.forEach((childdata: any) => {
                    this.checkIfSeconenameMatchesFn(childdata, childInfo);
                });
            });
        }
    }

    // Assosiated to startAssessment method
    private handleIfTransportationplanformattendingschooloforiginfromoutofhomeplacementInStartAssessFn(changedKey: any, form: any, formData: any) {
        this.handleIfSafecohpInStartAssessmentFn(changedKey, form, formData);
        if (this.assessmmentName === this.transportationplanformattendingschooloforiginfromoutofhomeplacement) {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            if (changedKey === 'reroutesupervisor') {
                const origsupervisor: any = this.routingInfo.find(item => item.fromrole === 'Supervisor');
                form.submission.data.supervisorname = (form.submission.data.reroutesupervisor && form.submission.data.reroutesupervisor !== '')
                    ? form.submission.data.reroutesupervisor.username : origsupervisor.fromusername;
            }
        }
    }
    // Assosiated to startAssessment method
    private handleIfSafecohpInStartAssessmentFn(changedKey: any, form: any, formData: any) {
        this.handleBestinterestdeterminationforeducationalplacementIfStartAssessmentFn(changedKey, form, formData);

        if (this.assessmmentName === 'Casey Life Skills Assessment') {
            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        if (this.assessmmentName === this.safecohp) {
            if (!['caseworkersign'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private handleBestinterestdeterminationforeducationalplacementIfStartAssessmentFn(changedKey: any, form: any, formData: any) {
        this.handleIfCansoutofhomeplacementserviceInAssessmentFn(changedKey, form, formData);
        if (this.assessmmentName === 'CANS-F' || this.assessmmentName === 'cans-v2') {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement) {
            if (!['fname', 'lname2', 'phonenumber', 'emailid', 'caseWorkerSignature'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private handleIfCansoutofhomeplacementserviceInAssessmentFn(changedKey: any, form: any, formData: any) {
        this.checkDomesticviolencelethalityscreenfordhsAndAODFormInStartAssessmentFn(changedKey, form, formData);

        if (this.assessmmentName === this.cansoutofhomeplacementservice) {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
        if (this.assessmmentName === 'PLACEMENT REQUEST FORM - ATTACHMENT A') {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private checkDomesticviolencelethalityscreenfordhsAndAODFormInStartAssessmentFn(changedKey: any, form: any, formData: any) {
        this.checkIfHomehealthreportInStartAssessmentFn(changedKey, form, formData);
        if (this.assessmmentName === this.domesticviolencelethalityscreenfordhs) {
            if (changedKey !== 'Signature') {
                form.submission = {
                    data: formData.data
                };
            }

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        if (this.assessmmentName === 'AOD Form') {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private checkIfHomehealthreportInStartAssessmentFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.homehealthreport && !['sharingbedwith', 'sleepinglocation', 'caseworkersignature', 'childnamelist'].includes(changedKey)) {
            if (changedKey === 'nameofcaretaker') {
                if (form.submission.data.nameofcaretaker === '') {
                    form.submission.data.age = '';
                    form.submission.data.address = '';
                    form.submission.data.city = '';
                    form.submission.data.state = '';
                    form.submission.data.zip = '';
                }
                else {
                    this.handleIfPersonSelectedFn(form);
                }
            }
            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            if (changedKey === 'reroutesupervisor') {
                const origsupervisor: any = this.routingInfo.find(item => item.fromrole === 'Supervisor');
                form.submission.data.supervisorname = (form.submission.data.reroutesupervisor && form.submission.data.reroutesupervisor !== '')
                    ? form.submission.data.reroutesupervisor.username : origsupervisor.fromusername;
            }
        }
    }
    // Assosiated to startAssessment method
    private handleIfPersonSelectedFn(form: any) {
        const personSelected: any = this.involvedPersons.find((person: any) => person.fullname.trim() === form.submission.data.nameofcaretaker);
        if (personSelected) {
            let age = personSelected['age'];
            if (age.includes(' Day(s)')) {
                age = String(age).substring(0, age.indexOf(' Day(s)'));
            } else if (age.includes(' Month(s)')) {
                age = String(age).substring(0, age.indexOf(' Month(s)'));
            } else if (age.includes(' Yrs')) {
                age = String(age).substring(0, age.indexOf(' Yrs'));
            }
            form.submission.data.age = age;
            form.submission.data.address = personSelected['address2'] ?
                personSelected['address'] + ' ' + personSelected['address2'] : personSelected['address'];
            form.submission.data.city = personSelected['city'];
            form.submission.data.state = personSelected['state'];
            form.submission.data.zip = personSelected['zipcode'];


            this.handleIfRelationshiparrayFn(personSelected, form);
        }
    }
    // Assosiated to startAssessment method
    private handleIfRelationshiparrayFn(personSelected: InvolvedPerson, form: any) {
        if (personSelected.relationshiparray && personSelected.relationshiparray.length > 0) {
            personSelected.relationshiparray.forEach(relation => {
                if (form.submission.data.householdmemberdetail && form.submission.data.householdmemberdetail.length > 0) {
                    this.handleIfRelationshiparrayCond1Fn(form, relation, personSelected);
                }
            });
        }
    }
    // Assosiated to startAssessment method
    private handleIfRelationshiparrayCond1Fn(form: any, relation: Relationship, personSelected: InvolvedPerson) {
        form.submission.data.householdmemberdetail.forEach((householdmember: any) => {
            if (relation.primaryuserid === personSelected.personid && relation.primaryuserid === householdmember.householdpersonid) {
                householdmember.householdmemberrelationship = 'self';
            }
            if (relation.primaryuserid === personSelected.personid && relation.secondaryuserid === householdmember.householdpersonid) {
                householdmember.householdmemberrelationship = relation.description;
            }
        });
    }
    // Assosiated to startAssessment method
    private handleAssessmentreviewedIfRoleNotAPCSInStartAssessmentFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === 'SAFE-C' && changedKey !== 'caseworkersignature' && changedKey !== 'supervisorrsignature' && (changedKey !== 'assessmentreviewed' || (changedKey === 'assessmentreviewed' && form.data.userrole !== 'apcs'))
            && changedKey !== 'signature') {

            form.submission = {
                data: formData.data // this.setChildDetails(formData)
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private checkAssessmentnameInStartAssessmentFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === 'SILA') {

            form.submission = {
                data: formData.data
            };
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        if (this.assessmmentName === 'MFIRA') {

            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        this.handleIfNotificationofplacemententryandexitreceiptInStartAssessmentFn(form, formData, changedKey);
    }
    // Assosiated to startAssessment method
    private handleIfNotificationofplacemententryandexitreceiptInStartAssessmentFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === this.notificationofplacemententryandexitreceipt) {

            form.submission = {
                data: formData.data
            };
            let childsInfo: any;
            if (form.submission.data.child_info_json) {
                childsInfo = JSON.parse(form.submission.data.child_info_json);
            }
            if (changedKey === 'childsName') {
                const childName = form.submission.data.childsName;
                const child = childsInfo.find((ele: { childname: any; }) => ele.childname === childName);
                this.handleIfNotificationofplacemententryandexitreceiptInStartAssessmentCond1Fn(child, form);
            }

            if (changedKey === 'placemententrydatetime') {
                const minDateForExit = form.submission.data.placemententrydatetime || this._dataStoreService.getData('dsdsActionsSummary').case_opendate;
                const exitDate = (<any>$(`[name="data[placementexitdatetime]"]`)[0])._flatpickr;
                exitDate.set('minDate', new Date(minDateForExit));
            }

            if (changedKey === 'placementexitdatetime') {
                const maxDateForStart = form.submission.data.placementexitdatetime;
                const startDate = (<any>$(`[name="data[placemententrydatetime]"]`)[0])._flatpickr;
                startDate.set('maxDate', new Date(maxDateForStart));
            }

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to startAssessment method
    private handleIfNotificationofplacemententryandexitreceiptInStartAssessmentCond1Fn(child: any, form: any) {
        if (child) {
            form.submission.data.placemententrydatetime = '';
            form.submission.data.placementexitdatetime = '';
            form.submission.data.dob = child.dob;
            form.submission.data.childClientId = child.cjamspid;
            if (child.gender === 'Male' || child.gender === 'M') {
                form.submission.data.childgender = 'male';
            }
            if (child.gender === 'Female' || child.gender === 'F') {
                form.submission.data.childgender = 'female';
            }
            const minDateForStart = moment(child.removalDate).format(this.dtformat) || this._dataStoreService.getData('dsdsActionsSummary').case_opendate;
            const startDate = (<any>$(`[name="data[placemententrydatetime]"]`)[0])._flatpickr;
            startDate.set('minDate', new Date(minDateForStart));
            const minDateForExit = form.submission.data.placemententrydatetime ||
                moment(child.removalDate).format(this.dtformat) || this._dataStoreService.getData('dsdsActionsSummary').case_opendate;
            const exitDate = (<any>$(`[name="data[placementexitdatetime]"]`)[0])._flatpickr;
            exitDate.set('minDate', new Date(minDateForExit));
        } else {
            form.submission.data.dob = '';
            form.submission.data.childClientId = '';
            form.submission.data.childgender = '';
            const startDate = (<any>$(`[name="data[placemententrydatetime]"]`)[0])._flatpickr;
            startDate.set('minDate', null);
            startDate.set('maxDate', null);
            const exitDate = (<any>$(`[name="data[placementexitdatetime]"]`)[0])._flatpickr;
            exitDate.set('minDate', null);
            form.submission.data.placemententrydatetime = '';
            form.submission.data.placementexitdatetime = '';
        }
    }
    // Assosiated to startAssessment method
    private handleIfFormChangeCond1IfStartAssessmentFn(changedKey: any, form: any, formData: any) {
        let childsInfo: any;
        if (form.submission.data.childs_info_json) {
            childsInfo = JSON.parse(form.submission.data.childs_info_json);
        }
        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement) {
            if (['studentname', 'bid1', 'bid2', 'bid3', 'bid4'].includes(changedKey) || this.bestIntrestSchoolInitialCheck) {
                this.bestIntrestSchoolInitialCheck = false;
                const studentname = form.submission.data.studentname;
                childsInfo.forEach((childInfo: any) => {
                    if (childInfo.studentname === studentname) {
                        form.submission.data.studentdob = childInfo.dob;
                        this.handleIfChildInfoEducationInStartAssessmentFn(childInfo, form);
                    }
                });
            }
            if (!['caseWorkerSignature', 'fname', 'lname2', 'relationshiptostudent', 'phonenumber', 'emailid'].includes(changedKey)) {
                form.submission = { data: formData.data };
            }
        }
        this.handleIfCansoutofhomeplacementserviceIfStartAssessmentFn(changedKey, form, childsInfo);

        this.handleIfChilderennameInStartAssessmentFn(form, changedKey);
    }
    // Assosiated to startAssessment method
    private handleIfChilderennameInStartAssessmentFn(form: any, changedKey: any) {
        this.handleIfChildsInfoWithCommaInStartAssessmentFn(form, changedKey);

        if (changedKey === 'childerenname') {
            const addedChildren = JSON.parse(form.submission.data.childrenhiddendetails);
            if (form.submission.data.childrendetails) {
                form.submission.data.childrendetails.forEach((child: { childerenname: any; DOB: any; }) => {
                    const changedChild = addedChildren.find((c: { childerenname: any; }) => c.childerenname === child.childerenname);
                    if (changedChild) {
                        child.DOB = changedChild.DOB;
                    }
                });
            }
        }
    }
    // Assosiated to startAssessment method
    private handleIfChildsInfoWithCommaInStartAssessmentFn(form: any, changedKey: any) {
        let childsInfoWithComma: any;
        if (form.submission.data.child_info_with_comma_json) {
            childsInfoWithComma = JSON.parse(form.submission.data.child_info_with_comma_json);
        }
        if (changedKey === 'seconename') {
            childsInfoWithComma.forEach((childInfo: { seconename: any; seconeage: any; }) => {
                form.submission.data.addchildren.forEach((childdata: { seconename: any; seconeage: any; }) => {
                    if (childInfo.seconename === childdata.seconename) {
                        childdata.seconeage = childInfo.seconeage;
                    }
                });
            });
        }
    }
    // Assosiated to startAssessment method
    private handleIfCansoutofhomeplacementserviceIfStartAssessmentFn(changedKey: any, form: any, childsInfo: any) {
        this.handleIfSafecohpMatchesInStartAssessmentFn(changedKey, form, childsInfo);
        if (changedKey === 'childname' && this.assessmmentName === this.cansoutofhomeplacementservice) {
            const childName = form.submission.data.childname;
            childsInfo.forEach((childInfo: { childname: any; age: any; }) => {
                if (childInfo.childname === childName) {
                    form.submission.data.age = childInfo.age;
                }
            });
        } else if (changedKey === 'childname') {
            childsInfo.forEach((childInfo: { childname: any; age: any; clientid: any; }) => {
                form.submission.data.childdatagrid.forEach((childdata: { childname: any; age: any; clientid: any; }) => {
                    if (childInfo.childname === childdata.childname) {
                        childdata.age = childInfo.age;
                        childdata.clientid = childInfo.clientid;
                    }
                });
            });
        }
    }
    // Assosiated to startAssessment method
    private handleIfSafecohpMatchesInStartAssessmentFn(changedKey: any, form: any, childsInfo: any) {
        if (this.assessmmentName === this.safecohp) {
            if (changedKey === 'ClientName') {
                this.handleChildNameInStartAssessmentFn(form, childsInfo);
            }

            if (changedKey === 'currentplacement' || (changedKey === 'ClientName' && form.submission.data.currentplacement)) {
                const currentStore = this._dataStoreService.getCurrentStore();
                if (currentStore) {
                    this.placementInfo = currentStore['CASEWORKER_PLACEMENT_INFO'];
                }
                this.handleIfCurrentplacementInStartAssessmentFn(form, childsInfo);

            }
        }
    }
    // Assosiated to startAssessment method
    private handleIfCurrentplacementInStartAssessmentFn(form: any, childsInfo: any) {
        const childName = form.submission.data.ClientName;
        if (form.submission.data.currentplacement) {
            childsInfo.forEach((childInfo: any) => {
                if (childInfo.childname === childName) {
                    const providerInfo = childInfo.providerInfo;
                    const placementDetail = childInfo.placementDetails.cpahomerevision.length > 0 ? childInfo.placementDetails.cpahomerevision : [];
                    form.submission.data['currentplacement'] = true;
                    form.submission.data['placementlivingarrangement'] = providerInfo.providername;
                    form.submission.data['addressline1'] = this.formAddress(providerInfo, ['adr_street_no', 'adr_box_no', 'adr_street_tx', 'adr_street_nm', 'adr_street_suffix_cd']);
                    form.submission.data['addressline2'] = this.formAddress(providerInfo, ['adr_unit_no_tx', 'adr_city_nm', 'adr_state_cd'], ", ");
                    form.submission.data['zipcode'] = providerInfo.adr_zip5_no;
                    form.submission.data['provideraddress'] = placementDetail.length > 0 ?
                        placementDetail[this.getIndexByLatestDate(placementDetail)]?.provideraddress : null;
                    form.submission.data['ext'] = '';
                    form.submission.data['fax'] = '';
                    form.submission.data['work'] = providerInfo.phonenumber;
                }
            });

        } else {
            form.submission.data.placementlivingarrangement = null;
            form.submission.data.addressline1 = null;
            form.submission.data.addressline2 = null;
            form.submission.data.zipcode = null;
            form.submission.data.work = null;
            form.submission.data.ext = null;
            form.submission.data.fax = null;
        }
    }
    // Assosiated to startAssessment method
    private handleChildNameInStartAssessmentFn(form: any, childsInfo: any) {
        const childName = form.submission.data.ClientName;
        childsInfo.forEach((childInfo: any) => {
            if (childInfo.childname === childName) {
                form.submission.data.dob = childInfo.dob;
                form.submission.data.clientid = childInfo.clientid;
                form.submission.data.currentplacement = childInfo.hasActivePlacement;
                const providerInfo = (childInfo.providerInfo) ? childInfo.providerInfo : null;
                form.submission.data['placementlivingarrangement'] = this.returnPlacementlivingarrangementData(providerInfo);
                form.submission.data['addressline1'] = this.returnAddressline1Data(providerInfo);
                form.submission.data['addressline2'] = this.returnAddressline2Data(providerInfo);
                form.submission.data['zipcode'] = (providerInfo && providerInfo.adr_zip5_no) ? providerInfo.adr_zip5_no : null;
                form.submission.data['ext'] = '';
                form.submission.data['fax'] = '';
                form.submission.data['work'] = (providerInfo && providerInfo.phonenumber) ? providerInfo.phonenumber : null;
            }
        });
    }
    // Assosiated to startAssessment method
    private returnAddressline2Data(providerInfo: any): any {
        return (providerInfo) ? this.formAddress(providerInfo, ['adr_unit_no_tx', 'adr_city_nm', 'adr_state_cd'], ", ") : null;
    }
    // Assosiated to startAssessment method
    private returnAddressline1Data(providerInfo: any): any {
        return (providerInfo) ? this.formAddress(providerInfo, ['adr_street_no', 'adr_box_no', 'adr_street_tx', 'adr_street_nm', 'adr_street_suffix_cd']) : null;
    }
    // Assosiated to startAssessment method
    private returnPlacementlivingarrangementData(providerInfo: any): any {
        return (providerInfo && providerInfo.providername) ? providerInfo.providername : null;
    }

    // Assosiated to startAssessment method
    private handleIfChildInfoEducationInStartAssessmentFn(childInfo: any, form: any) {
        if (childInfo.education) {
            form.submission.data.currentschool = null;
            form.submission.data.grade = null;
            form.submission.data.assignedstudent = null;
            form.submission.data.previousschool = null;
            var selectedcurrentschool = [];
            form.submission.data.selectedcurrentschool = [];
            for (const element of childInfo.education) {
                if (element.schooltype === 'current') {
                    form.submission.data.currentschool = element.educationname;
                    form.submission.data.grade = element.currentgradeleveldesc;
                    form.submission.data.assignedstudent = element.sasidno;
                    selectedcurrentschool.push(element.educationname);
                } else if (element.schooltype === 'Previous') {
                    form.submission.data.previousschool = element.educationname;
                    selectedcurrentschool.push(element.educationname);
                } else {
                    form.submission.data.previousschool = null;
                    form.submission.data.currentschool = null;
                    form.submission.data.grade = null;
                    form.submission.data.assignedstudent = null;
                }
            }
            form.submission.data.schoolList = JSON.stringify(selectedcurrentschool);
        } else {
            form.submission.data.previousschool = null;
            form.submission.data.currentschool = null;
            form.submission.data.grade = null;
            form.submission.data.assignedstudent = null;
            form.submission.data.schoolList = null;
        }
    }
    // Assosiated to startAssessment method
    private handleIfFormChangeCond2IfStartAssessmentFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === this.cansoutofhomeplacementservice) {

            form.submission = {
                data: formData.data // this.setChildDetails(formData)
            };

        }
        if (this.assessmmentName === this.safecohp) {
            if (!['caseworkersign'].includes(changedKey)) {
                form.submission = {
                    data: formData.data // this.setChildDetails(formData)
                };
            }

        }
        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement) {
            if (!['fname', 'lname2', 'phonenumber', 'emailid', 'caseWorkerSignature'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }

        }
    }
    // Assosiated to startAssessment method
    private handleIfFormSubmitInStartAssessmentFn(form: any, assessment: any) {
        form.on('submit', (submission: any) => {
            let assessmentactor = {};
            this.checkSubmissionCondInStartAssessmentFn(submission);

            submission.data = submission.data ? submission.data : {};
            if (this.assessmmentName === 'SAFE-C') {
                submission.data['safeCDangerInfluence'] = this.selectedSafeCDangerInfluence;
                submission.data['isChildSafe'] = this.isChildSafe;
                submission.data['assessmentactor'] = this.processChildDetails(submission);
                assessmentactor = this.processChildDetails(submission);
            }
            else if (this.assessmmentName === this.safecohp) {
                submission.data['assessmentactor'] = this.processSafeCOHP(submission);
                assessmentactor = this.processSafeCOHP(submission);
            }
            else if (this.assessmmentName === this.marylandfamilyriskreassessment) {
                submission.data['assessmentactor'] = this.processMFRRActors(submission);
                assessmentactor = this.processMFRRActors(submission);
            }
            else if (this.assessmmentName && this.assessmmentName.toUpperCase() === 'Shelter Care Authorization and Date of Hearing'.toUpperCase()) {
                const assessmentactortemp = this.processShelterCareActors();
                submission.data['assessmentactor'] = assessmentactortemp;
                assessmentactor = assessmentactortemp;
            }
            if (assessment.description === 'APPLA') {
                submission.data['child'] = this._dataStoreService.getData('placed_child') ?? this.storage.getObj('placed_child');
            }
            let { status, serviceCaseID, comments } = this.validateRoleIfAPCSorFieldInStartAssessmentFn(submission);


            if (this.assessmmentName === 'SAFE-C') {
                if (submission.data.childdeceased === true) {
                    if (submission.data.deceasedChildName === '' || submission.data.columnsChildDod === '') {
                        this._alertService.error('Deceased Child Name or Child DOD is missing');
                        return;
                    }
                }
                status = 'Review';
            }

            this.handleAddAssessmentApiInStartAssessmentFn(submission, status, assessmentactor, serviceCaseID, comments);
        });
    }
    // Assosiated to startAssessment method
    private handleAddAssessmentApiInStartAssessmentFn(submission: any, status: string, assessmentactor: {}, serviceCaseID: any, comments: string) {
        this._http
            .post(this.addasssessmenturl, {
                externaltemplateid: this.currentTemplateId,
                securityusersid: this._authService.getCurrentUser().user.securityusersid,
                objectid: this.id,
                submissionid: this.submission,
                submissiondata: submission.data ? submission.data : null,
                form: submission.form ? submission.form : null,
                score: submission.data.score ? submission.data.score : 0,
                ischildsafe: this.isChildSafe,
                assessmentstatustypekey1: status,
                assessmentactor: assessmentactor ? assessmentactor : null,
                servicecaseid: serviceCaseID,
                comments: comments
            })
            .subscribe(response => {

                if (status === 'Review') {
                    this._alertService.success(this.assessmmentName + ' submitted for approval.', true);
                } else {
                    this._alertService.success(this.assessmmentName + this.savedsuccessmsg, true);
                }

                if (response.data && response.data.submissionid) {
                    this.submission = response.data.submissionid;
                }
                //if(this.token.role.name === 'apcs')
                const sup = this.token.role.name === 'apcs' ? true : false;
                setTimeout(() => {
                    this.redirectToAssessment(sup);
                },
                    1500);

                /// (<any>$('#iframe-popup')).modal('hide');
                if (this.assessmmentName !== 'SAFE-C') {
                    this.handleIfNotSAFECinStartAssessmentFn(submission);
                }
                this.handleIfParticipantDetailInStartAssessmentFn(submission);
            });
    }
    // Assosiated to startAssessment method
    private handleIfParticipantDetailInStartAssessmentFn(submission: any) {
        if (this.assessmmentName === this.transportationplanformattendingschooloforiginfromoutofhomeplacement) {
            // this.baseLocation = this.location['_platformStrategy']._platformLocation.location;
            this.baseLocation = this.location.path();
            const protocol = this.baseLocation['protocol'];
            const host = this.baseLocation['host'];
            const participantDetail = [];
            participantDetail.push(
                Object.assign({
                    objectid: submission._id,
                    objecttypekey: 'assessment',
                    email: submission.data['sendemailid'],
                    message: `${protocol}//${host}/#/external-assessment/${this.id}/review/${this.currentTemplateId}/${submission._id}`,
                    url: `${protocol}//${host}/#/external-assessment/${this.id}/review/${this.currentTemplateId}/${submission._id}`
                })
            );
            if (participantDetail) {
                this._commonService.create(participantDetail, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.EmailSchoolNotification).subscribe();
            }
        }
    }
    // Assosiated to startAssessment method
    private handleIfNotSAFECinStartAssessmentFn(submission: any) {
        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement) {
            const participantDetail: any[] = [];
            const reportedChild = this.involvedPersons.filter(item => {
                return item.rolename === 'RC' || (item.roles.length && item.roles.filter(itm => itm.intakeservicerequestpersontypekey === 'RC').length);
            });
            let reportedChildName = '';
            if (reportedChild.length) {
                reportedChildName = reportedChild[0].lastname;
                if (reportedChild[0].firstname) {
                    reportedChildName += ', ' + reportedChild[0].firstname;
                }
            }
            this.involvedPersons.forEach(item => {
                if (item.rolename !== 'RC' && item.rolename !== 'AM') {
                    participantDetail.push({
                        objectid: this.id,
                        objecttypekey: 'servicerequest',
                        personid: item.personid,
                        relationship: item.relationship,
                        email: item.email,
                        firstname: item.firstname,
                        lastname: item.lastname,
                        message: 'This is to notify you that the child ' +
                            reportedChildName.toUpperCase() +
                            ' is being enrolled in ' +
                            submission.data.selectedcurrentschool +
                            ' school based on the best interest assessment for education'
                    });
                }
            });
            this._commonService.create(participantDetail, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.Notification).subscribe();
        }
    }
    // Assosiated to startAssessment method
    private validateRoleIfAPCSorFieldInStartAssessmentFn(submission: any) {
        let status = '';
        let comments = '';
        let serviceCaseID = null;
        serviceCaseID = this.serviceCaseId;
        if (this.isServiceCase) {
            serviceCaseID = this.id;
        }

        if (this.token.role.name === 'apcs') {
            status = submission.data.assessmentstatus;
            comments = submission.data.supervisorcomments;
            if (this.assessmmentName === this.safecohp && status === '') {
                if (submission.data.submit) {
                    status = 'InProcess';
                } else {
                    status = submission.data.assessmentreviewed;
                }
            }
        } else if (this.token.role.name === 'field') {
            ({ status, comments } = this.handleRolenameIfFIELDInStartAssessementfn(submission, status, comments));
        }
        return { status, serviceCaseID, comments };
    }
    // Assosiated to startAssessment method
    private handleRolenameIfFIELDInStartAssessementfn(submission: any, status: string, comments: string) {
        if (this._authService.isDJS()) {
            if (submission.data.submit) {
                status = 'InProcess';
            } else {
                status = 'Submitted';
            }
            comments = submission.data.caseworkercomments;
        } else {
            if (submission.data.submit) {
                status = 'InProcess';
            } else {
                status = submission.data.assessmentreviewed;
            }
            comments = submission.data.caseworkercomments;
        }
        return { status, comments };
    }
    // Assosiated to startAssessment method
    private checkSubmissionCondInStartAssessmentFn(submission: any) {
        if ((this.submission === null || this.submission === undefined) && (submission._id !== null && submission._id !== undefined)) {
            this.submission = submission._id;
        }
    }

    setMaxDateTime(datetimeField: any, currentDateTime: any) {
        datetimeField.set('maxDate', currentDateTime);
        datetimeField.set('maxTime', this.formatTime(currentDateTime));
    }
    
    formatTime(date: any) {
        return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false });
    }
    
    updateMaxTime(datetimeField: any, selectedDates: any, currentDateTime: any) {
        const selectedDate = selectedDates[0];
        const isToday = selectedDate.toDateString() === currentDateTime.toDateString();
        const newMaxTime = isToday
            ? this.formatTime(new Date())
            : '23:59'; // Set maxTime to 23:59 if it's not today
        datetimeField.set('maxTime', newMaxTime);
    }
    
    startAutoUpdate(datetimeField: any, currentDateTime: any) {
        return setInterval(() => {
            const currentTime = new Date();
            datetimeField.set('maxDate', currentTime);
            const selectedDates = datetimeField.selectedDates;
            if (selectedDates.length > 0) {
                this.updateMaxTime(datetimeField, selectedDates, currentDateTime);
            }
        }, 5000);
    }

    getIndexByLatestDate(placementDetail: any){
        const datesArray = [];
        const placementDetailDateArray = [];

        for (const item of placementDetail) {
            const date = item.entry_dt.split('T')[0];
            datesArray.push(new Date(date));
            placementDetailDateArray.push(date);
        }
        const maxDate = new Date(Math.max(...datesArray.map(date => date.getTime())));
        const latestDate = maxDate.toISOString().split('T')[0];
        return placementDetailDateArray.findIndex(item => item === latestDate);
    }
    
    processShelterCareActors() {
        const assessmentactorArray = [];
        if (this._dataStoreService.getData(CASE_STORE_CONSTANTS.SHELTER_ASSESSMENT_ISRACTORID)) {
            const assessmentactor = {
                'intakeservicerequestactorid': this._dataStoreService.getData(CASE_STORE_CONSTANTS.SHELTER_ASSESSMENT_ISRACTORID)
            };
            assessmentactorArray.push(assessmentactor);
        }
        return assessmentactorArray;
    }

    submittedAssessment(assessment: GetintakAssessment) {
        this.assessmmentName = assessment.titleheadertext;
        this.currentTemplateId = assessment.external_templateid;
        if (assessment.titleheadertext === 'APPLA') {
            this.isAppla = true;
        }
        Formio.baseUrl = environment.formBuilderHost;
            const url = `admin/assessment/getassessmentform/${assessment.external_templateid}/submission/${assessment.submissionid}`;
            this._commonService.getSingle({}, url).subscribe(result => {
                /* Migration Fix */
                if (assessment.submissiondata === null) {
                    assessment.submissiondata = result;
                }
                const res = assessment.submissiondata;
                // return res;
                Formio.createForm(
                    document.getElementById('assessmentForm'),
                    environment.formBuilderHost + `/form/${assessment.external_templateid}`,
                    {
                        readOnly: true,                            
                        icons:'fontawesome',                       
                        hooks: {
                            beforeSubmit: (sub: any, nextt: any) => {
                                if (!Formio.token) {
                                    Formio.token = this.storage.getObj('fbToken');
                                }
                                nextt();
                            }
                        }
                    }
                ).then((form: any) => {
                    form.data.childdatagrid = assessment.submissiondata.childdatagrid;
                    form.components = form.components.map((formItem: any) => {
                        if (formItem.key === 'Complete' && formItem.type === 'button') {
                            formItem.action = 'submit';
                        }
                        return formItem;
                    });
                    res['userMode'] = 'view';
                    form.submission = {
                        data: res
                    };
                    form.submission.data.userMode = 'view';
                    /// (<any>$('#iframe-popup')).modal('show');
                    form.on('render', (formData: any) => {
                        setTimeout(() => {
                            $(this.assessmentpopupid).scrollTop(0);
                        }, 200);
                    });
                });
            });
        
    }

    updateAssessment(assessment: GetintakAssessment, childRemovalInfo?: any) {
        this.assessmmentName = assessment.titleheadertext;
        this.currentTemplateId = assessment.external_templateid;
        if (assessment.titleheadertext === 'APPLA') {
            this.isAppla = true;
        }
        Formio.baseUrl = environment.formBuilderHost;

        this.submission = assessment.submissionid;
        const url = `admin/assessment/getassessmentform/${assessment.external_templateid}/submission/${assessment.submissionid}`;
        this._commonService.getSingle({}, url).subscribe(result => {
            /* Migration Fix */
            if (assessment.submissiondata === null) {
                assessment.submissiondata = result;
            }
            const res = assessment.submissiondata;
        Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`, {
            readOnly: false,                 
            icons:'fontawesome',           
            hooks: {
                beforeSubmit: (subm: any, nxt: any) => {
                    if (!Formio.token) {
                        Formio.token = this.storage.getObj('fbToken');
                    }
                    nxt();
                }
            }
        }).then((form: any) => {
            form.components = this.formItemType(form);
            form.submission = {
                data: this.getFormPrePopulation(this.assessmmentName, res)
            };
            if (!form.data.childdatagrid) {
                form.data.childdatagrid = assessment.submissiondata.childdatagrid;
            }
            const assessmentactor = assessment.submissiondata.assessmentactor;
            form.on('render', () => {       // NOSONAR // This function has less than 3 lines of identical code, hence marking it as no sonar.
                if(this.assessmmentName === this.homehealthreport){
                    const datetimeField = (<any>$(`[name="data[datetimefield1]"]`)[0])._flatpickr;
                    const currentDateTime = new Date();
                    this.setMaxDateTime(datetimeField, currentDateTime);
                    // Attach the onChange handler for updating maxTime when user selects a date/time
                    datetimeField.config.onChange.push((selectedDates: any) => this.updateMaxTime(datetimeField, selectedDates, currentDateTime));
                    let updateInterval: any;
                    // Periodically update maxTime every minute while the calendar is open
                    datetimeField.config.onOpen.push(() => {
                        updateInterval = this.startAutoUpdate(datetimeField, currentDateTime);
                    });
                    // Stop the interval when the calendar is closed
                    datetimeField.config.onClose.push(() => clearInterval(updateInterval));
                }
                setTimeout(() => {
                    $(this.assessmentpopupid).scrollTop(0);
                }, 200);
            });

            form.on('saveAsDraftSAFEC', (submission: any) => {
                this.saveAsDraftSAFEC(submission)
            });  

            this.handleFormSubmitFn(form, assessment, assessmentactor);
            this.handleFormChangeFn(form);

            form.on('error', () => {      // NOSONAR // This function has less than 3 lines of identical code, hence marking it as no sonar.
                setTimeout(() => {
                    $(this.assessmentpopupid).scrollTop(0);
                }, 200);
                this._alertService.error('Unable to save ' + this.assessmmentName + '. Please try again.');
            });
        });
    });
    }

    private formItemType(form: any){
        return form.components.map((formItemType: any) => {
            if (formItemType.key === 'Complete' && formItemType.type === 'button') {
                formItemType.action = 'submit';
            }
            return formItemType;
        });
    }
    // Assosiated to updateAssessment method
    private handleFormChangeFn(form: any) {
        form.on('change', (formData: any) => {
            this.safeCProcess(formData);

            // Begin - D-06439 Fix
            if (formData.changed) {
                if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement || this.assessmmentName === 'APPLA') {
                    if (this.assesmentStatus === 'Review') {
                        document.getElementById(document.getElementsByClassName(this.cssclassname)[0].id)?.getElementsByTagName("button")[0].classList.remove('disabled');
                        this.disableSubmitforApproval = false;
                    }
                }
                const changedKey = formData.changed.component.key;


                this.handleIfChangedKeyIsSeconenameOrChildname(changedKey, form, formData);

                this.handleAssessmentNameCond4InFormChangeFn(changedKey, form, formData);

                this.handleIfMarylandfamilyriskreassessmentFn(changedKey, form, formData);

                this.handleIfNameIsSILAorMFIRA(form, formData, changedKey);

                this.handleNotificationofplacemententryandexitreceiptInFormChangeFn(form, formData, changedKey);

                this.handleIfHomehealthreportInFormChangeFn(changedKey, form, formData);
                this.handleAssessmentNameCond1InFormChangeFn(changedKey, form, formData);

                this.handleAssessmentNameCond2InFormChangeFn(form, formData, changedKey);

                this.handleAssessmentNameCond3InFormChangeFn(changedKey, form, formData);
            }
        });
    }
    // Assosiated to updateAssessment method
    private handleNotificationofplacemententryandexitreceiptInFormChangeFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === this.notificationofplacemententryandexitreceipt) {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfMarylandfamilyriskreassessmentFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.marylandfamilyriskreassessment) {
            if (!(changedKey === 'childrenname' || changedKey === 'childrenage' || changedKey === 'childrenrelationship')) {
                form.submission = {
                    data: formData.data
                };
            }
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleAssessmentNameCond4InFormChangeFn(changedKey: any, form: any, formData: any) {
        if (this.returnIfAssessmmentNameIsSAFEC(changedKey, form)) {
            if (changedKey === 'assessmentstatus') {
                if (formData.changed.value === 'Accepted' || formData.data[formData.changed.component.key] === 'Accepted') {
                    form.data.safetyassessmentapprovaldate = new Date();
                }
                if (formData.changed.value === 'Rejected' || formData.data[formData.changed.component.key] === 'Rejected') {
                    form.data.safetyassessmentapprovaldate = new Date();
                }
            }
            form.submission = {
                data: formData.data // this.setChildDetails(formData)
            };
            // End - D-06439 Fix
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfReroutesupervisorFn(changedKey: any, form: any) {
        if (changedKey === 'reroutesupervisor') {
            const origsupervisor: any = this.routingInfo.find(item => item.fromrole === 'Supervisor');
            form.submission.data.supervisorname = (form.submission.data.reroutesupervisor && form.submission.data.reroutesupervisor !== '')
                ? form.submission.data.reroutesupervisor.username : origsupervisor.fromusername;
        }
    }
    // Assosiated to updateAssessment method
    private returnIfAssessmmentNameIsSAFEC(changedKey: any, form: any) {
        return (this.assessmmentName === 'SAFE-C' && changedKey !== 'caseworkersignature' && changedKey !== 'supervisorrsignature'
            && (changedKey !== 'assessmentreviewed' || (changedKey === 'assessmentreviewed' && form.data.userrole !== 'apcs'))
            && changedKey !== 'signature');
    }
    // Assosiated to updateAssessment method
    private handleAssessmentNameCond3InFormChangeFn(changedKey: any, form: any, formData: any) {
        this.handleIfSafecohpFn(changedKey, form, formData);

        if (this.assessmmentName === this.transportationplanformattendingschooloforiginfromoutofhomeplacement) {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfSafecohpFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.safecohp) {
            if (!['caseworkersign'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleAssessmentNameCond2InFormChangeFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === 'CANS-F' || this.assessmmentName === 'cans-v2') {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        this.handleIfBestinterestdeterminationforeducationalplacementFn(changedKey, form, formData);
        if (this.assessmmentName === 'CASEY LIFE SKILLS ASSESSMENT') {
            form.submission = {
                data: formData.data
            };

            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfBestinterestdeterminationforeducationalplacementFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement) {
            if (!['fname', 'lname2', 'phonenumber', 'emailid', 'caseWorkerSignature'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleAssessmentNameCond1InFormChangeFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.domesticviolencelethalityscreenfordhs) {
            if (changedKey !== 'Signature') {
                form.submission = {
                    data: formData.data
                };
            }
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        this.handleAODFormFn(form, formData, changedKey);

        this.handleIfCansoutofhomeplacementserviceFn(form, formData, changedKey);
    }
    // Assosiated to updateAssessment method
    private handleAODFormFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === 'AOD Form') {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfCansoutofhomeplacementserviceFn(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === this.cansoutofhomeplacementservice) {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfHomehealthreportInFormChangeFn(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === this.homehealthreport) {
            if (changedKey === 'nameofcaretaker') {
                if (form.submission.data.nameofcaretaker === '') {
                    form.submission.data.age = '';
                    form.submission.data.address = '';
                    form.submission.data.city = '';
                    form.submission.data.state = '';
                    form.submission.data.zip = '';
                }
                else {
                    this.handleIfPersonSelectedInFormChangeFn(form);
                }

            }
            if (!['caseworkersignature', 'childnamelist', 'sharingbedwith', 'sleepinglocation'].includes(changedKey)) {
                form.submission = {
                    data: formData.data
                };
            }
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfPersonSelectedInFormChangeFn(form: any) {
        const personSelected: any = this.involvedPersons.find((person: any) => person.fullname.trim() === form.submission.data.nameofcaretaker);
        if (personSelected) {
            let age = personSelected['age'];
            if (age.includes(' Day(s)')) {
                age = String(age).substring(0, age.indexOf(' Day(s)'));
            } else if (age.includes(' Month(s)')) {
                age = String(age).substring(0, age.indexOf(' Month(s)'));
            } else if (age.includes(' Yrs')) {
                age = String(age).substring(0, age.indexOf(' Yrs'));
            }
            form.submission.data.age = age;
            form.submission.data.address = personSelected['address2'] ?
                personSelected['address'] + ' ' + personSelected['address2'] : personSelected['address'];
            form.submission.data.city = personSelected['city'];
            form.submission.data.state = personSelected['state'];
            form.submission.data.zip = personSelected['zipcode'];
        }
    }
    // Assosiated to updateAssessment method
    private handleIfNameIsSILAorMFIRA(form: any, formData: any, changedKey: any) {
        if (this.assessmmentName === 'SILA') {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }

        if (this.assessmmentName === 'MFIRA') {
            form.submission = {
                data: formData.data
            };
            // @TM: change supervisorname to re-routed supervisor
            this.handleIfReroutesupervisorFn(changedKey, form);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfChangedKeyIsSeconenameOrChildname(changedKey: any, form: any, formData: any) {
        if (this.assessmmentName === 'SAFE-C' && (changedKey === 'seconename' || changedKey === 'childname')) {

            form.submission = {
                data: formData.data // this.setChildDetails(formData)
            };
            let otherChildsInfoWithComma: any;
            if (form.submission.data.other_childs_json) {
                otherChildsInfoWithComma = JSON.parse(form.submission.data.other_childs_json);
            }

            if (changedKey === 'seconename') {
                otherChildsInfoWithComma.forEach((childInfo: any) => {       //  NOSONAR     // This function has less than 3 lines of identical code.
                    form.submission.data.addchildren.forEach((childdata: any) => {
                        this.checkIfSeconenameMatchesFn(childdata, childInfo);
                    });
                });
            }

            let allChilds: any;
            if (form.submission.data.all_childs_json) {
                allChilds = JSON.parse(form.submission.data.all_childs_json);
            }

            if (changedKey === 'childname') {
                allChilds.forEach((childInfo: any) => {  //  NOSONAR     // This function has less than 3 lines of identical code.
                    form.submission.data.childdatagrid.forEach((childdata: any) => {
                        this.handleIfNameMatchesFn(childdata, childInfo);
                    });
                });
            }
        }
    }
    // Assosiated to updateAssessment method
    private handleIfNameMatchesFn(childdata: any, childInfo: any) {
        if (childdata.childname === childInfo.name) {
            childdata.age = childInfo.age;
            childdata.clientid = childInfo.cjamspid;
        }
    }
    // Assosiated to updateAssessment method
    private checkIfSeconenameMatchesFn(childdata: any, childInfo: any) {
        if (childdata.seconename === childInfo.seconename) {
            childdata.seconeage = childInfo.seconeage;
        }
    }
    // Assosiated to updateAssessment method
    private handleFormSubmitFn(form: any, assessment: GetintakAssessment, assessmentactor: any) {
        form.on('submit', (submission: any) => {
            if (submission.data.safetyassessmentapprovaldate !== '' && submission.data.safetyassessmentcompletiondate !== '') {
                const approvalDate = moment(submission.data.safetyassessmentapprovaldate);
                const completionDate = moment(submission.data.safetyassessmentcompletiondate);
                if (!approvalDate.isSameOrAfter(completionDate)) {
                    this._alertService.error('Approval date should be greater than the completion date');
                    return;
                }
            }
            submission._id = assessment.submissionid;

            if (this.assessmmentName === 'SAFE-C') {
                submission.data['safeCDangerInfluence'] = this.selectedSafeCDangerInfluence;
            }
            let status = '';
            let comments = '';
            let serviceCaseID = null;
            serviceCaseID = this.serviceCaseId;
            if (this.isServiceCase) {
                serviceCaseID = this.id;
            }

            if (this.token.role.name === 'apcs') {
                const { statusTemp, commentsTemp } = this.handleRolenameIfAPCSfn(submission);
                status = statusTemp;
                comments = commentsTemp;
            } else if (this.token.role.name === 'field') {
                const { statusTemp, commentsTemp } = this.handleRolenameIfFIELDfn(submission);
                status = statusTemp;
                comments = commentsTemp;

                if (this.assessmmentName === 'SAFE-C') {
                    if(this.isAssessmmentNameSAFECfn(submission)) {
                        return
                    }
                    status = 'Review';
                }
                
            }
            if (this.isSubmitForApprovalDisabled(status)) {
                return;
            }
            
            this.handleAddasssessmentApiInFormSubmitFn(submission, status, assessmentactor, serviceCaseID, comments, assessment);
        });
    }
    // Assosiated to updateAssessment method
    private isAssessmmentNameSAFECfn(submission: any) {
        if (submission.data.childdeceased === true) {
            if (submission.data.deceasedChildName === '' || submission.data.columnsChildDod === '') {
                this._alertService.error('Deceased Child Name or Child DOD is missing');
                return true;
            }
        }
        return false;
    }
    // Assosiated to updateAssessment method
    private isSubmitForApprovalDisabled(status: any) {
        if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement || this.assessmmentName === 'APPLA') {
            if (this.disableSubmitforApproval === true) {
                return true;
            }
            document.getElementById(document.getElementsByClassName(this.cssclassname)[0].id)?.getElementsByTagName("button")[0].classList.add('disabled');
            this.disableSubmitforApproval = true;
            this.assesmentStatus = status;
        }
        return false;
    }
    // Assosiated to updateAssessment method
    private handleRolenameIfFIELDfn(submission: any) {
        let statusTemp = '';
        let commentsTemp = '';
        if (this._authService.isDJS()) {
            if (submission.data.submit) {
                statusTemp = 'InProcess';
            } else {
                statusTemp = 'Submitted';
            }
            commentsTemp = submission.data.caseworkercomments;
        } else {
            if (submission.data.submit) {
                statusTemp = 'InProcess';
            } else {
                statusTemp = submission.data.assessmentreviewed;
                if (this.assessmmentName === 'Risk Assessment Legacy') {
                    statusTemp = 'Review';
                }
            }
            commentsTemp = submission.data.caseworkercomments;
        }
        return { statusTemp, commentsTemp };
    }
    // Assosiated to updateAssessment method
    private handleRolenameIfAPCSfn(submission: any) {
        let statusTemp = submission.data.assessmentstatus;
        const commentsTemp = submission.data.supervisorcomments;
        if (this.assessmmentName === this.safecohp && statusTemp === '') {
            if (submission.data.submit) {
                statusTemp = 'InProcess';
            } else {
                statusTemp = submission.data.assessmentreviewed;
            }
        }
        // routing update to service
        this.handleRoutingupdateApiInFormSubmitFn(submission);
        return { statusTemp, commentsTemp };
    }
    // Assosiated to updateAssessment method
    private handleRoutingupdateApiInFormSubmitFn(submission: any) {
        this._commonService
            .create(
                {
                    objectid: this.id,
                    eventcode: 'SPLR',
                    status: submission.data.assessmentstatus,
                    comments: submission.data.supervisorcomments,
                    notifymsg: submission.data.supervisorcomments,
                    routeddescription: submission.data.supervisorcomments,
                    assessmmentName: this.assessmmentName
                },
                'routing/routingupdate'
            )
            .subscribe(
                () => {
                    // No content to add or call // NOSONAR
                },
                err => {
                    this._alertService.error("Routing Update failed, please contact support");
                }
            );
    }
    // Assosiated to updateAssessment method
    private handleAddasssessmentApiInFormSubmitFn(submission: any, status: string, assessmentactor: any, serviceCaseID: any, comments: string, assessment: GetintakAssessment) {
        this._http
            .post(this.addasssessmenturl, {
                externaltemplateid: this.currentTemplateId,
                objectid: this.id,
                submissionid: submission._id,
                submissiondata: submission.data ? submission.data : null,
                form: submission.form ? submission.form : null,
                score: submission.data.score ? submission.data.score : 0,
                assessmentstatustypekey1: status,
                assessmentactor: assessmentactor ? assessmentactor : null,
                servicecaseid: serviceCaseID,
                comments: comments
            })
            .subscribe(response => {
                if (this.assessmmentName === this.bestinterestdeterminationforeducationalplacement || this.assessmmentName === 'APPLA') {
                    if (!response || !(response?.data)) {
                        document.getElementById(document.getElementsByClassName(this.cssclassname)[0].id)?.getElementsByTagName("button")[0].classList.remove('disabled');
                        this.disableSubmitforApproval = false;
                        this.assesmentStatus = null;
                    }
                }
                this.handleEmailSchoolNotificationApiFn(submission);

                if (status === 'Review') {
                    this._alertService.success(this.assessmmentName + ' submitted for approval.');
                } else {
                    this._alertService.success(this.assessmmentName + this.savedsuccessmsg);
                }


                // this.getPage(1);
                // this.showAssessment(
                //     this.showAssesment,
                //     this.getAsseesmentHistory
                // );
                //if(this.token.role.name === 'apcs')
                setTimeout(() => {
                    this.redirectToAssessment();
                },
                    1500);

                /// (<any>$('#iframe-popup')).modal('hide');
                this.handleStatusIfAcceptedOrSafeCfn(submission, assessment);

            });
    }
    // Assosiated to updateAssessment method
    private handleStatusIfAcceptedOrSafeCfn(submission: any, assessment: GetintakAssessment) {
        if (submission.data.assessmentstatus === 'Accepted') {
            if (this.assessmmentName === 'CANS-F' || this.assessmmentName === 'cans-v2') {
                this.saveAssessmentStrengthNeeds('cansF');
            }
            if (this.assessmmentName === this.cansoutofhomeplacementservice) {
                this.saveAssessmentStrengthNeeds('cansOutOfHomePlacementService');
            }
        }
        if (this.assessmmentName === 'SAFE-C') {
            // save safety plan service
            this.handleAssessmentStatusIfAcceptedIfNameIsSAFECfn(submission, assessment);
            observableTimer(500).subscribe(() => {
                this._router.routeReuseStrategy.shouldReuseRoute = function () {
                    return false;
                };
                this._router.navigateByUrl(this._router.url).then(() => {
                    this._router.navigated = true;
                    this._router.navigate([this._router.url]);
                });
            });
        }
    }
    // Assosiated to updateAssessment method
    private handleEmailSchoolNotificationApiFn(submission: any) {
        if (this.assessmmentName === this.transportationplanformattendingschooloforiginfromoutofhomeplacement) {
            // this.baseLocation = this.location['_platformStrategy']['_platformLocation']['location'];
            this.baseLocation = this.location.path();
            const protocol = this.baseLocation['protocol'];
            const host = this.baseLocation['host'];
            const participantDetail = [];
            participantDetail.push(
                Object.assign({
                    objectid: submission._id,
                    objecttypekey: 'assessment',
                    email: submission.data['sendemailid'],
                    message: `${protocol}//${host}/#/external-assessment/${this.id}/approved/${this.currentTemplateId}/${submission._id}`,
                    url: `${protocol}//${host}/#/external-assessment/${this.id}/approved/${this.currentTemplateId}/${submission._id}`
                })
            );
            if (participantDetail) {
                this._commonService.create(participantDetail, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.EmailSchoolNotification).subscribe();
            }
        }
    }
    // Assosiated to updateAssessment method
    private handleAssessmentStatusIfAcceptedIfNameIsSAFECfn(submission: any, assessment: GetintakAssessment) {
        if (submission.data.assessmentstatus === 'Accepted') {
            const safeCDangerInfluence: any[] = [];
            const safeCPlanActor: any[] = [];
            if (submission.data.safeCDangerInfluence && submission.data.safeCDangerInfluence.length) {
                submission.data.safeCDangerInfluence.forEach((danger: any) => {
                    safeCDangerInfluence.push({
                        dangerinfluencenumber: danger.text,
                        dangerinfluencedesc: danger.value,
                        completiondate: '',
                        partiesname: '',
                        reevaluationdate: '',
                        actiondescription: 'no'
                    });
                });
            }
            if (submission.data.associatedetails && submission.data.associatedetails.length) {
                submission.data.associatedetails.forEach((sign: any) => {
                    safeCPlanActor.push({
                        intakeservicerequestactorid: sign.intakeservicerequestactorid,
                        signimage: sign.signature ? sign.signature.replace('data:image/png;base64,', '') : ''
                    });
                });
            }
            const safetyPlanInput = {
                intakeserviceid: this.id,
                external_templateid: assessment.external_templateid,
                submissionid: assessment.submissionid,
                savemode: 1,
                dangerinfluence: safeCDangerInfluence,
                safetyplanactor: safeCPlanActor
            };
            this._commonService.create(safetyPlanInput, 'Safetyplans/add').subscribe(
                () => {
                    // No content to add or call // NOSONAR
                },
                err => {
                    this._alertService.error("Error in saving Safetyplans");
                }
            );
            // end of save safety plan service
            this.handleIfDangerInfluencesIdentifiedFn(submission);
        }
    }
    // Assosiated to updateAssessment method
    private handleIfDangerInfluencesIdentifiedFn(submission: any) {
        if (submission.data.dangerInfluencesIdentified === 'safetydecision2' || submission.data.dangerInfluencesIdentified === 'safetydecision3') {
            // // email to safety plan persons
            // this.baseLocation = this.location['_platformStrategy']['_platformLocation']['location'];
            this.baseLocation = this.location.path();
            const protocol = this.baseLocation['protocol'];
            const host = this.baseLocation['host'];
            const safetyPlanPersons: any[] = [];
            if (submission.data.associatedetails && submission.data.associatedetails.length) {
                submission.data.associatedetails.forEach((person: { email: any; }) => {
                    safetyPlanPersons.push(
                        Object.assign({
                            objectid: submission._id,
                            objecttypekey: 'assessment',
                            email: person.email,
                            message: `${protocol}//${host}/#/external-assessment/${this.id}/${this.currentTemplateId}/${submission._id}`,
                            url: `${protocol}//${host}/#/external-assessment/${this.id}/${this.currentTemplateId}/${submission._id}`
                        })
                    );
                });
            }
            if (safetyPlanPersons) {
                this._commonService.create(safetyPlanPersons, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.EmailSchoolNotification)
                    .subscribe();
            }
            // end of email to safety plan persons
        }
    }
    
    assessmentPrintView(assessment: GetintakAssessment) {
        Formio.baseUrl = environment.formBuilderHost;
        Formio.createForm(document.getElementById('assessmentForm'), environment.formBuilderHost + `/form/${assessment.external_templateid}`, {
            readOnly: true,
             icons:'fontawesome',
             hooks: {
                beforeSubmit: (submi: any, nexxt: any) => {
                    if (!Formio.token) {
                        Formio.token = this.storage.getObj('fbToken');
                    }
                    nexxt();
                }
            }
        }).then((submission: any) => {
            const options = {
                ignoreLayout: true
            };
            this.viewHtml(submission._form, submission._submission, options);
        });
    }

    viewHtml(componentData: any, submissionData: any, formioOptions: any) {

        delete submissionData._id;
        delete submissionData.owner;
        delete submissionData.modified;
        const assessmentDateUTC = moment(submissionData.data.assessmentInitiated);
        const assessmentDateESTStr = assessmentDateUTC.utcOffset(-5).format('YYYY-MM-DDThh:mm:ss-05:00');
        submissionData.data.assessmentInitiated = assessmentDateESTStr;
        submissionData.data.datetimefield01 = submissionData.data.datetimefield01 ? 
                                                    moment(submissionData.data.datetimefield01).format('YYYY-MM-DDThh:mm a') : submissionData.data.datetimefield01;
        submissionData.data.datetimefield1 = submissionData.data.datetimefield1 ? 
                                                    moment(submissionData.data.datetimefield1).format('YYYY-MM-DDThh:mm a') : submissionData.data.datetimefield1;
        const exporter = new FormioExport(componentData, submissionData, formioOptions);
        if (this._authService.isDJS() && componentData.title === 'Intake Detention Risk Assessment Instrument') {
            exporter.component.components[0].components[2].components[0]._value = ('' + exporter.component.components[0].components[2].components[0]._value);
            exporter.component.components[0].components[3].components[0]._value = ('' + exporter.component.components[0].components[3].components[0]._value);
            exporter.component.components[0].components[4].components[0]._value = ('' + exporter.component.components[0].components[4].components[0]._value);
            exporter.component.components[0].components[5].components[0]._value = ('' + exporter.component.components[0].components[5].components[0]._value);
            exporter.component.components[0].components[6].components[0]._value = ('' + exporter.component.components[0].components[6].components[0]._value);
            exporter.component.components[0].components[7].components[0]._value = ('' + exporter.component.components[0].components[7].components[0]._value);
            exporter.component.components[0].components[0].columns[0].components[1]._value =
                (moment(new Date(exporter.component.components[0].components[0].columns[0].components[1]._value.slice(0, 10))).format(this.dtformat));
            exporter.component.components[0].components[0].columns[1].components[3]._value =
                (moment(new Date(exporter.component.components[0].components[0].columns[1].components[3]._value.slice(0, 10))).format(this.dtformat));
        }
        const appDiv = document.getElementById('divPrintView');
        exporter.toHtml().then((html: any) => {
            if (componentData.title === this.homehealthreport) {
                html.innerHTML = this.replaceAll(html.innerHTML, ' UTC</div>', '</div>');
            }
            if (this._authService.isDJS() && componentData.title === 'Intake Detention Risk Assessment Instrument') {
                html.innerHTML = this.replaceAll(html.innerHTML, ' UTC</div>', '</div>');
            }
            html.style.margin = 'auto';
            const iframe: any = this.createIframe(appDiv);
            const doc = iframe.contentDocument || iframe.contentWindow.document;
            doc.body.appendChild(html);
            this.handleFocusAndPrintFn();
        });

    }

    private handleFocusAndPrintFn() {
        // window.frames['ifAssessmentView'].focus();
        // window.frames['ifAssessmentView'].print();
        const assessmentIframeFn = document.getElementById('ifAssessmentView') as HTMLIFrameElement | null;
        if (assessmentIframeFn && assessmentIframeFn.contentWindow) {
            assessmentIframeFn.contentWindow.focus();
            assessmentIframeFn.contentWindow.print();
        }
    }

    escapeRegExp(string: any) {
        return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }

    replaceAll(str: any, term: any, replacement: any) {
        return str.replace(new RegExp(this.escapeRegExp(term), 'g'), replacement);
    }

    private createIframe(el: any) {
        _.forEach(el.getElementsByTagName('iframe'), _iframe => {
            el.removeChild(_iframe);
        });
        const iframe = document.createElement('iframe');
        iframe.setAttribute('id', 'ifAssessmentView');
        iframe.setAttribute('name', 'ifAssessmentView');
        iframe.setAttribute('frameborder', '0');
        iframe.setAttribute('webkitallowfullscreen', '');
        iframe.setAttribute('mozallowfullscreen', '');
        iframe.setAttribute('allowfullscreen', '');
        iframe.setAttribute('style', 'width: -webkit-fill-available;height: -webkit-fill-available;');
        el.appendChild(iframe);
        return iframe;
    }

    private getFormPrePopulation(formName: string, submissionData: any) {
        const prefillUtil = new AssessmentPreFill(this.involvedPersons, this.routingInfo, this.routingSupervisors ,
                                                    this.token, this._commonService, this._dataStoreService, this._authService);
        switch (formName.toUpperCase()) {
            case 'MFIRA':
                submissionData = prefillUtil.fillMFRA(submissionData, this.daNumber);
                break;

            case this.marylandfamilyriskreassessment:
                submissionData = prefillUtil.fillMFRR(submissionData, this.daNumber);

                break;

            case 'SAFE-C':
                submissionData = prefillUtil.fillSafeC(submissionData, this.daNumber);
                break;

            case 'CANS-F':
                submissionData = prefillUtil.fillCansF(submissionData, this.daNumber);
                break;
            case 'SILA':
                submissionData = prefillUtil.fillSila(submissionData);
                break;

            case 'CANS-V2':
                submissionData = prefillUtil.fillCansFv2(submissionData, this.daNumber);
                break;
            case this.homehealthreport:
                submissionData = prefillUtil.fillHomeHealthReport(submissionData, this.daNumber);
                break;
            case this.safecohp:
                this.placement = this.placement.filter(item => !item.placeenddatetime && item.role === 'RC');
                submissionData = prefillUtil.fillSafeCOHP(submissionData, this.daNumber, this.placementInfo, this.removalChildList);
                break;
            case this.transportationplanformattendingschooloforiginfromoutofhomeplacement:
                submissionData = prefillUtil.fillTransportationPlan(submissionData, this.daNumber, this.childDetail);
                break;
            case this.bestinterestdeterminationforeducationalplacement:
                submissionData = prefillUtil.fillBestInterestDetermination(submissionData, this.daNumber, this.token.user.userprofile.displayname, this.eductionDetatils);
                break;
             case 'CASEY LIFE SKILLS ASSESSMENT':
                submissionData = prefillUtil.fillCaseyLifeSkills(submissionData, this.removalChildList);
                    break;
            case this.cansoutofhomeplacementservice:
                submissionData = prefillUtil.fillCansOutOfHomePlacement(submissionData, this.daNumber, this.token.user.userprofile.displayname, 
                                    this.placement, this.intakAssessment);
                break;
            /* case 'CLIENT ASSESSMENT FORM - 716 A':               //SonarQube fix - commented as there is not implementation inside
                // submissionData = prefillUtil.fillClientAssessmentForm716A(submissionData, this.daNumber, this.dsdsActionsSummary);
                break;
            case 'INVESTIGATION OUTCOME REPORT - 716 B':
                // submissionData = prefillUtil.fillInvestigationOutcomeReport716B(submissionData, this.daNumber, this.dsdsActionsSummary);
                break; */
            case 'ADULT PROTECTIVE SERVICE PROGRAM - PROJECT HOME APPLICATION':
                submissionData = prefillUtil.fillProjectHomeApplication(submissionData);
                break;

            case 'PROJECT HOME - RESIDENT AGREEMENT':
                submissionData = prefillUtil.fillResidentAgreement(submissionData);
                break;
            // case this.notificationofplacemententryandexitreceipt:
            // submissionData = prefillUtil.fillNotificationOfPlacement(submissionData, this.daNumber, this.token.user.userprofile.displayname);
            case 'CINA SHELTER PETITION REQUEST':
                submissionData = prefillUtil.fillCinaShelterPetition(submissionData, this.childRemovalInfo, this.daNumber, this.dsdsActionsSummary);
                break;

            case 'HOUSING CLASSIFICATION RE-ASSESSMENT FORM':
                submissionData = prefillUtil.housingClassificationReAssessment(submissionData);
                break;

            case 'DJS HOUSING CLASSIFICATION ASSESSMENT':
                submissionData = prefillUtil.djsHousingClassificationAssessment(submissionData);
                break;

            case 'YOUTH VULNERABILITY ASSESSMENT INSTRUMENT':
                submissionData = prefillUtil.youthVulnerabilityAssessmentInstrument(submissionData);
                break;

            case 'APPLA':
                submissionData = prefillUtil.fillAppla(submissionData);
                break;

            case 'PRE-DISCHARGE RE-ENTRY TRANSITION PLAN':
                submissionData = prefillUtil.b_02735uniform45dayspredischarge(submissionData, this.youthInvolvedPersons);
                break;

            case 'POST-DISCHARGE RE-ENTRY TRANSITION PLAN':
                submissionData = prefillUtil.b_02736postdischargere_enterytransitionplan(submissionData, this.youthInvolvedPersons);
                break;

            case 'DRAI FOLLOW UP':
                submissionData = prefillUtil.draiFollowUp(submissionData, this.youthInvolvedPersons);
                break;

            case 'INTAKE DETENTION RISK ASSESSMENT INSTRUMENT':
                submissionData = prefillUtil.intakedrai(submissionData, this.involvedPersons.find(data => data.rolename === 'Youth'), 
                                                            JSON.parse(JSON.stringify(this.intakeFormDRAIData)));
                break;
            case 'SHELTER CARE AUTHORIZATION AND DATE OF HEARING':
                submissionData = prefillUtil.shelterPetition(submissionData);
            break;
            case 'AOD FORM':  
            case 'AOD/PADS FORM':                          //SonarQube fix - added this as 1 to reduce the no.of switch cases(max 30)
                submissionData = prefillUtil.fillAOD(submissionData);
                break;
            /* case 'AOD/PADS FORM':
                 submissionData = prefillUtil.fillAOD(submissionData);
                break; */
            case this.domesticviolencelethalityscreenfordhs:
                submissionData = prefillUtil.fillDomesticViolence(submissionData);
                break;
            case this.notificationofplacemententryandexitreceipt:
                submissionData = prefillUtil.fillNotificationOfPlacement(submissionData, this.removalChildList);
                break;
            case 'RISK ASSESSMENT LEGACY':
                submissionData = prefillUtil.fillRiskAssessmentLegacy(submissionData, this.daNumber);
                break;

        }

        return submissionData;
    }
    get getChildList() {
        const CHILD_CATEGORIES = ['CHILD', 'BIOCHILD', 'NVC', 'OTHERCHILD', 'PAC', 'RC', 'AV'];
        return this.involvedPersons.filter(child => {
            let childFound = false;
            const roles = Array.isArray(child.roles) ? child.roles : [];
            roles.forEach(role => {
                const childCategory = CHILD_CATEGORIES.find(category => category === role.intakeservicerequestpersontypekey);
                if (childCategory) {
                    childFound = true;
                    return true;
                }
                return false
            });
            return childFound;
        });
    }

    processMFRRActors($event: any) {
        const assessmentactorArray: any[] = [];
        if (this.involvedPersons) {
            this.involvedPersons.forEach((data) => {        //SonarQube fix - Consider using "forEach" instead of "map" as its return value is not being used here.
                const childname = this.getName(data);
                if($event.data && $event.data.familygrid){
                    $event.data.familygrid.forEach((child: any) => {
                        const formchildname = child.childrenname;
                        const assessmentactor = {
                            'intakeservicerequestactorid': data.intakeservicerequestactorid
                        };
                        if ((childname.toLowerCase().trim() === formchildname.toLowerCase().trim())) {
                            assessmentactorArray.push(assessmentactor);
                        }
                    });
                }
            });
        }
        return assessmentactorArray;
    }
    
    getName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
        if(person && person.hasOwnProperty(key)){
            if ( (person[key] != null) && (person[key] !== 'null') && (person[key] !== '') ) {
            name = name + person[key];
            }}
            name = name + ' ';
        });
        return name;
    }
    processSafeCOHP($event: any) {
        const assessmentactorArray: any[] = [];
        if (this.getChildList) {
            this.getChildList.forEach((data) => {       //SonarQube fix - Consider using "forEach" instead of "map" as its return value is not being used here.
                const childname = data.firstname + ' ' + data.lastname;
                if($event.data &&  ((childname).toLowerCase().trim() === ($event.data.ClientName).toLowerCase().trim())){
                    const assessmentactor = {
                        'intakeservicerequestactorid': data.intakeservicerequestactorid
                    };
                    assessmentactorArray.push(assessmentactor);
                }

            });
        }
        return assessmentactorArray;
    }

    processChildDetails($event: any) {
        const assessmentactorArray: any[] = [];
        let childIsUnsafe = null;
        if($event.data){
            childIsUnsafe = ($event.data.dangerInfluencesIdentified === 'childIsUnsafe');
        }

        const issafe = childIsUnsafe ? 0 : 1;
        if (this.getChildList) {
            this.getChildList.forEach((data) => {          //SonarQube fix - Consider using "forEach" instead of "map" as its return value is not being used here.
                const childname = data.firstname + ' ' + data.lastname;

                this.handleIfChilddatagridProcessChildDetailsFn($event, data, issafe, childname, assessmentactorArray);


                this.handleIfAddchildrenInProcessChildDetailsFn($event, data, issafe, childname, assessmentactorArray);

            });
            // //  $event.data.childdatagrid.forEach(child => {
            // //     const  assessmentactor = {
            // //         'intakeservicerequestactorid': child.cjamspid,
            // //         'issafe': child.issafe };
            // //         assessmentactorArray.push(assessmentactor);
            // //  });
            return assessmentactorArray;
        }
        return {};
    }
    // Assosiated with processChildDetails method
    private handleIfAddchildrenInProcessChildDetailsFn($event: any, data: InvolvedPerson, issafe: number, childname: string, assessmentactorArray: any[]) {
        if ($event.data && $event.data.addchildren) {
            $event.data.addchildren.forEach((childd: any) => {
                const formchildname = childd.seconename;
                const assessmentactor = {
                    'intakeservicerequestactorid': data.intakeservicerequestactorid,
                    'issafe': issafe
                };
                if (childname.toLowerCase().trim() === formchildname.toLowerCase().trim()) {
                    if (assessmentactorArray.find(x => x.intakeservicerequestactorid === assessmentactor.intakeservicerequestactorid) === undefined) {
                        assessmentactorArray.push(assessmentactor);
                    }
                }
            });
        }
    }
    // Assosiated with processChildDetails method
    private handleIfChilddatagridProcessChildDetailsFn($event: any, data: InvolvedPerson, issafe: number, childname: string, assessmentactorArray: any[]) {
        if ($event.data && $event.data.childdatagrid) {
            $event.data.childdatagrid.forEach((chld: any) => {
                const formchildname = chld.childname;
                const assessmentactor = {
                    'intakeservicerequestactorid': data.intakeservicerequestactorid,
                    'issafe': issafe
                };
                if (childname.toLowerCase().trim() === formchildname.toLowerCase().trim()) {
                    assessmentactorArray.push(assessmentactor);
                }
            });
        }
    }

    private getAge(dateValue: any) {
        if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
            const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
            return moment().diff(rCDob, 'years');
        } else {
            return '';
        }
    }
    setChildDetails($event: any) {
        if ($event.changed && $event.changed.component.key === 'childname') {

            if (this.getChildList) {
                this.getChildList.forEach((data) => {   //SonarQube fix - Consider using "forEach" instead of "map" as its return value is not being used here.
                    const childname = data.firstname + ' ' + data.lastname;
                    $event.data.childdatagrid.forEach((child: any, index: any) => {
                        const formchildname = child.childname;
                        $event.data.childdatagrid[index].childname = childname;
                        if (childname === formchildname || $event.changed.value === '') {
                            $event.data.childdatagrid[index].clientid = data.cjamspid;
                            $event.data.childdatagrid[index].age = this.getAge(data.dob);
                        }
                    });

                });
            }
            return $event.data;
        } else {
            return $event.data;
        }
    }
    private safeCProcess1($event: any) {
        if (this.assessmmentName === 'SAFE-C') {
            if ($event.changed) {
                const dangerInfluenceKey = $event.changed.component.key;
                if (dangerInfluenceKey === 'childIsUnsafe') {
                    this.isChildSafe = !$event.data[$event.changed.component.key];
                }
                if (dangerInfluenceKey && this.safeCKeys.indexOf(dangerInfluenceKey) > -1) {
                    this.handleDangerInflunceItemFn(dangerInfluenceKey, $event);
                }
            }
        } else {
            this.selectedSafeCDangerInfluence = [];
        }
        return of($event);
    }
    // Assosiated with safeCProcess1, safeCProcess method
    private handleDangerInflunceItemFn(dangerInfluenceKey: any, $event: any) {
        const dangerInflunceItem = this.selectedSafeCDangerInfluence.find(item => item.value === dangerInfluenceKey);
        if (dangerInflunceItem) {
            if ($event.changed.value === 'no' || $event.data[$event.changed.component.key] === 'no') {
                const itemIndex = this.selectedSafeCDangerInfluence.indexOf(dangerInflunceItem);
                this.selectedSafeCDangerInfluence.splice(itemIndex, 1);
            }
        } else {
            if ($event.changed.value === 'yes' || $event.data[$event.changed.component.key] === 'yes') {
                this.selectedSafeCDangerInfluence.push({
                    text: $event.changed.component.label,
                    value: dangerInfluenceKey
                });
            }
        }
    }

    private safeCProcess($event: any) {
        if (this.assessmmentName === 'SAFE-C') {
            if ($event.changed) {
                const dangerInfluenceKey = $event.changed.component.key;
                if (dangerInfluenceKey === 'childIsUnsafe') {
                    this.isChildSafe = !$event.data[$event.changed.component.key];
                }
                if (dangerInfluenceKey && this.safeCKeys.indexOf(dangerInfluenceKey) > -1) {
                    this.handleDangerInflunceItemFn(dangerInfluenceKey, $event);
                }
            }
        } else {
            this.selectedSafeCDangerInfluence = [];
        }
    }

    redirectToAssessment(isSup?: any) {
        this.isInitialized = false;
        if (this.intakAssessment && this.intakAssessment.description === 'CINA Shelter Petition Request') {
            this._router.navigate([this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/child-removal']);
        } else if ((this.intakAssessment ) && (this.intakAssessment.description === 'APPLA' || this.intakAssessment.titleheadertext === 'APPLA')) {
            this._router.navigate([this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/sc-permanency-plan/placement/appla/list']);
        } else if (this.isShelterForm && !isSup) {
            this.isShelterForm = false;
            this._router.navigate([this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/child-removal/details']);
        } else {
            this._router.navigate([this.caseworkerurl + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
        }
    }
    saveAssessmentStrengthNeeds(templatename: any) {
        // How do we handle cans-outofhome?
        const payload = {
          'objectid': this.id,
          'templatename': templatename,
          'status': 'accepted'
        };
        this._commonService.create(payload, 'serviceplan/saveAssessmentStrengthNeeds').subscribe();
      }

      printAssessment() {
          window.print();
      }

      ngOnDestroy() {
        window.location.reload();
    }
}