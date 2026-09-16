
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Observable ,  forkJoin } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, CommonHttpService, CommonDropdownsService } from '../../../../../@core/services';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { HealthInsuranceInformationService } from '../health-insurance-information.service';
import { PersonDetailsService } from '../../../person-details.service';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'health-insurance-information-create-edit',
    templateUrl: './health-insurance-information-create-edit.component.html',
    styleUrls: ['./health-insurance-information-create-edit.component.scss'],
    standalone: false
})
export class HealthInsuranceInformationCreateEditComponent implements OnInit {
  healthinsuranceForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  isInsuranceAvailableforPerson!: boolean;
  reportMode!: string;
  minDate = new Date();
  maxDate = new Date();
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<any[]>;
  medAssistance!: boolean;
  resourceId!: string | null;

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _commonHttpService: CommonHttpService,
    private _commonDropdownsService: CommonDropdownsService,
    private personService: PersonDetailsService,
    private route: ActivatedRoute,
    private _healthInsInfoService: HealthInsuranceInformationService) {
  }

  ngOnInit() {
    this.loadDropDowns();
    this.medAssistance = false;
    this.editMode = false;
    this.reportMode = 'add';
    this.resourceId = null;
    this.isInsuranceAvailableforPerson = false;
    this.modalInt = -1;
    this.healthinsuranceForm = this.formbulider.group({
      ismedicaidmedicare: '',
      medicalinsuranceprovider: '',
      providertype: '',
      isinsuranceavailable: [''],
      policyholdername: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      county: '',
      zip: '',
      providerphone: '',
      patientpolicyholderrelation: '',
      policyname: '',
      groupnumber: '',
      updateddate: '',
      startdate: null,
      enddate: null

    });

    this.route.params.subscribe(params => {
      this._healthInsInfoService.healthInsInfo$.subscribe(data => {
        data.forEach(element => {
          if (element.personhealthinsuranceid === params.id) {
            this.isInsuranceExsists(true);
            this.loadCounty(element.state);
            this.selectmedicalassistance(element.ismedicaidmedicare);
            setTimeout(() => {
              this.healthinsuranceForm.patchValue({
                ismedicaidmedicare: [element.ismedicaidmedicare],
                medicalinsuranceprovider: element.medicalinsuranceprovider,
                providertype: element.providertype,
                policyholdername: element.policyholdername,
                address1: element.address1,
                address2: element.address2,
                city: element.city,
                state: element.state,
                county: element.countyid,
                zip: element.zip,
                providerphone: element.providerphone,
                patientpolicyholderrelation: element.patientpolicyholderrelation,
                policyname: element.policyname,
                groupnumber: element.groupnumber,
                updateddate: element.createddate,
                startdate: element.effectivepolicydate,
                enddate: element.expirationdate,
                isinsuranceavailable: [true]
              });
            }, 1000);
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.resourceId = params.id;
            } else if (params.reportMode === 'view') {
              this.healthinsuranceForm.disable();
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
        NewUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        NewUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          ethinicities: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.ethnicgrouptypekey
              })
          ),
          states: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          )
        };
      }),
      share(),);
    this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
  }

  loadCounty(countystate?: any) {
    const state = countystate ? countystate : this.healthinsuranceForm.get('state')?.value;
    this.countyDropDownItems$ = this._commonDropdownsService.getCountyList(state);
  }

  selectmedicalassistance(control: any) {
    this.medAssistance = control;
  }

  addUpdate(healthinsuranceForm: any) {
    const currDate = new Date();
    healthinsuranceForm.updateddate = currDate;
    healthinsuranceForm.personhealthinsuranceid = this.resourceId;
    healthinsuranceForm.personid = this.personService.person.personid;
    if (healthinsuranceForm.startdate) {
      if (!(healthinsuranceForm.startdate instanceof Date)) {
        healthinsuranceForm.startdate = new Date(healthinsuranceForm.startdate);
      }
    }
    if (healthinsuranceForm.enddate) {
      if (!(healthinsuranceForm.enddate instanceof Date)) {
        healthinsuranceForm.enddate = new Date(healthinsuranceForm.enddate);
      }
    }
    this._healthInsInfoService.addUpdateHealthInsuranceInfo(healthinsuranceForm).subscribe(result => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.success('Health Insurance Information details saved successfully!');
    }, error => {
      const element: HTMLElement |null = document.getElementById('backbutton');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  private enableorDisableField(field: any, opt: any) {
    if (opt) {
      this.healthinsuranceForm.get(field)?.enable();
      this.healthinsuranceForm.get(field)?.setValidators([Validators.required]);
      this.healthinsuranceForm.get(field)?.updateValueAndValidity();
    } else {
      this.healthinsuranceForm.get(field)?.disable();
      this.healthinsuranceForm.get(field)?.clearValidators();
      this.healthinsuranceForm.get(field)?.updateValueAndValidity();
    }
  }

  isInsuranceExsists(opt: any) {

    this.enableorDisableField('ismedicaidmedicare', opt);
    this.enableorDisableField('medicalinsuranceprovider', opt);
    this.enableorDisableField('providertype', opt);
    this.enableorDisableField('policyname', opt);
    this.enableorDisableField('startdate', opt);
    this.enableorDisableField('groupnumber', opt);
    this.isInsuranceAvailableforPerson = opt;
    this.healthinsuranceForm.reset();
    this.healthinsuranceForm.patchValue({ 'isinsuranceavailable': opt });

  }

  resetForm() {
    this.healthinsuranceForm.reset();
    this.isInsuranceAvailableforPerson = false;
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.healthinsuranceForm.enable();
    this.medAssistance = false;
  }

  private startDateChanged() {
    this.healthinsuranceForm.patchValue({ enddate: '' });
    const empForm = this.healthinsuranceForm.getRawValue();
    this.maxDate = new Date(empForm.enddate);
  }
  private endDateChanged() {
    this.healthinsuranceForm.patchValue({ startdate: '' });
    const empForm = this.healthinsuranceForm.getRawValue();
    this.minDate = new Date(empForm.startdate);
  }
}
