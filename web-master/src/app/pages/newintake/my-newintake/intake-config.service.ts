import { Injectable } from '@angular/core';
import { AuthService, DataStoreService } from '../../../@core/services';
import { IntakePurpose, IntakeCommunication } from './_entities/newintakeModel';
import { IntakeStoreConstants, MyNewintakeConstants } from './my-newintake.constants';
import { DJS_TAB_ORDER, CW_TAB_ORDER } from './intake-tab-config';
import _ from 'lodash';
import { Subject } from 'rxjs';

const subtypeDependencyPurposes = [MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION, MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT];
@Injectable()
export class IntakeConfigService {

  private purposeList: IntakePurpose[] = [];
  private communicationList: IntakeCommunication[] = [];
  private _selectedPurpose!: string;
  private _intakeAction!: string | null;
  private _iseditIntake = true;
  public intakeDecision$ = new Subject<any>();
  public isVoluntaryPlacement$ = new Subject<any>();
  public colletarlCount$ = new Subject<any>();
  public scanConfig$ = new Subject<any>();
  homeServiceCheckValue!: string;
  public quickAddPersonListener$ = new Subject<any>();
  public quickAddPersonCount$ = new Subject<any>();
  constructor(private _authService: AuthService,
    private _dataStoreService: DataStoreService) { }


  getintakeAction(): string | null {
    return this._intakeAction;
  }

  setintakeAction(value: string | null) {
    this._intakeAction = value;
    if (value === 'view') {
      this._iseditIntake = false;
    } else {
      this._iseditIntake = true;
    }
  }

  getiseditIntake() {
    return this._iseditIntake;
  }

  setPurposeList(purposeList: IntakePurpose[]) {
    this.purposeList = purposeList;
  }

  getPurposeList(): IntakePurpose[] {
    return this.purposeList;
  }

  getCommunicationList(): IntakeCommunication[] {
    return this.communicationList;
  }

  setCommunicationList(communicationList: IntakeCommunication[]) {
    this.communicationList = communicationList;
  }

  public get selectedPurpose(): string {
    return this._selectedPurpose;
  }
  public set selectedPurpose(value: string) {
    this._selectedPurpose = value;
  }

  // @Simar: currently just checking if the Intake is for purpose Child Protective Services
  // This can be enhanced to add more logic for what defines a case to be non-CPS
  // Like for instance would Risk of Harm be considered non-cps etc..
  isNonCPS(): boolean {
    const intakePurpose = this.getIntakePurpose();
    if (intakePurpose && intakePurpose.intakeservreqtypekey === 'CHILD') {
        return false;
    }
    return true;
  }


  getIntakePurpose(): IntakePurpose | null | undefined {
    const purpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
    if (!purpose) {
      return null;
    }
    const purposeKey = purpose.value;
    return this.getSelectedPurpose(purposeKey);
  }

  getDJSTabOrder() {
    const purposeObject = this.getIntakePurpose();
    if (purposeObject) {
      switch (purposeObject.intakeservreqtypekey) {
        case MyNewintakeConstants.REFERRAL.LAW_ENFORCEMENT:
          return DJS_TAB_ORDER.COMMON_ORDER;
        case MyNewintakeConstants.REFERRAL.WAIVER_FROM_ADUL_COURT:
          return DJS_TAB_ORDER.WAIVER_FROM_ADUL_COURT_ORDER;
        case MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION:
          return DJS_TAB_ORDER.ADULT_HOLD_DETENTION;
        case MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT:
          return DJS_TAB_ORDER.INTERSTATE_COMPACT;
        case MyNewintakeConstants.REFERRAL.PEACE_ORDER:
          return DJS_TAB_ORDER.PO_ORDER;
        default:
          return DJS_TAB_ORDER.COMMON_ORDER;


      }
    } else {
      return DJS_TAB_ORDER.COMMON_ORDER;
    }
  }

