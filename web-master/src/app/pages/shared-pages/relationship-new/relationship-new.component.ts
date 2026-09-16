
import {pluck, share} from 'rxjs/operators';
import { Component, OnInit, Injector } from '@angular/core';
import { InvolvedPerson } from '../involved-persons/_entities/involvedperson.data.model';
import { Observable } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService, DataStoreService, AuthService, SessionStorageService, AlertService } from '../../../@core/services';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { DropdownModel, PaginationRequest } from '../../../@core/entities/common.entities';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { AppConstants } from '../../../@core/common/constants';
import { AppConfig } from '../../../app.config';
import { apiResourcePath } from '../../../@core/common/initializer';
import { TransferHistoryApprovedService } from '../../../shared/services/transfer-history-approved.service';
import { BreakpointObserver } from '@angular/cdk/layout';

@Component({
    selector: 'relationship-new',
    host: {
        class: 'relationship-new'
    },
    templateUrl: './relationship-new.component.html',
    styleUrls: ['./relationship-new.component.scss'],
    standalone: false
})
export class RelationshipNewComponent implements OnInit {
  source!: string;
  selectedCard!: number;
  involevedPersonList: InvolvedPerson[] = [];
  involevedPerson$!: Observable<InvolvedPerson[]>;
  selectedPerson: any;
  private id!: string;
  relationshipForm!: FormGroup;
  personid2: any;
  relationShipToRADropdownItems: DropdownModel[] = [];
  isClosed = false;
  careGiverFlag = false;
  isChildSelected = false;
  showInfo = true;
  moduleview: any;
  isReadonly!: boolean;
  matCols!: number;
  reverseRelationActorId!: string | null;

  private route: ActivatedRoute;
  private _commonHttpService: CommonHttpService;
  private _dataStoreService: DataStoreService;
  private formBuilder: FormBuilder;
  public _authService: AuthService;
  private _sessionStorage: SessionStorageService;
  private readonly _transferHistoryApprovedService: TransferHistoryApprovedService;
  private _session: SessionStorageService;
  private breakpointObserver: BreakpointObserver;
  private _alertService: AlertService;


  constructor(private injector: Injector){
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._commonHttpService= this.injector.get<CommonHttpService>(CommonHttpService);
    this._dataStoreService= this.injector.get<DataStoreService>(DataStoreService);
    this.formBuilder= this.injector.get<FormBuilder>(FormBuilder);
    this._authService= this.injector.get<AuthService>(AuthService);
    this._sessionStorage= this.injector.get<SessionStorageService>(SessionStorageService);
    this._transferHistoryApprovedService= this.injector.get<TransferHistoryApprovedService>(TransferHistoryApprovedService);
    this._session= this.injector.get<SessionStorageService>(SessionStorageService);
    this.breakpointObserver= this.injector.get<BreakpointObserver>(BreakpointObserver);
    this._alertService= this.injector.get<AlertService>(AlertService);
  
    this.route.data.subscribe(data => {
      if (data && data.hasOwnProperty('result')) {
        this._authService.setAuthDetail('relationship', data.result);
      }
    }); 
}

  ngOnInit() {
    const activeModuleRole = this._sessionStorage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access','relationship-add-edit');
    }
    this.moduleview = this._authService.isModuleAccessable('relationship', 'relationship');
    this.initAll();
    this.loadPersons();
    this.isClosed = this._authService.iscaseclosed('personrelationship');
    this._authService.readonlyPage('read_only_access','relationship-edit-mode',
      [this.relationshipForm]);
    
    if(this._dataStoreService.getData(IntakeStoreConstants.INTAKE_IS_CLOSED)){
      this.relationshipForm.disable();
      this.isClosed = true;
    }
    
    if(this.isIntakeMode() && this._transferHistoryApprovedService.getTrasferHistory()) {
      this.isClosed = true;
    }

