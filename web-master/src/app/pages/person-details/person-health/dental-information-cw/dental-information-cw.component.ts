
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';

import { FormBuilder, FormGroup, Validators } from '@angular/forms';
// tslint:disable-next-line:import-blacklist
import { Observable ,  forkJoin ,  Subject } from 'rxjs';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { PersonDentalInfo, Health } from '../../../../@core/common/models/involvedperson.data.model';
import { MyNewintakeConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { AlertService, DataStoreService, CommonHttpService, ValidationService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dental-information-cw',
    templateUrl: './dental-information-cw.component.html',
    styleUrls: ['./dental-information-cw.component.scss'],
    standalone: false
})
export class DentalInformationCwComponent implements OnInit {
  @Input()
  healthFormReset$ = new Subject<boolean>();
  minDate = new Date();
  maxDate = new Date();
  dentalForm!: FormGroup;
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  persondentalinfo: PersonDentalInfo[] = [];
  health: Health = {};
  specialty$!: Observable<DropdownModel[]>;
  specialty: any[] = [];
  constants = MyNewintakeConstants.Intake.PersonsInvolved.Health;

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService
  ) {

  }

  ngOnInit() {
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.dentalForm = this.formbulider.group({
      'isdentalinfo': [false, Validators.required],
      'dentistname': ['', Validators.required],
      'dentalspecialtytypekey': ['', Validators.required],
      'phone': ['', Validators.required],
      'email': ['', ValidationService.mailFormat],
      'address1': '',
      'address2': '',
      'city': '',
      'state': '',
      'county': ['', Validators.required],
      'zip': '',
      'startdate': [null, Validators.required],
      'enddate': null,
    });
    this.healthFormReset$.subscribe((res) => {
      if (res === true) {
        this.initializeProvider();
      }
    });

    this.initializeProvider();
    this.loadDropDowns();
  }

  initializeProvider() {
    this.health = this._dataStoreService.getData(this.constants.Health);

    if (this.health && this.health.persondentalinfo) {
      this.persondentalinfo = this.health.persondentalinfo;
    }

    this.resetForm();
  }


  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1 },
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.StateListUrl + '?filter'
      ),
      this._commonHttpService.create(
        {
          nolimit: true
        },
        CommonUrlConfig.EndPoint.Intake.CountryListUrl
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          order: 'description'
        },
        CommonUrlConfig.EndPoint.Intake.dentalspecialtytype + '?filter'
      ),
    ]).pipe(
      map((result: any) => {
        result[3].forEach((type: any) => {
          this.specialty[type.dentalspecialtytypekey] = type.description;
        });
        return {
          ethinicities: result[0].map(
            (res: { typedescription: any; ethnicgrouptypekey: any; }) =>
              new DropdownModel({
                text: res.typedescription,
                value: res.ethnicgrouptypekey
              })
          ),
          states: result[1].map(
            (res: { statename: any; stateabbr: any; }) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          ),
          counties: result[2].map(
            (res: { countyname: any; }) =>
              new DropdownModel({
                text: res.countyname,
                value: res.countyname
              })
          ),
          specialty: result[3].map(
            (res: { description: any; dentalspecialtytypekey: any; }) =>
              new DropdownModel({
                text: res.description,
                value: res.dentalspecialtytypekey
              })
          ),
        };
      }),
      share(),);
    this.countyDropDownItems$ = source.pipe(pluck('counties'));
    this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.specialty$ = source.pipe(pluck('specialty'));
  }

  add() {
    this.persondentalinfo.push(this.dentalForm.getRawValue());
    this.health = this._dataStoreService.getData(this.constants.Health);
    this.health.persondentalinfo = this.persondentalinfo;
    this._dataStoreService.setData(this.constants.Health, this.health);
    this._alertSevice.success('Added Successfully');
    this.resetForm();
  }

  resetForm() {
    this.dentalForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.dentalForm.enable();
  }

  update() {
    if (this.modalInt !== -1) {
      this.persondentalinfo[this.modalInt] = this.dentalForm.getRawValue();
    }
    this.resetForm();
    this._alertSevice.success('Updated Successfully');
  }

  view(modal: any) {
    this.reportMode = 'edit';
    this.patchForm(modal);
    this.editMode = false;
    this.dentalForm.disable();
  }

  edit(modal: any, i: any) {
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.dentalForm.enable();
  }

  delete(index: any) {
    this.persondentalinfo.splice(index, 1);
    this._alertSevice.success('Deleted Successfully');
    this.resetForm();
  }

  cancel() {
    this.resetForm();
  }

  startDateChanged() {
    this.dentalForm.patchValue({enddate : ''});
    const empForm = this.dentalForm.getRawValue();
    this.maxDate = new Date(empForm.startdate);
  }
  endDateChanged() {
    this.dentalForm.patchValue({startdate : ''});
    const empForm = this.dentalForm.getRawValue();
    this.minDate = new Date(empForm.enddate);
  }
  private patchForm(modal: PersonDentalInfo) {
    this.dentalForm.patchValue(modal);
  }

}
