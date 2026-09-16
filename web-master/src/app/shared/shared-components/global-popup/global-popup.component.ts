import { Component, Input, Output, EventEmitter, OnInit, OnDestroy, Injector, ChangeDetectorRef } from '@angular/core';
import { AbstractControl, FormArray, FormBuilder, FormGroup, ValidationErrors, ValidatorFn, Validators } from '@angular/forms';
import { AuthService, CommonHttpService, DataStoreService, GlobalPopupService, AlertService } from '../../../../app/@core//services';
import { CaseWorkerUrlConfig } from '../../../../app/pages/case-worker/case-worker-url.config';
import { MedicationIncludingPsychotropicCwComponent } from '../../../../app/pages/shared-pages/person-info/person-health/medication-including-psychotropic-cw/medication-including-psychotropic-cw.component';
import { GLOBAL_MESSAGES } from '../../../../app/@core/entities/constants';
import { AppConstants } from '../../../../app/@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../../app/pages/case-worker/_entities/caseworker.data.constants';
import { Router } from '@angular/router';
import { forkJoin, Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

declare let $: any;

@Component({
    selector: 'global-popup',
    templateUrl: './global-popup.component.html',
    styleUrls: ['./global-popup.component.scss'],
    standalone: false
})


export class GlobalPopupComponent implements OnInit, OnDestroy {
    @Output() laArrangementCheck: EventEmitter<any> = new EventEmitter();
    @Output() userInput: EventEmitter<any> = new EventEmitter();
    @Output() selectValue: EventEmitter<any> = new EventEmitter();
    @Input() confrimMessage: string = "";
    @Input() header: string = "";
    @Input() btn1label: string = "";
    @Input() btn2label: string = "";
    @Input() isConfrimPopup: boolean = true;
    @Input() isCustomBtnLabel: boolean = false;
    @Input() isDismissAttr: boolean = true;
    showChildName: boolean = false;
    lgrData: any;
    medicalPrescribedData: any;
    medicalPrescribedActionForm: FormGroup = new FormGroup({});
    alertFormGroups: { [alerttype: string]: FormGroup[] } = {};
    objectid: any;
    caseId: any;
    daType: any;
    medicalPrescribedActionContainer!: boolean;
    alertMessageContainer!: boolean;
    notPlacedChildList: any;
    isNavigateFromNotes: boolean = false;
    openNewTabForMedPsyForm: any[] = [];
    identifyactivepersons: boolean = false;
    openHospitalizationRecords: any;
    hospitalizationlist: any;
    lapopupData: boolean = false;
    lapopupFcnFHSData: boolean = false;
    lapopupFcnFHSClientDetails: any[] = [];
    globalAlertPopupTitle : any;
    globalAlertPopupMessage : any;
    popupTitle = "Case Notifications";
    isValue: number = 1;
    personsWithSpecificLang:any = [];
    labelMap: any = {
        'Health-Disorder': 'Diagnose Condition',
        'Medication-Psychotropic': 'Prescribed Medication',
        'Substance-New-Born': 'Substance Exposed to New Born',
        'Birth-Match': 'Active Birth Match Client',
        'EBP-Warning-Message': 'EBP Warning Message',
        'Substance-New-Born-Caseconnect':'Substance Exposed to New Born  case connect',
    };

    private _globalPopupService: GlobalPopupService;
    private fb: FormBuilder;
    private _commonHttpService: CommonHttpService;
    private _authService: AuthService;
    private _formBuilder: FormBuilder;
    private _dataStoreService: DataStoreService;
    private _alertService: AlertService;
    private router: Router;
    sencasenotpresent: any;
    fromscreen: any;
    senUntimelyForm: FormGroup = new FormGroup({});
    facetofacelist: any;
    safeclist: any;
    mfiralist: any;
    showSenUntimelyPopup: boolean = false;


    constructor(private injector: Injector,private cdr: ChangeDetectorRef) {
        this._globalPopupService = this.injector.get<GlobalPopupService>(GlobalPopupService);
        this.fb = this.injector.get<FormBuilder>(FormBuilder);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this.router = this.injector.get<Router>(Router);
        this._alertService = this.injector.get<AlertService>(AlertService);
    }

    ngOnInit() {
        if (this.router.url.includes('report-summary') || this.router.url.includes('/notes') || this.router.url.includes('/dsds-action/assessment')) {
            this.personsWithSpecificLang = []; // to clear data before popup opens
            this.objectid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
            this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
            this.daType = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_TYPE);

            this.displayTabsOnLoad();
        }
        this.setButtonLabels();
        this.loadDropDownsAsObservable().subscribe();
    }

    setButtonLabels() {
        this.btn1label = this.isCustomBtnLabel ? this.btn1label : "Ok";
    }

    ngOnDestroy() {
        this.resetPopupData();
    }

    displayTabsOnLoad(): void {
        setTimeout(() => {
            this.getCombinedData();
            if (this.alertMessageContainer || this.medicalPrescribedActionContainer) {
                this.openGlobalPopup();
            }
            else {
                this.closeGlobalPopup();
                this.closePopup()
            }
        }, 2000);
    }

    getCombinedData(): void {

        // role data and not placed child list and legal guardian data
        this._globalPopupService.lgrData$.subscribe(lgrData => {
            if (lgrData?.isLGPresent || lgrData?.notPlacedChildList.length > 0) {
                this.lgrData = lgrData;
                this.notPlacedChildList = lgrData?.notPlacedChildList;
                this.alertMessageContainer = true;
            } else {
                this.lgrData = null;
                this.notPlacedChildList = null;
            }

        });

        // Hospitalization data
        this._globalPopupService.hospitalData$.subscribe(hospitalData => {
            if (hospitalData?.openHospitalizationRecords) {
                this.openHospitalizationRecords = hospitalData?.openHospitalizationRecords;
                this.hospitalizationlist = hospitalData?.hospitalizationlist;
                this.alertMessageContainer = true;
            }
        });

        // Identify active persion data
        this._globalPopupService.identfyactiper$.subscribe(identfyactiper => {
            if (identfyactiper) {
                this.identifyactivepersons = true;
                this.alertMessageContainer = true;
            }
        });
        // Getting child names
        this._globalPopupService.setChildName$.subscribe((personsInvolved: any[] = []) => {
            if(personsInvolved?.length){
                this.personsWithSpecificLang = personsInvolved || [];
                this.showChildName = this.personsWithSpecificLang.length > 0;
                this.alertMessageContainer = this.showChildName;
                if(this.alertMessageContainer){
                    this.openGlobalPopup()
                }
            }
        });
        // Living Arrangement popup
        this._globalPopupService.lapopup$.subscribe(lapopup => {
            if (lapopup) {
                this.lapopupData = true;
                this.alertMessageContainer = true;
            }
        });

        // Living Arrangement FHS popup
        this._globalPopupService.lapopupFcnFHS$.subscribe(lapopupFcnFHS => {
            if (lapopupFcnFHS) {
                this.lapopupFcnFHSData = true;
                this.alertMessageContainer = true;
            }
        });

        this._globalPopupService.lapopupClientFcnFHS$.subscribe(lapopupFcnFHS => {
            if (lapopupFcnFHS) {
                this.lapopupFcnFHSClientDetails = lapopupFcnFHS;
                this.alertMessageContainer = true;
            }
        });
  this._globalPopupService.sencaseconnect$.subscribe(sencase =>{
      if(sencase && this.daType!='SERVICE_CASE'){
          this.sencasenotpresent =sencase;
          this.alertMessageContainer =true
      }
  })


        this._globalPopupService.mpActiondata$.subscribe(mpActiondata => {
            // Medication psychotropic data
            if (mpActiondata?.length > 0) {
                this.medicalPrescribedData = mpActiondata;
                this.buildMedicalPrescribedForm();
                this.medicalPrescribedActionContainer = true;
            } else {
                this.medicalPrescribedData = null;
                this.medicalPrescribedActionContainer = false;
            }
        });


        // Medication psychotropic navigation from notes page
        this._globalPopupService.isNavgFromNotes$.subscribe(isNavgFromNotes => {
            if (isNavgFromNotes) {
                this.isNavigateFromNotes = true;
                this.popupTitle = 'Prescribed Medication Alert';
                this.openGlobalPopup();
            } else {
                this.popupTitle = 'Case Notifications';
                this.isNavigateFromNotes = false;
            }
        });
    }

    goToActionTab(): void {
        if (this.lapopupData || this.lapopupFcnFHSData) {
            this.laArrangementCheck.emit(false);
        }

        if (this.openHospitalizationRecords) {
            const obj = { hospitaldetails: this.hospitalizationlist };
            this._commonHttpService.create(obj, 'personhospitalization/notificationsupdate').subscribe();
        }

        if (this.medicalPrescribedActionContainer) {
            this.isValue = 2;
            $('#action-tab').tab('show');
        } else {
            this.closeGlobalPopup();
        }
    }

    closeGlobalPopup(): void {
        $('#globalPopup').modal('hide');
    }

    openGlobalPopup(): void {
        if (this.router.url.includes('report-summary') || this.router.url.includes('/notes')) {
            if (this.alertMessageContainer || this.medicalPrescribedActionContainer) {
                $('#globalPopup').modal('show');
                if (!this.alertMessageContainer) {
                    this.isValue = 2;
                    $('#action-tab').tab('show');
                }
            }
        }
    }

    private resetPopupData(): void {
        this._globalPopupService.resetData();
        this.lgrData = null
        this.medicalPrescribedData = null
        this.medicalPrescribedActionContainer = false;
        this.alertMessageContainer = false;
        this.notPlacedChildList = null
        this.isNavigateFromNotes = false;
        this.openNewTabForMedPsyForm = [];
        this.identifyactivepersons = false;
        this.openHospitalizationRecords = null;
        this.hospitalizationlist = null;
        this.lapopupData = false;
        this.lapopupFcnFHSData = false;

    }

    // Build Medical/Is Prescribed Action Form
    buildMedicalPrescribedForm(): void {
        const grouped: { [alerttype: string]: FormGroup[] } = {};

        for (const alert of this.medicalPrescribedData) {
            const group = this.fb.group({
                alerttype: [alert.alerttype],
                id: [alert.id],
                name: [alert.name],
                selectedOption: [null]
            });

            if (!grouped[alert.alerttype]) {
                grouped[alert.alerttype] = [];
            }
            grouped[alert.alerttype].push(group);
        }

        this.alertFormGroups = grouped;
        for (const type of Object.keys(this.alertFormGroups)) {
            this.medicalPrescribedActionForm.addControl(type, this.fb.array(this.alertFormGroups[type]));
        }
    }

    private medicalConditionActions(formValues: any, key: any){
        if (Array.isArray(formValues[key])) {
            formValues[key].forEach((item: any) => {
                if (item.selectedOption === 'Yes') {
                    this.ActionYes(item.id, key);
                } else if (item.selectedOption === 'No') {
                    this.ActionNo(item.id, key);
                }
            });
        }
    }

    // Medical condition & Is prescribed final submit
    onSubmit() {
        if (this.medicalPrescribedActionForm.valid) {
            const formValues = this.medicalPrescribedActionForm.value;
            // Health-Disorder Yes/No response action.
            this.medicalConditionActions(formValues,'Health-Disorder');

            // Medication-Psychotropic Yes/No response action.
            if (Array.isArray(formValues['Medication-Psychotropic'])) {
                this.medicalConditionActions(formValues,'Medication-Psychotropic');

                if (this.openNewTabForMedPsyForm?.length > 0) {
                    const route = '#/pages/case-worker/';
                    const finalURl = route + this.objectid + '/' + this.caseId + '/dsds-action/person-cw/list';
                    const personIds = this.openNewTabForMedPsyForm;

                    personIds.forEach((id,index) => {
                        const uniqueKey = `tabState_${Date.now()}_${index}`;
                        localStorage.setItem(uniqueKey,id);
                        const newTab = window.open(finalURl,'_blank');
                        if (newTab) {
                            newTab.name = uniqueKey;
                        }
                    });
                    this.closeGlobalPopup();
                }
            }

            // Substance New-Born
            this.medicalConditionActions(formValues,'Substance-New-Born');

            // Active Birth Match Client
            this.medicalConditionActions(formValues,'Birth-Match');

            // EBP Warning Message
            this.medicalConditionActions(formValues,'EBP-Warning-Message');

        } else {
            this.medicalPrescribedActionForm.markAllAsTouched();
        }
    }

    getFormGroupsForType(type: string): FormGroup[] {
        return (this.medicalPrescribedActionForm.get(type)?.value || []).map((_: any, i: any) =>
            (this.medicalPrescribedActionForm.get(type) as any).controls[i]
        );
    }

    // Medical condition & Is prescribed option selected to Yes
    ActionYes(id: any, alerttype: any): void {
        if (alerttype == 'Medication-Psychotropic') {
            // updating audit logs
            this.addConditionsAudit('Yes', alerttype, id);
            const personInfo = {
                source: this.getSource(),
                sourceID: this.getCaseUuid(),
                personId: id,
                action: "New",
                data: {
                    purposeId: this._dataStoreService.getData('da_typeid'),
                    caseNumber: this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER)
                }
            };
            this._dataStoreService.setObj("PERSON_NAVIGATION_INFO", personInfo);
            localStorage.setItem('navigationInfo', JSON.stringify(personInfo));
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_UID, this.objectid);
            this._dataStoreService.setData(CASE_STORE_CONSTANTS.DA_NUMBER, this.caseId);

            localStorage.setItem('IsNavigateToMedPsy', JSON.stringify(true));
            this.openNewTabForMedPsyForm.push(id);

        } else if (alerttype == 'Health-Disorder') {
            // updating audit logs
            this.addConditionsAudit('Yes', alerttype, id);
            this._globalPopupService.updateMyTaskbyUser('Health-Disorder', id, false);
            this.closeGlobalPopup();
        } else if (alerttype == 'Substance-New-Born') {
            this._commonHttpService
                .create({ senpersonids: id }, 'People/updatesennotification')
                .subscribe();
            this.closeGlobalPopup();
        } else if (alerttype == 'Birth-Match') {
            this._commonHttpService
                .create({ personbirthmatchids: id }, 'People/updatebirthmatch')
                .subscribe();
            this.closeGlobalPopup();
        } else if (alerttype == 'EBP-Warning-Message') {
            let currentUrl = this.router.url;
            currentUrl = currentUrl.replace("report-summary", "service-plan/service-log-activity/referred-services");
            const urlTree = this.router.createUrlTree([currentUrl]);
            let url = window.location.origin + this.router.serializeUrl(urlTree);
            url = url.replace("pages", "#/pages");
            window.open(url, '_blank');
            this.closeGlobalPopup();
        }

    }

    // Medical condition & Is prescribed option selected to No
    ActionNo(id: any, alerttype: any): void {
        // Inserting No record in Psychotropic Form
        if (alerttype == 'Medication-Psychotropic') {
            // Inserting audit logs
            this.addConditionsAudit('No', alerttype, id);
            this.createMedicationPsychotropicFormAndSaveNo(id);
            this._globalPopupService.updateMyTaskbyUser('Medication-Psychotropic', id, false);
            this.closeGlobalPopup();
        } else if (alerttype == 'Health-Disorder') {
            // Inserting audit logs
            this.addConditionsAudit('No', alerttype, id);
            this._globalPopupService.updateMyTaskbyUser('Health-Disorder', id, false);
            this.closeGlobalPopup();
        } else if (alerttype == 'Substance-New-Born' || alerttype == 'Birth-Match' || alerttype == 'EBP-Warning-Message') {
            this.closeGlobalPopup();
        }
    }

    private getSource() {
        return AppConstants.CASE_TYPE.SERVICE_CASE;
    }

    private getCaseUuid() {
        const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        if (caseID) {
            return caseID;
        }
        const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
        return caseInfo?.intakeserviceid ?? null;
    }

    // Inserting audit data
    addConditionsAudit(key: any, alerttype: any, refkeyid: any) {
        let username;
        let objectType;
        if (alerttype == 'Health-Disorder') {
            objectType = 'Person-profile';
            if (key == 'Yes') {
                key = "yes-popup-health-condition";
            } else {
                key = "no-popup-health-condition";
            }

        } else if (alerttype == 'Medication-Psychotropic') {
            objectType = 'Medication-Psychotropic';
            if (key == 'Yes') {
                key = "yes-popup-medication-psychotropic";
            } else {
                key = "no-popup-medication-psychotropic";
            }
        }
        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.securityusersid;
        });

        const comment = {
            securityusersid: username,
            logtype: key,
            referenceid: refkeyid,
            objectype: objectType,
            objectid: this.caseId ?? null,
            description: key
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit).subscribe(
            (result) => {
                console.log(result);
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }


    // On User response to No, Intialising Medication Psychotropic form and saving record.
    createMedicationPsychotropicFormAndSaveNo(id: any) {
        let medicationPsychotropicForm = MedicationIncludingPsychotropicCwComponent.createForm(this._formBuilder)
        medicationPsychotropicForm.patchValue({
            isprescribedmedication: false,
            renewal: false
        });
        const uploadInfo: any = {};
        uploadInfo['uploadedFiles'] = [];
        const data = { ...medicationPsychotropicForm.getRawValue(), ...uploadInfo };
        let finaldata = this.replaceEmptyValuesWithNull(data);
        this._globalPopupService.saveHealth({ 'personmedicalPsychotropic': [finaldata] }, id).subscribe(() => {
            this.closeGlobalPopup();
        });
    }

    replaceEmptyValuesWithNull(obj: any): any {
        if (Array.isArray(obj)) {
            return obj.map(item => this.replaceEmptyValuesWithNull(item));
        } else if (obj !== null && typeof obj === 'object') {
            const updatedObj: any = {};
            for (const key in obj) {
                if (obj.hasOwnProperty(key)) {
                    updatedObj[key] = this.replaceEmptyValuesWithNull(obj[key]);
                }
            }
            return updatedObj;
        } else if (obj === '') {
            return null;
        } else {
            return obj;
        }
    }

    getChildName(childList: any) {
        let childNameList = '';
        if (childList && childList?.length) {
            childList.forEach((child: any, index: any) => {
                childNameList = childNameList + ' "' + child.personName + '"' + ((index !== childList?.length - 1) ? ', ' : '');
            });
        }
        return childNameList;
    }


    isFormTouchedAndValid(): boolean {
        for (const key of Object.keys(this.medicalPrescribedActionForm.controls)) {
            const formArray = this.medicalPrescribedActionForm.get(key) as FormArray;
            for (const group of formArray.controls) {
                const value = group.get('selectedOption')?.value;
                if (value === 'Yes' || value === 'No') {
                    return true;
                }
            }
        }
        return false;
    }

    showEbpInfoDialog() {
        $('#ebp-warning-hoover-popup').modal('show');
    }

    openConfirmationModal(): void {
        $('#globalConfrimationPopup').modal('show');
    }
    closeConfirmationModal(): void {
        $('#globalConfrimationPopup').modal('hide');
    }
    confrimedSave(userInput: boolean) {        
        this.userInput.emit(userInput);
    }
    
    showGlobalPopupAlert(title : any, message : any): void {
        this.globalAlertPopupTitle = title;
        this.globalAlertPopupMessage = message;
        $('#globalAlertPopup').modal('show');
    }

    closeGlobalAlertPopup() : void {
        $('#globalAlertPopup').modal('hide');
    }

    showSenUntimelyPopupAlert(fromscreen : any, senuntimelylist: any): void {
        this.showSenUntimelyPopup = true;
        this.fromscreen = fromscreen;
        this.senUntimelyForm = this._formBuilder.group({
            childlist: this._formBuilder.array([])
        });
        this.buildSENForm(senuntimelylist);  
        this.cdr.detectChanges();
        (<any>$('#senuntimelyPopup')).modal('show');
    }

    buildSENForm(senuntimelylist: any[]) {
        const arr = this.childlist;
    
        senuntimelylist.forEach(item => {
          arr.push(
            this._formBuilder.group({
                clientname: [item.clientname],
                cjamspid: [item.cjamspid],
                f2fctrl: [{value: !!item.progressnoteid, disabled: true}],
                f2fcontactuntimelydone: [item.f2fcontactuntimelydone],
                f2fcontactuntimelydonereason: [item.f2fcontactuntimelydonereason],
                safecctrl: [{value: !!item.safecassessmentid, disabled: true}],
                safecuntimelydone: [item.safecuntimelydone],
                safecuntimelydonereason: [item.safecuntimelydonereason],
                mfiractrl:  [{value: !!item.mfiraassessmentid, disabled: true}],
                mfirauntimelydone: [item.mfirauntimelydone],
                mfirauntimelydonereason: [item.mfirauntimelydonereason],
                otherf2fcomments: [item.otherf2fcomments],
                othersafeccomments: [item.othersafeccomments],
                othermfiracomments: [item.othermfiracomments],
                personid: [item.personid],
                servicecaseid: [item.servicecaseid],
                progressnoteid: [item.progressnoteid],
                safecassessmentid: [item.safecassessmentid],
                mfiraassessmentid: [item.mfiraassessmentid],
                startdate: [item.startdate],
            }, { validators: this.senUntimelyReasonValidator })
          );
        });
      }

    private senUntimelyReasonValidator: ValidatorFn =
            (group: AbstractControl): ValidationErrors | null => {
            const screen = this.fromscreen;

            const f2fctrl = group.get('f2fctrl')?.value;
            const f2fDone = group.get('f2fcontactuntimelydone')?.value;
            const f2fReason = group.get('f2fcontactuntimelydonereason')?.value;
            const safecctrl = group.get('safecctrl')?.value;
            const safecDone = group.get('safecuntimelydone')?.value;
            const safecReason = group.get('safecuntimelydonereason')?.value;
            const mfiractrl = group.get('mfiractrl')?.value;
            const mfiraDone = group.get('mfirauntimelydone')?.value;
            const mfiraReason = group.get('mfirauntimelydonereason')?.value;
            if (screen === 'Contact') {
            return f2fctrl && f2fDone && !f2fReason
                ? {f2fReasonRequired: true }
                : null;
            }

            if (screen === 'SAFEC') {
                return safecctrl && safecDone && !safecReason
                ? {safecReasonRequired: true }
                : null;
            }

            if (screen === 'MFIRA') {
            return mfiractrl && mfiraDone && !mfiraReason
                ? {mfiraReasonRequired: true }
                : null;
            }

            if (screen === 'caseworkercomponent') {
                if (f2fctrl && f2fDone && !f2fReason) {
                    return {f2fReasonRequired: true };
                }

                if (safecctrl && safecDone && !safecReason) {
                    return {safecReasonRequired: true };
                }

                if (mfiractrl && mfiraDone && !mfiraReason) {
                    return {mfiraReasonRequired: true };
                }
            }

        return null;
    };
              

      get childlist(): FormArray {
        return this.senUntimelyForm.get('childlist') as FormArray;
      }

      private loadDropDownsAsObservable(): Observable<any> {
        const displayorder = 'displayorder ASC';
        const referencevaluesurl = 'referencevalues?filter';
    
        return forkJoin([
          this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500801 }, order: displayorder, method: 'get' }, referencevaluesurl),
          this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500802 }, order: displayorder, method: 'get' }, referencevaluesurl),
          this._commonHttpService.getArrayList({ nolimit: true, where: { referencetypeid: 500803 }, order: displayorder, method: 'get' }, referencevaluesurl),
        ]).pipe(
          tap(([facetoface, safec, mfira]) => {
            this.facetofacelist = facetoface.sort(this.sortOtherSpecifyLast);
            this.safeclist = safec.sort(this.sortOtherSpecifyLast);
            this.mfiralist = mfira.sort(this.sortOtherSpecifyLast);
          })
        );
      }

      private sortOtherSpecifyLast = (a: { description?: string }, b: { description?: string }): number => {
        const da = String(a?.description ?? '');
        const db = String(b?.description ?? '');
        if (da === 'Other') return 1;
        if (db === 'Other') return -1;
        return da.localeCompare(db);
      };

    closeSenUntimelyAlertPopup() : void {
        (<any>$('#senuntimelyPopup')).modal('hide');
        if(this.fromscreen == 'SAFEC' || this.fromscreen == 'MFIRA') {
            setTimeout(() => {
                this.router.navigate(['/pages/case-worker/' + this.objectid + '/' + this.caseId + '/dsds-action/assessment']);
            }, 1000);
        }
    }

    saveSenUntimely(){
        const children = this.senUntimelyForm.get('childlist') as FormArray;
        children.controls.forEach((child: any) => {
            const f2fcontactuntimelydonereason = child.get('f2fcontactuntimelydonereason').value;
            const otherf2fcomments = child.get('otherf2fcomments');
            if (f2fcontactuntimelydonereason === 'OTR') {
                otherf2fcomments?.setValidators([Validators.required]);
            } else {
                otherf2fcomments?.clearValidators();
                otherf2fcomments?.setValue(null); 
            }
            otherf2fcomments?.updateValueAndValidity();
            const safecuntimelydonereason = child.get('safecuntimelydonereason').value;
            const othersafeccomments = child.get('othersafeccomments');
            if (safecuntimelydonereason === 'OTR') {
                othersafeccomments?.setValidators([Validators.required]);
            } else {
                othersafeccomments?.clearValidators();
                othersafeccomments?.setValue(null); 
            }
            othersafeccomments?.updateValueAndValidity();
            const mfirauntimelydonereason = child.get('mfirauntimelydonereason').value;
            const othermfiracomments = child.get('othermfiracomments');

            if (mfirauntimelydonereason === 'OTR') {
                othermfiracomments?.setValidators([Validators.required]);
            } else {
                othermfiracomments?.clearValidators();
                othermfiracomments?.setValue(null);
            }
            othermfiracomments?.updateValueAndValidity();
        });
        if(this.senUntimelyForm.invalid){
            return;
        }
        const req = {
            where:{data: this.childlist.getRawValue()}
        }
        this._commonHttpService.create(req, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.addsenuntimelycompletionreason).subscribe(
            (result) => {
               this._alertService.success('Sen Untimely Reasons saved successfully');
               this.closeSenUntimelyAlertPopup();
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }
    
    closePopup(){
        this._globalPopupService.getChilderNames(null);
    }
}
