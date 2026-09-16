
import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { forkJoin ,  Observable } from 'rxjs';

import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import { ActivatedRoute } from '@angular/router';

export class PersonElimination
{
  infoprovidedby!: string;
  clientlist!: string;
  collaterallist!: string;
  infoprovidedname!: string;
  relationship!: string;
  eliminationinfounknown!: boolean;
  currentstatus!: string;
  toilettraining!: string;
  otherSpecify!: string;
  bowelmovement!: string;
  urination!: string;
  toiletcomments!: string;
  considerunknown!: string;
  specialcomments!: string;
}
@Component({
    selector: 'elimination',
    templateUrl: './elimination.component.html',
    styleUrls: ['./elimination.component.scss'],
    standalone: false
})
export class EliminationComponent implements OnInit {

  EliminationInfoForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
  modalInt!: number;
  eliminationcw: any[] = [];
  StatusList$!: Observable<DropdownModel[]>;
  TrainingList$!: Observable<DropdownModel[]>;
  isAddEdit = false;
  personId!: string;
  eliminationId!: string;
  selected = [];
  isClosed = false;
  deleteItem: any;
  deletepopupid = '#delete-popup';

  private formbuilder: FormBuilder;
  private _alertService: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _personInfoService: PersonInfoService;
  private _authService: AuthService;
  private route: ActivatedRoute;

  constructor(private injector : Injector){
    this.formbuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
  }

  ngOnInit() {
    this.personId =  this._personInfoService.getPersonId();
    this.reportMode = 'add';
    this.loadDropDowns();
    this.initForm();
    this.getEliminationInfoList();
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.eliminationsave');
    this.route.queryParams.subscribe(params => {
      const status = params['elimination'];
      if (status) {
        const elimination = JSON.parse(this._dataStoreService.getData('elimination-health-summary'));
        this.view(elimination);
      }
    });
   }

  resetForm() {
    this.EliminationInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.EliminationInfoForm.enable();
    this.selected =  [];
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = false;
    modal.infoprovidedname 		  = modal.v_providedname;
    modal.eliminationinfounknown= modal.v_iseliminationinfoknown;
    modal.currentstatus         = modal.v_elimination_currentstatus;
    modal.toilettraining        = modal.v_toilettrainingmethod;
    modal.otherSpecify        = modal.v_otherspecify;
    modal.bowelmovement         = modal.v_wordforbowelmovement;
    modal.urination             = modal.v_wordforurination;
    modal.toiletcomments        = modal.v_toiletcomments;
    modal.specialcomments       = modal.v_specialcomments;
    modal.considerunknown       = modal.v_considerunknown;
    this.eliminationId          = modal.v_personhltheliminationid;
    this.selected =  modal.v_toilettrainingmethod;
    this.patchForm(modal);
    this.EliminationInfoForm.disable();
  }

  edit(modal: any, i: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    modal.infoprovidedname 		  = modal.v_providedname;
    modal.eliminationinfounknown= modal.v_iseliminationinfoknown;
    modal.currentstatus         = modal.v_elimination_currentstatus;
    modal.toilettraining        = modal.v_toilettrainingmethod;
    modal.otherSpecify        = modal.v_otherspecify;
    modal.bowelmovement         = modal.v_wordforbowelmovement;
    modal.urination             = modal.v_wordforurination;
    modal.toiletcomments        = modal.v_toiletcomments;
    modal.specialcomments       = modal.v_specialcomments;
    modal.considerunknown       = modal.v_considerunknown;
    this.eliminationId          = modal.v_personhltheliminationid;
    this.patchForm(modal);
    this.selected =  modal.v_toilettrainingmethod;
    this.EliminationInfoForm.enable();
  }

  public delete() {
    const modal = this.deleteItem;
    
    const data = {
      'personhltheliminationid': modal.v_personhltheliminationid,
    };
    this._healthService.saveHealth({ 'personElimination': [data] }, 2).subscribe(_ => {
      this._alertService.success('Elimination Info Deleted Successfully');
        this.resetForm();
        this.getEliminationInfoList();
        (<any>$(this.deletepopupid)).modal('hide');
        this.deleteItem = null;
        
      });
  }

  cancel() {
    this.resetForm();
    if(this.isClosed) {
      window.scrollTo(0,0);
      this.isAddEdit = false;
    }
  }

  private patchForm(modal: PersonElimination) {
    this.EliminationInfoForm.patchValue(modal);
  }

  update() {
    if (this.EliminationInfoForm.invalid) {
      this.EliminationInfoForm.markAllAsTouched();
      return;
    }
    const modal = this.EliminationInfoForm.getRawValue();
    modal.personhltheliminationid = this.eliminationId;
    this._healthService.saveHealth({ 'personElimination': [modal] }, 0).subscribe(response => {
      this._alertService.success('Elimination Info Updated Successfully');
      this.getEliminationInfoList();
    });
    this.resetForm();
  }

  add() {
    if (this.EliminationInfoForm.invalid) {
      this.EliminationInfoForm.markAllAsTouched();
      return;
    }
    const eliminateinfo = this.EliminationInfoForm.getRawValue();
    this._healthService.saveHealth({ 'personElimination': [eliminateinfo] }, 1).subscribe(response => {
      this._alertService.success('Elimination Info Added Successfully');
      this.getEliminationInfoList();
    });
    this.resetForm();
  }

  initForm() {
    this.reportMode = 'add';
    this.EliminationInfoForm = this.formbuilder.group({
      infoprovidedname: ['', Validators.required],
      eliminationinfounknown: false,
      currentstatus: '',
      toilettraining: '',
      otherSpecify: '',
      bowelmovement: '',
      urination: '',
      toiletcomments: '',
      considerunknown: false,
      specialcomments: ''
    });
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '59', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '342', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )]).pipe(
      map((result) => {
        return {
          StatusList: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          ),
          TrainingList: result[1].map(
            (res) =>    //  NOSONAR   //  This function has identical code of less than 3 lines. Hence, marking it as no sonar.
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          )
        };
      }),
      share(),);
    this.StatusList$ = source.pipe(pluck('StatusList'));
    this.TrainingList$ = source.pipe(pluck('TrainingList'));
  }

  addEliminationnfo() {
    this.isAddEdit = true;
  }

  getEliminationInfoList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId}
    }, 'personfamilyinfo/getpersonelimination?filter').subscribe(res => {
      this.eliminationcw = res ? res.data : [];
    });
  }

  getCurrentStatus(data: any) {
    if (data && Array.isArray(data)) {
      return data.join(',');
    }
    return '';
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
    (<any>$(this.deletepopupid)).modal('show');
  }
}
