
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Medication, Health } from '../../../../../@core/common/models/involvedperson.data.model';
import { MyNewintakeConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { MedicationIncludingPsychotropicService } from '../medication-including-psychotropic.service';
import { PersonDetailsService } from '../../../person-details.service';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medication-including-psychotropic-create-edit',
    templateUrl: './medication-including-psychotropic-create-edit.component.html',
    styleUrls: ['./medication-including-psychotropic-create-edit.component.scss'],
    standalone: false
})
export class MedicationIncludingPsychotropicCreateEditComponent implements OnInit {
  medicationpsychotropicForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  medicationpsychotropic: Medication[] = [];
  health: Health = {};
  constants = MyNewintakeConstants.Intake.PersonsInvolved.Health;
  prescriptionReasonType$!: Observable<DropdownModel[]>;
  informationSourceType$!: Observable<DropdownModel[]>;
  maxDate = new Date();
  resourceId!: string;

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _commonHttpService: CommonHttpService,
    private personService: PersonDetailsService,
    private route: ActivatedRoute,
    private _medicalConditionService: MedicationIncludingPsychotropicService) { }

  ngOnInit() {
    this.loadDropDowns();
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.medicationpsychotropicForm = this.formbulider.group({
      medicationname: ['', Validators.required],
      dosage: ['', Validators.required],
      frequency: ['', Validators.required],
      lastdosetakendate: ['', Validators.required],
      informationsourcetypekey: null,
      medicationeffectivedate: [null, Validators.required],
      medicationexpirationdate: null,
      prescribingdoctor: '',
      prescriptionreasontypekey: null,
      monitoring: '',
      comments: ''
    });

    this.route.params.subscribe(params => {
      this._medicalConditionService.medicationInfo$.subscribe(data => {
        data.forEach(element => {
          if (element.personmedicpshychotropicid === params.id) {
            element.comments = element.medicationcomments;
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.resourceId = params.id;
            } else if (params.reportMode === 'view') {
              this.medicationpsychotropicForm.disable();
              this.reportMode = 'view';
              this.editMode = false;
              this.resourceId = params.id;
            }
            this.patchForm(element);
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
        CommonUrlConfig.EndPoint.Intake.prescriptionreasontype + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.informationsourcetype + '?filter'
      )
    ]).pipe(
      map((result: any) => {
        return {
          prescriptionreasontype: result[0].map(
            (res: { description: any; prescriptionreasontypekey: any; }) =>
              new DropdownModel({
                text: res.description,
                value: res.prescriptionreasontypekey
              })
          ),
          informationsourcetype: result[1].map(
            (res: { description: any; informationsourcetypekey: any; }) =>
              new DropdownModel({
                text: res.description,
                value: res.informationsourcetypekey
              })
          )
        };
      }),
      share(),);
    this.prescriptionReasonType$ = source.pipe(pluck('prescriptionreasontype'));
    this.informationSourceType$ = source.pipe(pluck('informationsourcetype'));
  }

  addUpdate(medicationpsychotropicForm: any) {
    medicationpsychotropicForm.personmedicpshychotropicid = this.resourceId;
    medicationpsychotropicForm.personid = this.personService.person.personid;
    if (medicationpsychotropicForm.lastdosetakendate) {
      if (!(medicationpsychotropicForm.lastdosetakendate instanceof Date)) {
        medicationpsychotropicForm.lastdosetakendate = new Date(medicationpsychotropicForm.lastdosetakendate);
      }
    }
    if (medicationpsychotropicForm.medicationeffectivedate) {
      if (!(medicationpsychotropicForm.medicationeffectivedate instanceof Date)) {
        medicationpsychotropicForm.medicationeffectivedate = new Date(medicationpsychotropicForm.medicationeffectivedate);
      }
    }
    if (medicationpsychotropicForm.medicationexpirationdate) {
      if (!(medicationpsychotropicForm.medicationexpirationdate instanceof Date)) {
        medicationpsychotropicForm.medicationexpirationdate = new Date(medicationpsychotropicForm.medicationexpirationdate);
      }
    }
    this._medicalConditionService.addUpdatemedition(medicationpsychotropicForm).subscribe(() => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.success('Medications details saved successfully!');
    }, (_error: any) => {
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  resetForm() {
    this.medicationpsychotropicForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.medicationpsychotropicForm.enable();
  }

  private patchForm(modal: Medication) {
    this.medicationpsychotropicForm.patchValue(modal);
  }


}