  getCWTabOrder() {
    const purposeObject = this.getIntakePurpose();
    if (purposeObject) {
      switch (purposeObject.intakeservreqtypekey) {
        case MyNewintakeConstants.PURPOSE.ROA_CPS:
          return CW_TAB_ORDER.ROA_CPS;
        case MyNewintakeConstants.PURPOSE.CHILD_PROTECTION_SERVICES:
        case MyNewintakeConstants.PURPOSE.INFORMATION_AND_REFERRAL:
        case MyNewintakeConstants.PURPOSE.REQUEST_FOR_SERVICES:
          return CW_TAB_ORDER.CPS_ORDER;
        case MyNewintakeConstants.PURPOSE.RISK_OF_HARM_INTAKE:
          return CW_TAB_ORDER.RISK_HARM_ORDER;
        default:
          return CW_TAB_ORDER.NON_CPS_ORDER;
      }
    } else {
      return CW_TAB_ORDER.COMMON_ORDER;
    }
  }

  getSelectedPurpose(purposeID: any): IntakePurpose | null | undefined {
    if (this.purposeList) {
      return this.purposeList.find(puroposeItem => puroposeItem.intakeservreqtypeid === purposeID);
    }
    return null;
  }

  getSelectedPurposeByKey(purposeKey: any): IntakePurpose | null | undefined {
    if (this.purposeList) {
      return this.purposeList.find(puroposeItem => puroposeItem.intakeservreqtypekey === purposeKey);
    }
    return null;
  }

  getSelectedCommunication(commID: any): IntakeCommunication | null | undefined {
    if (this.communicationList) {
      return this.communicationList.find(commItem => commItem.intakeservreqinputtypeid === commID);
    }
    return null;
  }

  getSelectedCommunicationByKey(commKey: any): IntakeCommunication | null | undefined {
    if (this.communicationList) {
      return this.communicationList.find(commItem => commItem.intakeservreqinputtypekey === commKey);
    }
    return null;
  }

  selectedPurposeIs(purposeKey: any): boolean {
    const purposeSelected = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
    if (!purposeSelected || !purposeSelected.value) {
      return false;
    }
    const selectedPurpose = this.getSelectedPurpose(purposeSelected.value);
    if (selectedPurpose && selectedPurpose.intakeservreqtypekey === purposeKey) {
      return true;
    } else {
      return false;
    }
  }

  isComplaintNeeded(): boolean {
    const tab_orders = this.getDJSTabOrder();
    if (tab_orders.indexOf('evaluation') !== -1) {
      return true;
    }
    return false;
  }

  isFlowToCaseSupervisor(): boolean {
    const purposeObject = this.getIntakePurpose();
    if (!purposeObject) {
      return false;
    }
    this.selectedPurpose = purposeObject.description;
    switch (this.selectedPurpose) {
      case MyNewintakeConstants.REFERRAL.WAIVER_FROM_ADUL_COURT:
      case MyNewintakeConstants.REFERRAL.ADULT_HOLD_DETENTION:
      case MyNewintakeConstants.REFERRAL.INTERSTATE_COMPACT:
        return true;
      default:
        return false;
    }
  }

  isCaseHasSubTypeDependancy() {
    const selectedpurposeObject = this.getIntakePurpose();
    if (!selectedpurposeObject) {
      return false;
    }
    if (subtypeDependencyPurposes.indexOf(selectedpurposeObject.description) !== -1) {
      return true;
    }
    return false;
  }

  djsInfoValidation() {
    const purpose = this.getIntakePurpose();
    const errorMsg = { message: [], status: false, No_Jurisdiction: [], Insufficient_Information: [] };
    if (purpose && purpose.intakeservreqtypekey === MyNewintakeConstants.REFERRAL.LAW_ENFORCEMENT) {
      const addedPersons = this._dataStoreService.getData(IntakeStoreConstants.addedPersons);
      const caseCreated = this._dataStoreService.getData(IntakeStoreConstants.createdCases);
      const evalField = this._dataStoreService.getData(IntakeStoreConstants.evalFields);
      // In Sufficient Information Validation
      this.checkAddPersonFn(addedPersons, errorMsg);
      if (caseCreated && caseCreated.length > 0) {
        this.caseCreatedMapFn(caseCreated, errorMsg);
      }
      if (evalField && evalField.length > 0) {
        this.checkRequiredEvalFieldFn(evalField, errorMsg);
      }

      errorMsg.Insufficient_Information = errorMsg.message;

      this.nojurisdicationCheckFn(errorMsg);

      if (errorMsg.message && errorMsg.message.length > 0) {
        this._dataStoreService.setData(IntakeStoreConstants.complaintInfoReview, errorMsg);
        errorMsg.status = true;
      } else {
        errorMsg.status = false;
      }
      return errorMsg;
    }
    return errorMsg;
  }

