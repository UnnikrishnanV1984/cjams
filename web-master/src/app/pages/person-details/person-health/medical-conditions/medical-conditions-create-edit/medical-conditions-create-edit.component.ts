
import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { MedicalConditionType } from '../../../../newintake/my-newintake/_entities/newintakeModel';
import { MedicalConditions } from '../../../../../@core/common/models/involvedperson.data.model';
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { MedicalConditionsService } from '../medical-conditions.service';
import { PersonDetailsService } from '../../../person-details.service';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medical-conditions-create-edit',
    templateUrl: './medical-conditions-create-edit.component.html',
    styleUrls: ['./medical-conditions-create-edit.component.scss'],
    standalone: false
})
export class MedicalConditionsCreateEditComponent implements OnInit {
  medicalconditionForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  minDate = new Date();
  maxDate = new Date();
  medicalCondtionType: MedicalConditionType[] = [];
  medicalConditionDescription: string[] = [];
  resourceId!: string;
  medicalConditionType$!: Observable<DropdownModel[]>;
  _medicalcondtion: string[] = [];

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _commonHttpService: CommonHttpService,
    private personService: PersonDetailsService,
    private route: ActivatedRoute,
    private _medicalConditionService: MedicalConditionsService) { }

  ngOnInit() {
    this.loadDropDowns();
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.medicalconditionForm = this.formbulider.group({
      medicalconditiontypekey: ['', Validators.required],
      begindate: [null, Validators.required],
      enddate: [null, Validators.required],
      recordedby: ['', Validators.required],
      medicalconditiondesc: null
    });

    this.route.params.subscribe(params => {
      this._medicalConditionService.medicalConditionInfo$.subscribe(data => {
        data.forEach(element => {
          if (element.personmedicalconditionid === params.id) {
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.resourceId = params.id;
            } else if (params.reportMode === 'view') {
              this.medicalconditionForm.disable();
              this.reportMode = 'view';
              this.editMode = false;
              this.resourceId = params.id;
            }
            setTimeout(() => {
              element.medicalcondition.forEach((_element: { medicalconditiontypekey: string; }) => {
                this._medicalcondtion.push(_element.medicalconditiontypekey);
                this.medicalConditionDescription?.push(_element.medicalconditiontypekey);
              });
              this.medicalconditionForm.controls['medicalconditiontypekey'].setValue(this._medicalcondtion);
              this.patchForm(element);
            }, 1000);
          }
        });
      });
    });
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.medicalconditiontype + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          medicalconditiontype: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.medicalconditiontypekey
              })
          )
        };
      }),
      share(),);
    this.medicalConditionType$ = source.pipe(pluck('medicalconditiontype'));
  }

  addUpdate(medicalconditionForm: any) {
    medicalconditionForm.personmedicalconditionid = this.resourceId;
    medicalconditionForm.personid = this.personService.person.personid;
    medicalconditionForm.medicalcondition = this.medicalCondtionType;
    if (medicalconditionForm.begindate) {
      if (!(medicalconditionForm.begindate instanceof Date)) {
        medicalconditionForm.begindate = new Date(medicalconditionForm.begindate);
      }
    }
    if (medicalconditionForm.enddate) {
      if (!(medicalconditionForm.enddate instanceof Date)) {
        medicalconditionForm.enddate = new Date(medicalconditionForm.enddate);
      }
    }
    this._medicalConditionService.addUpdatemedicalCondition(medicalconditionForm).subscribe(result => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.success('Medical Conditions details saved successfully!');
    }, error => {
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  resetForm() {
    this.medicalconditionForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.medicalconditionForm.enable();
  }

  getMedicalCondition(modal: any) {
    const obj = JSON.parse(JSON.stringify(modal));
    obj.medicalconditiontype = obj.medicalconditiontypekey;
    obj.medicalconditiontypekey = obj.medicalconditiontypekey.map((item: { medicalconditiontypekey: any; }) => item.medicalconditiontypekey);

    return obj;
  }

  selectMedicalConditionType(event: any) {
    if (event) {
      const medicalConditionType = event.map((res: any) => {
        return { medicalconditiontypekey: res };
      });
      this.medicalCondtionType = medicalConditionType;
      this.medicalConditionType$.subscribe(items => {
        if (items) {
          const getConditiontems = items.filter(item => {
            if (event.includes(item.value)) {
              return item;
            }
          });
          this.medicalConditionDescription = getConditiontems.map(res => res.text);
        }
      });
    }
  }
  startDateChanged() {
    this.medicalconditionForm.patchValue({ enddate: '' });
    const empForm = this.medicalconditionForm.getRawValue();
    this.maxDate = new Date(empForm.begindate);
  }
  endDateChanged() {
    this.medicalconditionForm.patchValue({ begindate: '' });
    const empForm = this.medicalconditionForm.getRawValue();
    this.minDate = new Date(empForm.enddate);
  }
  private patchForm(modal: MedicalConditions) {
    this.medicalconditionForm.patchValue(modal);
  }

}
