
import {pluck, share, map} from 'rxjs/operators';
import { ChangeDetectionStrategy, ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { DropdownModel, DynamicObject } from '../../../../../@core/entities/common.entities';
import { Validators, FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { DataStoreService, AuthService, AlertService, CommonHttpService, SessionStorageService } from '../../../../../@core/services';
import { Observable } from 'rxjs';
import { InvolvedPersonsService } from '../../../../shared-pages/involved-persons/involved-persons.service';
import { InvolvedPerson } from '../../../../../@core/common/models/involvedperson.data.model';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import _ from 'lodash';
import { CourtResolverService } from '../court-resolver-service';
declare var $: any;

@Component({
    selector: 'legal-custody',
    templateUrl: './legal-custody.component.html',
    styleUrls: ['./legal-custody.component.scss'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    standalone: false
})
export class LegalCustodyComponent implements OnInit {

  caseid: string;
  involvedYouth!: string;
  addEditLabel!: string;
  updateButton!: boolean;
  involvedPersons: InvolvedPerson[] = [];
  intakeservicerequestpetitionactors: any[] = [];
  legalForm!: FormGroup;
  legalCustodyDropdownItems$!: Observable<DropdownModel[]>;
  permanencyPlanId: any;
  private id: string;
  private store: DynamicObject;
  private daNumber: string;
  childActorId!: string;
  personId!: string;
  involevedPerson$!: Observable<InvolvedPerson[]>;
  involvedPersonList: InvolvedPerson[] = [];
  personList: InvolvedPerson[] = [];
  legalPerson: InvolvedPerson[] = [];
  legalCustodyDetails: any[] = [];
  addDisable!: boolean;
  viewDate!: boolean;
  minDate!: Date;
  selectChild!: boolean;
  isClosed = false;
  deleteLegalCustodyId!: string;
  isDeleteDisabled = false;
  isEditDisabled = false;
  isReadonly: boolean = false;
  displayValidationMessages: boolean = false;
  iscaseexpunged: any = 0;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _formBuilder: FormBuilder;
  private readonly _alertService: AlertService;
  public readonly _authService: AuthService;
  private readonly _store: DataStoreService;
  private readonly _router: Router;
  private readonly _service: InvolvedPersonsService;
  private readonly storage: SessionStorageService;
  private readonly _dataStoreService: DataStoreService;
  public cdr: ChangeDetectorRef;

  constructor(
    private injector: Injector,
    private readonly _courtResolverService: CourtResolverService
     // private _PlacementAdoptionService: PlacementAdoptionService
  ) {
      
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._store = this.injector.get<DataStoreService>(DataStoreService);
    this._router = this.injector.get<Router>(Router);
    this._service = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.caseid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.store = this._store.getCurrentStore();
    this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
  }

  ngOnInit() {
    this.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
      this.isDeleteDisabled = this._authService.isDisabled('court','court.legalcustody.delete');
      this.isEditDisabled = this._authService.isDisabled('court','court.legalcustody.edit');
      this.selectChild = false;
      this.legalCustodyDetails = [];
      this.addEditLabel = 'Add';
      this.legalForm = this._formBuilder.group({
          intakeservicerequestactorid: [''],
          fromdate: ['', [Validators.required]],
          todate: [''],
          relationship: [''],
          Address: [''],
          phonenumber: [''],
          workphone: [''],
          code: [''],
          reason: [''],
          legalcustodytypekey: ['', [Validators.required]],
          legalcustodyid: [null],
          permanencyplanid: [null]
      });
      this.addDisable = true;
      this.getLegalCustodyDropdown();
      this.disableFieldOnInit();
      this.loadPersons();
      this.isClosed = this._authService.iscaseclosed('legalcustody');
      const activeModuleRole = this.storage.getItem('activeModuleRole');
        if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
          this.isReadonly = false;
        } else {
          this.isReadonly =  this._authService.readonlyButton('read_only_access','caseworker-legal-custody-add');
        }
  }
  private getLegalCustodyDropdown() {
    this.legalCustodyDropdownItems$ = this._commonHttpService
        .getArrayList(
            {
                where: {
                    referencetypeid: '28',
                    teamtypekey: null
                },
                method: 'get',
                nolimit: true
            },
            'referencetype/gettypes' + '?filter'
        ).pipe(
        map(result => {
            return result.map(
                res =>
                    new DropdownModel({
                        text: res.description,
                        value: res.ref_key
                    })
            );
        }));
}

  beginDateChange(form: any) {
    this.minDate = new Date(form.value.fromdate);
    form.get('todate').reset();
  }

  addLegalCustody(type: any, item?: any) {
    this.viewDate = false;
    if (type === 'add') {
        this.addEditLabel = 'Add';
        this.legalForm.patchValue({ legalcustodyid: null });
        this.legalForm.enable();
        this.disableFieldOnInit();
        this.legalForm.reset();
    } else {
        this.legalForm.patchValue(item);
        this.changePerson(item.intakeservicerequestactorid, item.personid);
        if (type === 'view') {
            this.addEditLabel = 'View';
            this.viewDate = true;
            this.updateButton = true;
            this.legalForm.disable();
        } else if (type === 'edit') {
            this.addEditLabel = 'Update';
            this.updateButton = true;
            this.legalForm.enable();
            this.disableFieldOnInit();
        }
    }
    $('#addlegalcustody').modal('show');
}
cancelAdoption() {
  this.legalForm.reset();
  this.updateButton = false;
  this.addEditLabel = 'Add';
}

  loadPersons() {
    this.personList = [];
    this.legalPerson = [];
    this.involevedPerson$ = this._service.getInvolvedPerson(1, 100).pipe(
      share(),
      pluck('data'),);
    this.involevedPerson$.subscribe(response => {
        if (response && response.length) {
          this.checkPersons(response);
          }
          });
  }

  checkPersons(response: any) {
    response.map((item: any) => {
      if (!item.rolename || item.rolename === '') {
        if (item.roles && item.roles.length && item.roles[0].intakeservicerequestpersontypekey) {
          item.roles.map((role: any) => {
            if (role.intakeservicerequestpersontypekey === 'AV' || role.intakeservicerequestpersontypekey === 'CHILD') {
              item.rolename = role.intakeservicerequestpersontypekey;
              item.intakeservicerequestactorid = role.intakeservicerequestactorid;
            }
          });
        }
      }
      // CDM-2352
      this.handlePersonsListFn(item);
    });
    this.cdr.markForCheck();
  }
  // Assosiated with checkPersons method
  private handlePersonsListFn(item: any) {
      if (item.rolename && (item.rolename === 'AV' || item.rolename === 'CHILD')) {
        this.personList.push(item);
      } else {
      if (!item.intakeservicerequestactorid) {
        if (item.roles && item.roles.length && item.roles[0].intakeservicerequestactorid) {
          item.intakeservicerequestactorid = item.roles[0].intakeservicerequestactorid;
        }
  }
     this.legalPerson.push(item);
    }
  }

  getLegalCustody() {
    this._commonHttpService.getArrayList({
      method: 'get',
      where: {
        personid: this.childActorId,
        isExpungementSuperUser: this._authService.isExpungementSuperUser(),
        iscaseexpunged: this.iscaseexpunged
      }
    }, 'legalcustody/getlegalcustody?filter').subscribe( res => {
      console.log(res)
      if (res && res.length && res[0].getlegalcustody) {
        this.legalCustodyDetails = res[0].getlegalcustody;
        if (this.legalCustodyDetails) {
          const sortedDetails = [...this.legalCustodyDetails].sort((a, b) => {
            const aDate = a?.todate || '';
            const bDate = b?.todate || '';
            return bDate.localeCompare(aDate);
          });
          this.legalCustodyDetails = sortedDetails;
        }
      } else {
        this.legalCustodyDetails = [];
      }
      this.cdr.markForCheck();
    });
  }

  isSelectedPerson(modal: any) {
    const index = this.personList
        ? this.personList.findIndex(
            item =>
                item.intakeservicerequestactorid === modal.intakeservicerequestactorid
        )
        : -1;
    return index >= 0;
}
  changePerson(id: any, legalcustodyid: any) {
    const personRelation = this.legalPerson && this.legalPerson.length ? this.legalPerson.filter(item => item.intakeservicerequestactorid === id) : [];
    const legalCustodyPersonIdCheck = personRelation && personRelation.length ? personRelation[0].personid : '';
    const relationshipText = personRelation && personRelation.length ? personRelation[0].relationship : '';
    let legalRelationship: any;
    const personRelationCheck = personRelation && personRelation.length ? personRelation[0].relationshiparray : [];
      _.forIn(personRelationCheck, (relatnship) => {
          if (relatnship.primaryuserid === legalcustodyid && relatnship.secondaryuserid === legalCustodyPersonIdCheck && !legalRelationship) {
              legalRelationship = relatnship.description ? relatnship.description : null ;
              return true;
          }
      });

    const AddressText = this.getAddressTest(personRelation);
    const Phoneno = this.getPhoneNumber(personRelation);
    this.legalForm.patchValue({
        relationship: legalRelationship ? legalRelationship : relationshipText,
        Address: AddressText,
        phonenumber: Phoneno
    });
}

  getAddressTest(personRelation: any) {
    let AddressText;
    if (personRelation && personRelation.length) {
      AddressText = personRelation[0].address ? personRelation[0].address : '';
      AddressText += personRelation[0].address2 ? ', ' + personRelation[0].address2 : '';
      AddressText += personRelation[0].city ? ', ' + personRelation[0].city : '';
      AddressText += personRelation[0].county ? ', ' + personRelation[0].county : '';
      AddressText += personRelation[0].state ? ', ' + personRelation[0].state : '';
      AddressText += personRelation[0].zipcode ? ' - ' + personRelation[0].zipcode : '';
    }
    return AddressText;
  }

  getPhoneNumber(personRelation: any){
    return personRelation && personRelation.length ? personRelation[0].phonenumber : '';
  }
  onChildChecked(child: any, event: any) {
    if (event.checked) {
      this.childActorId = child.intakeservicerequestactorid;
      this.personId = child.personid;
      this.getLegalCustody();
      this.addDisable = false;
      for (const element of this.personList) {
        if (element.intakeservicerequestactorid === this.childActorId) {
          element.isSelected = true;
        } else {
          element.isSelected = false;
        }
      }
      this.selectChild = true;
    } else {
      this.addDisable = true;
      this.legalCustodyDetails = [];
      this.selectChild = false;
    }
  }

  saveLegalCustody(model: any) {
    if (this.legalForm.invalid) {
      this.displayValidationMessages =true;
      this.legalForm.markAllAsTouched();
      return;
    }	
    const legalCustoduInput = model;
    const isservicecase = this._store.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isservicecase) {
      legalCustoduInput.servicecaseid = this.id;
      delete legalCustoduInput.intakeserviceid;
    } else {
      legalCustoduInput.intakeserviceid = this.id;
      delete legalCustoduInput.servicecaseid;
    }
    legalCustoduInput.permanencyplanid = null;
    if (!legalCustoduInput.intakeservicerequestactorid) {
      legalCustoduInput.intakeservicerequestactorid = this.childActorId;
    }
    legalCustoduInput.personid = this.personId;
    this._commonHttpService.create(legalCustoduInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.LegalCustodyAddUpdate).subscribe(
      res => {
          this.updateButton = true;
          this._alertService.success('Court - Legal custody saved successfully');
        $('#addlegalcustody').modal('hide');
        this.legalForm.reset();
        this.getLegalCustody();
      },
      err => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

  deleteLegalCustody(item: any) {
    $('#deleteLegalCustody').modal('show');
    this.deleteLegalCustodyId = item.legalcustodyid;
  }

  confirmDelete() {
      const payload: any = {}
      payload['legalcustodyid'] = this.deleteLegalCustodyId;
      this._commonHttpService.create(payload, 'legalcustody/deletelegalcustody').subscribe(
          response => {
            this.getLegalCustody();
              $('#deleteLegalCustody').modal('hide');
              this._alertService.success('Legal custody deleted successfully!');
          }
      );
  }

  clearLeagalCustody() {
      this.legalForm.reset();
      this.disableFieldOnInit();
  }
  private disableFieldOnInit() {
      this.legalForm.get('relationship')?.disable();
      this.legalForm.get('Address')?.disable();
      this.legalForm.get('phonenumber')?.disable();
      this.legalForm.get('workphone')?.disable();
      this.legalForm.get('code')?.disable();
  }
  navigateTo() {
    const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/tpr-recom';
    this._router.navigate([redirectUrl]);
  }

  getLegalRequestorFullName(id: any){
    const personRelation: any = this.legalPerson && this.legalPerson.length ? this.legalPerson.filter(item => item.intakeservicerequestactorid === id) : [];
    if(personRelation && personRelation.length){
      return personRelation[0]['fullname'];
    }else {
      return 'LDSS';
    }
  }

  getErrorsMessage(ControlName: any, displayName: any) {
    if(this.legalForm.controls[ControlName].status =='INVALID' ) {
      return 'Please enter valid ' + displayName
    }
  }

}