  private checkAddPersonFn(addedPersons: any, errorMsg: any) {
    if (addedPersons && addedPersons.length > 0) {
      const youthDetails = addedPersons.find((data: { Role: string; }) => data.Role === 'Youth');
      this.ifYouthDetailsFn(youthDetails, errorMsg, addedPersons);
    } else {
      errorMsg.message.push('Please add a person to submit');
    }
  }

  private caseCreatedMapFn(caseCreated: any, errorMsg: any) {
    caseCreated.map((data: { complaintids: string | any[]; }) => {
      if (!(data.complaintids && data.complaintids.length > 0)) {
        errorMsg.message.push('Please add Complaint');
      }
    });
  }

  private nojurisdicationCheckFn(errorMsg: any) {
    const nojurisdication = this._dataStoreService.getData(IntakeStoreConstants.complaintInfoReview);

    if (nojurisdication && nojurisdication.No_Jurisdiction && nojurisdication.No_Jurisdiction.length > 0) {
      errorMsg.No_Jurisdiction = nojurisdication.No_Jurisdiction;
      errorMsg.message = [...errorMsg.message, ...nojurisdication.No_Jurisdiction];
    }
  }

  private ifYouthDetailsFn(youthDetails: any, errorMsg: any, addedPersons: any) {
    if (youthDetails) {
      if (youthDetails.Role === 'Youth') {
        this.checkRequiredDataIfYouthFn(youthDetails, errorMsg);
      }
    } else {
      errorMsg.message.push('Please add Youth');
    }
    const relationship = addedPersons.filter((data: { RelationshiptoRA: string; }) => data.RelationshiptoRA === 'father' || data.RelationshiptoRA === 'mother' || data.RelationshiptoRA === 'guardian');
    if (!(relationship && relationship.length > 0)) {
      errorMsg.message.push('Please add Youth Parent/ Guardian');
    }
  }

  private checkRequiredEvalFieldFn(evalField: any, errorMsg: any) {
    evalField.map((data: { complaintid: any; age: any; allegedoffense: string | any[]; }) => {
      if (!data.complaintid) {
        errorMsg.message.push('Please add Complaint');
      }
      if (!data.age) {
        errorMsg.message.push('Please add Youth Age');
      }
      if (!(data.allegedoffense && data.allegedoffense.length > 0)) {
        errorMsg.message.push('Please add Youth Offence');
      }
    });
  }

  private checkRequiredDataIfYouthFn(youthDetails: any, errorMsg: any) {
    if (!youthDetails) {
      errorMsg.message.push('Please add Youth Details to submit');
    }
    if (_.isEmpty(youthDetails.Dob)) {
      errorMsg.message.push('Please add Youth Date of Birth');
    }
    if (_.isEmpty(youthDetails.Address)) {
      errorMsg.message.push('Please add Youth Address');
    }
    if (_.isEmpty(youthDetails.City)) {
      errorMsg.message.push('Please add Youth City');
    }
    if (_.isEmpty(youthDetails.State)) {
      errorMsg.message.push('Please add Youth State');
    }
    if (_.isEmpty(youthDetails.county)) {
      errorMsg.message.push('Please add Youth county');
    }
    if (_.isEmpty(youthDetails.Zip)) {
      errorMsg.message.push('Please add Youth zipcode');
    }
  }

  changeHomeServiceValue(value: any) {
    this.homeServiceCheckValue = (value) ? 'ILAC' : 'VP';
    this.intakeDecision$.next(this.homeServiceCheckValue);
  }