    // Adjust cards display based on the screen resolution
    this.breakpointObserver.observe([
      '(max-width: 599.98px)', 
      '(min-width: 600px) and (max-width: 839.98px)', 
      '(min-width: 840px)' 
    ]).subscribe(result => {
      if (result.matches) {
        if (result.breakpoints['(max-width: 599.98px)']) {
          this.matCols = 1; 
        } else if (result.breakpoints['(min-width: 600px) and (max-width: 839.98px)']) {
          this.matCols = 2;
        } else {
          this.matCols = 4;
        }
      }
    });
  }
 
  loadPersons() {
    this.involevedPerson$ = this.getInvolvedPerson(1, 100, null).pipe(
      share(),
      pluck('data'),);
    this.involevedPerson$.subscribe(response => {
      if (response && Array.isArray(response)) {
        // Removing Collateral From list
        this.involevedPersonList = response.filter(data => data.iscollateralcontact !== 1);
        this.selectPersonCard(0, this.involevedPersonList[0]);
        const involevedPerson = response;
        involevedPerson.forEach(person => {
          if (person.userphoto) {
                      // involevedPerson$ is shared, so a second subscriber (or a
                      // re-emission) prefixed these same objects again.
                      person.userphoto = AppConfig.baseUrl + apiResourcePath(person.userphoto);
                   } })
      }
    });
  }

  

  selectPersonCard(index: any, person: any) {
    this.isChildSelected = false;
    this.selectedCard = index;
    this.selectedPerson = person;
    if (person?.roles?.length > 0 && person.roles.some((roleid: { intakeservicerequestpersontypekey: string; }) => roleid.intakeservicerequestpersontypekey === 'CHILD')) {
      this.isChildSelected = true;
    }
    if (this.selectedPerson) {
      this.mergePersons();
    }
  }

  initAll() {
    this.getRelationList();
    this.relationshipForm = this.formBuilder.group({
      actorrelationshipid: [''],
      intakeservicerequestactorid: [''],
      relationshiptypekey: [''],
      person1id: [''],
      person2id: [''],
      servicecaseid: [this.id],
      careGiverFlag: false,
      intakeserviceid: null,
      intakenumber:null
    });
  }



  getFullName(person: any) {
    if (person) {
      return person.fullname;
    }
  }
  getRelationList() {
    this._commonHttpService.getArrayList(
      {
        where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .RelationshipTypesUrl + '?filter'
    ).subscribe(data => {
      if (data && data.length) {
        this.setRelationList(data);
      }
    });
  }
  setRelationList(data: any) {
    if (data && data.length) {
      this.relationShipToRADropdownItems = data.map((res: { description: any; relationshiptypekey: any; }) => {
        return new DropdownModel({
          text: res.description,
          value: res.relationshiptypekey
        });
      });
    }
  }

  UpdatePersonId(person: any) {
    this.personid2 = person;
    this.relationshipForm.patchValue({
      actorrelationshipid: null,
      intakeservicerequestactorid: person.intakeservicerequestactorid,
      relationshiptypekey: person.relationshiptypekey,
      person1id: this.selectedPerson.personid,
      person2id: person.personid,
      careGiverFlag: person.careGiverFlag
    });
    this.setReverseRelationActorId();
  }
  
  updateRelation() {
    this._commonHttpService.create(this.relationshipForm.value, 'Actorrelationships/addupdate').subscribe(
      (res) => {
        if(this.relationshipForm.value.careGiverFlag){
          this._alertService.warn('Please enter the Marital Status (mandatory) for the Caregiver in Person Profile')
        }
        if (this.selectedPerson) {
          this.mergePersons();
        }
        this.reverseRelationShip();
      
      });
  }
  reverseRelationShip(){
    let opositRelationShip:string | null = null;
    this._commonHttpService
    .getArrayList(
      {
        method: 'get',
        where: { relationshiptypekey: this.relationshipForm.value.relationshiptypekey }
      },
      'reverserelationship/list?filter'
    ).subscribe(res => {
        if (res && res.length>0) {
          if(this.selectedPerson.gender==='Male' || this.selectedPerson.gender==='M'){
            opositRelationShip = res[0].malereverserelationshiptypekey;
          } else {
            opositRelationShip = res[0].femalereverserelationshiptypekey;
          }
        }

        if(!opositRelationShip){
          return;
        }
        const request = {
          actorrelationshipid: null,
          intakeservicerequestactorid: this.reverseRelationActorId ?? this.selectedPerson.intakeservicerequestactorid,
          person1id: this.personid2.personid,
          person2id: this.selectedPerson.personid,
          relationshiptypekey:opositRelationShip,
          servicecaseid : this.relationshipForm.controls.servicecaseid.value,
          intakeserviceid: this.relationshipForm.controls.intakeserviceid.value,
          intakenumber: this.relationshipForm.controls.intakenumber.value,      
        };
        this._commonHttpService.create(request, 'Actorrelationships/addupdate').subscribe(
          () => {
            if (this.selectedPerson) {
              this.mergePersons();
            }
          });

      });
  }

  setReverseRelationActorId() : any {
    this.getInvolvedPersonWithPersonID(1, 20, this.personid2.personid)
      .subscribe(response => {
        if (Array.isArray(response)) {
          const matchedRelation = response.find(item =>
            item.person2id === this.selectedPerson.personid
          );
          this.reverseRelationActorId  =  matchedRelation?.intakeservicerequestactorid ?? null;
        } else {
          this.reverseRelationActorId = null;
        }
      });
  }

  mergePersons() {
    this.getInvolvedPersonWithPersonID(1, 20, this.selectedPerson.personid)
      .subscribe(response => {
        if (Array.isArray(response)) {
          let found = false;
          for (let i = 0; i < this.involevedPersonList.length; i++) {
            found = false;
            for (const element of response) {
              if (this.involevedPersonList[i].personid === element.person2id) {
                this.involevedPersonList[i].relation = element.relation;
                this.involevedPersonList[i].relationshiptypekey = element.relationshiptypekey;
                this.involevedPersonList[i].careGiverFlag = element.caregiverflag == 1;
                this.involevedPersonList[i].intakeservicerequestactorid = element.intakeservicerequestactorid;
                found = true;
                break;
              }
            }
            if (!found) {
              this.commonElseCondition(i);
            }
          }
        }
        else{
          this.mergePersonsElse();
        }
      });
  }

  private mergePersonsElse(){
    for (let i = 0; i < this.involevedPersonList.length; i++) {
      this.commonElseCondition(i);
    }
  }

  private commonElseCondition(i: number) {
    this.involevedPersonList[i].relation = 'unknown';
    this.involevedPersonList[i].relationshiptypekey = '';
    this.involevedPersonList[i].careGiverFlag = false;
  }

  switchInfo() {
    this.showInfo = !this.showInfo;
  }

  getInvolvedPerson(page: number, limit: number,personid: any) {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';
    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          nolimit: limit?true:false,
          method: 'get',
          where: this.getRequestParam(personid)
        }),
        url + '?filter'
      );
  }
  getInvolvedPersonWithPersonID(page: number, limit: number,personid: string) {

    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: page,
          limit: limit,
          method: 'get',
          where: this.getRequestParam(personid)
        }),
        'People/getallpersonrelationbyprovidedpersonid?filter'
      );


  }
  getRequestParam(personid: string) {
    let inputRequest: any;
    const caseID = this.getCaseUuid();
    this.source = this.getSource();
    if (this.isServiceCase()) {
      inputRequest = {
        objectid: caseID,
        objecttypekey: 'servicecase',
      };
      this.relationshipForm.patchValue({
        servicecaseid: caseID,
        intakeserviceid: null,
        intakenumber : null
      })
    } else if (this.isIntakeMode()) {
      inputRequest = {
        intakenumber: this.getIntakeNumber()
      };
      this.relationshipForm.patchValue({
        servicecaseid: null,
        intakeserviceid: null,
        intakenumber : this.getIntakeNumber()
      })
     
    } else {
      inputRequest = {
        intakeserviceid: caseID
      };
      this.relationshipForm.patchValue({
        intakeserviceid: caseID,
        servicecaseid: null,
        intakenumber : null 
        })
    }
    if(personid) {
      inputRequest.personid=personid;
    }

    inputRequest.isExpungementSuperUser=  this._authService.isExpungementSuperUser();
    inputRequest.iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
    return inputRequest;
  }

  isServiceCase() {
    return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
  }

  isIntakeMode() {
    return this.getIntakeNumber() ? true : false;
  }

  getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    if (intakeStore && intakeStore.number) {
      return intakeStore.number;
    } else {
      return null;
    }
  }

  getCaseUuid() {
     let caseID = this.route.snapshot?.parent?.parent?.parent?.parent?.params['id'];
        if (!caseID) {
            caseID = this.getIntakeNumber();
        }
     return caseID;
  }

  getCaseNumber() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    let caseNumber = null;
    if (caseInfo) {
      caseNumber = caseInfo.da_number;
    }
    return caseNumber;
  }

  getUniqueNumber() {
    if (this.isIntakeMode()) {
      return this.getIntakeNumber();
    } else {
      return this.getCaseUuid();
    }
  }

  getSource() {

    if (this.isServiceCase()) {
     return AppConstants.CASE_TYPE.SERVICE_CASE;
    } else if (this.isIntakeMode()) {
      return AppConstants.CASE_TYPE.INTAKE;
    } else {
      return AppConstants.CASE_TYPE.CPS_CASE;
    }
    // need to add condition for adoption case
  }


  getPersonRelations(personid: string) {
    return this._commonHttpService
      .getAll('People/getpersonrelations?filter={"where":{"personid":"' + personid + '"}}');
  }

}
