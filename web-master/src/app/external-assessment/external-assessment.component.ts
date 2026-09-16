import { Component, OnInit } from '@angular/core';
import { SessionStorageService } from '../@core/services/storage.service';
import { environment } from '../../environments/environment';
import { HttpService } from '../@core/services/http.service';
import { AlertService, CommonHttpService } from '../@core/services';
import { ActivatedRoute } from '@angular/router';
import { CaseWorkerUrlConfig } from '../pages/case-worker/case-worker-url.config';
declare var $: any;
declare var Formio: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'external-assessment',
    templateUrl: './external-assessment.component.html',
    standalone: true
})
export class ExternalAssessmentComponent implements OnInit {
    assessmmentName!: string;
    private servicereqid: string;
    private templateId: string;
    private submissionId: string;
    isApproved!: boolean;
    intakeservicerequestactorid: string;
    // tslint:disable-next-line:max-line-length
    constructor(private storage: SessionStorageService, private route: ActivatedRoute, private _http: HttpService, private _alertService: AlertService, private _commonService: CommonHttpService) {
        this.servicereqid = route.snapshot.params['servicereqid'];
        if (route.snapshot.params['isApproved'] === 'review') {
            this.isApproved = false;
        } else if (route.snapshot.params['isApproved'] === 'approved') {
            this.isApproved = true;
        }
        this.templateId = route.snapshot.params['templateId'];
        this.submissionId = route.snapshot.params['submissionId'];
        this.intakeservicerequestactorid = route.snapshot.params['intakeservicerequestactorid'];
    }

    ngOnInit() {
        this.openAssessment();
    }
    private openAssessment() {
        setTimeout(() => { 
            // // Fetching the assesssment token from session storage service
            // const token = this.storage.getObj('assessment_token') || this.storage.getObj('fbToken');
            // Formio.setToken(token);
            Formio.baseUrl = environment.formBuilderHost;
            const _self = this;
            let formioUrl = '';
            if (this.submissionId === 'survey') {
                formioUrl = environment.formBuilderHost + `/form/${this.templateId}`;
             } else {
                formioUrl = environment.formBuilderHost + `/form/${this.templateId}/submission/${this.submissionId}`;
             }

            Formio.createForm(document.getElementById('assessmentForm'), formioUrl, {
                readOnly: _self.isApproved,
                icons:'fontawesome'
            }).then(function(form: any) {
                const formData = form.data;
                formData.userrole = 'Intake Worker';
                if (_self.submissionId === 'survey') {
                    formData.isCjamsId = _self.route.snapshot.params['isApproved'];
                }
                form.submission = {
                    data: formData
                };
                form.on('submit', (submission: any) => {
                    if (_self.submissionId === 'survey') {
                        _self.surveyFormSave(submission);
                    } else {
                        _self.transportationFormSave(submission);
                    }
                });
            });
        }, 3000);
    }

    private transportationFormSave(submission: any) {
        const formContent = document.getElementById('assessmentForm')?.innerHTML;
        const attachment = window.btoa(String(formContent));
        const schoolEmail = [
            {
                email: submission.data['sendemailid'],
                objectid: this.submissionId,
                objecttypekey: 'Assessment',
                attachment: attachment,
                message: ''
            }
        ];
        this._commonService.create(schoolEmail, CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval.EmailSchoolNotification).subscribe(res => {
            this._alertService.success(this.assessmmentName + ' saved successfully.');
        });
    }

    private surveyFormSave(submission: any) {
        this._http
            .post('admin/assessment/Add', {
                externaltemplateid: this.templateId,
                objectid: this.servicereqid,
                submissionid: submission._id,
                submissiondata: submission.data ? submission.data : null,
                form: submission.form ? submission.form : null,
                score: submission.data.score ? submission.data.score : 0,
                intakeservicerequestactorid: this.intakeservicerequestactorid,
                assessmentstatustypekey1: 'Submitted'
            })
            .subscribe(response => {
                this._alertService.success('Survey form saved successfully.');
            });
    }
}
