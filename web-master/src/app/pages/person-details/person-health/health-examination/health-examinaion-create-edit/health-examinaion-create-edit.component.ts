
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { HealthExamination } from '../../../../../@core/common/models/involvedperson.data.model';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Observable , forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { HealthExaminationService } from '../health-examination.service';
import { PersonDetailsService } from '../../../person-details.service';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'health-examinaion-create-edit',
    templateUrl: './health-examinaion-create-edit.component.html',
    styleUrls: ['./health-examinaion-create-edit.component.scss'],
    standalone: false
})
export class HealthExaminaionCreateEditComponent implements OnInit {
  healthexaminationForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  resourceId!: string | null;
  healthExaminationForm!: FormGroup;
  healthProfessionType$!: Observable<DropdownModel[]>;
  healthDomainType$!: Observable<DropdownModel[]>;
  healthDomainTypes: any[] = [];
  healthAssessmentTypes: any[] = [];
  domainTypeKey!: string;
  healthAssessmentType$!: Observable<DropdownModel[]>;
  healthexamination$!: Observable<HealthExamination[]>;

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _commonHttpService: CommonHttpService,
    private personService: PersonDetailsService,
    private route: ActivatedRoute,
    private _healthExamInfoService: HealthExaminationService) { }

  ngOnInit() {
    this.loadDropDowns();
    this.editMode = false;
    this.modalInt = -1;
    this.domainTypeKey = '';
    this.reportMode = 'add';
    this.resourceId = null;
    this.healthexaminationForm = this.formbulider.group({
      healthexamname: '',
      healthassessmenttypekey: ['', Validators.required],
      healthdomaintypekey: ['', Validators.required],
      assessmentdate: [null, Validators.required],
      healthprofessiontypekey: '',
      practitionername: '',
      outcomeresults: ['', Validators.required],
      notes: ''
    });

    this.route.params.subscribe(params => {
      this._healthExamInfoService.healthExamInfo$.subscribe(data => {
        data.forEach(element => {
          if (element.personhealthexaminationid === params.id) {
            setTimeout(() => {
              this.patchForm(element);
            }, 1000);
            this.setDomainTypeKey(element.healthdomaintypekey);
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.resourceId = params.id;
            } else if (params.reportMode === 'view') {
              this.healthexaminationForm.disable();
              this.reportMode = 'view';
              this.editMode = false;
              this.resourceId = params.id;
            }
          }
        });
      });
    });

  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1 },
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.healthprofessiontype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.healthdomaintype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.healthassessmenttype + '?filter'
      )
    ]).pipe(
      map((result) => {
        result[1].forEach(type => {
          this.healthDomainTypes[type.healthdomaintypekey] = type.description;
        });
        result[2].forEach(type => {
          this.healthAssessmentTypes.push(type);
        });

        return {
          healthprofessiontype: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.healthprofessiontypekey
              })
          ),
          healthdomaintype: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.healthdomaintypekey
              })
          ),
          healthassessmenttype: result[2].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.healthassessmenttypekey
              })
          )
        };
      }),
      share(),);
    this.healthProfessionType$ = source.pipe(pluck('healthprofessiontype'));
    this.healthDomainType$ = source.pipe(pluck('healthdomaintype'));
    this.healthAssessmentType$ = source.pipe(pluck('healthassessmenttype'));
  }

  setDomainTypeKey(key: any) {
    this.domainTypeKey = key;
    this.healthAssessmentType$ = this.healthAssessmentType$.pipe(map(elements => {
      return elements.filter(element => element.value !== key);
    }));
  }

  addUpdate(healthExamForm: any) {
    healthExamForm.personhealthexaminationid = this.resourceId;
    healthExamForm.personid = this.personService.person.personid;
    if (healthExamForm.assessmentdate) {
      if (!(healthExamForm.assessmentdate instanceof Date)) {
        healthExamForm.assessmentdate = new Date(healthExamForm.assessmentdate);
      }
    }
    this._healthExamInfoService.addUpdateHealthExamInfo(healthExamForm).subscribe(() => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.success('Health Examination Information details saved successfully!');
    }, error => {
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  resetForm() {
    this.healthexaminationForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.setDomainTypeKey('');
    this.healthexaminationForm.enable();
  }

  view(modal: any) {
    this.reportMode = 'edit';
    this.setDomainTypeKey(modal.domain);
    this.patchForm(modal);
    this.editMode = false;
    this.healthexaminationForm.disable();
  }

  edit(modal: any, i: any) {
    this.reportMode = 'edit';
    this.setDomainTypeKey(modal.domain);
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.healthexaminationForm.enable();
  }

  cancel() {
    this.resetForm();
  }

  private patchForm(modal: HealthExamination) {
    this.healthexaminationForm.patchValue(modal);
  }

}
