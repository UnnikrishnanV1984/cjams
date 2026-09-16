import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
@Component({
    selector: 'ytp-documentation',
    templateUrl: './ytp-documentation.component.html',
    styleUrls: ['./ytp-documentation.component.scss'],
    standalone: false
})
export class YtpDocumentationComponent implements OnInit {

  documentationFormGroup!: FormGroup;
  documentationShortTermGoals: any[] = [];
  ytpData: any;
  store: any;
  uploadedDocuments: any = [];

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.documentationFormGroup = this.formBuilder.group({
      fosterCareVerification: [null, Validators.required],
      educationRecords: [null, Validators.required],
      // planforhousing: [null,Validators.required],
      socialSecurityCard: [null, Validators.required],
      identification: [null, Validators.required],
      healthInsuranceCard: [null, Validators.required],
      instruction: [null, Validators.required],
      greenCard: [null, Validators.required],
      medicalRecord: [null, Validators.required],
      birthCertificate: [null, Validators.required],
      additionalDocumentsNeeded: [null, Validators.required],
      youth: [null, Validators.required],
      caregiver: [null, Validators.required],
      caseFile: [null, Validators.required],
      independentLivingProvider: [null, Validators.required],
      other: [null],
      otherDesc: [null],
      signatureName: [null, Validators.required],
      youthSign: [null],
      youthSignDate: [null],
      youthuploadsign: [null],
      youthrefusesign: [null],
      ldssRepresentativeSign: [null],
      ldssRepresentativeSignDate: [null],
      // ldssRepresentativeuploadsign: [null],
      // ldssRepresentativerefusesign: [null],
      otherParticipantSign: [null],
      otherParticipantSignDate: [null],
      otherParticipantuploadsign: [null],
      otherParticipantrefusesign: [null],
    });

    this.documentationFormGroup.disable();

    this.ytpData = this.store['YTPDATA'];

    if (this.ytpData && this.ytpData.documentation_json) {
      setTimeout(() => {
        this.documentationFormGroup.patchValue(this.ytpData.documentation_json);
      }, 1000);

      if (this.ytpData.documentation_json.uploadedDocuments) {
        this.uploadedDocuments = this.ytpData.documentation_json.uploadedDocuments;
      }

      if (this.ytpData.documentation_json.goals) {
        this.documentationShortTermGoals = this.ytpData.documentation_json.goals;
        if (Array.isArray(this.documentationShortTermGoals) && this.documentationShortTermGoals.length) {
          this.documentationShortTermGoals.forEach((item: any) => {
            item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
          });
        }
      }

    }
  }


  save() {
    const data = this.documentationFormGroup.getRawValue();
    data.goals = this.documentationShortTermGoals;
    data.uploadedDocuments = this.uploadedDocuments;
    data.uploadedDocuments.forEach((document: { percentage: any; }) => {
      if (document.percentage) {
        delete document.percentage;
      }
    });
    let isCompleted = false;
    if (this.documentationFormGroup.valid) {
      if (data.goals.length > 0) {
        isCompleted = true;
      }
    }
    data.isCompleted = isCompleted;
    this._ytpService.patchData('documentation_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].documentation_json = data;
          this._alertservice.success('Documentation details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering documentation details!');
        }
      );
  }

  clear() {
    this.documentationFormGroup.reset();
  }
}
