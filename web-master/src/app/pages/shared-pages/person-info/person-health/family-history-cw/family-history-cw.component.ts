
import {map, share, pluck} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService, AuthService } from '../../../../../@core/services';
import { forkJoin ,  Observable } from 'rxjs';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { FamilyHistory, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { PersonHealthService } from '../person-health.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import { InvolvedPersonsService } from '../../../involved-persons/involved-persons.service';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

declare let $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'family-history-cw',
    templateUrl: './family-history-cw.component.html',
    styleUrls: ['./family-history-cw.component.scss'],
    standalone: false
})
export class FamilyHistoryCwComponent implements OnInit {
  familyHistoryForm!: FormGroup;
  editMode!: boolean;
  reportMode!: string;
  modalInt!: number;
  familyHistorycw: FamilyHistory[] = [];
  health: Health = {};
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  relationshipTypeDropdownItems$!: Observable<DropdownModel[]>;
  deathCauseTypeDropdownItems$!: Observable<DropdownModel[]>;
  infoclienttypekeyDropdownItems$!: Observable<DropdownModel[]>;
  id!: string;
  personRoles : Array<any> = [];
  isAddEdit = false;
  involevedPerson$: any;
  majorHealthProblem$!: Observable<DropdownModel[]>;
  teamTypeKey: any;
  personId!: string;
  uploadedFiles = [];
  uploadNumber = '123434';
  selectedItem: any;
  personfmlymdclhstryid!: string;
  load:boolean = false;
  checkmandatory :boolean =false;
  isClosed = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;

  private _formBuilder: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  public _personInfoService: PersonInfoService;
  private _involvedPersonService: InvolvedPersonsService;
  public _authService: AuthService;
  private route: ActivatedRoute;
  retrydoc: any = false;
  personfmlymdclCheck: any;
  personfmlymdclid: any;

