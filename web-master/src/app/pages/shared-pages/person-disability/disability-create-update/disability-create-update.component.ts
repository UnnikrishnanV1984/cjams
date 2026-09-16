import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { PersonDisabilityService } from '../person-disability.service';
import { Router, ActivatedRoute } from '@angular/router';
import { AlertService, DataStoreService } from '../../../../@core/services';

@Component({
    selector: 'disability-create-update',
    templateUrl: './disability-create-update.component.html',
    styleUrls: ['./disability-create-update.component.scss'],
    standalone: false
})
export class DisabilityCreateUpdateComponent implements OnInit {

  personDisabilityForm!: FormGroup;
  disabilityTypes: any[] = [];
  disabilityConditions: any[] = [];

  maxDate: any;
  person: any;
  startDate: any;
  constructor(private _formBuilder: FormBuilder,
    private _service: PersonDisabilityService,
    private _router: Router,
    private route: ActivatedRoute,
    private alertService: AlertService,
    private dataStoreService: DataStoreService) { }

  ngOnInit() {
    (<any>$('#disability-form')).modal('show');
    this.person = this._service.person;
    this.initForm();
    this.loadDropDowns();
    this.subscribeValues();
  }

  initForm() {
    this.personDisabilityForm = this._formBuilder.group({
      personid: [this._service.person.personid],
      disabilityconditiontypekey: [null, Validators.required],
      diagnoiseddisabilitynotes: [null],
      startdate: [null, Validators.required],
      enddate: [null],
      disabilityflag: [null],
      evaluationdate: [null],
      evaluatorname: [null],
      disabilitytypekey: [null, Validators.required],
      comments: [null]
    });
  }
  subscribeValues() {
    this.personDisabilityForm.controls['startdate'].valueChanges.subscribe(v => {
      this.maxDate = new Date(v);
      
    })
  }
  loadDropDowns() {
    this._service.getDisabilityTypes().subscribe(response => {
      if (response && Array.isArray(response)) {
        this.disabilityTypes = response;
      }
    });
    this._service.getDisabilityConditions().subscribe(response => {
      if (response && Array.isArray(response)) {
        this.disabilityConditions = response;
      }
    });
  }

  saveDisability() {
    if (this.personDisabilityForm.invalid) {
      this.alertService.error('please fill required fields');
      return;
    }
    const data = this.personDisabilityForm.getRawValue();
    this._service.createDisability(data).subscribe(response => {
      this.alertService.success('Disability added successfully', true);
      this.dataStoreService.setData('DISABILITY_CREATED', this.person.personid, true, 'DISABILITY');
      this.goBack();
    });
  }

  goBack() {
    (<any>$('#disability-form')).modal('hide');
    this._router.navigate(['../../../'], { relativeTo: this.route });
  }

  close() {
    this.goBack();
  }

}
