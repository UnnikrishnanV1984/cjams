import { Component, OnInit, Injector, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonDropdownsService, DataStoreService, CommonHttpService, AlertService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import moment from 'moment';
import { AssessmentService } from '../assessment.service';
import { Router } from '@angular/router';
import { OwlDateTimeComponent } from '@danielmoncada/angular-datetime-picker';

@Component({
    selector: 'assessment-youth-indicators',
    templateUrl: './assessment-youth-indicators.component.html',
    styleUrls: ['./assessment-youth-indicators.component.scss'],
    standalone: false
})
export class AssessmentYouthIndicatorsComponent implements OnInit {
    @ViewChild('picker11') picker11!: OwlDateTimeComponent<any>;
    @ViewChild('picker12') picker12!: OwlDateTimeComponent<any>;
    @ViewChild('picker13') picker13!: OwlDateTimeComponent<any>;
    dtformat2 = 'MM/DD/YYYY h:mm a';
    mifraData: any;
    childList: any[] = [];
    selectedChild = '';
    assessmentyouthindicatorsForm!: FormGroup;
    submitForApprovalClicked: boolean = false;
    caseUUID: string = '';
    routingSupervisors: any;
    assignSupervisors: any;
    loggedInUser: any;
    isSupervisor: boolean = false;
    assessmentYouthData: any;
    currentAssessmentId: any;
    currentSubmissionId: string='';
    ASSESSMENT_NAME = "Quick Youth Indicators for Trafficking (QYIT)";
    id: any;
    daNumber: any;
    saveAsDraftClicked: boolean = false;
    caseworkersignature: string = '';
    supervisorsignature: string = '';
    isReadOnly: boolean = false;
    currentdatetime = moment();

    private fb: FormBuilder;
    private _dataStoreService: DataStoreService;
    private _commonDDService: CommonDropdownsService;
    private commonHttpService: CommonHttpService;
    private readonly _alertService: AlertService;
    private readonly _authService: AuthService;
    private _assessmentService: AssessmentService;
    private _router: Router;

    constructor(private readonly injector: Injector) {
        this.fb = this.injector.get<FormBuilder>(FormBuilder);
        this._commonDDService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this.commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._assessmentService = this.injector.get<AssessmentService>(AssessmentService);
        this._dataStoreService = injector.get<DataStoreService>(DataStoreService);
        this._router = this.injector.get<Router>(Router);

        this.id = this._commonDDService.getStoredCaseUuid();
        this.daNumber = this._commonDDService.getStoredCaseNumber();
        this.caseUUID = this._commonDDService.getStoredCaseUuid();
        this.loggedInUser = this._authService.getCurrentUser();
        this.isSupervisor = (this?.loggedInUser?.role?.name === 'apcs') ? true : false;

    }

    ngOnInit(): void {
        this._assessmentService.getservicecase();
        this.routingSupervisors = this._dataStoreService.getData('CASEWORKER_SUPERVISORS');
        this.assignSupervisors = this._dataStoreService.getData('da_assignedby');
        this.assessmentYouthData = this._dataStoreService.getData('CASEWORKER_SELECTED_ASSESSMENT');
        this.currentAssessmentId = this.assessmentYouthData?.assessmentid;
        this.currentSubmissionId = this.assessmentYouthData?.submissionid;
        let data: any = {};
        if (this.currentAssessmentId) {
            data = this.assessmentYouthData || {};
            data = { ...data, ...data?.submissiondata }
        }

        this.fetchChildDetails();
        this.initializeForm(data);
    }

    changeSupervisor(userid:any) {
        const user = this.routingSupervisors.find((item :any) => item?.userid === userid);
        if (user?.username) {
            this.assessmentyouthindicatorsForm.patchValue({
                supervisorname: user?.username
            });
        }
    }

    initializeForm(data:any) {
        const defaultSupervisor = this.routingSupervisors.find((item :any) =>
            item.username === this.assignSupervisors
        );

        this.assessmentyouthindicatorsForm = this.fb.group({
            childname: [data?.childname, Validators.required],
            childage: [data?.childage],
            childclientid: [data?.childclientid],
            youthrefused: [data?.youthrefused],
            q1: [data?.q1],
            q2: [data?.q2],
            q3: [data?.q3],
            q4: [data?.q4],
            q1skip: [data?.q1skip],
            q2skip: [data?.q2skip],
            q3skip: [data?.q3skip],
            q4skip: [data?.q4skip],
            additionalservicesrequired: [data?.additionalservicesrequired || ''],
            regionalnavigator: [data?.regionalnavigator],
            providerorservice: [data?.providerorservice],
            workersname: [{ value: data?.workersname || this.loggedInUser.user.userprofile.fullname, disabled: true }],
            workersid: [data?.workersid],
            reroutesupervisor: [data?.reroutesupervisor ? data?.reroutesupervisor : defaultSupervisor?.userid],
            supervisorname: [data?.supervisorname],
            completiondate: [(data?.completiondate) ? (data?.completiondate) : null, Validators.required],
            caseworkersignature: [data?.caseworkersignature],
            supervisorsignature: [data?.supervisorsignature],
            caseWorkercomments: [data?.caseWorkercomments],
            supervisorcomments: [data?.supervisorcomments],
            caseworkersignaturedate: [(data?.caseworkersignaturedate) ? (data?.caseworkersignaturedate) : null],
            supervisorsignaturedate: [(data?.supervisorsignaturedate) ? (data?.supervisorsignaturedate) : null],
            assessmentstatus: [data.assessmentstatustypekey === 'Review' ? '' : (data?.assessmentstatus || '')],
        });

        if (data?.mode === 'submit') {
            this.isReadOnly = true;
            this.assessmentyouthindicatorsForm.disable();
        }

        this.onYouthRefused();
        this.supervisorChages();

        if (data?.caseworkersignature) {
            this.caseworkersignature = data?.caseworkersignature;
        }
        if (data?.supervisorsignature) {
            this.supervisorsignature = data?.supervisorsignature;
        }

        let validationControls = [
            { control: 'q1skip', validtorControl: 'q1' },
            { control: 'q2skip', validtorControl: 'q2' },
            { control: 'q3skip', validtorControl: 'q3' },
            { control: 'q4skip', validtorControl: 'q4' },
        ];

        setTimeout(() => {
            for (const item of validationControls) {
                this.setValidator(item.control, item.validtorControl);
            }
        }, 0);

    }

    resetSignature(value: string) {
        if (value == 'caseworker') {
            this.caseworkersignature = '';
        } else if (value === 'supervisor') {
            this.supervisorsignature = '';
        }
    }

    supervisorChages() {
        if (this.isSupervisor) {
            this.assessmentyouthindicatorsForm?.get("caseworkersignaturedate")?.disable();
            this.assessmentyouthindicatorsForm?.get("caseworkersignaturedate")?.updateValueAndValidity();
            this.assessmentyouthindicatorsForm?.get('assessmentstatus')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get("assessmentstatus")?.updateValueAndValidity();
        } else {
            this.assessmentyouthindicatorsForm?.get("supervisorsignaturedate")?.disable();
            this.assessmentyouthindicatorsForm?.get("supervisorsignaturedate")?.updateValueAndValidity();
            this.assessmentyouthindicatorsForm?.get("supervisorcomments")?.disable();
            this.assessmentyouthindicatorsForm?.get("supervisorcomments")?.updateValueAndValidity();
        }
    }
    onApproval() {
        if (this.isSupervisor) {
            this.submitForApproval();
        } else {
            (<any>$('#confirm-popup')).modal('show');
        }
    }

    onClose() {
        (<any>$('#confirm-popup')).modal('hide');
        this.saveAsDraft();
    }

    get onRegionalNavigator() {
        if (this.assessmentyouthindicatorsForm?.get('regionalnavigator')?.value === 'ProviderOrService'
            && this.assessmentyouthindicatorsForm?.get('additionalservicesrequired')?.value === 'Yes') {
            this.assessmentyouthindicatorsForm?.get('providerorservice')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get("providerorservice")?.updateValueAndValidity();
            return true;
        } else {
            if (this.assessmentyouthindicatorsForm?.get('providerorservice')?.value) {
                this.assessmentyouthindicatorsForm?.get('providerorservice')?.clearValidators();
                this.assessmentyouthindicatorsForm?.get('providerorservice')?.setValue('');
                this.assessmentyouthindicatorsForm?.get("providerorservice")?.updateValueAndValidity();
            }
            return false;
        }
    }

    onadditionalServiceChange() {
        if (this.assessmentyouthindicatorsForm?.get('additionalservicesrequired')?.value === 'No') {
            this.assessmentyouthindicatorsForm?.get('regionalnavigator')?.setValue('');
            this.assessmentyouthindicatorsForm?.get('providerorservice')?.setValue('');
            this.assessmentyouthindicatorsForm?.get('providerorservice')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get('regionalnavigator')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get("providerorservice")?.updateValueAndValidity();
            this.assessmentyouthindicatorsForm?.get("regionalnavigator")?.updateValueAndValidity();
        } else {
            this.assessmentyouthindicatorsForm?.get('regionalnavigator')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get("regionalnavigator")?.updateValueAndValidity();
        }
    }

    validateMandatoryFields(controlName:any) {
        return this.assessmentyouthindicatorsForm['controls'][controlName]
            && this.assessmentyouthindicatorsForm['controls'][controlName]['errors']
            && this.assessmentyouthindicatorsForm['controls'][controlName]['errors']['required'];
    }

    fetchChildDetails() {
        this.commonHttpService.getArrayList({
            method: 'post',
            objectid: this.caseUUID,
        },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.AssessmentYouth.Getchilddatqyitasssessment
        ).subscribe(response => {
            this.childList = response[0].getchilddatqyitasssessment || [];
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }
    saveAsDraft() {

        this.submitForApprovalClicked = false;
        this.saveAsDraftClicked = true;

        const assessmentYouthFormData = this.assessmentyouthindicatorsForm.getRawValue();
        assessmentYouthFormData.currentSubmissionId = this.currentSubmissionId;
        assessmentYouthFormData.routingsupervisors = this.routingSupervisors;
        this._dataStoreService.setData('PRINTDATA', assessmentYouthFormData);
        this._assessmentService.saveAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, assessmentYouthFormData)
            .subscribe(
                (response) => {
                    if (response?.data) {
                        this.currentAssessmentId = response?.data?.assessmentid;
                        this.currentSubmissionId = response?.data?.submissionid;
                    } else {
                        this.currentAssessmentId = response?.assessmentid;
                        this.currentSubmissionId = response?.submissionid;
                    }
                    this._alertService.success(`Form Saved Successfully`);
                },
                (error) => {
                    this._alertService.error('Unable to save.');
                }
            );
    }

    submitForApproval() {
        (<any>$('#confirm-popup')).modal('hide');
        this.submitForApprovalClicked = true;
        this.saveAsDraftClicked = false;
        if (!this.assessmentyouthindicatorsForm.valid) {
            this._alertService.error('Please fill mandatory fields');
            return false;
        }
        const submissionData = this.assessmentyouthindicatorsForm.getRawValue();
        if (!this.isSupervisor) {
            submissionData.submissionapprovaldate = moment(new Date()).format('YYYY-MM-DDTHH:mm')
        }


        if (this.isSupervisor) {
            submissionData.assessmentStaus = this.assessmentyouthindicatorsForm?.get('assessmentstatus')?.value;
        } else {
            submissionData.assessmentStaus = 'Review';
        }

        submissionData.currentSubmissionId = this.currentSubmissionId;
        submissionData.routingsupervisors = this.routingSupervisors;
        submissionData.comments = submissionData.caseWorkercomments;
        this._dataStoreService.setData('PRINTDATA', submissionData);
        this._assessmentService.saveSafecAssessment(this.ASSESSMENT_NAME, this.currentAssessmentId, submissionData)
            .subscribe(
                (response) => {
                    this._alertService.success(`${submissionData?.assessmentStaus} Submitted Successfully`);
                    this.goBack();
                },
                (error) => {
                    this._alertService.error('Unable to submit for approval.');
                }
            );
    }

    goBack() {
        setTimeout(() => {
            this._router.navigate(['/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/assessment']);
        }, 1000);
    }

    getFullName(event: any) {
        return `${event.firstname} ${event.middlename} ${event.lastname}`
    }

    onChildChange(value: any) {
        let selectedChild = this.childList.find(item => this.getFullName(item) === value)
        this.assessmentyouthindicatorsForm?.get('childclientid')?.setValue(selectedChild.cjamspid);
        this.assessmentyouthindicatorsForm?.get('childage')?.setValue(this.calculateAge(selectedChild.dob));
    }

    calculateAge(dateOfBirth:any) {
        const today = new Date();
        const birthDate = new Date(dateOfBirth);
        let age = today.getFullYear() - birthDate.getFullYear();
        const monthDiff = today.getMonth() - birthDate.getMonth();

        // Check if birthday has occurred this year
        if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        return `${age} Yrs`;
    }

    setValidator(control: string, validtorControl: string) {
        if (this.assessmentyouthindicatorsForm?.get(validtorControl)?.value === 'Skip') {
            this.assessmentyouthindicatorsForm?.get(control)?.setValidators([Validators.required]);
        } else {
            this.assessmentyouthindicatorsForm?.get(control)?.clearValidators();
        }
        this.assessmentyouthindicatorsForm?.get(control)?.updateValueAndValidity();
    }

    onYouthRefused() {
        if (!this.assessmentyouthindicatorsForm?.get('youthrefused')?.value) {
            this.assessmentyouthindicatorsForm?.get('q1')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get('q2')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get('q3')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get('q4')?.setValidators([Validators.required]);
            this.assessmentyouthindicatorsForm?.get('additionalservicesrequired')?.setValidators([Validators.required]);
        } else {
            this.assessmentyouthindicatorsForm?.get('q1')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get('q2')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get('q3')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get('q4')?.clearValidators();
            this.assessmentyouthindicatorsForm?.get('additionalservicesrequired')?.clearValidators();
        }

        this.assessmentyouthindicatorsForm?.get("q1")?.updateValueAndValidity();
        this.assessmentyouthindicatorsForm?.get("q2")?.updateValueAndValidity();
        this.assessmentyouthindicatorsForm?.get("q3")?.updateValueAndValidity();
        this.assessmentyouthindicatorsForm?.get("q4")?.updateValueAndValidity();
        this.assessmentyouthindicatorsForm?.get("additionalservicesrequired")?.updateValueAndValidity();
    }

    openPicker(picker: any) {
        if(picker === 'picker11') {
            this.picker11.open();
        } else if(picker === 'picker12') {
            this.picker12.open();
        } else if(picker === 'picker13') {
            this.picker13.open();
        }
    }

    onPickerClosed(event: any, controlName: string) {
    const control: any = this.assessmentyouthindicatorsForm.get(controlName);
    const selectedDate: any = control?.value;
    if (selectedDate) {
      const maxDate: any = this.currentdatetime;
      if (selectedDate > maxDate) {
        control.setValue(maxDate);
      }
    }
  }
}
