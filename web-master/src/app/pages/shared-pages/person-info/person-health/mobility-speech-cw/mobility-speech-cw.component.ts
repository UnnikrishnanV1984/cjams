
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { forkJoin ,  Observable } from 'rxjs';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import { ActivatedRoute } from '@angular/router';

export class MobilitySpeech {
  infoprovidedby!: string;
  clientlist!: string;
  Collaterallist!: string;
  infoprovidedname!: string;
  relationship!: string;
  mobspeechinfounknown!: boolean;
  speechvalue!: string;
  mobilityvalue!: string;
  childsatup!: string;
  childwalked!: string;
  childtalked!: string;
  comments!: string;
  ishousehold!: boolean;
  iscollateral!: boolean;
  
}
@Component({
    selector: 'mobility-speech-cw',
    templateUrl: './mobility-speech-cw.component.html',
    styleUrls: ['./mobility-speech-cw.component.scss'],
    standalone: false
})
export class MobilitySpeechCwComponent implements OnInit {

  mobilitySpeechInfoForm!: FormGroup;
  SpeechList$!: Observable<DropdownModel[]>;
  MobilityList$!: Observable<DropdownModel[]>;
  prenatalCareDropdownItems$!: Observable<DropdownModel[]>;
  editMode!: boolean;
  mandatoryField!: boolean;
  reportMode!: string;
  modalInt!: number;
  speechcw: any[] = [];
  personId!: string;
  isAddEdit = false;
  isClosed = false;

  selectedMobilitySpeech: any;

  private formbuilder: FormBuilder; 
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _personInfoService: PersonInfoService;
  private _authService: AuthService;
  private route: ActivatedRoute;

  constructor(private injector: Injector){
    this.formbuilder = this.injector.get<FormBuilder>(FormBuilder); 
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    }

  ngOnInit() {
    this.reportMode = 'add';
    this.personId = this._personInfoService.getPersonId();
    this.mobilitySpeechInfoForm = this.formbuilder.group({
      personhlthmobilityspeechid: [null],
      ishousehold: ['', Validators.required],
      provided_name: ['', Validators.required],
      relationship: ['', Validators.required],
      ismbltyspchknown: false,
      satupage: '',
      walkedage: '',
      talkedage: '',
      comments: ''
    });
    this.loadDropDowns();
    this.getSpeechInfoList();
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person','person.Health.mobilityadd');
    this.route.queryParams.subscribe(params => {
      const status = params['mobility'];
      if (status) {
        const mobility = JSON.parse(this._dataStoreService.getData('mobility-health-summary'));
        this.view(mobility);
      }
    });
  }
  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '341', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '340', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.RelationshipTypesUrl + '?filter')]).pipe(
      map((result) => {
        return {
          SpeechList: result[0].map(
            (res) =>
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          ),
          MobilityList: result[1].map(
            (res) =>          //  NOSONAR   // This function is having identical lines of code less than 3 lines. Hence, marking it as no sonar.
              new DropdownModel({
                text: res.description_tx,
                value: res.value_tx
              })
          ),
          prenatalCareList: result[2].map(
            (res) =>
              new DropdownModel({
                text: res.description,
                value: res.relationshiptypekey
              })
          )
        };
      }),
      share(),);
    this.SpeechList$ = source.pipe(pluck('SpeechList'));
    this.MobilityList$ = source.pipe(pluck('MobilityList'));
    this.prenatalCareDropdownItems$ = source.pipe(pluck('prenatalCareList'));

  }
  private resetForm() {
    this.mobilitySpeechInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.isAddEdit = false;
    this.mobilitySpeechInfoForm.enable();
  }

  view(modal: any) {
    this.reportMode = 'edit';
    this.patchForm(modal);
    this.editMode = false;
    this.isAddEdit = true;
    this.mobilitySpeechInfoForm.disable();
  }

  edit(modal: any, i: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.mobilitySpeechInfoForm.enable();
  }

    delete() {
    if (this.selectedMobilitySpeech) {
      const data = {personhlthmobilityspeechid: this.selectedMobilitySpeech.personhlthmobilityspeechid };
      this._healthService.saveHealth({ 'mobilitySpeechInfo': [data] }, 2).subscribe(response => {
        this._alertSevice.success('Mobility/Speech Information Deleted Successfully');
        this.getSpeechInfoList();
      });
    }

  }

  cancel() {
    this.resetForm();
    if(this.isClosed) {
      window.scrollTo(0,0);
      this.isAddEdit = false;
    }
  }

  private patchForm(modal: MobilitySpeech) {

    this.mobilitySpeechInfoForm.patchValue(modal);
    let houseHoldOrColatral = null;
    if (modal.ishousehold) {
      houseHoldOrColatral = 1;
    }
    if (modal.iscollateral) {
      houseHoldOrColatral = 2;
    }
    this.mobilitySpeechInfoForm.patchValue({ ishousehold: houseHoldOrColatral });
  }
  getValidationMessage(controlName: any,displayname: any){
 
    if(this.mobilitySpeechInfoForm.controls[controlName].status == 'INVALID' )
    {
        return 'Please  '+displayname;
    }}
  add() {
    this.mandatoryField=true;
    if(this.mobilitySpeechInfoForm.invalid ){
      return;
    }
    const speechinfo = this.mobilitySpeechInfoForm.getRawValue();

    speechinfo.iscollateral = (speechinfo.ishousehold === 2) ? true : false;
    speechinfo.ishousehold = (speechinfo.ishousehold === 1) ? true : false;
    let isNew = 1;
    if (speechinfo.personhlthmobilityspeechid) {
      isNew = 0;
    }
    this._healthService.saveHealth({ 'mobilitySpeechInfo': [speechinfo] }, isNew).subscribe(response => {
      this._alertSevice.success('Mobility/Speech Information Added Successfully');
      this.getSpeechInfoList();
    });
    this.resetForm();
  }

  update() {
    this.mandatoryField=true;
    if(this.mobilitySpeechInfoForm.invalid ){
      return;
    }
    const speechinfo = this.mobilitySpeechInfoForm.getRawValue();
    speechinfo.iscollateral = (speechinfo.ishousehold === 2) ? true : false;
    speechinfo.ishousehold = (speechinfo.ishousehold === 1) ? true : false;
    let isNew = 1;
    if (speechinfo.personhlthmobilityspeechid) {
      isNew = 0;
    }
    this._healthService.saveHealth({ 'mobilitySpeechInfo': [speechinfo] }, isNew).subscribe(response => {
      this._alertSevice.success('Mobility/Speech Information Updated Successfully');
      this.getSpeechInfoList();
    });
    this.resetForm();
  }

  getSpeechInfoList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId }
    }, 'personfamilyinfo/getpersonmobility?filter').subscribe(res => {
      this.speechcw = res ? res.data : [];
    });
  }

  addSpeechInfo() {
    this.isAddEdit = true;
  }

  deleteConfirm(item: any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedMobilitySpeech = item;
  }
}
