
import { pluck, share, map } from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { forkJoin, Observable } from 'rxjs';
import { Under5Info, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService } from '../../../../../@core/services/alert.service';
import { DataStoreService, CommonHttpService, CommonDropdownsService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'under-5years-cw',
    templateUrl: './under-5years-cw.component.html',
    styleUrls: ['./under-5years-cw.component.scss'],
    standalone: false
})
export class Under5yearsCwComponent implements OnInit {

  under5yearsInfoForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
  modalInt!: number;
  under5Infocw: Under5Info[] = [];
  health: Health = {};
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  prenatalCareDropdownItems$!: Observable<DropdownModel[]>;
  gestationDropdownItems$!: Observable<DropdownModel[]>;
  deliveryTypeDropdownItems$!: Observable<DropdownModel[]>;
  complicationTypeDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  whenBegunItems$!: Observable<DropdownModel[]>;
  parityItems$!: Observable<DropdownModel[]>;

  address = { address1: null, address2: null, city: null, state: null, zipcode: null };

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _healthService: PersonHealthService,
    private _commonDropdownService: CommonDropdownsService
  ) {

  }


  ngOnInit() {
    this.reportMode = 'add';
    this.loadDropDown();
    this.under5yearsInfoForm = this.formbulider.group({
      parentcare: '',
      gestation: '',
      deliveryType: '',
      comments: '',
      whenbegun: null,
      parity: null,
      prenatalproblem: null,
      prenatalproblemspecify: null,
      hospitalcomments: '',
      complications: '',
      childbornin: '',
      speciality: '',
      phone: '',
      email: ''
    });
  }

  resetForm() {

    this.under5yearsInfoForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.under5yearsInfoForm.enable();

  }


  view(modal: any) {
    this.reportMode = 'edit';
    this.patchForm(modal);
    this.editMode = false;
    this.under5yearsInfoForm.disable();
  }

  edit(modal: any, i: any) {
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.under5yearsInfoForm.enable();
  }

  delete(index: any) {
    this.under5Infocw.splice(index, 1);
    this._alertSevice.success('Deleted Successfully');
    this.resetForm();
  }

  cancel() {
    this.resetForm();
  }

  patchForm(modal: Under5Info) {
    this.under5yearsInfoForm.patchValue(modal);
  }

  add() {
    this.under5Infocw.push(this.under5yearsInfoForm.getRawValue());
    this.health = this._dataStoreService.getData(this.constants.Health);
    this.health.personUnder5Info = this.under5Infocw;
    this._dataStoreService.setData(this.constants.Health, this.health);
    const data = { ...this.under5yearsInfoForm.getRawValue(), ...this.address };
    this._healthService.saveHealth({ 'personHealthUnder5Years': [data] }).subscribe(_ => {
      this._alertSevice.success('Added Successfully');
      this.resetForm();
    });
  }

  update() {
    if (this.modalInt !== -1) {
      this.under5Infocw[this.modalInt] = this.under5yearsInfoForm.getRawValue();
    }
    this.resetForm();
    this._alertSevice.success('Updated Successfully');
  }

  loadDropDown() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '151' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '90' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '337' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '53' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      ),
      this._commonHttpService.create(
        {
          nolimit: true,
          order: 'countyname asc'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
      ),
      this._commonDropdownService.getDropownsByTable('whenbegun'),
      this._commonDropdownService.getDropownsByTable('parity'),
    ]).pipe(
      map((result: any) => {
        return {
          prenatalCareList: this.createDropDown(result[0],1),
          gestationList: this.createDropDown(result[1],1),
          deliveryTypeList: this.createDropDown(result[2],1),
          complicationTypeList: this.createDropDown(result[4],1),
          states: result[4].map(
            (res: { statename: any; stateabbr: any; }) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          ),
          counties: result[5].map(
            (res: { countyname: any; }) =>
              new DropdownModel({
                text: res.countyname,
                value: res.countyname
              })
          ),
          whenbegun:  this.createDropDown(result[6],2),
          parity: this.createDropDown(result[7],2)
        };
      }),
      share());
    this.prenatalCareDropdownItems$ = source.pipe(pluck('prenatalCareList'));
    this.gestationDropdownItems$ = source.pipe(pluck('gestationList'));
    this.deliveryTypeDropdownItems$ = source.pipe(pluck('deliveryTypeList'));
    this.complicationTypeDropdownItems$ = source.pipe(pluck('complicationTypeList'));
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.countyDropDownItems$ = source.pipe(pluck('counties'));
    this.whenBegunItems$ = source.pipe(pluck('whenbegun'));
    this.parityItems$ = source.pipe(pluck('parity'));
  }

  createDropDown(result: any, type: any) {
    let dropDownModel;
    if (type == 1) {
      dropDownModel = result.map(
        (res: { description_tx: any; picklist_value_cd: any; }) =>
          new DropdownModel({
            text: res.description_tx,
            value: res.picklist_value_cd
          })
      )
    } else if (type == 2) {
      dropDownModel = result.map(
        (res: { description: any; }) =>
          new DropdownModel({
            text: res.description,
            value: res.description
          })
      )
    }
    return dropDownModel;
  }
}