  isVoluntaryPlacementEnabled(value: any) {
    this.isVoluntaryPlacement$.next(value);
  }

  mapOldJsonData(person: any) {
    return {
      'Dob': person.dob,
      'dateofdeath': person.dateofdeath,
      'Pid': person.personid,
      'Zip': person.zipcode,
      'City': person.city,
      'Role': person.rolename,
      'Ethnicity': person.ethinicity,
      'State': 'MD',
      'County': 'Anne Arundel',
      'Gender': person.gender,
      'county': person.county,
      'school': [],
      'Address': person.address,
      'emailID': [

      ],
      'testing': [

      ],
      'Lastname': person.lastname,
      'cjamspid': person.cjamspid,
      'employer': [

      ],
      'fullName': person.fullname,
      'guardian': {

      },
      'vocation': [

      ],
      'Firstname': person.firstname,
      'aliasname': person.aliasname,
      'emergency': [

      ],
      'personRole': person.roles ? person.roles.map((role: { intakeservicerequestpersontypekey: any; typedescription: any; }) => {
        return {
          'hidden': false,
          'rolekey': role.intakeservicerequestpersontypekey,
          'isprimary': 'true',
          'description': role.typedescription,
          'relationshiptorakey': ''
        };
      }) : [],
      /* [
        {
          'hidden': false,
          'rolekey': 'LG',
          'isprimary': 'true',
          'description': 'Legal Guardian',
          'relationshiptorakey': 'BGFTHR'
        },
        {
          'hidden': false,
          'rolekey': 'MP',
          'isprimary': 'false',
          'description': 'Medical Professional',
          'relationshiptorakey': 'BGFTHR'
        }
      ], */
      'substances': [

      ],
      'fullAddress':  person.address,
      'ishousehold': 'yes',
      'ishouseholdmember': person.ishousehold,
      'isheadofhousehold': person.isheadofhousehold,
      'personpayee': [

      ],
      'phoneNumber': [

      ],
      schoolname: person.schoolname,
      phonedetails: person.phonedetails,
      race: person.race,
      addressinfo: person.addressinfo,
      maritalstatus: person.maritalstatus,
      ssn: person.ssn,
      email: person.email,
      emaildetails: person.emaildetails,
      'Dangerousself': 'no',
      'Mentealimpair': 'no',
      'personsupport': [

      ],
      'physicianinfo': [

      ],
      'Mentealillness': 'no',
      'accomplishment': [

      ],
      'Dangerousworker': 'no',
      'healthinsurance': [

      ],
      'primarylanguage': 'ENG',
      'RelationshiptoRA': 'SELF',
      'persondentalinfo': [

      ],
      'personhealthexam': [

      ],
      'safehavenbabyflag': 1,
      'citizenalenageflag': '1',
      'personAddressInput': [
        {
          'city': 'Linthicum',
          'state': 'MD',
          'county': 'Anne Arundel',
          'endDate': '04/29/2019',
          'phoneNo': '',
          'zipcode': '21090',
          'Address2': '',
          'address1': '849 Internation',
          'addressid': '',
          'startDate': '',
          'activeflag': 1,
          'addresstype': '31',
          'addresstypeLabel': 'Home',
          'knownDangerAddress': '',
          'knownDangerAddressReason': ''
        }
      ],
      'personabusehistory': [

      ],
      'everbeenadoptedflag': person.everbeenadoptedflag,
      'personabusesubstance': [

      ],
      'drugexposednewbornflag': person.drugexposednewbornflag,
      'personbehavioralhealth': [

      ],
      'personmedicalcondition': [

      ],
      'sexoffenderregisteredflag': person.sexoffenderregisteredflag,
      'senstatusflag': person.senstatusflag,
      'fetalalcoholspctrmdisordflag': person.fetalalcoholspctrmdisordflag,
      'personmedicationphyscotropic': [

      ],
      'probationsearchconductedflag': person.probationsearchconductedflag

    };
  }
}





