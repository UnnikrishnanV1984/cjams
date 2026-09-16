import { Injectable } from '@angular/core';
import { GenericService, DataStoreService, CommonHttpService, AuthService } from '../../../@core/services';
import { InvolvedPerson } from '../../../@core/common/models/involvedperson.data.model';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { ActivatedRoute } from '@angular/router';
import { AppConstants } from '../../../@core/common/constants';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { NewUrlConfig } from '../../newintake/newintake-url.config';

@Injectable()
export class PaymentScheduleService {

  victims: InvolvedPerson[] = [];
  youth: InvolvedPerson | null = new InvolvedPerson();
  pageSource!: string;
  id!: string;
  daNumber!: string;
  cases: any[] = [];
  relations!: InvolvedPerson[];
  role: string;
  intakeserreqrestitutionid!: string;
  ccuenable = false;
  ccuPage = false;
  constructor(private _service: GenericService<InvolvedPerson>,
    private route: ActivatedRoute,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService) {
    this.route.data.subscribe((response:any) => {
      this.pageSource = response.pageSource;
    });
    this.role = this._authService.getCurrentUser().role.name;
  }

  loadCases() {
    if (this.pageSource === AppConstants.PAGES.INTAKE_PAGE) {
      const cases = this._dataStoreService.getData(IntakeStoreConstants.disposition);
      this.cases = cases ? cases.filter((c: { dispositioncode: string; supDisposition: string; restitution: any; supRestitution: any; }) => ((c.dispositioncode === 'IAD' || c.supDisposition === 'IAD')
        && ((c.restitution && !c.supDisposition)
          || (c.supRestitution)))) : [];
    } else {
      this.cases = [{
        serviceTypeID: this.id,
        ServiceRequestNumber: this.daNumber
      }];
    }
  }

  processInvolvedVictims() {
    if (this.pageSource === AppConstants.PAGES.INTAKE_PAGE) {
      this.getIntakeVictims();
    } else {
      // consdier by default AppConstants.PAGES.CASE_PAGE
      this.getCaseVictims();
    }
  }

  getIntakeVictims() {
    const persons = this._dataStoreService.getData(IntakeStoreConstants.addedPersons);
    this.victims = persons ? persons.filter((person: any) => person.Role === 'Victim').map((person: { Lastname: any; Firstname: any; Pid: any; }) => {
      return {
        lastname: person.Lastname,
        firstname: person.Firstname,
        personid: person.Pid
      };
    }) : [];
    this.relations = persons ? persons.filter((person: any) => (person.Role !== 'Youth' && person.Role !== 'Victim')).map((person: { Lastname: any; Firstname: any; Pid: any; RelationshiptoRA: any; }) => {
      return {
        lastname: person.Lastname,
        firstname: person.Firstname,
        personid: person.Pid,
        relationship: person.RelationshiptoRA
      };
    }) : [];
    this.youth = persons ? persons.filter((person: any) => person.Role === 'Youth').map((person: { Lastname: any; Firstname: any; Pid: any; }) => {  // NOSONAR    // This function has 3 lines of code which has identical implementation. hence marking it as no sonar
      return {
        lastname: person.Lastname,
        firstname: person.Firstname,
        personid: person.Pid
      };
    })[0] : null;
  }

  getCaseVictims() {
    this.processInvolvedPerson().subscribe(result => {
        const persons = result.data;
        this.victims = persons ? persons.filter((person) => person.rolename === 'Victim') : [];
        this.relations = persons ? persons.filter((person) => (person.rolename !== 'Youth' && person.rolename !== 'Victim')) : [];
        const filtervalue:any  = persons ? persons?.filter((person) => person.rolename === 'Youth')[0] :[] ;
         this.youth =filtervalue;
      });
  }

  processInvolvedPerson() {
    return this._service
      .getPagedArrayList(new PaginationRequest({
        page: 1,
        limit: 200,
        method: 'get',
        where: { intakeserviceid: this.id }
      }), CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .PersonList + '?filter');
  }

  isCasePage(): boolean {
    return this.pageSource === AppConstants.PAGES.CASE_PAGE;
  }

  isRCPage(): boolean {
    return this.pageSource === AppConstants.PAGES.RESTITUTION_COORDINATOR;
  }

  getRelations() {
    return this._commonHttpService.getArrayList(
      {
        where: { activeflag: 1 },
        method: 'get',
        nolimit: true,
        order: 'description'
      },
      NewUrlConfig.EndPoint.Intake.RelationshipTypesUrl + '?filter'
    );
  }

  getPlacementDetails(personid: string) {
    return this._commonHttpService.getArrayList(
      {
        where: { personid: personid },
        method: 'get',
        nolimit: true
      },
      NewUrlConfig.EndPoint.Intake.PlacementRestitution
    );
  }

  getCcuenable(): boolean {
    return this.ccuenable;
  }

  setCcuenable(ccu: boolean) {
    this.ccuenable = ccu;
  }

  getCcuPage(): boolean {
    return this.ccuPage;
  }

  setCcuPage(ccu: boolean) {
    this.ccuPage = ccu;
  }

}
