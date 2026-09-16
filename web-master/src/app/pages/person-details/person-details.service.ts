import { Injectable } from '@angular/core';
import { GenericService, AuthService, CommonHttpService, AlertService } from '../../@core/services';
import { PersonBasicDetail } from '../../@core/common/models/involvedperson.data.model';
import { Observable ,  BehaviorSubject } from 'rxjs';
import { AppConstants } from '../../@core/common/constants';
import { AppUser } from '../../@core/entities/authDataModel';
import { CommonUrlConfig } from '../../@core/common/URLs/common-url.config';



@Injectable()
export class PersonDetailsService {

  private _person!: PersonBasicDetail;
  private _isEditable = false;
  private _action!: string;
  private EDITABLE_ROLES = [
    AppConstants.ROLES.INTAKE_WORKER,
    AppConstants.ROLES.CASE_WORKER,
    AppConstants.ROLES.SUPERVISOR,
    AppConstants.ROLES.RESTITUTION_COORDINATOR];
  public personStatus$ = new BehaviorSubject<string>('');
  public personStatus!: string;
  public personid!: string | null;

  constructor(private _personDetailService: GenericService<any>,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService,
    private _authService: AuthService) { }

  getPersonDetails(personid: any): Observable<PersonBasicDetail> {
    return this._personDetailService
      .getById(personid, 'People/getpersonbasicdetails');
  }

  getPersonStatusSubject() {
    return this.personStatus$;
  }

  setPersonStatus(status: any) {
    this.personStatus = status;
    this.personStatus$.next(status);

  }

  savePersonDetails(personData: any) {
    this._commonHttpService.create({ Person: [personData], intakeserviceid: null }, CommonUrlConfig.EndPoint.PERSON.UpdatePerson).subscribe(
      (result) => {
        this._alertService.success('Person update successfully');
        this.getPersonDetails(this.person.personid).subscribe(response => {
          this.person = response;
        });
      }
    );
  }

  set person(person: PersonBasicDetail) {
    this._person = person;
  }

  get person(): PersonBasicDetail {
    return this._person;
  }

  set action(action: any) {
    this._action = action;
  }

  get action() {
    return this._action;
  }

  get isEditable(): boolean {
    if (this.action && this.action === AppConstants.ACTIONS.EDIT && this.hasEditAccess()) {
      return true;
    }
    return false;
  }

  hasEditAccess() {
    const user: AppUser = this._authService.getCurrentUser();
    let hasAccess = false;
    const found = this.EDITABLE_ROLES.indexOf(user.role.name);
    if (found !== -1) {
      hasAccess = true;
    }
    return hasAccess;
  }

  isSupervisor(): boolean {
    const user: AppUser = this._authService.getCurrentUser();
    if (user.role.name === AppConstants.ROLES.SUPERVISOR) {
      return true;
    }
    return false;
  }


  findPersonIdentifier(personidentifier: any, key: any) {
    const pi = personidentifier.find((pir: { personidentifiertypekey: any; }) => {
      if (pir.personidentifiertypekey === key) {
        return true;
      }
    });
    if (pi && pi.personidentifiervalue) {
      return pi.personidentifiervalue;
    }
  }
  findPhysicalAttribute(phycialAttributes: any, key: any) {
    const pa = phycialAttributes.find((pir: { physicalattributetypekey: any; }) => {
      if (pir.physicalattributetypekey === key) {
        return true;
      }
    });
    if (pa && pa.attributevalue) {
      return pa.attributevalue;
    }
  }
}
