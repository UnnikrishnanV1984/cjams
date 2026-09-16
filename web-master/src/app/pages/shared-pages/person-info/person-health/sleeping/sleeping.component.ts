
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { forkJoin ,  Observable } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import { ActivatedRoute } from '@angular/router';
import moment from 'moment';

export class Sleeping {
  infoprovidedby!: string;
  clientlist!: string;
  collaterallist!: string;
  infoprovidedname!: string;
  relationship!: string;
  sleepinginfounknown!: boolean;
  sleepingenvironment!: string;
  sleepingproblems!: string;
  sleepingposition!: string;
  naptime!: string;
  bedtime!: string;
  sleepcomments!: string;
  sleepingschedule_naptime!: string;
  sleepingschedule_bedtime!: string;
}

declare let $ : any;

@Component({
    selector: 'sleeping',
    templateUrl: './sleeping.component.html',
    styleUrls: ['./sleeping.component.scss'],
    standalone: false
})

export class SleepingComponent implements OnInit {
  SleepingInfoForm!: FormGroup;
  SleepEnvironment$!: Observable<DropdownModel[]>;
  SleepPosition$!: Observable<DropdownModel[]>;
  SleepProblem$!: Observable<DropdownModel[]>;
  reportMode!: string;
  editMode!: boolean;
  modalInt!: number;
  sleepcw: any[] = [];
  isAddEdit = false;
  personId!: string;
  sleepingId!: boolean;
  selected = [];
  otherSpecify!: string;
  isClosed = false;
  deleteItem: any;
  deletepopupid = '#delete-popup';

  private formbuilder: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _authService: AuthService;
  private _personInfoService: PersonInfoService;
  private route: ActivatedRoute;

  constructor(private injector : Injector){
    this.formbuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
 }

  ngOnInit() {
    this.personId =  this._personInfoService.getPersonId();
    this.reportMode = 'add';
    this.SleepingInfoForm = this.formbuilder.group({
      ishousehold: null,
      provided_name: ['', Validators.required],
      relationship: '',
      issleepinginfoknown: false,
      sleepingenvironment: '',
      sleepingproblems: '',
      sleepingposition: '',
      otherSpecify: '',
      sleepingschedule_naptime: [null],
      sleepingschedule_bedtime: [null],
      comments: ''
    });
    this.loadDropDowns();
    this.getSleepingInfoList();
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.sleepingadd');
    this.route.queryParams.subscribe(params => {
      const status = params['sleeping'];
      if (status) {
        const sleeping = JSON.parse(this._dataStoreService.getData('sleeping-health-summary'));
        this.view(sleeping);
      }
    });
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '200', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '201', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '152', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )]).pipe(
      map((result) => {
        return {
          SleepEnvironmentList: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          ),
          SleepPositionList: result[1].map(
            (res) =>
              new DropdownModel({
                text: res.description_tx,
                value: res.picklist_value_cd
              })
          ),
          SleepProblemList: result[2].map(
            (res) =>            //  NOSONAR   // This function has less than 3 lines of identicial code. Hence, marking it as no sonar.
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          )
            };
          }),
          share(),);
      this.SleepEnvironment$ = source.pipe(pluck('SleepEnvironmentList'));
      this.SleepPosition$ = source.pipe(pluck('SleepPositionList'));
      this.SleepProblem$ = source.pipe(pluck('SleepProblemList'));
  }

  resetForm() {
    this.SleepingInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.SleepingInfoForm.enable();
    this.selected =  [];
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    modal.provided_name = modal.providedname;
    modal.otherSpecify   = modal.otherspecify;
    this.selected =  modal.sleepingproblems;
    this.patchForm(modal);
    this.editMode = false;    
    this.SleepingInfoForm.disable();
  }

  edit(modal: any, i: any) {
    this.sleepingId = modal.personhlthsleepingid;
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    modal.provided_name = modal.providedname;
    modal.otherSpecify = modal.otherspecify;    
    this.patchForm(modal);
    this.selected =  modal.sleepingproblems;    
    this.SleepingInfoForm.enable();
  }

  delete() {
    const modal = this.deleteItem;

    const data = {
      'personhlthsleepingid': modal.personhlthsleepingid,
    };
    this._healthService.saveHealth({ 'sleepingInfo': [data] }, 2).subscribe(_ => {
        this._alertSevice.success('Sleeping Info Deleted Successfully');
        this.resetForm();
        this.getSleepingInfoList();
       $(this.deletepopupid).modal('hide');
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

  private patchForm(modal: Sleeping) {
    this.SleepingInfoForm.patchValue(modal);
    this.SleepingInfoForm.patchValue({sleepingschedule_naptime: modal.sleepingschedule_naptime ? moment(modal.sleepingschedule_naptime, 'HH:mm') : null, sleepingschedule_bedtime: modal.sleepingschedule_bedtime ? moment(modal.sleepingschedule_bedtime, 'HH:mm') : null});
  }

  add() {
    if (this.SleepingInfoForm.invalid) {
      this.SleepingInfoForm.markAllAsTouched();
      return;
    }
    const sleepinginfo = this.SleepingInfoForm.getRawValue();
    this.getbedandnaptime(sleepinginfo);
    
    this._healthService.saveHealth({ 'sleepingInfo': [sleepinginfo]}).subscribe(response => {
      this._alertSevice.success('Sleeping Info Added Successfully');
      this.isAddEdit = false;
      this.getSleepingInfoList();
    });
    this.resetForm();
  }

  update() {
    if (this.SleepingInfoForm.invalid) {
      this.SleepingInfoForm.markAllAsTouched();
      return;
    }
    const sleepinginfo = this.SleepingInfoForm.getRawValue();
    this.getbedandnaptime(sleepinginfo);
    sleepinginfo.personhlthsleepingid = this.sleepingId;
    this._healthService.saveHealth({ 'sleepingInfo': [sleepinginfo] }, 0).subscribe(response => {
      this._alertSevice.success('Sleeping Info Updated Successfully');
      this.isAddEdit = false;
      this.getSleepingInfoList();
    });
    this.resetForm();
  }

  getbedandnaptime(sleepinginfo: any) {
    if (sleepinginfo?.sleepingschedule_naptime) {
      const formattedTime = moment(this.SleepingInfoForm.getRawValue().sleepingschedule_naptime, "HH:mm").format("YYYY-MM-DD HH:mm:ss");
    
      sleepinginfo.sleepingschedule_naptime = formattedTime;
    }

    if (sleepinginfo?.sleepingschedule_bedtime) {
      const formattedTime = moment(this.SleepingInfoForm.getRawValue().sleepingschedule_bedtime, "HH:mm").format("YYYY-MM-DD HH:mm:ss");
    
      sleepinginfo.sleepingschedule_bedtime = formattedTime;
    }
  }

  getSleepingInfoList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId}
    }, 'personfamilyinfo/getpersonsleeping?filter').subscribe(res => {
      this.sleepcw = res ? res.data : [];
    });
  } 

  addSleepingInfo() {
    this.isAddEdit = true;
  }

  getEnvironment(environment: any) {
    if (environment && Array.isArray(environment)) {
      return environment.join(',');
    } 
    return '';
  }

  getProblems(problems: any) {
    if (problems && Array.isArray(problems)) {
      return problems.join(',');
    }
    return '';
  }
  declineDelete() {
   $(this.deletepopupid).modal('hide');
  }
  confirmDelete(modal: any){
    this.deleteItem = modal;
   $(this.deletepopupid).modal('show');
  }
}