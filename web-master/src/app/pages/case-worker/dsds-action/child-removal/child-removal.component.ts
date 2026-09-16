
import {pluck, share, map} from 'rxjs/operators';
import { AfterViewInit, Component, OnInit, Injector } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import moment from 'moment';
import _ from 'lodash';
import { forkJoin ,  Observable } from 'rxjs';
import { DataStoreService } from '../../../../@core/services';
import { AuthService } from '../../../../@core/services/auth.service';
import { RoutingUser } from '../../../cjams-dashboard/_entities/dashBoard-datamodel';
import { Assessments } from '../../../newintake/my-newintake/_entities/newintakeModel';
import { DSDSActionSummary, InvolvedPerson, RoutingInfo } from '../../_entities/caseworker.data.model';
import { DropdownModel, PaginationRequest } from './../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from './../../../../@core/entities/constants';
import { AlertService } from './../../../../@core/services/alert.service';
import { CommonHttpService } from './../../../../@core/services/common-http.service';
import { GenericService } from './../../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from './../../case-worker-url.config';
import { ChildRoles, EmailNotification, NotificationRole, NotificationUser, Providerinfo, RoutingUserList, AssessmentInfo, ServiceCase, CreateCase } from './_entities/childremoval.model';
import { SaftyPlanBlob } from '../involved-persons/_entities/involvedperson.data.model';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { IntakeUtils } from '../../../_utils/intake-utils.service';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'child-removal',
    templateUrl: './child-removal.component.html',
    styleUrls: ['./child-removal.component.scss'],
    standalone: false
})
export class ChildRemovalComponent implements OnInit, AfterViewInit {
    [key: string]: any;
    childRemovalFormGroup!: FormGroup;
    serviceCaseFormGroup!: FormGroup;
    serviceCase!: ServiceCase;
    caseFormData!: CreateCase;
    notificationFormGroup!: FormGroup;
    jDFormGroup!: FormGroup;
    vPFormGroup!: FormGroup;
    sHBFormGroup!: FormGroup;
    cdvpFormGroup!: FormGroup;
    childRemovalID!: string;
    childDetails: DropdownModel[] = [];
    personDetails: DropdownModel[] = [];
    familyStructureDropdown$!: Observable<DropdownModel[]>;
    removalTypeDropdown$!: Observable<DropdownModel[]>;
    removalReasonSelection: any[] = [];
    removalReasonDropdownItems!: any[];
    involevedPerson: InvolvedPerson[] = [];
    notificationRole: NotificationRole[] = [];
    removalReasonDescription: string[] = [];
    relationName: ChildRoles[] = [];
    dsdsActionsSummary = new DSDSActionSummary();
    removalReasonDropdownItems$!: Observable<DropdownModel[]>;
    sendToDropdownItems$!: Observable<DropdownModel[]>;
    statesDropdownItems$!: Observable<DropdownModel[]>;
    attachmentTypeDropdown$!: Observable<DropdownModel[]>;
    jurisdictionDropdownItems$!: Observable<DropdownModel[]>;
    daNumber: string;
    id: string;
    primaryCaregiverList: InvolvedPerson[] =  [];
    cjamspid: string;
    emailNotificationList: NotificationRole[] = [];
    emailNotificationSave: EmailNotification[] = [];
    muiltipleNotification: EmailNotification[] = [];
    caseWorkerList!: RoutingUser[];
    childRemovalSettings = {
        fatherFirstName: '',
        fatherLastName: '',
        motherFirstName: '',
        motherLastName: ''
    };
    ismailsent = false;
    caseWorkersName: string[] = [];
    childOtherDetails!: ChildRoles;
    saveBtnDisable = true;
    externaltemplateid = '';
    private routingInfo!: RoutingInfo[];
    private submissionId!: string;

    placementProvider = new Providerinfo;
    routingUser!: RoutingUserList;
    notificationUser = new NotificationUser;
    assessmentInfo = new AssessmentInfo;
    childRemovalShow = false;
    isVP = false;
    isJD = false;
    isSHB = false;
    isCDVP = false;
    userInfo: AppUser;
    childremovalpopupid = '#ChildRemovalNotification';
    montgomerycounty = 'Montgomery County';
    twelvehour: boolean = true;
    timeInterval: number = 5;
    iscaseexpunged: any = 0;


    private _commonService: CommonHttpService;
    private _authService: AuthService;
    private _alertService: AlertService;
    private _router: Router;
    private _assessmentService: GenericService<Assessments>;
    private _formBuilder: FormBuilder;
    private _dataStoreService: DataStoreService;
    private intakeUtils: IntakeUtils;

