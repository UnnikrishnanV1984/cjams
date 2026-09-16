
import {pluck} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../@core/services';
import { Subject ,  Observable } from 'rxjs';
import { Employer, Work } from '../../../@core/common/models/involvedperson.data.model';
import { PersonsDetailsConstants } from '../_entities/person_details.constants';
import { PersonWorksDetailsService } from './person-works-details.service';
import { PersonDetailsService } from '../person-details.service';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { PaginationRequest } from '../../../@core/entities/common.entities';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-works-details',
    templateUrl: './person-works-details.component.html',
    styleUrls: ['./person-works-details.component.scss'],
    standalone: false
})
export class PersonWorksDetailsComponent implements OnInit {

  @Input()
  workFormReset$ = new Subject<boolean>();
  employerForm!: FormGroup;
  careerForm!: FormGroup;
  employer?: Employer[] = [];
  careergoals!: string;
  work: Work = {};
  minDate = new Date();
  maxDate = new Date();
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  carrerreportMode!: string;
  notes = 'Enter Career Goals';
  resourceID!: string | null;
  carreerresourceID!: string;
  employerList$ = new Observable<any>();
  carrerList$ = new Observable<any>();
  deleteemployerpopup = '#delete-employer-popup';
  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _workdetailsService: PersonWorksDetailsService,
    public _personDetailService: PersonDetailsService) { }

  ngOnInit() {
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.carrerreportMode = 'add';
    this.employerForm = this.formbulider.group({
      employername: ['', Validators.required],
      currentemployer: false,
      noofhours: ['', Validators.required],
      duties: ['', Validators.required],
      startdate: ['', Validators.required],
      enddate: ['', Validators.required],
      reasonforleaving: ['', Validators.required],
    });
    this.careerForm = this.formbulider.group({
      careergoals: ''
    });
    this.workFormReset$.subscribe((res) => {
      if (res === true) {
        this.workFormResetResponseFn();
      }
    });

    if (this.work && this.work.employer) {
      this.employer = this.work.employer;
    }
    if (this.work && this.work.careergoals) {
      this.careerForm.patchValue({ 'careergoals': this.careergoals });
    }
    this.getEmployerList();
    this.getCarrerList();
  }

  private workFormResetResponseFn() {
    this.work = this._dataStoreService.getData(PersonsDetailsConstants.PERSONS_WORK);
    if (this.work && this.work.employer) {
      this.employer = this.work.employer;
    } else {
      this.employer = [];
    }

    if (this.work && this.work.careergoals) {
      this.careergoals = this.work.careergoals;
    } else {
      this.careergoals = '';
    }
    this.careerForm = this.formbulider.group({
      careergoals: ''
    });
  }

  addUpdateEmployer(model: any) {
    model.personemployerdetailid = this.resourceID;
    model.personid = this._personDetailService.person.personid;
    if (model.startdate) {
      if (!(model.startdate instanceof Date)) {
        model.startdate = new Date(model.startdate);
      }
    }
    if (model.enddate) {
      if (!(model.enddate instanceof Date)) {
        model.enddate = new Date(model.enddate);
      }
    }
    model.careergoals = 'test';
    this._workdetailsService.addUpdateEmployer(model).subscribe(result => {
      this.getEmployerList();
      this.reportMode = 'add';
      this.resourceID = null;
      this.resetForm();
      this._alertSevice.success('Employer details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getEmployerList() {
    const source = this._workdetailsService.getEmployerList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: 1,
        limit: 10,
      }), 10);

    this.employerList$ = source.pipe(pluck('data'));
  }

  getCarrerList() {
    const source = this._workdetailsService.getCarrerList(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: 1,
        limit: 1,
      }), 10);

    this.carrerList$ = source.pipe(pluck('data'));
    this.carrerList$.subscribe(data => {
      data.forEach((element: { personworkcarrergoalid: string; careergoals: any; }) => {
        this.carreerresourceID = element.personworkcarrergoalid;
        this.careerForm.patchValue({
          careergoals: element.careergoals
        });
        this.carrerreportMode = 'edit';
      });
    });

  }

  editEmployer(model: any, index: any) {
    this.employerForm.patchValue(model);
    this.modalInt = index;
    this.patchForm(model);
    this.employerForm.enable();
    this.isCurrentEmployerOnEdit(model.currentemployer);
    this.resourceID = model.personemployerdetailid;
    this.reportMode = 'edit';
    this.employerForm.enable();
    this.editMode = true;
  }

  viewEmployer(model: any) {
    this.employerForm.patchValue(model);
    this.resourceID = model.personemployerdetailid;
    this.reportMode = 'view';
    this.employerForm.disable();
  }

  showDeletePopEmployer(resourceid: any) {
    this.resourceID = resourceid;
    (<any>$(this.deleteemployerpopup)).modal('show');
  }
  deleteEmployer() {
    this._workdetailsService.deleteEmployer(this.resourceID).subscribe(
      response => {
        this.getEmployerList();
        this.resourceID = null;
        this.resetForm();
        this._alertSevice.success('Employer deleted successfully');
        (<any>$(this.deleteemployerpopup)).modal('hide');
      },
      error => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deleteemployerpopup)).modal('hide');
      }
    );
  }

  addUpdateCarreerGoal(model: any) {
    model.personworkcarrergoalid = this.carreerresourceID;
    model.personid = this._personDetailService.person.personid;
    this._workdetailsService.addUpdateCarrer(model).subscribe(result => {
      this.getCarrerList();
      this._alertSevice.success('Carreer Goals details saved successfully!');
    }, error => {
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  resetForm() {

    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.employerForm.reset();
    this.employerForm.enable();
    this.employerForm.get('enddate')?.enable();
    this.employerForm.get('enddate')?.setValidators([Validators.required]);
    this.employerForm.get('enddate')?.updateValueAndValidity();
    this.employerForm.get('reasonforleaving')?.enable();
    this.employerForm.get('reasonforleaving')?.setValidators([Validators.required]);
    this.employerForm.get('reasonforleaving')?.updateValueAndValidity();
  }


  isCurrentEmployer(control: any) {
    if (control.checked) {
      this.isCurrEmployerIfConditionFn();
    } else {
      this.isCurrEmployerElseConditionFn();
    }
  }

  isCurrentEmployerOnEdit(control: any) {
    if (control) {
      this.isCurrEmployerIfConditionFn();
    } else {
      this.isCurrEmployerElseConditionFn();
    }
  }

  private isCurrEmployerIfConditionFn() {
    this.employerForm.get('enddate')?.disable();
    this.employerForm.get('enddate')?.clearValidators();
    this.employerForm.get('enddate')?.updateValueAndValidity();
    this.employerForm.get('reasonforleaving')?.disable();
    this.employerForm.get('reasonforleaving')?.clearValidators();
    this.employerForm.get('reasonforleaving')?.updateValueAndValidity();
  }

  private isCurrEmployerElseConditionFn() {
    this.employerForm.get('enddate')?.enable();
    this.employerForm.get('enddate')?.setValidators([Validators.required]);
    this.employerForm.get('enddate')?.updateValueAndValidity();
    this.employerForm.get('reasonforleaving')?.enable();
    this.employerForm.get('reasonforleaving')?.setValidators([Validators.required]);
    this.employerForm.get('reasonforleaving')?.updateValueAndValidity();
  }

  dateChanged() {
    const empForm = this.employerForm.getRawValue();
    this.minDate = new Date(empForm.startdate);
  }

  private patchForm(modal: Employer) {
    this.employerForm.patchValue(modal);
  }


}