  constructor(private injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._involvedPersonService = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.personfmlymdclid = params['retryid'];
    });
    
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this.personId = this._personInfoService.getPersonId();
    this.teamTypeKey = this._authService.getAgencyName();
    this.reportMode = 'add';
    this.loadDropDowns();
    this.getInvolvedPerson();
    this.initForm();
    this.getFamilyHistoryList();
    this.route.queryParams.subscribe(params => {
      const status = params['familyHistory'];
      if (status) {
        const familyHistory = JSON.parse(this._dataStoreService.getData('familyHistory-health-summary'));
        this.view(familyHistory);
      }
    });
  }

  uploadclosed(event: any){
    if(event){
    this.documentuploaded.closeupload();
    this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }
  

  initForm() {
    this.familyHistoryForm = this._formBuilder.group({
      personfmlymdcl_hstryid: null,
      clientlist: ['', [Validators.required]],
      major_health_problems: ['', [Validators.required]],
      cause_of_death: [''],
      comments: ''
    });
    if (this.isClosed || !this._authService.isPersonSubTabViewable('person','person.Health.familyhistoryadd')) {
      this.familyHistoryForm.disable();
    }
  }

    resetForm() {
    this.familyHistoryForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.modalInt = -1;
    this.familyHistoryForm.enable();
    this.uploadedFiles = [];
    this.isAddEdit = false;
  }

  view(modal: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    const data = Object.create(modal);
    data.comments = modal.comments;
    data.clientlist = modal.clientlist;
    data.personid = modal.personid;
    data.relationship = modal.relationship;
    data.major_health_problems = (data.major_health_problems && data.major_health_problems.length) ? data.major_health_problems.map((healthData: { ref_key: any; }) => healthData.ref_key) : [];
    data.cause_of_death = (data.cause_of_death) ? data.cause_of_death.picklist_value_cd : '';
    this.uploadedFiles = data.uploadpath ? data.uploadpath : [];
    this.patchForm(data);
    this.editMode = false;
    this.familyHistoryForm.disable();
  }

  edit(modal: any, i?: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    const data = Object.create(modal);
    data.comments = modal.comments;
    data.clientlist = modal.clientlist;
    this.personfmlymdclhstryid = data.personfmlymdcl_hstryid;
    data.personid = modal.personid;
    data.relationship = modal.relationship;
    data.major_health_problems = (data.major_health_problems && data.major_health_problems.length) ? data.major_health_problems.map((healthData: { ref_key: any; }) => healthData.ref_key) : [];
    data.cause_of_death = (data.cause_of_death) ? data.cause_of_death.picklist_value_cd : '';
    this.uploadedFiles = data.uploadpath ? data.uploadpath : [];
    this.patchForm(data);
    this.familyHistoryForm.enable();
  }



  cancel() {
    this.resetForm();
  }

  patchForm(modal: FamilyHistory) {
    this.familyHistoryForm.patchValue(modal);
  }

  add() {
    this.checkmandatory =true;
    if (this.familyHistoryForm.valid){
    const uploadInfo: any = {};
    uploadInfo['uploadpath'] = this.uploadedFiles;
    const data = { ...this.familyHistoryForm.getRawValue(), ...uploadInfo };

    if (data.uploadpath) {
      data.uploadpath.forEach((document: { percentage: any; }) => {
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }
    let isNew = 1;
    let message = 'Family History Added Successfully';
    if (this.editMode) {
      isNew = 0;
      message = 'Family History Updated Successfully';
    }
    data.personfmlymdcl_hstryid = this.personfmlymdclhstryid;
    data.major_health_problems = (data.major_health_problems.length) ? data.major_health_problems.join(', ') : null;
    this._healthService.saveHealth({ 'personfamilyHistroy': [data] }, isNew).subscribe(response => {
      this._alertSevice.success(message);
      this.getFamilyHistoryList();
    });
    this.resetForm();
  } else{
    this._alertSevice.error('Pleas fill all the required fields');

  }

  }

  update() {
    if (this.modalInt !== -1) {
      this.familyHistorycw[this.modalInt] = this.familyHistoryForm.getRawValue();
    }
    this.resetForm();
    this._alertSevice.success('Updated Successfully');
  }

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { activeflag: 1 }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.RelationshipTypesUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '34', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService
        .getArrayList(
          {
            where: { "tablename": "majorhealthprob", "teamtypekey": this.teamTypeKey },
            method: 'get'
          },
          'referencetype/gettypes' + '?filter'
        )
    ]).pipe(map((result) => {
      return {
        relationshipTypeList: result[0].map(
          (res) =>
            new DropdownModel({
              text: res.description,
              value: res.relationshiptypekey
            })
        ),
        deathCauseTypeList: result[1].map(
          (res) =>
            new DropdownModel({
              text: res.description_tx,
              value: res.picklist_value_cd
            })
        ),
        majorHealthProblem: result[2].map(
          (res) =>
            new DropdownModel({
              text: res.description,
              value: res.ref_key
            })
        )
      };
    }),
      share(),);
    this.relationshipTypeDropdownItems$ = source.pipe(pluck('relationshipTypeList'));
    this.deathCauseTypeDropdownItems$ = source.pipe(pluck('deathCauseTypeList'));
    this.majorHealthProblem$ = source.pipe(pluck('majorHealthProblem'));
  }

  private getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    forkJoin([
      this._commonHttpService
        .getPagedArrayList(
          {
            where: this._involvedPersonService.getRequestParam(),
            page: 1,
            limit: 20,
            method: 'get'
          },
          url + '?filter'
        )]).subscribe((result) => {
          if (result[0].data) {
            this.personRoles = [];
            result[0].data.forEach((list: any) => {
              return this.personRoles.push({
                intakeservicerequestactorid: list.intakeservicerequestactorid,
                displayname: list.firstname + ' ' + list.lastname,
                personname: list.firstname + ' ' + list.lastname,
                role: list.roles, 
                dob: list.dob,
                userroles: list.userroles,
                cjamspid: list.cjamspid
              });
            });
          }
        });
  }

  addFamilyHistory() {
    this.isAddEdit = true;
  }

  getFamilyHistoryList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId }
    }, 'personfamilyinfo/getpersonfamilyhistory?filter').subscribe(res => {
      this.familyHistorycw = res ? res.data : [];
       this.personfmlymdclCheck = (this.familyHistorycw as any[]).find(item => item.personfmlymdcl_hstryid === this.personfmlymdclid);
          if (this.personfmlymdclCheck && this.personfmlymdclid) {
              this.edit(this.personfmlymdclCheck);
              this.personfmlymdclid = null;
          }
    });
  }

  displayMajorHealthProblems(healthProblems: any) {
    if (healthProblems && healthProblems.length > 0) {
      return healthProblems.map((data: { description: any; }) => data.description).join(",");
    }
    return '';
  }

  deleteConfirm(item: any, index: any) {
    $('#delete-popup').modal('show');
    this.selectedItem = item;
  }

  delete() {
    const data = {
      'personfmlymdcl_hstryid': this.selectedItem.personfmlymdcl_hstryid,
    };
    this._healthService.saveHealth({ 'personfamilyHistroy': [data] }, 2).subscribe(_ => {
      this._alertSevice.success('Family History Deleted Successfully');
      this.resetForm();
      this.getFamilyHistoryList();
    });
  }

}
