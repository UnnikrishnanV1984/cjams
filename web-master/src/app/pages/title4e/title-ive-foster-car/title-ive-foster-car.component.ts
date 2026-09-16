import { Component, Injector, OnInit } from '@angular/core';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { FormGroup, FormArray, FormBuilder } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { AlertService, CommonHttpService, SessionStorageService, DataStoreService } from '../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { Titile4eUrlConfig } from '../_entities/title4e-dashboard-url-config';
import { Title4eService } from '../../title4e/services/title4e.service';
import { NavigationUtils } from '../../../pages/_utils/navigation-utils.service';
import moment from 'moment';
import _ from 'lodash';
import { DatePipe, Location } from '@angular/common';
import { AuthService } from '../../../@core/services/auth.service';
import { Title4eFosterCareService } from './title4e-foster-care.service';
import { AppConstants } from '../../../@core/common/constants';
import { Observable } from 'rxjs';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'title-ive-foster-car',
    templateUrl: './title-ive-foster-car.component.html',
    styleUrls: ['./title-ive-foster-car.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class TitleIveFosterCarComponent implements OnInit {
  SupervisorDetails: any;
  ageCalculate: any;
  WorkersList: any;
  supervisorList: any[]=[];
  caseNumber: any;
  workerList: any[] = [];
  iveUserRole: any = null;
  eventTableData: any[] = [];
  tempRows1 = Array();
  typeOfPlacement = ['Foster Care', 'Therapeutic foster care', 'Group Home', 'RCC', 'Formal Kinship Care', 'Provisional Kinship Care', 'Pre-Adoptive Home', 'Adoptive Home'];
  mainTanble = [];
  selectedPeriodItems = [];
  STATUS = ['Pending', 'Returned', 'Completed', 'Submitted', 'In progress', 'Approved'];
  TYPE = ['Foster-Care', 'Adoption', 'GAP', 'Foster Care 18-21', 'Adoption 18-21', 'GAP 18-21'];
  ELIGIBILITYSTATUS = ['Initial Determination', 'Corrected initial determination', 'Redetermination', 'Corrected redetermination', '180 day VPA redetermination'];
  JURISDICTION = ['ELK RDG', 'LINTHICUM', 'ELCOTT CITY'];
  approvesObj = [{
    status: '',
    type: '',
    elegibilityStatus: '',
    jurisdiction: ''
  }];
  approveData = [{
    status: '',
    type: '',
    elegibilityStatus: '',
    jurisdiction: ''
  }];
  determinationTransactionId: string='';
  FilterData = [];
  selectedSuperviser: any;
  worksheetForm!: FormGroup;
  worksheetData: any;
  generalForm!: FormGroup;
  ageDetailsForm!: FormGroup;
  otherCriteriaRdForm!: FormGroup;
  criteriaForm!: FormGroup;
  deprivationForm!: FormGroup;
  assetForm!: FormGroup;
  incomeForm!: FormGroup;
  removalHomeForm!: FormGroup;
  // removalTypeForm!: FormGroup;
  courtOrderForm!: FormGroup;
  legalForm!: FormGroup;
  demographicsForm!: FormGroup;
  placementForm!: FormGroup;
  missingFields!: FormGroup;
  ssiForm!: FormGroup;
  clientId: any;
  summaryInfo: any;
  activeModule: any = null;
  userInfo: any;
  getUsersList: any[]=[];
  removalId: any;
  placementId: any;
  isCPSAR: any;
  moduleview: any;
  dtformat = 'MM/DD/YYYY';
  responsibilityTypeDropdownItems$!: Observable<any[]>;
  
  private readonly router: Router;
  private readonly _commonHttpService: CommonHttpService;
  private readonly fb: FormBuilder;
  private readonly _dataStoreService: DataStoreService;
  private readonly _alertService: AlertService;
  public _authService: AuthService;
  private readonly route: ActivatedRoute;
  private readonly storage: SessionStorageService;
  private _service: Title4eFosterCareService;
  private readonly title4eService: Title4eService;

  constructor(private injector : Injector, 
              private readonly navigateutil: NavigationUtils, 
              private readonly _location: Location, public dialog: MatDialog) { 
    this.router = this.injector.get<Router>(Router);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this.fb = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.storage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._service = this.injector.get<Title4eFosterCareService>(Title4eFosterCareService);
    this.title4eService = this.injector.get<Title4eService>(Title4eService);

  }

  ngOnInit() {
    setTimeout(() => {
        this.moduleview = this._authService.isModuleAccessable('ivefc', 'ivefc');
        this._dataStoreService.setData('addNarrative', false);
        this.activeModule = this.storage.getItem('activeModuleNav');
        this.userInfo = this._authService.getCurrentUser();
        this.clientId = this.route.snapshot.params['clientId'];
        this.removalId = this.route.snapshot.params['removalId'];
        this.createForm();
        this.loadUsersList();
        this.getSummaryInfo();
        if(this.userInfo && this.userInfo.role &&  this.userInfo.role.name) {
          this.iveUserRole = this.userInfo.role.name;
        }
        this.legalForm?.controls.removalTypeForm.get('TypeOfRemoval')?.valueChanges.subscribe(val => {
          if (val === 'None') {
            this.legalForm?.controls.removalTypeForm.get('IsSafeHavenBaby')?.setValue('YES');
          }
        });
        if(this.activeModule === '4E Analyst'){
          this.getcaseassignment();
        }else{
          this._dataStoreService.setData('isivereadonly', false);
        }
        this.route.queryParams.subscribe(params => {
          if(params['retrydocument']) {
            $('#attachmentBtnTrigger').click();          
          }
        });
    }, 1000);
  }
  getcaseassignment() {
    const data = {
      clientId: this.clientId,
      removalId: this.removalId,
      module: 'fostercare'
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getiveassignment).subscribe(
      (response: any) => {
        if(response && response.length > 0 && response[0].getiveassignment === this.userInfo.user.securityusersid){
          this._dataStoreService.setData('isivereadonly', false);
        }else{
          this._dataStoreService.setData('isivereadonly', true);
        }
      });
  }

  navigateCaseNumber(data: any){
    this.navigateutil.routToServiceCase(data);
  }

  goBack() {
    this._location.back();
 }

  getSummaryInfo() {
    const data = {
      clientId: this.clientId,
      removalId: this.removalId
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getEligibilityWorksheet).subscribe(
      (response: any) => {
        this.summaryInfo = _.assign({}, _.get(response, "summaryInfo.0"), _.get(response, "generalInfo.0"));
        this.summaryInfo.specialistName = _.get(this.userInfo, "user.userprofile.fullname");
        if (response.householdInfo.length > 0 && response.householdInfo[0].getfinanceincomebycase.length > 0 ) {
          if(response.householdInfo[0].getfinanceincomebycase[0].servicecasenumber !== null ) {
              this.summaryInfo.casenumber = response.householdInfo[0].getfinanceincomebycase[0].servicecasenumber;
          }
          if (response.householdInfo[0].getfinanceincomebycase[0].servicecaseid !== null) {
            this.summaryInfo.servicecaseid = response.householdInfo[0].getfinanceincomebycase[0].servicecaseid;
          }
        }
        this._dataStoreService.setData('ivepersonnameselected', this.summaryInfo?.childname);
        this._dataStoreService.setData('ivepersoncjamspidselected', this.clientId);
      },
      (error) => {
        return false;
      }
    );
  }

  getEligibilityWorksheetData() {
    this._commonHttpService.getAll(Titile4eUrlConfig.EndPoint.getEligibilityWorksheet + this.clientId).subscribe(
      (response: any) => {
        this.worksheetData = response;
        this._service.fosterCareData = response;
        if (response.summaryInfo){
          this.setSummaryInfoData(response.summaryInfo[0]);}
        if (response.generalInfo){
          this.setGeneralInfoData(response.generalInfo[0]);}
        this.setcourtInfoData(response.courtInfo[0]);
        this.setRemovalInfoData(response.removalInfo[0]);
        this.setIncomeInfoData(response.incomeInfo[0]);
        this.setRedetCriteriaInfo(response.redetCriteriaInfo[0]);
        this.setEighteenCriteriaInfo(response.eighteenCriteriaInfo[0]);
        if (response.incomeInfo && response.incomeInfo.length > 0){
          this.setincomeInfoTable(response.incomeInfo[0].incometype);}
        this.setotherCriteriaIdTable(response.initialCriteriaInfo[0].specifiedrelatives);
        this.setssissaCriteriaInfo(response.ssissaCriteriaInfo[0]);

      },
      (error) => {
        return false;
      }
    );
  }
  get incomeSummaryForm() {
    return this.incomeForm?.get('incomeSummaryForm');
  }

  get incomeSUmmaryTable() {
    return this.incomeSummaryForm?.get('incomeSUmmaryTable') as FormArray;
  }
  get otherCriteriaIdForm() {
    return this.criteriaForm.get('otherCriteriaIdForm');
  }
  get otherCriteriaIdTable() {
    return this.otherCriteriaIdForm?.get('otherCriteriaIdTable') as FormArray;
  }
  setincomeInfoTable(data:any) {
    if (data) {
      data.forEach((val:any) => {
        this.incomeSUmmaryTable.push(
          this.fb.group({
            ClientID: val.client_id,
            involvedclientid: val.involvedclientid,
            involvedclientname: val.involvedclientname,
            InAU: val.assistanceunit,
            EarnedIncomeAmount: val.earnedincomeno,
            UnearnedIncomeType: [],
            UnearnedIncomeAmount: val.unearnedincome,
            IsIncomeDeemed: val.deemedincome,
            SupportExpenseAmount: val.supportexpenseamount,
            ivePersonIncomeiId: val.ivepersonincomeid
          })
        );
      });
    }
  }
  setotherCriteriaIdTable(data:any) {
    if (data) {
      data.forEach((val:any) => {
        this.otherCriteriaIdTable.push(
          this.fb.group({
            SpecifiedRelativeClientID: val.specifiedrelativeclientid ? val.specifiedrelativeclientid.toString() : null,
            SpecifiedRelativeName: val.specifiedrelativename,
            SpecifiedRelativeDateChildLastLivedWith: val.specifiedrelativedatechildlastlivedwith ? moment(val.specifiedrelativedatechildlastlivedwith).format(this.dtformat) : null,
            SpecifiedRelativePhysicalAddress: val.specifiedrelativephysicaladdress,
            SpecifiedRelativeRelationshipID: val.specifiedrelativerelationshipid,
            specifiedrelativerelationship: val.specifiedrelativerelationship,
          })
        );
      });
    }
  }

  transform(value: string): string {
    const today = moment();
    const birthdate = moment(value);
    const years = today.diff(birthdate, 'years');
    this.ageCalculate = `${years} yr `;
    this.ageCalculate += `${today.subtract(years, 'years').diff(birthdate, 'months')} mon`;
    return this.ageCalculate;
  }

  setSummaryInfoData(data:any) {
    this.worksheetForm.get('clientId')?.setValue(data.cjams_pid);
    this.worksheetForm.get('fullName')?.setValue(data.childname);
    this.worksheetForm.get('dob')?.setValue(data.dateofbirth);
    this.worksheetForm.get('JURISDICTION')?.setValue(data.childjurisdiction);
    this.worksheetForm.get('dateOfRemoval')?.setValue(this.convertToDate(data.removaldate));
    this.worksheetForm.get('casenumber')?.setValue(data.casenumber);
    this.worksheetForm.get('ageOfRemoval')?.setValue(data.removalage);
    this.worksheetForm.get('Agency')?.setValue(data.childagency);
    this.storage.setObj('casenumber', data.servicecaseid);
  }

  setGeneralInfoData(data:any) {
    this.generalForm.controls.placementForm.get('DateOfChildPlacement')?.setValue(this.convertToDate(data.dateofchildplacement));
    this.generalForm.controls.placementForm.get('DateOfLivingArrangement')?.setValue(this.convertToDate(data.dateoflivingarrangement));
    this.criteriaForm?.controls.otherCriteriaRdForm.get('IsLivingArrangementSameAsPlacement')?.setValue(data.islivingarrangementsameasplacement);
    this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.setValue(data.isplacementeligible);
    this.generalForm.controls.demographicsForm.get('IsDJSOrDSSChild')?.setValue(data.isdjsordsschild);
    this.incomeForm?.controls.incomeSummaryForm.get('ClientID')?.setValue(data.cjamspid);
    this.generalForm.controls.demographicsForm.get('DateOfBirth')?.setValue(this.convertToDate(data.dateofbirth));
    this.generalForm.controls.demographicsForm.get('USCitizen')?.setValue(data.uscitizen);
    this.generalForm.controls.demographicsForm.get('QualifiedAlien')?.setValue(data.qualifiedalien);
    this.generalForm.controls.demographicsForm.get('QualifiedAlienStaus')?.setValue(data.qualifiedalienstaus);
    this.generalForm.controls.demographicsForm.get('AlienRegistrationNumber')?.setValue(data.alienregistrationnumber);
  }

  convertToDate(date:string) {
    return date ? new Date(date) : null;
  }

  setcourtInfoData(data:any) {
    this.legalForm?.controls?.removalTypeForm?.get('RemovalId')?.setValue(data.removal_id);
    this.legalForm?.controls.courtOrderForm.get('TypeOfCourtHearing')?.setValue(data.typeofcourthearing);
    this.legalForm?.controls.courtOrderForm.get('DateOfCourtHearing')?.setValue(this.convertToDate(data.dateofcourthearing));
    this.legalForm?.controls.courtOrderForm.get('CTWDecision')?.setValue(data.ctwdecision);
    this.legalForm?.controls.courtOrderForm.get('DateOfFindingCTWDecision')?.setValue(this.convertToDate(data.dateoffindingctwdecision));
    this.legalForm?.controls.courtOrderForm.get('NameOfSubjectCTWFinding')?.setValue(data.nameofsubjectctwfinding);
    this.legalForm?.controls.courtOrderForm.get('ClientIDOfSubjectCTWFinding')?.setValue(data.clientidofsubjectctwfinding);
    this.legalForm?.controls.courtOrderForm.get('RelationshipOfSubjectCTWFinding')?.setValue(data.relationshipofsubjectctwfinding);
    this.legalForm?.controls.courtOrderForm.get('CourtOrderDelayRemoval')?.setValue(data.courtorderdelayremoval);
    this.legalForm?.controls.courtOrderForm.get('CourtOrderDelayTimeFrame')?.setValue(data.courtorderdelaytimeframe);
    this.legalForm?.controls.courtOrderForm.get('ReasonableEffortsMade')?.setValue(data.reasonableeffortsmade);
    this.legalForm?.controls.courtOrderForm.get('ReasonableEffortsNotNecessaryDueToEmergentCircumstances')?.setValue(data.reasonableeffortsnotnecessaryduetoemergentcircumstances);
    this.legalForm?.controls.courtOrderForm.get('REFPPNotDue')?.setValue(data.refppnotdue);
    this.legalForm?.controls.courtOrderForm.get('DateOfJudicialFindingOfREFPP')?.setValue(this.convertToDate(data.dateofjudicialfindingofreffpp));
    this.legalForm?.controls.courtOrderForm.get('DateOfCurrentJudicialFindingOfREFPP')?.setValue(this.convertToDate(data.dateofcurrentjudicialfindingofrefpp));
    this.legalForm?.controls.courtOrderForm.get('DateOfPreviousJudicialFindingOfREFPP')?.setValue(this.convertToDate(data.dateofpreviousjudicialfindingofrefpp));
    this.legalForm?.controls.courtOrderForm.get('DateOfSubsequentJudicialFindingOfREFPP')?.setValue(this.convertToDate(data.dateofsubsequentjudicialfindingofrefpp));
    this.legalForm?.controls.courtOrderForm.get('DateOfBestInterestFinding')?.setValue(this.convertToDate(data.dateofbestinterestfinding));
    this.legalForm?.controls.courtOrderForm.get('DateOfCurrentJudicialFindingOfBestInterest')?.setValue(this.convertToDate(data.dateofcurrentjudicialfindingofbestinterest));
    this.legalForm?.controls.courtOrderForm.get('DateOfPreviousBestInterestFinding')?.setValue(this.convertToDate(data.dateofpreviousbestinterestfinding));
    this.legalForm?.controls.courtOrderForm.get('DateOfSubsequentFindingOfBestInterest')?.setValue(this.convertToDate(data.dateofsubsequentfindingofbestinterest));
    this.legalForm?.controls.courtOrderForm.get('FosterCarePermanencyPlan')?.setValue(data.fostercarepermanencyplan);
    this.legalForm?.controls.courtOrderForm.get('IsIVEAgencyResponsibleForPlacementAndCare')?.setValue(data.iveagencyresponsibleforplacementandcare);
    this.legalForm?.controls.courtOrderForm.get('MagistrateOrJudgeName')?.setValue(data.magistrateorjudgename);
    this.legalForm?.controls.courtOrderForm.get('DateOfNextHearing')?.setValue(this.convertToDate(data.dateofnexthearing));
    this.legalForm?.controls.courtOrderForm.get('SignedByJudge')?.setValue(data.issignedbyjudge);
    this.legalForm?.controls.courtOrderForm.get('DateAgencyLostLegalResponsibility')?.setValue(this.convertToDate(data.dateagencylostlegalresponsibility));
    this.title4eService.getRemovalId(data.removal_id);
    this.legalForm?.controls.courtOrderForm.get('CourtOrderDelayTimeFrame')?.setValue(data.courtorderdelaytimedays);
    this.legalForm?.controls.courtOrderForm.get('IsIVEAgencyResponsibleForPlacementAndCare')?.setValue(data.isiveagencyresponsibleforplacementandcare);
  }

  setRemovalInfoData(data:any) {
    this.legalForm?.controls.removalTypeForm.get('TypeOfRemoval')?.setValue(data.typeofremoval);
    this.legalForm?.controls.removalTypeForm.get('CourtOrdered')?.setValue(data.courtordered);
    this.legalForm?.controls.removalTypeForm.get('TypeOfVPA')?.setValue(data.typeofvpa);
    this.legalForm?.controls.removalTypeForm.get('IsSafeHavenBaby')?.setValue(data.issafehavenbaby);

    this.legalForm?.controls.removalHomeForm.get('ChildPhysicalRemovalDate')?.setValue(data.childphysicalremovaldate);
    this.legalForm?.controls.removalHomeForm.get('ChildPhysicalAddressAfterRemoval')?.setValue(data.childphysicaladdressafterremoval);
    this.legalForm?.controls.removalHomeForm.get('ClientIDOfPersonFromWhomChildWasPhysicallyRemoved')?.setValue(data.clientnameofpersonfromwhomchildwasphysicallyremoved);
    this.legalForm?.controls.removalHomeForm.get('RelationshipIDOfPersonFromWhomChildWasPhysicallyRemoved')?.setValue(data.relationshipofpersonfromwhomchildwasphysicallyremoved ? data.relationshipofpersonfromwhomchildwasphysicallyremoved : null);
    this.legalForm?.controls.removalHomeForm.get('DateOf1stParentSignatureOnVPA')?.setValue(this.convertToDate(data.dateof1stparentsignatureonvpa));
    this.legalForm?.controls.removalHomeForm.get('DateOf2ndParentSignatureOnVPA')?.setValue(this.convertToDate(data.dateof2ndparentsignatureonvpa));
    this.legalForm?.controls.removalHomeForm.get('MandatoryNoteOnMissing2ndParentSignatureOnVPA')?.setValue(data.mandatorynoteonmissing2ndparentsignatureonvpa);
    this.legalForm?.controls.removalHomeForm.get('DateOfYouthSignatureOnVPA')?.setValue(this.convertToDate(data.dateofyouthsignatureonvpa));
    this.legalForm?.controls.removalHomeForm.get('PreviousFosterCareEpisodeExist')?.setValue(data.previousfostercareepisodeexist);
    this.legalForm?.controls.removalHomeForm.get('ReasonForExit')?.setValue(data.reasonforexit);
    this.legalForm?.controls.removalHomeForm.get('ExitCareDateFromPreviousFosterCareEpisode')?.setValue(this.convertToDate(data.exitcaredatefrompreviousfostercareepisode));
    this.legalForm?.controls.removalHomeForm.get('DateOfGuardianSignatureOnVPA')?.setValue(this.convertToDate(data.dateofguardiansignatureonvpa));
    this.legalForm?.controls.removalHomeForm.get('ClientIDWhoSignedVPA')?.setValue(data.clientnamewhosignedvpa);
    this.legalForm?.controls.removalHomeForm.get('DateOfLDSSSignatureOnVPA')?.setValue(this.convertToDate(data.dateofldsssignatureonvpa));
    this.legalForm?.controls.courtOrderForm.get('DateOfReasonableEffortsCourtHearing')?.setValue(this.convertToDate(data.dateofreasonableeffortscourthearing));
    this.criteriaForm?.controls.otherCriteriaRdForm.get('IsReasonableEffortsFindingTimely')?.setValue(data.isreasonableeffortsfindingtimely);
  }

  setIncomeInfoData(data:any) {
    this.incomeForm?.controls.incomeSummaryForm.get('EarnedIncomeAmount')?.setValue(data.earnedincome);
    this.incomeForm?.controls.incomeSummaryForm.get('UnearnedIncomeAmount')?.setValue(data.unearnedincomeamount);
    this.incomeForm?.controls.incomeSummaryForm.get('UnearnedIncomeType')?.setValue(data.unearnedincometype);
    this.incomeForm?.controls.incomeSummaryForm.get('IsIncomeDeemed')?.setValue(data.isincomedeemed);
    this.incomeForm?.controls.incomeSummaryForm.get('NoOfMembersInAU')?.setValue(data.noofmembersinau);
    this.incomeForm?.controls.incomeSummaryForm.get('NoOfMembersNotInAU')?.setValue(data.noofmembersnotinau);
    this.incomeForm?.controls.incomeSummaryForm.get('GrossIncome185PctForAU')?.setValue(data.grossincome185pct);
    this.incomeForm?.controls.deprivationForm.get('ChildDeprivedOfParentalSupport')?.setValue(data.childdeprivedofparentalsupport);
    this.incomeForm?.controls.deprivationForm.get('ReasonForAbsence')?.setValue(data.reasonforabsence);
    this.incomeForm?.controls.incomeSummaryForm.get('InAU')?.setValue(data.inau);

    this.incomeForm?.controls.incomeSummaryForm.get('TypeOfBenefit')?.setValue(data.typeofbenefit);
    this.incomeForm?.controls.assetForm.get('AssetAllowance')?.setValue(data.assetallowance);
    this.incomeForm?.controls.assetForm.get('AssetsMarketValue')?.setValue(data.assetsmarketvalue);
    this.incomeForm?.controls.deprivationForm.get('DeprivationFactor')?.setValue(data.deprivationfactor);
    this.incomeForm?.controls.deprivationForm.get('DateOfParentDeath')?.setValue(this.convertToDate(data.dateofparentdeath));
    this.incomeForm?.controls.deprivationForm.get('IncarcerationDate')?.setValue(this.convertToDate(data.incarcerationdate));
    this.incomeForm?.controls.deprivationForm.get('Unemployment')?.setValue(data.unemploymentorunderemployment);
    this.incomeForm?.controls.incomeSummaryForm.get('AmountOfBenefit')?.setValue(data.benefitamount);
    this.incomeForm?.controls.incomeSummaryForm.get('TotalChildCareCost')?.setValue(data.childcarecost);
    this.incomeForm?.controls.incomeSummaryForm.get('StandardOfNeedForNotInAU')?.setValue(data.notinstandardunitno);
    this.incomeForm?.controls.incomeSummaryForm.get('StandardOfNeedForAU')?.setValue(data.standardunitno);
  }

  setRedetCriteriaInfo(data:any) {
    this.criteriaForm?.controls.otherCriteriaRdForm.get('ChildBeenInFosterCare')?.setValue(data.childbeeninfostercare12monthormore);
  }

  setssissaCriteriaInfo(data:any) {
    this.criteriaForm?.controls.ssiForm.get('ChildReceivingSSIOrSSADuringReviewPeriod')?.setValue(data.childreceivingssiorssa);
    this.criteriaForm?.controls.ssiForm.get('IsTheAgencyTheRepresentativePayee')?.setValue(data.agencyrepresentativeflag);
    this.criteriaForm?.controls.ssiForm.get('WHOISTHEREPERSINTIVEPAYEE')?.setValue(data.whoisrepresentativepayee);
    this.criteriaForm?.controls.ssiForm.get('HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE')?.setValue(data.suspendssipaymentflag);
    this.criteriaForm?.controls.ssiForm.get('ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE')?.setValue(data.reasonfornotsuspendingssipayment);
    this.criteriaForm?.controls.ssiForm.get('ReasonForWhyTheAgencyISNOTTheRepresentativePayee')?.setValue(data.reasonforagencynotrepresentativepayee);
  }

  setEighteenCriteriaInfo(data:any) {
    this.criteriaForm?.controls.ageDetailsForm.get('NameOfSecondaryEducationOrEquivalentProgram')?.setValue(data.nameofsecondaryeducationorequivalentprogram);
    this.criteriaForm?.controls.ageDetailsForm.get('StartDateOfSecondaryEducationOrEquivalentProgram')?.setValue(data.startdateofsecondaryeducationorequivalentprogram);
    this.criteriaForm?.controls.ageDetailsForm.get('NameOfpostSecondaryOrVocationalEducation')?.setValue(data.nameofpostsecondaryorvocationaleducation);
    this.criteriaForm?.controls.ageDetailsForm.get('StartDateOfpostSecondaryOrVocationalEducation')?.setValue(data.startdateofpostsecondaryorvocationaleducation);
    this.criteriaForm?.controls.ageDetailsForm.get('NameOfPromoteToEmploymentProgram')?.setValue(data.nameofpromotetoemploymentprogram);
    this.criteriaForm?.controls.ageDetailsForm.get('StartDateOfPromoteToEmploymentProgram')?.setValue(data.startdateofpromotetoemploymentprogram);
    this.criteriaForm?.controls.ageDetailsForm.get('NameOfEmployer')?.setValue(data.nameofemployer);
    this.criteriaForm?.controls.ageDetailsForm.get('StartDateOfEmployment')?.setValue(data.startdateofemployment);
    this.criteriaForm?.controls.ageDetailsForm.get('HoursPerMonthEmployed')?.setValue(data.hourspermonthemployed);
    this.criteriaForm?.controls.ageDetailsForm.get('ChildDisabilityType')?.setValue(data.childdisabilitytype);
    this.criteriaForm?.controls.ageDetailsForm.get('ChildDisabilityStartDate')?.setValue(data.childdisabilitystartdate);
    this.criteriaForm?.controls.ageDetailsForm.get('ChildDisabilityEvaluationDocumentionDate')?.setValue(data.childdisabilityevaluationdocumentiondate);
    this.criteriaForm?.controls.ageDetailsForm.get('IsThereValidSILAAgreement')?.setValue(data.istherevalidsilaagreement);
    this.criteriaForm?.controls.ageDetailsForm.get('DateOfValidSILAAgreement')?.setValue(data.dateofvalidsilaagreement);
  }

  getTableData(tabdata:any) {
    tabdata.controls.forEach((element:any) => {
      this.tempRows1.push(
        {
          unearnedIncome: [{
            UnearnedIncomeType: element.value.UnearnedIncomeType,
            UnearnedIncomeAmount: element.value.UnearnedIncomeAmount
          }],
          IsIncomeDeemed: element.value.IsIncomeDeemed,
          supportExpense: [{
            SupportExpenseAmount: element.value.SupportExpenseAmount,
          }],
          ClientID: element.value.ClientId,
          InAU: element.value.InAU,
          earnedIncome: [{
            EarnedIncomeAmount: element.value.EarnedIncomeAmount,
          }]
        });
    });

  }

  createForm() {
    this.worksheetForm = this.fb.group({
      status: [],
      casenumber: [],
      fullName: [],
      clientId: [],
      dob: [],
      JURISDICTION: [],
      dateOfRemoval: [],
      ageOfRemoval: [],
      Agency: []
    });
    this.generalForm = this.fb.group({
      placementForm: this.fb.group({
        DateOfChildPlacement: [],
        DateOfLivingArrangement: []
      }),
      demographicsForm: this.fb.group({
        IsDJSOrDSSChild: [],
        DateOfBirth: [],
        USCitizen: [],
        QualifiedAlien: [],
        QualifiedAlienStaus: [],
        AlienRegistrationNumber: []
      })
    });

    this.legalForm = this.fb.group({
      courtOrderForm: this.fb.group({
        TypeOfCourtHearing: [],
        DateOfCourtHearing: [],
        CTWDecision: [],
        DateOfFindingCTWDecision: [],
        NameOfSubjectCTWFinding: [],
        ClientIDOfSubjectCTWFinding: [],
        RelationshipOfSubjectCTWFinding: [],
        CourtOrderDelayRemoval: [],
        CourtOrderDelayTimeFrame: [],
        ReasonableEffortsMade: [],
        ReasonableEffortsNotNecessaryDueToEmergentCircumstances: [],
        REFPPNotDue: [],
        DateOfReasonableEffortsCourtHearing: [],
        DateOfJudicialFindingOfREFPP: [],
        DateOfCurrentJudicialFindingOfREFPP: [],
        DateOfPreviousJudicialFindingOfREFPP: [],
        DateOfSubsequentJudicialFindingOfREFPP: [],
        DateOfBestInterestFinding: [],
        DateOfCurrentJudicialFindingOfBestInterest: [],
        DateOfPreviousBestInterestFinding: [],
        DateOfSubsequentFindingOfBestInterest: [],
        FosterCarePermanencyPlan: [],
        IsIVEAgencyResponsibleForPlacementAndCare: [],
        MagistrateOrJudgeName: [],
        DateOfNextHearing: [],
        SignedByJudge: [],
        DateAgencyLostLegalResponsibility: []
      }),
      removalTypeForm: this.fb.group({
        RemovalId: [],
        TypeOfRemoval: [],
        CourtOrdered: [],
        TypeOfVPA: [],
        IsSafeHavenBaby: []
      }),
      removalHomeForm: this.fb.group({
        ChildPhysicalRemovalDate: [],
        ChildPhysicalAddressAfterRemoval: [],
        ClientIDOfPersonFromWhomChildWasPhysicallyRemoved: [],
        RelationshipIDOfPersonFromWhomChildWasPhysicallyRemoved: [],
        DateOf1stParentSignatureOnVPA: [],
        DateOf2ndParentSignatureOnVPA: [],
        MandatoryNoteOnMissing2ndParentSignatureOnVPA: [],
        DateOfYouthSignatureOnVPA: [],
        PreviousFosterCareEpisodeExist: [],
        ReasonForExit: [{ value: '', disabled: false }],
        ExitCareDateFromPreviousFosterCareEpisode: [],
        DateOfGuardianSignatureOnVPA: [],
        ClientIDWhoSignedVPA: [],
        DateOfLDSSSignatureOnVPA: []
      })
    });
    this.incomeForm = this.fb.group({
      incomeSummaryForm: this.fb.group({
        ClientID: [],
        EarnedIncomeAmount: [],
        UnearnedIncomeAmount: [],
        UnearnedIncomeType: [],
        AmountOfBenefit: [],
        SupportExpenseAmount: [],
        TotalChildCareCost: [],
        TypeOfBenefit: [],
        IsIncomeDeemed: [],
        NoOfMembersInAU: [],
        NoOfMembersNotInAU: [],
        StandardOfNeedForAU: [],
        StandardOfNeedForNotInAU: [],
        GrossIncome185PctForAU: [],
        InAU: [],
        incomesummaryInfo: [],
        incomeSUmmaryTable: this.fb.array([])
      }),
      assetForm: this.fb.group({
        AssetAllowance: [],
        AssetsMarketValue: []
      }),
      deprivationForm: this.fb.group({
        ChildDeprivedOfParentalSupport: [],
        ReasonForAbsence: [],
        DeprivationFactor: [],
        DateOfParentDeath: [],
        IncarcerationDate: [],
        Unemployment: []
      })
    });
    this.criteriaForm = this.fb.group({
      otherCriteriaIdForm: this.fb.group({
        SpecifiedRelativeClientID: [],
        SpecifiedRelativeDateChildLastLivedWith: [],
        SpecifiedRelativeName: [],
        SpecifiedRelativePhysicalAddress: [],
        SpecifiedRelativeRelationshipID: [],
        FosterCareEligibilityStatus: [],
        otherCriteriaIdTable: this.fb.array([])
      }),
      otherCriteriaRdForm: this.fb.group({
        IsLivingArrangementSameAsPlacement: [],
        IsPlacementEligible: [],
        ChildBeenInFosterCare: [],
        HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency: [],
        TypeOfLapses: [],
        FosterCareRedeterminationStage: [],
        FosterCareReviewPeriodEndDate: [],
        FosterCareReviewPeriodStartDate: [],
        EventReason: [],
        EventStage: [],
        EventStartDate: [],
        EventEndDate: [],
        EventStatus: [],
        FosterCareRedeterminationCompletionDate: [],
        FosterCareRedeterminationEligibilityStatus: [],
        FosterCareRedeterminationEligibilityStatusWithEventChange: [],
        IsThereAnyReasonableEffortsFindingDuringReviewPeriod: [],
        IsReasonableEffortsFindingTimely: []
      }),
      ageDetailsForm: this.fb.group({
        NameOfSecondaryEducationOrEquivalentProgram: [],
        StartDateOfSecondaryEducationOrEquivalentProgram: [],
        NameOfpostSecondaryOrVocationalEducation: [],
        StartDateOfpostSecondaryOrVocationalEducation: [],
        NameOfPromoteToEmploymentProgram: [],
        StartDateOfPromoteToEmploymentProgram: [],
        NameOfEmployer: [],
        StartDateOfEmployment: [],
        HoursPerMonthEmployed: [],
        ChildDisabilityType: [],
        ChildDisabilityStartDate: [],
        ChildDisabilityEvaluationDocumentionDate: [],
        IsThereValidSILAAgreement: [],
        DateOfValidSILAAgreement: []
      }),
      ssiForm: this.fb.group({
        ChildReceivingSSIOrSSADuringReviewPeriod: [],
        IsTheAgencyTheRepresentativePayee: [],
        WHOISTHEREPERSINTIVEPAYEE: [],
        HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE: [],
        ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE: [],
        ReasonForWhyTheAgencyISNOTTheRepresentativePayee: []
      })
    });
    this.missingFields = this.fb.group({
      FosterCareReviewPeriodEndDate: [],
      ChildFosterCareEntryDate: [],
      ChildBeenInFosterCare12MonthOrMore: [],
      Step: [],
    });
  }
  // modal implementation start
  getSupervisorDetails() {
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'PTA' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result) => {
        this.supervisorList = result.data.filter(s => s.issupervisor);
      });
  }



  showSupervisorList() {
    this.title4eService.getUsersList().subscribe(result => {
        this.getUsersList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
    });
    $('#myModal5').modal('show');
  }


  submitClentCase() {

    if(this.selectedSuperviser){
      this._commonHttpService
        .create({
          method: 'post'
        },
          'titleivefc/fc/determination-transaction-id/' + this.determinationTransactionId
        )
        .subscribe((result) => {
          this._alertService.success(result.message);
        });
        const message = 'Placement for ' + this._service.fosterCareData.summaryInfo[0].casenumber + 'sent for Review';
      const data = {
        'where': {
          'assignedtoid': this.selectedSuperviser.userid,
          'eventcode': 'PLTR',
          'servicecaseid': this._service.fosterCareData.summaryInfo[0].servicecaseid,
          'status': 'SplReview',
          'notifymsg': message,
          'routeddescription': message,
          'comments': message,
        }
      };

      this.title4eService?.routingUpdate(data)?.subscribe(response => {
        this._alertService.success('Case Assigned Successfully ');
        $('#caseassign').modal('hide');
        $('#assign').modal('hide');
        // go back to dashboard
      });
    }else{
      this._alertService.error('Select a Supervisor');
    }

  }
  selectPerson(person:any) {
    this.selectedSuperviser = person;
  }


  closePopup() {
    $('#worker-caseassign').modal('hide');
  }
  // modal implementation end

  approveSubmit() {
    this.approvesObj = this.approveData;
  }
  onPeriodStartDate(item:any) {
    this.eventTableData = item.filter((s:any) => s.v_start_dt === item[0].v_start_dt);
  }

  addSpecifiedRelative(): FormGroup {
    return this.fb.group({
      SpecifiedRelativeDateChildLastLivedWith: [],
      SpecifiedRelativePhysicalAddress: [],
      SpecifiedRelativeName: [],
      SpecifiedRelativeClientID: [],
      SpecifiedRelativeRelationshipID: []
    });
  }
  onSearch(field: string, value: string) {
    this.router.navigate(['/pages/title4e/foster-care']);
  }

  submitDetermination(obj:{clientId:any, removalId:any, initialEligibleStatus:any, selectedPeriods:any, educationinformation:any, employmentinformation:any, employmentbarrierinfomation:any, disablityinformation:any, annual21Bday:any}) {
    // const obj = {
    //   clientId,
    //   removalId,
    //   initialEligibleStatus,
    //   selectedPeriods,
    //   educationinformation,
    //   employmentinformation,
    //   employmentbarrierinfomation,
    //   disablityinformation,
    //   annual21Bday
    // }

    this._commonHttpService.create(obj, Titile4eUrlConfig.EndPoint.auditPeriods).subscribe(
      (response) => {
        try {
          let status = true;
          response.selectedPeriods.forEach((determinationResult:any) => {
            if(determinationResult.result.status !== "success"){
              status = false;
              this._alertService.warn(determinationResult.result.msg);
            }
          });

          if(status){
            this._alertService.success('Eligibility Worksheet summary sent successfully!');
          }
          const eligibilityBtn = document.getElementById('eligibilityDetailsBtnTrigger')
          if (eligibilityBtn) {
            eligibilityBtn.click();
          }
        } catch (error) {
          this._alertService.error('Unable to send Eligibility Worksheet summary, please try again.');
          return false;
        }
      },
      (error) => {
        this._alertService.error('Unable to send Eligibility Worksheet summary, please try again.');
        return false;
      }
    );
  }

  submitForReview(worker:any, i:number) {
    this.workerList.splice(i, 1);
  }

  getHouseholdData(data:any) {
    return data.map((v:any) => {
      return {
        'unearnedIncome': [{
          '__metadata': {
            '#type': 'UnearnedIncome',
            '#id': 'UnearnedIncome_id_1'
          },
          'UnearnedIncomeAmount': v.UnearnedIncomeAmount ? v.UnearnedIncomeAmount.UnearnedIncomeAmount : null,
          'UnearnedIncomeType': v.UnearnedIncomeAmount.UnearnedIncomeType ? v.UnearnedIncomeAmount.UnearnedIncomeType : null,
        }],
        'IsIncomeDeemed': v.IsIncomeDeemed,
        'supportExpense': [{
          'SupportExpenseAmount': v.SupportExpenseAmount,
          '__metadata': {
            '#type': 'SupportExpense',
            '#id': 'SupportExpense_id_1'
          }
        }],
        'ClientID': v.ClientID,
        'InAU': v.InAU,
        '__metadata': {
          '#type': 'HouseholdMember',
          '#id': 'HouseholdMember_id_1'
        },
        'earnedIncome': [{
          'EarnedIncomeAmount': v.EarnedIncomeAmount,
          '__metadata': {
            '#type': 'EarnedIncome',
            '#id': 'EarnedIncome_id_1'
          }
        }]
      };
    });
  }
  
  getFCEvents() {
    const fcEvents = [
      {
        'EventReason': 'PC',
        'IsLivingArrangementSameAsPlacement': this.criteriaForm?.controls.otherCriteriaRdForm?.get('IsLivingArrangementSameAsPlacement')?.value,
        'HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency': null,
        'EventStatus': null,
        'Step': null,
        'TypeOfLapses': this.criteriaForm?.controls.otherCriteriaRdForm.get('TypeOfLapses')?.value,
        'EventStage': 'E1',
        IsPlacementEligible: this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.value,
        'EventEndDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value).format(this.dtformat) : null,
        'IsReasonableEffortsFindingTimely': null,
        'EventStartDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value).format(this.dtformat) : null,
        'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
        '__metadata': {
          '#type': 'FosterCareEvents',
          '#id': 'FosterCareEvents_id_1'
        },
        'FosterCareRedeterminationEligibilityStatusWithEventChange': null
      },
      {
        'EventReason': 'PC',
        'IsLivingArrangementSameAsPlacement': this.criteriaForm?.controls.otherCriteriaRdForm.get('IsLivingArrangementSameAsPlacement')?.value,
        'HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency': null,
        'EventStatus': null,
        'Step': null,
        'TypeOfLapses': this.criteriaForm?.controls.otherCriteriaRdForm.get('TypeOfLapses')?.value,
        'EventStage': 'E2',
        IsPlacementEligible: this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.value,
        'EventEndDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value).format(this.dtformat) : null,
        'IsReasonableEffortsFindingTimely': null,
        'EventStartDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value).format(this.dtformat) : null,
        'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
        '__metadata': {
          '#type': 'FosterCareEvents',
          '#id': 'FosterCareEvents_id_2'
        },
        'FosterCareRedeterminationEligibilityStatusWithEventChange': null
      },
      {
        'EventReason': 'PC',
        'IsLivingArrangementSameAsPlacement': this.criteriaForm?.controls.otherCriteriaRdForm.get('IsLivingArrangementSameAsPlacement')?.value,
        'HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency': null,
        'EventStatus': null,
        'Step': null,
        'TypeOfLapses': this.criteriaForm?.controls.otherCriteriaRdForm.get('TypeOfLapses')?.value,
        'EventStage': 'E3',
        IsPlacementEligible: this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.value,
        'EventEndDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value).format(this.dtformat) : null,
        'IsReasonableEffortsFindingTimely': null,
        'EventStartDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value).format(this.dtformat) : null,
        'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
        '__metadata': {
          '#type': 'FosterCareEvents',
          '#id': 'FosterCareEvents_id_3'
        },
        'FosterCareRedeterminationEligibilityStatusWithEventChange': null
      },
      {
        'EventReason': 'PC',
        'IsLivingArrangementSameAsPlacement': this.criteriaForm?.controls.otherCriteriaRdForm.get('IsLivingArrangementSameAsPlacement')?.value,
        'HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency': null,
        'EventStatus': null,
        'Step': null,
        'TypeOfLapses': this.criteriaForm?.controls.otherCriteriaRdForm.get('TypeOfLapses')?.value,
        'EventStage': 'E4',
        IsPlacementEligible: this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.value,
        'EventEndDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value).format(this.dtformat) : null,
        'IsReasonableEffortsFindingTimely': null,
        'EventStartDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value).format(this.dtformat) : null,
        'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
        '__metadata': {
          '#type': 'FosterCareEvents',
          '#id': 'FosterCareEvents_id_4'
        },
        'FosterCareRedeterminationEligibilityStatusWithEventChange': null
      },
      {
        'EventReason': 'PC',
        'IsLivingArrangementSameAsPlacement': this.criteriaForm?.controls.otherCriteriaRdForm.get('IsLivingArrangementSameAsPlacement')?.value,
        'HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency': null,
        'EventStatus': null,
        'Step': null,
        'TypeOfLapses': this.criteriaForm?.controls.otherCriteriaRdForm.get('TypeOfLapses')?.value,
        'EventStage': 'E5',
        'IsPlacementEligible': this.criteriaForm?.controls.otherCriteriaRdForm.get('IsPlacementEligible')?.value,
        'EventEndDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventEndDate')?.value).format(this.dtformat) : null,
        'IsReasonableEffortsFindingTimely': null,
        'EventStartDate': this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value ?
          moment(this.criteriaForm?.controls.otherCriteriaRdForm.get('EventStartDate')?.value).format(this.dtformat) : null,
        'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
        '__metadata': {
          '#type': 'FosterCareEvents',
          '#id': 'FosterCareEvents_id_5'
        },
        'FosterCareRedeterminationEligibilityStatusWithEventChange': null
      }
    ];

    if (this.selectedPeriodItems.filter((v:any)=> v.sqnm_sw === 'R1E1' || v.sqnm_sw === 'R2E1').length > 0) {
      return fcEvents;
    }
    return [];
  }



  loadUsersList() {
    this.title4eService.getUsersList().subscribe(result => {
      this.supervisorList = result.data.filter(user => user.rolecode === AppConstants.ROLES.TITLE_IVE_SUPERVISOR);
    });
  }
  selectResponsibilityType(event:any){

  }
}