    constructor(private injector: Injector){
        this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._assessmentService = this.injector.get<GenericService<Assessments>>(GenericService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
    
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.userInfo = this._authService.getCurrentUser();
        this.cjamspid = this.userInfo.user.userprofile.cjamspid;
    }

    ngOnInit() {
        this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
        this.getInvolvedPerson();
        this.initializeForm();
        this.loadCaseWorker();
        this.getplacementProvider();
        this.childRemovalFormGroup.controls['fathername'].disable();
        this.childRemovalFormGroup.controls['fatherLastName'].disable();
        this.childRemovalFormGroup.controls['mothername'].disable();
        this.childRemovalFormGroup.controls['motherLastName'].disable();
        this.childRemovalFormGroup.controls['rmvdfrmpersonname'].disable();
        this.getRoutingInfo();
        this.getJurisdictionDropdown();
        this.childRemovelCheck().subscribe((item) => {
            this.childRemovalShow = false;
            if (item.length) {
                const safetyPlanBlob = <SaftyPlanBlob>item[0];
                if (safetyPlanBlob) {
                    if (safetyPlanBlob.assessmentstatustypekey !== 'InProcess') {
                        if (safetyPlanBlob.submissiondata) {
                            if (safetyPlanBlob.submissiondata['dangerInfluencesIdentified'] === 'childIsUnsafe') {
                                this.childRemovalShow = true;
                            }
                        }
                    }
                }
            }
        });
    }

    ngAfterViewInit() {
        $('#child-removel').click();
    }
    initializeForm() {
        this.childRemovalFormGroup = this._formBuilder.group({
            intakeservicerequestactorid: [null, Validators.required],
            rmvdfrmisractorid: [null],
            fathername: [''],
            fatherLastName: [''],
            mothername: [''],
            motherLastName: [''],
            removaladd1: ['', Validators.required],
            removaladd2: [''],
            removalzip: ['', Validators.required],
            removalstatecd: ['', Validators.required],
            removalcity: ['', Validators.required],
            rmvdfrmpersonname: [null, Validators.required],
            removalreason: ['', Validators.required],
            agencytypekey: ['', Validators.required],
            removaldate: ['', Validators.required],
            removaltypekey: ['', Validators.required]
            // primarycaregiverid: [null],
            //  Validators.required removed in on init please do validation on @showTypeofRemoval()
        });
        this.serviceCaseFormGroup = this._formBuilder.group({
            intakeserviceid: [''],
            servicecaseid: [null],
            isnewcase: ['']
        });
        this.cdvpFormGroup =  this._formBuilder.group({
            familystructuretypekey: [''],
            vpabegindate: [null],
            vpaparentssigneddate: [''],
            agencysigneddate: [''],
            isbothparentssigned: [''],
            reasonableeffortsmade: [''],
            childfactorsentry: [''],
            removaltypeform: [''],
            primarycaregiveractorid: ['']
        });

        this.notificationFormGroup = this._formBuilder.group({
            notify: this._formBuilder.array([]),
            ldssCaseworkers: [''],
            ldssCountyid: [null],
            ldssMessage: ['', Validators.required]
        });

        this.jDFormGroup = this._formBuilder.group({
            judicialFlag: [''],
            clientId: [''],
            ctwsanctioningchildremoval: [null],
            childphysicalremovaldate: [null],
            petitionfiledate: [null],
            dateofremovalcourthearing: [null],
            magistrateorjudgename: [null],
            judgesigned: [null],
            ctwdecision: [null],
            dateoffindingctwdecision: [null],
            hearingdate: [null],
            whoisresponsibleforplacementandcare: [null],
            nameofsubjectctwfinding: [null],
            clientidofsubjectctwfinding: [null],
            relationshipofsubjectctwfinding: [null],
            physicalremovalafterdetermination: [null],
            removalcourtorderdate: [null],
            childphysicalremovaladdress: [null],
            courtorderdelayremoval: [null],
            courtorderdelaytimeframe: [null],
            childphysicaladdressafterremoval: [null],
            specifiedrelativephysicaladdressafterremoval: [null],
            specifiedrelativename: [null],
            specifiedrelativeclientid: [null],
            specifiedrelativedatechildlastlivedwith: [null],
            specifiedrelativephysicaladdress: [null],
            specifiedrelativerelationshipid: [null],
            dateofreasonableeffortscourthearing: [null],
            reasonableeffortsmade: [null],
            reasonableEffortsnotnecessaryduetoemergentcircumstances: [null],
            sheltergranted: [null]
        });
        this.sHBFormGroup = this._formBuilder.group({
            safeHavenFlag: [''],
            clientId: [''],
            issafehavenbaby: [''],
            nameofsubjectctwfinding: [''],
            clientidofsubjectctwfinding: [null],
            relationshipofsubjectctwfinding: [''],
            childphysicalremovaladdress: [''],
            childphysicaladdressafterremoval: [''],
            specifiedrelativephysicaladdressafterremoval: ['']
        });
        this.vPFormGroup = this._formBuilder.group({
            vpaFlag: [''],
            clientId: [''],
            typeofvpa: [null],
            eavpaagreementflag: [null],
            vpaparentssigneddate: [null],
            parent2signeddate: [null],
            dateofguardiansignatureonvpa: [null],
            // primarycaregiverid: [null],
            dateofchildsignatureonvpa: [null],
            vpadsssigneddate: [null],
            vpabegindate: [null],
            mandatorynoteonmissing2ndparentsignatureonvpa: [''],
            entry_dt: [null],
            nameofsubjectctwfinding: [null],
            clientidofsubjectctwfinding: [null],
            relationshipofsubjectctwfinding: [null],
            childphysicalremovaladdress: [null],
            childphysicaladdressafterremoval: [null],
            specifiedrelativephysicaladdressafterremoval: [null]
        });
    }

    createFormGroup() {
        return this._formBuilder.group({
            personid: [''],
            firstname: [''],
            lastname: [''],
            countyid: [null],
            rolename: [''],
            relationship: [''],
            email: ['', Validators.required],
            message: ['', Validators.minLength(1), Validators.required],
            ismailsent: [false]
        });
    }

    private loadCaseWorker() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INVR' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.caseWorkerList = result.data;
            });
    }

    notifyCaseWorkers(event: any) {
        this.muiltipleNotification = [];
        this.caseWorkersName = [];
        this.caseWorkerList.forEach(data => {
            event.map((sel: string) => {
                if (data.userid === sel) {
                    const msgSent = {
                        userid: data.userid,
                        email: data.email
                    };
                    this.muiltipleNotification.push(msgSent);
                }
            });
        });

        const selectedUsers = this.caseWorkerList.filter(data => {
            if (data) {
                if (event.includes(data.userid)) {
                    return data;
                }
            }
        });
        this.caseWorkersName = selectedUsers.map(res => res.username);
    }

    setFormValues() {
        this._dataStoreService.currentStore.subscribe(store => {
            if (store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
            }
        });
        const control = <FormArray>this.notificationFormGroup.controls.notify;
        this.emailNotificationList.forEach(x => {
            control.push(this.buildEmailNotificationForm(x));
        });
    }

    private buildEmailNotificationForm(x: any): FormGroup {
        const notificationlogValue = (x.notificationlog.ismailsent ? true : false);
        return this._formBuilder.group({
            personid: x.personid ? x.personid : '',
            firstname: x.firstname ? x.firstname : '',
            lastname: x.lastname ? x.lastname : '',
            rolename: x.rolename ? x.rolename : '',
            relationship: x.relationship ? x.relationship : '',
            ismailsent: x.notificationlog ? notificationlogValue : false,
            email: x.email ? x.email : '',
            countyid: x.countyid ? x.countyid : '',
            message: x.notificationlog ? x.notificationlog.message : this.changeFormJurisdiction(null, 0, 0, x)
        });
    }

    getInvolvedPerson() {
        // Both branches pointed at GetPersonList, which accepts a single required
        // 'data' query argument and reads where.intakeservreqid. The CW branch sent
        // '?filter' with where.intakeserviceid -- that is getpersondetailcw's
        // contract -- so 'data' resolved to undefined and strong-remoting rejected
        // the call with "data is a required argument" before the method ran. The
        // agency made no difference to the url, so use the endpoint's own contract.
        const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListUrl + '?data';
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeservreqid: this.id }
                }), url
            ).subscribe((item) => {
                this.involevedPerson =  item.data;
                this.primaryCaregiverList = item['data'];
                this.involevedPerson.forEach((data) => {
                if (data.relationship === 'BGFTHR' || data.relationship === 'RELATIVE') {
                        this.childRemovalSettings.fatherFirstName = data.firstname;
                        this.childRemovalSettings.fatherLastName = data.lastname;
                    }
                if (data.relationship === 'BGMTHR' || data.relationship === 'RELATIVE') {
                    this.childRemovalSettings.motherFirstName =
                        data.firstname;
                    this.childRemovalSettings.motherLastName =
                        data.lastname;
                }
            });
            this.getInvolvedPersonList();
                this.loadDropDown();
            });
    }

    getInvolvedPersonList() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 20,
                    method: 'get',
                    where: { intakeserviceid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .InvolvedPersonList + '?filter'
            )
            .subscribe(items => {
                if (items.data) {
                    this.childDetails = [];
                    this.personDetails = [];
                    this.relationName = [];
                    this.relationName = items.data;
                    this.getChildDetailsDropdown(items);
                    this.getPersonDetailsDropdown(items);
                }
            });
    }

    getChildDetailsDropdown(items: any){
        items.data.map((list: { roles: any; firstname: string; lastname: string; }) => {
            if (list.roles) {
                const checkRC = list.roles.filter((role: { intakeservicerequestpersontypekey: string; }) =>
                        role.intakeservicerequestpersontypekey ===
                        'RC'
                );
                const checkAV = list.roles.filter((role: { intakeservicerequestpersontypekey: string; }) =>
                        role.intakeservicerequestpersontypekey !==
                        'RC' &&
                        role.intakeservicerequestpersontypekey ===
                        'AV'
                );
                if (checkRC.length) {
                    checkRC.map((res: { intakeservicerequestactorid: any; }) => {
                        this.childDetails.push(
                            new DropdownModel({
                                value:
                                    res.intakeservicerequestactorid,
                                text:
                                    list.firstname +
                                    ' ' +
                                    list.lastname
                            })
                        );
                    });
                } else if (checkAV.length) {
                    checkAV.map((res: { intakeservicerequestactorid: any; }) => {        // NOSONAR      // This function has less than 3 lines of identical code hence marking it as no sonar.
                        this.childDetails.push(
                            new DropdownModel({
                                value:
                                    res.intakeservicerequestactorid,
                                text:
                                    list.firstname +
                                    ' ' +
                                    list.lastname
                            })
                        );
                    });
                }
            }
        });
    }

    getPersonDetailsDropdown(items: any){
        items.data.map((list: { ishousehold: any; relationship: string; personid: any; }) => {
            if (
                list.ishousehold &&
                list.relationship &&
                list.relationship !== 'norelation'
            ) {
                this.personDetails.push(
                    new DropdownModel({
                        value: list.personid,
                        text: list.relationship
                    })
                );
            }
        });
    }

    loadDropDown() {
        const source = forkJoin([
            this._commonService.getArrayList(
                {
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetRemovalReason + '?filter'
            ),
            this._commonService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetState +
                    '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where: { agencycategorykey: 'CHDC' },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetSentTo +
                    '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where: { referencetypeid: '52', teamtypekey: null },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
                    '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where: { referencetypeid: '53', teamtypekey: null },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetTypes +
                    '?filter'
            )
        ]).pipe(
            map(result => {
                return {
                    removalReason: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.removalreasontypekey
                            })
                    ),
                    states: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.statename,
                                value: res.stateabbr
                            })
                    ),
                    sendTo: result[2].map(
                        res =>
                            new DropdownModel({
                                text: res.typedescription,
                                value: res.agencytypekey
                            })
                    ),
                    familyStructure: result[3].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.ref_key
                            })
                    ),
                    childRemoval: result[4].map(
                        res =>                           // NOSONAR      // This function has less than 3 lines of identical code hence marking it as no sonar.
                            new DropdownModel({
                                text: res.description,
                                value: res.ref_key
                            })
                    )
                };
            }),
            share(),);
        this.removalReasonDropdownItems$ = source.pipe(pluck('removalReason'));
        this.statesDropdownItems$ = source.pipe(pluck('states'));
        this.sendToDropdownItems$ = source.pipe(pluck('sendTo'));
        this.familyStructureDropdown$ = source.pipe(pluck('familyStructure'));
        this.removalTypeDropdown$ = source.pipe(pluck('childRemoval'));
        this.getChildRemoval();
    }

    removalReason(event: any) {
        this.removalReasonDropdownItems$.subscribe(data => {
            if (data) {
                const removalReasonItems = data.filter(item => {
                    if (event.includes(item.value)) {
                        return item;
                    }
                });
                this.removalReasonDescription = removalReasonItems.map(
                    res => res.text
                );
            }
        });

        this.removalReasonSelection = event.map((sel: any) => {
            return {
                removalreasontypekey: sel
            };
        });
    }

    enableOtherReason(event: any) {
        if (event === 'other') {
            this.childRemovalFormGroup.controls['rmvdfrmpersonname'].enable();
            this.childRemovalFormGroup.controls['rmvdfrmpersonname'].reset();
        } else {
            this.childRemovalFormGroup.controls['rmvdfrmpersonname'].disable();
            this.relationName.forEach(items => {
                if (items.personid === event) {
                    this.childRemovalFormGroup.patchValue({
                        rmvdfrmpersonname:
                            items.firstname + ' ' + items.lastname
                    });
                }
            });
        }
    }

    getChildRemoval() {
        this._commonService
            .getSingle(
                {
                    where: { intakeserviceid: this.id },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .GetChildRemovalList + '?filter'
            )
            .subscribe(result => {
                if (result && result.length) {
                    this.saveBtnDisable = false;
                    this.childRemovalID = result[0].intakeservreqchildremovalid;
                    const reason: any[] = [];
                    this.removalReasonSelection = result[0].removalreason.map((element: { removalreasontypekey: any; }) => {
                            return {
                                removalreasontypekey:
                                    element.removalreasontypekey
                            };
                        }
                    );
                    result[0].removalreason.map((element: { removalreasontypekey: any; }) => {
                        reason.push(element.removalreasontypekey);
                    });

                    this.removalReasonDropdownItems$.subscribe(data => {
                        if (data) {
                            const removalReasonValue = this.removalReasonSelection.map(
                                res => res.removalreasontypekey
                            );
                            const removalReasonItems = data.filter(item => {
                                if (removalReasonValue.includes(item.value)) {
                                    return item;
                                }
                            });
                            this.removalReasonDescription = removalReasonItems.map(
                                res => res.text
                            );
                        }
                    });

                    this.childRemovalFormGroup.patchValue(result[0]);
                    this.cdvpFormGroup.patchValue(result[0]);
                    this.childRemovalFormGroup.controls[
                        'removalreason'
                    ].patchValue(reason);
                    this.childRemovalFormGroup.patchValue({
                        rmvdfrmisractorid:
                            result[0].rmvdfrmisractorid === null
                                ? 'other'
                                : result[0].rmvdfrmisractorid
                    });
                    this.showChildDetails();
                } else {
                    this.saveBtnDisable = true;
                }
                this.childRemovalFormGroup.patchValue({
                    fathername: this.getFatherFirstName()
                });
                this.childRemovalFormGroup.patchValue({
                    fatherLastName: this.getFatherLastName()
                });
                this.childRemovalFormGroup.patchValue({
                    mothername: this.getMotherFirstName()
                });
                this.childRemovalFormGroup.patchValue({
                    motherLastName: this.getMotherLastName()
                });
            });
    }
    getFatherFirstName(){
        return this.childRemovalSettings.fatherFirstName ? this.childRemovalSettings.fatherFirstName : '';
    }

    getFatherLastName(){
        return this.childRemovalSettings.fatherLastName ? this.childRemovalSettings.fatherLastName : '';
    }

    getMotherFirstName(){
        return this.childRemovalSettings.motherFirstName ? this.childRemovalSettings.motherFirstName : '';
    }

    getMotherLastName(){
        return this.childRemovalSettings.motherLastName ? this.childRemovalSettings.motherLastName : '';
    }

    submitChildRemoval() {
        if (this.childRemovalFormGroup.valid && this.cdvpFormGroup.valid) {
            if (this.childRemovalID) {
                this.addChildRemoval();
            } else {
                this.updateChildRemoval();
            }
        } else {
            this.intakeUtils.findInvalidControls(this.childRemovalFormGroup);
            this._alertService.warn('Please fill madatory fields');
        }
    }
    addChildRemoval() {
        const childRemovalFormData = Object.assign(this.cdvpFormGroup.getRawValue(), this.childRemovalFormGroup.getRawValue());
        const rmvdfrmisractoridValue =  childRemovalFormData.rmvdfrmisractorid === 'other'
        ? (childRemovalFormData.rmvdfrmisractorid = null)       // NOSONAR
        : childRemovalFormData.rmvdfrmisractorid;     
        childRemovalFormData.removalreason = this.removalReasonSelection;
        childRemovalFormData.Attachment = [];
        childRemovalFormData.intakeserviceid = this.id;
        childRemovalFormData.intakeservreqchildremovalid = this.childRemovalID;
        childRemovalFormData.isbothparentssigned = childRemovalFormData.isbothparentssigned ? 1 : 0;
        childRemovalFormData.rmvdfrmisractorid =rmvdfrmisractoridValue;
           
        this._commonService
            .create(
                childRemovalFormData,
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .SubmitChildRemoval
            )
            .subscribe(result => {
                this.updateChildRemovalSubscribe(result,childRemovalFormData);
            });
    }

    updateChildRemoval() {
        const childRemovalFormData = Object.assign(this.cdvpFormGroup.getRawValue(), this.childRemovalFormGroup.getRawValue());
        const rmvdfrmisractoridValue =   childRemovalFormData.rmvdfrmisractorid === 'other'
        ? (childRemovalFormData.rmvdfrmisractorid = null)   //  NOSONAR
        : childRemovalFormData.rmvdfrmisractorid;
        childRemovalFormData.removalreason = this.removalReasonSelection;
        childRemovalFormData.Attachment = [];
        childRemovalFormData.intakeserviceid = this.id;
        childRemovalFormData.isbothparentssigned = childRemovalFormData.isbothparentssigned ? 1 : 0;
        childRemovalFormData.rmvdfrmisractorid = rmvdfrmisractoridValue;          
        this._commonService
            .create(
                childRemovalFormData,
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .SubmitChildRemoval
            )
            .subscribe(result => {
               this.updateChildRemovalSubscribe(result,childRemovalFormData);
            });
    }

    updateChildRemovalSubscribe(result: any, childRemovalFormData: any) : void {
        if (result) {
            this.removalReasonSelection = [];
            this.getChildRemoval();
            this.serviceCaseValidate(childRemovalFormData);
        } else {
            this._alertService.error(
                GLOBAL_MESSAGES.ERROR_MESSAGE
            );
        }
    }

    serviceCaseValidate(childRemovalFormData: any) {
        this._commonService
            .getSingle(
                {
                    where: {
                        intakeserviceid: this.id,
                        personid: childRemovalFormData.intakeservicerequestactorid
                    },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .ServiceCaseValidate + '?filter'
            )
            .subscribe(result => {
                if (result.isavailable === 1) {
                    this.serviceCase = result.data;
                    $('#ServiceCaseValidation').modal('show');
                } else {
                    this._alertService.success('Service case created successfully. Servicecase #' + result.data[0].servicecaseno);
                }
            });
    }
    selectCase(selectedCase: any) {
        this.caseFormData = {
            servicecaseid: selectedCase.servicecaseid,
            intakeserviceid: this.id,
            isnewcase: 0
        };
    }
    createServiceCase(isnewcase: any) {
        if (isnewcase === 1) {
            this.caseFormData = {
                servicecaseid: null,
                intakeserviceid: this.id,
                isnewcase: isnewcase
            };
        } else {
            if (this.caseFormData && this.caseFormData.servicecaseid === null) {
                this._alertService.success(
                    'Please Select Case'
                );
                return false;
            }
        }
        this._commonService
                    .create(
                        this.caseFormData,
                        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                            .CreateCaseUrl
                    )
                    .subscribe(result => {
                        if (result) {
                           $('#ServiceCaseValidation').modal('hide');
                            this._alertService.success('Service case created successfully. Servicecase #' + result.data[0].servicecaseno);
                        } else {
                            this._alertService.error(
                                GLOBAL_MESSAGES.ERROR_MESSAGE
                            );
                        }
                    });
    }
    getNotificationRoleList() {
        const removalArr = [
            {type: 'isVP', value: this.isVP, formGroup: 'vPFormGroup'},
            {type: 'isJD', value: this.isJD, formGroup: 'jDFormGroup'},
            {type: 'isSHB', value: this.isSHB, formGroup: 'sHBFormGroup'},
            {type: 'isCDVP', value: this.isCDVP, formGroup: 'cdvpFormGroup'}];
        const obj: any = _.find(removalArr, ['value', true]);
      if (this.childRemovalFormGroup.valid && this[obj.formGroup].valid) {
        $(this.childremovalpopupid).modal('show');
        this._dataStoreService.currentStore.subscribe(store => {   // NOSONAR       // This function has less han 3 lines of identical code. Hence marking it as no sonar.
            if (store['dsdsActionsSummary']) {
                this.dsdsActionsSummary = store['dsdsActionsSummary'];
            }
        });

        this.notificationFormGroup = this._formBuilder.group({
            notify: this._formBuilder.array([]),
            ldssCaseworkers: [''],
            ldssCountyid: [null],
            ldssMessage: ['', Validators.required]
        });

        this._commonService.getArrayList({
                method: 'post',
                intakeserviceid: this.id,
                intakeservreqchildremovalid: this.childRemovalID,
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.GetRemovalNotificationRoles)
        .subscribe((data) => {
            this.setEmailNotificationList(data);
            this.changeJurisdiction(null);
            this.setFormValues();
        });
      } else {
        $(this.childremovalpopupid).modal('hide');
        this._alertService.error('Please fill mandatory fields');
      }
    }

    setEmailNotificationList(data: any) {
        this.emailNotificationList = data.filter((list: { relationship: string; rolename: string; roles: any; }) => {
            if ((list.relationship === 'father' || list.relationship === 'mother') && list.rolename === 'PARENT') {
                return list;
            } else {
                if (list.roles) {
                    // tslint:disable-next-line:max-line-length
                    const getRole = list.roles.filter((item: { intakeservicerequestpersontypekey: string; }) => item.intakeservicerequestpersontypekey === 'LC' || item.intakeservicerequestpersontypekey === 'LG' || item.intakeservicerequestpersontypekey === 'ATTR');
                    if (getRole.length) {
                        return list;
                    }
                }
            }
        });

    }

    sendMail(data: any, index: any, isLDSS: any) {
        this.emailNotificationSave = [];
        if (
            (data.email && data.message) ||
            (isLDSS === true && this.muiltipleNotification.length > 0)
        ) {
            if (isLDSS) {
                if (this.notificationFormGroup.value.ldssMessage) {
                    this.muiltipleNotification.forEach(item => {
                        item.objectid = this.childRemovalID;
                        item.objecttypekey = 'childremoval';
                        item.ismailsent = true;
                        item.intakeserviceid = this.id;
                        item.message = this.notificationFormGroup.value.ldssMessage;
                        return item;
                    });
                    this.emailNotificationSave = this.muiltipleNotification;
                    this.ismailsent = true;
                    this._commonService
                        .create(
                            this.emailNotificationSave,
                            CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                                .Notification
                        ).subscribe();
                }
            } else {
                data.objectid = this.childRemovalID;
                data.objecttypekey = 'childremoval';
                data.ismailsent = true;
                this.emailNotificationSave.push(data);
                this._commonService
                    .create(
                        this.emailNotificationSave,
                        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                            .Notification
                    )
                    .subscribe(res => {
                        const notifyArray = <FormArray>(
                            this.notificationFormGroup.controls.notify
                        );
                        const _notifyMailSent = notifyArray.controls[index];
                        _notifyMailSent.patchValue({ ismailsent: true });
                    });
            }
        } else {
            this._alertService.error('Please fill Email and Message');
        }
    }

    showChildDetails() {
        this.childOtherDetails = Object.assign({});
        const childActorID = this.childRemovalFormGroup.get('intakeservicerequestactorid')?.value;
        if (childActorID) {
            this.relationName.forEach(list => {
                const checkActorId = list.roles.filter(role => {
                    return role.intakeservicerequestactorid === 'Admin'
                });
          
                if (checkActorId.length > 0) {
                  this.childOtherDetails = Object.assign({}, list);
                }
            });
        }
    }
    
    closeNotification() {
        this.notificationFormGroup.reset();
        this.ismailsent = false;
        this.caseWorkersName = [];
        this.muiltipleNotification = [];
        $(this.childremovalpopupid).modal('hide');
    }
    startPetitionForm() {
        let rmvdfrmpersonname = '';
        this.relationName.forEach(items => {
            if (items.personid === this.childRemovalFormGroup.value.rmvdfrmisractorid) {
                rmvdfrmpersonname = items.firstname + ' ' + items.lastname;
            }
        });
                const assessment = {
                    mode: 'start',
                    description: 'CINA Shelter Petition Request',
                    titleheadertext: 'CINA Shelter Petition Request',
                    external_templateid: this.externaltemplateid,
                    submissionid: ''
                };
                const token = this._authService.getCurrentUser();
                if (token.role.name === 'apcs') {
                    assessment.mode = 'update';
                    assessment.submissionid = this.submissionId;
                }
                const storeData = this._dataStoreService.getCurrentStore();
                storeData['CASEWORKER_ROUTING_INFO'] = this.routingInfo;
                storeData['CASEWORKER_INVOLVED_PERSON'] = this.involevedPerson;
                storeData['CASEWORKER_SELECTED_ASSESSMENT'] = assessment;
                const fatherDetails = this.relationName.filter(res => res.relationship === 'father');
                const motherDetails = this.relationName.filter(res => res.relationship === 'mother');
                const childDetails: any[] = [];
                this.relationName.map((res) => {    // NOSONAR
                        if (res.roles) {
                        const checkRC = res.roles.filter(role => role.intakeservicerequestpersontypekey === 'RC');
                        if (checkRC.length) {
                            childDetails.push(res);
                        }
                    }});
                const childRemovalInfo: any = {
                    formData: this.childRemovalFormGroup.value,
                    parentName: this.childRemovalSettings,
                    removerName: rmvdfrmpersonname,
                    fatherdetails:  fatherDetails,
                    motherdetails:  motherDetails,
                    childdetails: childDetails
                };
                storeData['CHILD_REMOVAL_INFO'] = childRemovalInfo;
                this._dataStoreService.setObject(
                    storeData,
                    true,
                    'CASEWORKER_ASSESSMENT_LOAD'
                );
                this._router.navigate([
                    '/pages/case-worker/' +
                        this.id +
                        '/' +
                        this.daNumber +
                        '/dsds-action/assessment/case-worker-view-assessment'
                ]);
    }

    private getRoutingInfo() {
        this._commonService
            .getArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    method: 'get',
                    where: { intakeserviceid: this.id }
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment
                    .RoutingInfoList
            )
            .subscribe(res => {
                if (res && res.length) {
                    this.routingInfo = res[0]['routinginfo'];
                }
            });
    }
    private getSubmissionId() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        this._assessmentService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 50,
                    where: {
                        servicerequestid: this.id,
                        categoryid: null,
                        subcategoryid: null,
                        targetid: null,
                        assessmentstatus: null,
                        isExpungementSuperUser: isExpungementSuperUser,
                        iscaseexpunged: this.iscaseexpunged
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment
                    .ListAssessment + '?filter'
            )
            .subscribe(res => {
                const petition = res.data.filter(
                    form =>
                        form.external_templateid === this.externaltemplateid
                );
                if (petition && petition.length) {
                    if (petition[0].intakassessment) {
                        this.submissionId =
                            petition[0].intakassessment[0].submissionid;
                    }
                }
            });
    }

    changeJurisdiction(event: any) {
       const users = this.usersInfo();
       let ldssMessage = '';
        if (event && event.source.triggerValue === this.montgomerycounty) {
            ldssMessage = users.childInfo  + event.source.triggerValue + '\n';
          } else {
            ldssMessage = users.childInfo  + (event ? event.source.triggerValue : '') + '\n';
        }
        ldssMessage = ldssMessage + '\n\n' + users.courtInfo;
        this.notificationFormGroup.patchValue({ldssMessage : ldssMessage + users.parentInfo + users.caseworker + users.supervisor + users.providerInfo});
    }

    changeFormJurisdiction(event: any, formIndex: any, mode: any, data: any) {
        const ldssMessage = this.getLdssMessage(event);

        this.patchMode1Message(ldssMessage, formIndex, data);
    }

    getLdssMessage(event: any) {
        const users = this.usersInfo();
        let ldssMessage = '';
        if (event && event.source.triggerValue === this.montgomerycounty) {
            ldssMessage = users.childInfo + event.source.triggerValue;
        } else {
            ldssMessage = users.childInfo + (event ? event.source.triggerValue : '');
        }
        ldssMessage = ldssMessage + '\n\n' + users.courtInfo;
        return ldssMessage;
    }
    patchMode1Message(ldssMessage: any, formIndex: any, data: any) {
        const users = this.usersInfo();
        const control = <FormArray>(this.notificationFormGroup.controls.notify);
        const message = control.controls[formIndex];
        if (data.rolename && data.rolename === 'ATTR') {
            message.patchValue({ message: ldssMessage + users.parentInfo + users.caseworker + users.supervisor + users.providerInfo });
        } else {
            message.patchValue({ message: ldssMessage + users.attorneyInfo + users.caseworker + users.supervisor });
        }
    }

    private usersInfo() {
        const personDobValue = this.dsdsActionsSummary.persondob ? moment(this.dsdsActionsSummary.persondob).format('MM/DD/YYYY') : '';
         // tslint:disable-next-line:max-line-length
         this.notificationUser.childInfo = this.dsdsActionsSummary ? ('Child name and DOB \n' + this.dsdsActionsSummary.da_focus + ' (' + personDobValue + ')\n' + 'Has been taken into custody by ') : '';
         this.notificationUser.parent = this.emailNotificationList.filter(item => item.rolename !== 'ATTR').map(list => {
             // tslint:disable-next-line:max-line-length
             return {role: list.rolename, address: this.getAddress(list)};
         });
         const parentInfo = this.notificationUser.parent.filter(item => item.role === 'PARENT').map(res => res.address);
         const lgInfo = this.notificationUser.parent.filter(item => item.role === 'LG').map(res => res.address);
         const lcInfo = this.notificationUser.parent.filter(item => item.role === 'LC').map(res => res.address);
         this.notificationUser.parentInfo = [];
         if (parentInfo.length) {
            this.notificationUser.parentInfo.push('\nDemographic information of Parents:' + parentInfo);
         }

         if (lgInfo.length) {
            this.notificationUser.parentInfo.push('\n\nDemographic information of Legal Guardian:' + lgInfo);
        }

        if (lcInfo.length) {
            this.notificationUser.parentInfo.push('\n\nDemographic information of Legal Custodian:' + lcInfo);
        }
        if (this.assessmentInfo) {
            const datetime = this.getCourthearingdatatime();
            this.setCourtInfo(datetime);
         }
         const providerInfo = this.getProviderInfo();
    
        const caseworker = this.getCaseWorker();
        const supervisor = this.getSupervisor();
         this.notificationUser.attorneyInfo = '\nRight to have attorney: You have a right to be represented by an attorney at the shelter care hearing and at all stages of the CINA proceeding. If you cannot afford an attorney, you may apply to the Office of the Public Defender for representation by contacting the following';
         this.notificationUser.providerInfo = providerInfo;
         this.notificationUser.caseworker = caseworker;
         this.notificationUser.supervisor = supervisor;
        return this.notificationUser;
    }
    getAddress(list: any) {
        return '\n' + list.firstname + ' ' + list.lastname + ', ' 
                    + (list.dob ? moment(list.dob).format('MM/DD/YYYY') : '') 
                    + (list.address ? ', ' + list.address : '') 
                    + (list.address2 ? ', ' + list.address2 : '') 
                    + (list.phonenumber ? ', ' + list.phonenumber : '') 
                    + (list.email ? ', ' + list.email : '')
    }
    getCourthearingdatatime(){
        return this.assessmentInfo.courthearingdatatime ? moment(this.assessmentInfo.courthearingdatatime).format('MM/DD/YYYY hh:mm A') : '';
    }
    setCourtInfo(datetime: any){
        // tslint:disable-next-line:max-line-length
        this.notificationUser.courtInfo = 'Shelter Care Hearing Next day: ' + datetime + '\n' + (this.assessmentInfo.courtaddress1 ? this.assessmentInfo.courtaddress1 : '') + (this.assessmentInfo.courtaddress2 ? ', ' + this.assessmentInfo.courtaddress2 : '') + (this.assessmentInfo.courtcity ? ', ' + this.assessmentInfo.courtcity : '') + (this.assessmentInfo.courtstate ? ', ' + this.assessmentInfo.courtstate : '') + (this.assessmentInfo.courtcounty ? ', ' + this.assessmentInfo.courtcounty : '') + (this.assessmentInfo.courtzip ? ', ' + this.assessmentInfo.courtzip : '') + '\n';
    }
    getProviderInfo() {
        let providerInfo = '';
        if (this.placementProvider) {
            // tslint:disable-next-line:max-line-length
            providerInfo = '\n\nChild’s placement information\n' + this.returnProvidernameProviderInfoFn() + '\n' + this.returnAddressline1ProviderInfoFn() + this.returnAddressline2ProviderInfoFn() + this.returnCityProviderInfoFn() + (this.placementProvider.state ? ', ' + this.placementProvider.state : '') + (this.placementProvider.county ? ', ' + this.placementProvider.county : '') + (this.placementProvider.zipcode ? ', ' + this.placementProvider.zipcode : '') + '\n' + (this.placementProvider.phonenumber ? this.placementProvider.phonenumber[0].phonenumber : '') + (this.placementProvider.email ? ', ' + this.placementProvider.email : '');
        }
        return providerInfo;
    }
    // Assosiated with getProviderInfo method
    private returnCityProviderInfoFn() {
        return (this.placementProvider.city ? ', ' + this.placementProvider.city : '');
    }
    // Assosiated with getProviderInfo method
    private returnProvidernameProviderInfoFn() {
        return (this.placementProvider.providername ? this.placementProvider.providername : '');
    }
    // Assosiated with getProviderInfo method
    private returnAddressline2ProviderInfoFn() {
        return (this.placementProvider.addressline2 ? ', ' + this.placementProvider.addressline2 : '');
    }
    // Assosiated with getProviderInfo method
    private returnAddressline1ProviderInfoFn() {
        return (this.placementProvider.addressline1 ? this.placementProvider.addressline1 : '');
    }
    
    getCaseWorker() {
        let caseworker = '';
        if (this.routingUser && this.routingUser.caseworkerdetails[0]) {
            // tslint:disable-next-line:max-line-length
            caseworker = '\n\nCase worker contact information\n' + this.routingUser.caseworkerdetails[0].caseworkername + (this.routingUser.caseworkerdetails[0].phonenumber ? '\n' + this.routingUser.caseworkerdetails[0].phonenumber : '') + (this.routingUser.caseworkerdetails[0].email ? '\n' + this.routingUser.caseworkerdetails[0].email : '');
        }
        return caseworker;
    }
    getSupervisor() {
        let supervisor = '';
        if (this.routingUser && this.routingUser.supervisordetails[0]) {
            // tslint:disable-next-line:max-line-length
            supervisor = '\n\nSupervisor  contact information\n' + this.routingUser.supervisordetails[0].supervisorname + (this.routingUser.supervisordetails[0].phonenumber ? '\n' + this.routingUser.supervisordetails[0].phonenumber : '') + (this.routingUser.supervisordetails[0].email ? '\n' + this.routingUser.supervisordetails[0].email : '');
        }
        return supervisor;
    }
    private getJurisdictionDropdown() {
        this.jurisdictionDropdownItems$ = this._commonService
            .getArrayList(
                {
                    where: {
                        activeflag: '1',
                        state: 'MD'
                    },
                    method: 'get',
                    order: 'countyname asc',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.JurisdictionListUrl + '?filter'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.countyname === this.montgomerycounty ? res.countyname + ' - department of health and human services' : res.countyname + ' - department of social services',
                            value: res.countyid
                        })
                );
            }));
    }


    private getplacementProvider() {
        forkJoin([
            this._commonService.getArrayList(
                {
                    where: { 'intakeserviceid': this.id },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.PlacementListUrl + '?filter'
            ),
            this._commonService.getArrayList(
                {
                    where: { 'intakeserviceid': this.id },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.routingUserUrl + '?filter'
            ), this._commonService.getArrayList(
                {
                    method: 'get',
                    where: {
                        objectid: this.id,
                        assessmenttemplatename: 'cinaShelterPetitionAuthorization'
                    },
                    page: 1,
                    limit: 10
                },
                'admin/assessment/getassessment?filter'
            )
        ]).subscribe((result: any) => {
            if (result[0]['data'] && result[0]['data'].length) {
                this.placementProvider = result[0]['data'][0].providerinfo;
            }
            this.routingUser = result[1][0];
            if (result[2] && result[2].length) {
                this.assessmentInfo = Object.assign({}, result[2][0].submissiondata);
                this.externaltemplateid = result[2][0].externaltemplateid;
                }
                this.getSubmissionId();
        });
    }
    childRemovelCheck() {
        return this._commonService.getArrayList(
            {
                method: 'get',
                where: {
                    objectid: this.id,
                    assessmenttemplatename: 'SAFE-C'
                },
                page: 1,
                limit: 10
            },
            'admin/assessment/getassessment?filter'
        );
    }
    showTypeofRemoval (removalType: any) {
        this.isVP = false;
        this.isJD = false;
        this.isSHB = false;
        this.isCDVP = false;
        if (removalType === 'VP') {
            this.removeValidators();
            this.cdvpFormGroup.reset();
            this.isVP = true;
        } else if (removalType === 'CDVP') {
            this.setValidators();
            this.isCDVP = true;
        } else if (removalType === 'JD') {
            this.removeValidators();
            this.cdvpFormGroup.reset();
            this.isJD = true;
        } else {
            this.removeValidators();
            this.cdvpFormGroup.reset();
            this.isSHB = true;
        }
    }
    private setValidators() {
        this.cdvpFormGroup.controls['familystructuretypekey'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['familystructuretypekey'].updateValueAndValidity();
        this.cdvpFormGroup.controls['vpabegindate'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['vpabegindate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['vpaparentssigneddate'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['vpaparentssigneddate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['agencysigneddate'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['agencysigneddate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['isbothparentssigned'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['isbothparentssigned'].updateValueAndValidity();
        this.cdvpFormGroup.controls['reasonableeffortsmade'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['reasonableeffortsmade'].updateValueAndValidity();
        this.cdvpFormGroup.controls['childfactorsentry'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['childfactorsentry'].updateValueAndValidity();
        this.cdvpFormGroup.controls['removaltypeform'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['removaltypeform'].updateValueAndValidity();
        this.cdvpFormGroup.controls['primarycaregiveractorid'].setValidators([Validators.required]);
        this.cdvpFormGroup.controls['primarycaregiveractorid'].updateValueAndValidity();
    }
    private removeValidators() {
        this.cdvpFormGroup.controls['familystructuretypekey'].clearValidators();
        this.cdvpFormGroup.controls['familystructuretypekey'].updateValueAndValidity();
        this.cdvpFormGroup.controls['vpabegindate'].clearValidators();
        this.cdvpFormGroup.controls['vpabegindate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['vpaparentssigneddate'].clearValidators();
        this.cdvpFormGroup.controls['vpaparentssigneddate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['agencysigneddate'].clearValidators();
        this.cdvpFormGroup.controls['agencysigneddate'].updateValueAndValidity();
        this.cdvpFormGroup.controls['isbothparentssigned'].clearValidators();
        this.cdvpFormGroup.controls['isbothparentssigned'].updateValueAndValidity();
        this.cdvpFormGroup.controls['reasonableeffortsmade'].clearValidators();
        this.cdvpFormGroup.controls['reasonableeffortsmade'].updateValueAndValidity();
        this.cdvpFormGroup.controls['childfactorsentry'].clearValidators();
        this.cdvpFormGroup.controls['childfactorsentry'].updateValueAndValidity();
        this.cdvpFormGroup.controls['removaltypeform'].clearValidators();
        this.cdvpFormGroup.controls['removaltypeform'].updateValueAndValidity();
        this.cdvpFormGroup.controls['primarycaregiveractorid'].clearValidators();
        this.cdvpFormGroup.controls['primarycaregiveractorid'].updateValueAndValidity();
    }
    fourEChildRemoval() {
        const childRemovalFormData = this.childRemovalFormGroup.getRawValue();
        if (childRemovalFormData.removaltype === 'JD') {
            const ChildJDFormData = this.jDFormGroup.getRawValue();
            ChildJDFormData.judicialFlag = 'YES';
            ChildJDFormData.clientId = this.cjamspid;
            this._commonService
            .create(
                {where: ChildJDFormData},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .FourEChildRemoval
            ).subscribe();
        } else if (childRemovalFormData.removaltype === 'VP') {
            const ChildVPFormData = this.vPFormGroup.getRawValue();
            ChildVPFormData.vpaFlag = 'YES';
            ChildVPFormData.clientId = this.cjamspid;
            this._commonService
            .create(
                {where: ChildVPFormData},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .FourEChildRemoval
            ).subscribe();
        } else {
            const ChildShpFormData = this.sHBFormGroup.getRawValue();
            ChildShpFormData.safeHavenFlag = 'YES';
            ChildShpFormData.clientId = this.cjamspid;
            this._commonService
            .create(
                {where: ChildShpFormData},
                CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
                    .FourEChildRemoval
            ).subscribe();
        }

    }
}
