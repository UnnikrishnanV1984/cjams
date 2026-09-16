
import {forkJoin as observableForkJoin,  Observable ,  Subject } from 'rxjs';

import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit, ChangeDetectorRef, AfterViewChecked, Injector } from '@angular/core';
import { CommonHttpService, AlertService, DataStoreService, GenericService, AuthService, SessionStorageService } from '../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { ReportSummary, SearchRecording, DSDSActionSummary } from '../../_entities/caseworker.data.model';
import { ObjectUtils } from '../../../../@core/common/initializer';
import { RecordingNotes } from '../recording/_entities/recording.data.model';
import { CountyDetail, IncomeDetail, AssetDetail, InvestigationFinding } from './_entities/investigation-finding.data.model';
import { InvolvedPerson, Medicationinformation, Medicalinformation, MedicalCondition } from '../involved-persons/_entities/involvedperson.data.model';
import { InvestigationFindingStoreConstants } from './as-maltreatment-information-constant';
import { MaltreatmentInformation } from '../maltreatment-information/_entites/maltreatment.data.model';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'as-maltreatment-information',
    templateUrl: './as-maltreatment-information.component.html',
    styleUrls: ['./as-maltreatment-information.component.scss'],
    standalone: false
})
export class AsMaltreatmentInformationComponent implements OnInit, AfterViewChecked {

  mdCountys$: Observable<CountyDetail[]>;
  maltreatementForm: FormGroup;
  serviceworkerForm: FormGroup;
  clientsLivingSituationFormGroup: FormGroup;
  countyAddresses = [];
  dsdsActionsSummary = new DSDSActionSummary();
  id: string;
  reportSummary: ReportSummary;
  paginationInfo: PaginationInfo = new PaginationInfo();
  recording$: Observable<RecordingNotes[]>;
  totalRecords$: Observable<number>;
  private pageSubject$ = new Subject<number>();
  private recordSearch = new SearchRecording();
  personType = 'Involved';
  supportedPersons = [];
  supportedPersonsSave = [];
  guardian = [];
  suporter: { personType: string, person: string, type: string, desc: string };
  personRoles : Array<any> = [];
  isInitialLoad = false;
  guardianRole: InvolvedPerson[] = [];
  legalInformationFormGroup: FormGroup;
  medicationForm: FormGroup;
  clientSupport: FormGroup;
  financialDisclosureSubmissionData: any;
  medications: Medicationinformation[];
  medicalinformation: Medicalinformation[];
  medicalcondition: MedicalCondition[];
  guardianDescription: string[] = [];
  incomeDetails: IncomeDetail[];
  assetDetails: AssetDetail[];
  psychiatricimportinfo = '0';
  financialimportinfo = '0';
  finacialDesc: string;
  clientCapacity: string;
  closingReason: string;
  maltreatmentInformation: MaltreatmentInformation[] = [];
  maltreatmentReported: MaltreatmentInformation[] = [];
  maltreatmentIdentified: MaltreatmentInformation[] = [];
  investigationFinding: InvestigationFinding;
  getinvestigationFinding: InvestigationFinding;
  juridictionAddress: any;
  public _authService: AuthService;
  private storage: SessionStorageService;

  constructor(private _commonHttpService: CommonHttpService,
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private formBuilder: FormBuilder,
    private _detect: ChangeDetectorRef,
    private _dataStoreService: DataStoreService,
    private _reportSummaryService: GenericService<ReportSummary>,
    public injector: Injector) {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._authService = injector.get<AuthService>(AuthService);
    this.storage = injector.get<SessionStorageService>(SessionStorageService);
  }
  loggermsg = 'county.countyname..';
  accountstmt = 'Account Statement';

  ngOnInit() {

    this.initForm();
    this.isInitialLoad = true;
    // this._dataStoreService.currentStore.subscribe(store => {
      const store = this._dataStoreService.getCurrentStore();
      if (this.isInitialLoad && store['dsdsActionsSummary']) {
        this.dsdsActionsSummary = store['dsdsActionsSummary'];
        if (this.dsdsActionsSummary) {
          this.setDefaults();
          this.getinvestigationallegation();
          this.getMaltreatmentInformation();
          this.isInitialLoad = false;
        }
      }
    // });
    this.loadDropdown();
    this.loadSummaryNarrative();
    this.getInvolvedPerson();
    this.getPage(1);
    this.getInvestigationFinding();

  }

  ngAfterViewChecked() {
    this._detect.detectChanges();
  }

  getInvestigationFinding() {

    this._commonHttpService.getSingle(new PaginationRequest({
      where: {
        intakeserviceid: this.id
      },
      method: 'get'
    }), 'Investigationfindings/list?filter').subscribe((data) => {
      if (data) {
        this.getinvestigationFinding = data[0];
        this.patchForms();

          if (this.getinvestigationFinding) {
            this.handleIfGetinvestigationFindingFn();
          }
      }
    });
  }
  private handleIfGetinvestigationFindingFn() {
    this.getinvestigationFinding.investigationfindingtypeperson.forEach((list) => {
      this.supportedPersons.push({
        person: list.invesfindingpersonname ? list.invesfindingpersonname : list.personname,
        description: list.invesfindingpersondesc,
        personType: list.invsfindingpersonsupporttype,
        type: list.investigationfindingpersontype
      });
      this.supportedPersonsSave.push(list);
    });

    const guardianLit = this.getinvestigationFinding.investigationfindingguardian ? this.getinvestigationFinding.investigationfindingguardian.map(items => items.intakeservicerequestactorid) : '';
    this.legalInformationFormGroup.patchValue({
      poa: this.getinvestigationFinding.legalinfopoa ? this.getinvestigationFinding.legalinfopoa : '',
      reppayee: this.getinvestigationFinding.legalinforeppayee ? this.getinvestigationFinding.legalinforeppayee : '',
      courtinvolvement: this.getinvestigationFinding.legalinfocourtinvolved ? this.getinvestigationFinding.legalinfocourtinvolved : '',
      description: this.getinvestigationFinding.legalinfodesc ? this.getinvestigationFinding.legalinfodesc : '',
      guardian: guardianLit
    });
  }

  patchForms(){
    this.maltreatementFormPatch();
    this.serviceworkerFormPatch();
    this.clientsLivingSituationFormGroupPatch();
    this.medicationFormPatch();
    this.clientCapacity = this.getinvestigationFinding.clentcapacitydesc ? this.getinvestigationFinding.clentcapacitydesc : '';
    this.closingReason = this.getinvestigationFinding.reasonclosingdesc ? this.getinvestigationFinding.reasonclosingdesc : '';
    this.finacialDesc = this.getinvestigationFinding.assetdetailsdesc ? this.getinvestigationFinding.assetdetailsdesc : '';
  }

  maltreatementFormPatch(){
    this.maltreatementForm.patchValue({
      countyid: this.getinvestigationFinding.invsfindingjurisdiction ? this.getinvestigationFinding.invsfindingjurisdiction : '',
      address: this.getinvestigationFinding.invsfindingaddress ? this.getinvestigationFinding.invsfindingaddress : '',
      insertedon: this.getinvestigationFinding.investigationfindingdate ? this.getinvestigationFinding.investigationfindingdate : ''
   });
  }

  serviceworkerFormPatch(){
    this.serviceworkerForm.patchValue({
      workersigndate: this.getinvestigationFinding.apsworkersigndate ? this.getinvestigationFinding.apsworkersigndate : '',
      supervisorsigndate: this.getinvestigationFinding.supervisorsigndate ? this.getinvestigationFinding.supervisorsigndate : ''
    });
  }

  clientsLivingSituationFormGroupPatch(){
    this.clientsLivingSituationFormGroup.patchValue({
      description: this.getinvestigationFinding.socialhistorydesc ? this.getinvestigationFinding.socialhistorydesc : '',
      familyhistory: this.getinvestigationFinding.familyhistorydesc ? this.getinvestigationFinding.familyhistorydesc : '',
      education: this.getinvestigationFinding.educationalfactors ? this.getinvestigationFinding.educationalfactors : ''
    });
  }

  medicationFormPatch(){
    this.medicationForm.patchValue({
      psychiatricdesc: this.getinvestigationFinding.psychiatricdesc ? this.getinvestigationFinding.psychiatricdesc : ''
    });

    this.clientCapacity = this.getinvestigationFinding.clentcapacitydesc ? this.getinvestigationFinding.clentcapacitydesc : '';
    this.closingReason = this.getinvestigationFinding.reasonclosingdesc ? this.getinvestigationFinding.reasonclosingdesc : '';
    this.finacialDesc = this.getinvestigationFinding.assetdetailsdesc ? this.getinvestigationFinding.assetdetailsdesc : '';
  }

  private loadDropdown() {
    this.mdCountys$ = this._commonHttpService.create({ where: { state: 'MD' }, order: 'countyname', nolimit: true }, CommonUrlConfig.EndPoint.Listing.CountryListUrl).pipe(map(result => {
      return result;
    }));
  }

  loadSummaryNarrative() {
    this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + this.id).subscribe(result => {
      this.reportSummary = result;
    });
  }


  getMaltreatmentInformation() {
    this._commonHttpService
                .getArrayList(
                    {
                        where: { investigationid: this.dsdsActionsSummary.da_investigationid },
                        method: 'get'
                    },
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
                ).subscribe((data) => {
                    this.maltreatmentInformation = data;
                    if (this.maltreatmentInformation)  {
                      this.maltreatmentReported = data.filter(reporter => reporter.isreported === 'reported' && reporter.investigationallegation);
                      this.maltreatmentIdentified = data.filter(reporter => reporter.isreported === 'identifer' && reporter.investigationallegation);
                    }
                });
  }

  onCountyChange(countyId) {
    this.mdCountys$.subscribe(item => {
      if (item) {
        const county = item.find(ca => ca.countyid === countyId);
        if (county) {
          switch (county.countyname) {
            case 'Anne Arundel County':
              this.juridictionAddress = '80 West Street Annapolis, Maryland 21401';
              break;
            case 'Baltimore City':
              this.juridictionAddress = 'Talmadge Branch Building 1910 N. Broadway Street Baltimore, Maryland 21213';
              break;
            case 'Baltimore County':
              this.juridictionAddress = '6401 York Road Baltimore, Maryland 21212';
              break;
            case 'Calvert County':
              this.juridictionAddress = '200 Duke Street Prince Frederick, Maryland 20678';
              break;
            case 'Caroline County':
              this.juridictionAddress = '207 South Third Street Denton, Maryland 21629';
              break;
            case 'Carroll County':
              this.juridictionAddress = '1232 Tech Court Westminster, Maryland 21157';
              break;
            case 'Cecil County':
              this.juridictionAddress = 'Elkton District Court/Multi Service Building 170 East Main Street Elkton,Maryland 21921';
              break;
            case 'Charles County':
              this.juridictionAddress = '200 Kent Avenue LaPlata, Maryland 20646';
              break;
            case 'Dorchester County':
              this.juridictionAddress = '627 Race Street Cambridge, Maryland 21613';
              break;
            case 'Frederick County':
              this.juridictionAddress = '1888 North Market Street Frederick, Maryland 21701';
              break;
            case 'Garrett County':
              this.juridictionAddress = '12578 Garrett Highway Oakland, Maryland 21550';
              break;
            case 'Harford County':
              this.juridictionAddress = '2 South Bond Street Suite 300 Bel Air, Maryland 21014';
              break;
            case 'Howard County':
              this.juridictionAddress = '7121 Columbia Gateway Drive Columbia, Maryland 21046';
              break;
            case 'Kent County':
              this.juridictionAddress = '350 High Street P.O. Box 670 Chestertown, MD 21620';
              break;
            case 'Montgomery Count':
              this.juridictionAddress = '401 Hungerford Drive, 5th Floor Rockville, Maryland 20850';
              break;
            case "Prince George's County":
              this.juridictionAddress = '805 Brightseat Road Landover, Maryland 20785-4723';
              break;
            case "Queen Anne's County":
              this.juridictionAddress = '125 Comet Drive Centreville, Maryland 21617';
              break;
            case "Saint Mary's County":
              this.juridictionAddress = '23110 Leonard Hall Dr Leonardtown, MD 20650';
              break;
            case 'Somerset County':
              this.juridictionAddress = '30397 Mt. Vernon Road Princess Anne, Maryland 21853';
              break;
            case 'Washington County':
              this.juridictionAddress = '122 North Potomac Street Hagerstown, Maryland 21740';
              break;
            case 'Wicomico County':
              this.juridictionAddress = '201 Baptist Street, Suite 27 Salisbury, Maryland 21801';
              break;
            case 'Worcester County':
              this.juridictionAddress = '299 Commerce Street Snow Hill, Maryland 21863';
              break;
          }

          this.maltreatementForm.patchValue({ address: this.juridictionAddress });
        }
      }
    });
  }

  private setDefaults() {
    const adultDetail = {
      clientname: this.dsdsActionsSummary.da_focus,
      clientid: this.dsdsActionsSummary.cjamspid,
      insertedon: new Date(this.dsdsActionsSummary.da_insertedon),
      actuatlRefferal: ''
    };
    const serviceWorker = {
      caseworker: this.dsdsActionsSummary.da_assignedto,
      supervisor: '',
    };
    this.maltreatementForm.patchValue(adultDetail);
    this.serviceworkerForm.patchValue(serviceWorker);
  }

  private initForm() {
    this.maltreatementForm = this.formBuilder.group({
      countyid: [''],
      address: [''],
      clientname: [''],
      clientid: [''],
      clientaddress: [''],
      insertedon: [''],
      actuatlRefferal: ['']
    });
    this.clientSupport = this.formBuilder.group({
      personType: ['Involved'],
      person: [''],
      type: [''],
      description: ['']
    });
    this.serviceworkerForm = this.formBuilder.group({
      caseworker: [''],
      workersigndate: new Date(),
      supervisor: [''],
      supervisorsigndate: new Date()
    });
    this.legalInformationFormGroup = this.formBuilder.group({
      poa: [''],
      reppayee: [''],
      guardian: [''],
      courtinvolvement: [''],
      description: ['']
    });
    this.clientsLivingSituationFormGroup = this.formBuilder.group({
      ethinicity: [''],
      religion: [''],
      livingsituation: [''],
      familyhistory: [''],
      education: [''],
      description: ['']
    });
    this.medicationForm = this.formBuilder.group({
      psychiatricdesc: ['']
    });

  }

  getPage(page: number) {
    const isExpungementSuperUser =  this.storage.getItem('isExpungementSuperUser');
    ObjectUtils.removeEmptyProperties(this.recordSearch);
    const recordSearch = this.recordSearch;
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            recordSearch,
            isExpungementSuperUser
          },
          method: 'get'
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.GetAllDaRecordingUrl + '/' + this.id + '?data'
      ).pipe(
      map((result) => {
        return {
          data: result.data,
          count: result.count,
          canDisplayPager: result.count > this.paginationInfo.pageSize
        };
      }),
      share(),);
    this.recording$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
    }
  }
  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageSubject$.next(this.paginationInfo.pageNumber);
  }

  involvedChange(event) {
    this.clientSupport.reset();
    this.clientSupport.patchValue({personType: event});
 }

  addSupportedPerson(suporter) {
    const supoterObject = {
      person: suporter.person.personname ? suporter.person.personname : suporter.person,
      description: suporter.description,
      type: suporter.type,
      personType: suporter.personType,
    };
    if (this.clientSupport.get('personType').value === 'Involved') {
      const supoterSave = {
        intakeservicerequestactorid: suporter.person.intakeservicerequestactorid,
        invesfindingpersondesc: suporter.description,
        invsfindingpersonsupporttype: suporter.type,
        investigationfindingpersontype: suporter.personType
      };
      this.supportedPersonsSave.push(Object.assign({}, supoterSave));
    }
    if (this.clientSupport.get('personType').value === 'Non-Involved') {
      const supoterSave = {
        invesfindingpersonname: suporter.person,
        invesfindingpersondesc: suporter.description,
        invsfindingpersonsupporttype: suporter.type,
        investigationfindingpersontype: suporter.personType
      };
      this.supportedPersonsSave.push(Object.assign({}, supoterSave));
    }
    this.supportedPersons.push(Object.assign({}, supoterObject));
    this.clientSupport.reset();
    this.clientSupport.patchValue({personType: 'Involved'});
  }

  removeSuporter(index) {
    this.supportedPersons.splice(index, 1);
    this.supportedPersonsSave.splice(index, 1);
  }

  private getInvolvedPerson1() {

    this._commonHttpService
      .getPagedArrayList(
        {
          where: { intakeserviceid: this.id },
          page: 1,
          limit: 20,
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.InvolvedPersonUrl + '?filter'
      )
      .subscribe((itm) => {
        if (itm.data) {
          this.personRoles = [];
          this.guardianRole = [];
          itm.data.forEach((list: InvolvedPerson) => {
            const role = list.roles.filter(role3 => role3.intakeservicerequestpersontypekey === 'RA');
            const grd = list.roles.filter(role4 => role4.intakeservicerequestpersontypekey === 'GRD');
            if (grd.length) {
              this.guardianRole.push(list);
            }
            if (role.length) {
              const address = this.setAddress(list);
              this.maltreatementForm.patchValue({ clientaddress: address });
              this.clientsLivingSituationFormGroup.patchValue({ religion: list.religion, ethinicity: list.ethinicity });
            }
            return this.personRoles.push({
              intakeservicerequestactorid: list.roles[0].intakeservicerequestactorid,
              displayname: list.firstname + ' ' + list.lastname + '(' + list.roles[0].typedescription + ')',
              personname: list.firstname + ' ' + list.lastname,
              role: list.roles
            });
          });
        }
      });
  }

  setAddress(list){
    return (list.address ? list.address : '') + '' 
            + (list.address2 ? list.address2 : '') + '' 
            + this.setAddressCity(list);
  }

  setAddressCity(list){
    return (list.city ? list.city : '') + '' 
            + (list.county ? list.county : '') + '' 
            + (list.zipcode ? list.zipcode : '');
  }

  private getInvolvedPerson() {
    observableForkJoin([
      this._commonHttpService
        .getPagedArrayList(
          {
            where: { intakeserviceid: this.id },
            page: 1,
            limit: 20,
            method: 'get'
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.InvolvedPersonUrl + '?filter'
        ),
      this._commonHttpService.getPagedArrayList({
        assessment: [
          {
            titleheadertext: '248 C Financial Disclosure'
          }
        ],
        intakeserviceid: this.id
        ,
        method: 'post'
      }, 'admin/assessment/getassessmentdetailsbytitleheadertext')]).subscribe((result) => {
        if (result[0].data) {
          this.personRoles = [];
          this.guardianRole = [];
          result[0].data.forEach((list: InvolvedPerson) => {
            const role = list.roles.filter(role1 => role1.intakeservicerequestpersontypekey === 'RA');
            const grd = list.roles.filter(role2 => role2.intakeservicerequestpersontypekey === 'GRD');
            if (grd.length) {
              this.guardianRole.push(list);
            }
            if (role.length) {
              const address = this.setAddress(list);
              this.medications = list.medicationinformation;
              this.medicalcondition = list.medicalcondition.filter(item => item.description);
              this.medicalinformation = list.medicalinformation;
              this.maltreatementForm.patchValue({ clientaddress: address });
              this.clientsLivingSituationFormGroup.patchValue({ religion: list.religion, ethinicity: list.ethinicity });
            }
            return this.personRoles.push({
              intakeservicerequestactorid: list.intakeservicerequestactorid,
              displayname: list.firstname + ' ' + list.lastname + '(' + list.roles[0].typedescription + ')',
              personname: list.firstname + ' ' + list.lastname,
              role: list.roles
            });
          });
        }
        if (result[1].data.length && result[1].data[0].submissiondata) {
          this.financialDisclosureSubmissionData = result[1].data[0].submissiondata;
          this.patchFinanceAssessment(result[1].data[0].submissiondata);
        }
      });
  }

  getinvestigationallegation() {
    this._commonHttpService
      .getArrayList(
        {
          where: { investigationid: this.dsdsActionsSummary.da_investigationid },
          nolimit: true,
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.MaltreatmentInformation.MaltreatmentInformation + '?filter'
      ).subscribe((result) => {
        if (result) {
          this.maltreatmentInformation = result;
        }
      });
  }

  selectedGuardian(event) {
    if (event) {
      const getperson = this.guardianRole.filter(item => event.includes(item.intakeservicerequestactorid));
      this.guardian = getperson.map(list => { return { intakeservicerequestactorid: list.intakeservicerequestactorid };
      });
      if (getperson.length) {
        this.guardianDescription = getperson.map(res => (res.firstname + ' ' + res.lastname));
      }
    }
  }

  psychiatricImportant(event) {
    this.psychiatricimportinfo = event.checked ? '1' : '0';
  }

  financeImportant(event) {
    this.financialimportinfo = event.checked ? '1' : '0';
  }

  patchFinanceAssessment(assessment) {
    this.incomeDetails = [];
    this.assetDetails = [];
    this.setIncomeDetailsc1toc3(assessment);
    this.setIncomeDetailsc7toc9(assessment);
    this.setIncomeDetailsc10toc12(assessment);
    this.setAssetDetailse1toe5(assessment);
    this.setAssetDetailse6toe11(assessment);
  }

  setIncomeDetailsc1toc3(assessment){
    if (assessment.c1 || assessment.d1 || assessment.SocialSecuritySelectField1) {
      this.incomeDetails.push({ category: 'Social Security', source: InvestigationFindingStoreConstants[assessment.SocialSecuritySelectField1], clientIncome: assessment.c1, spouseIncome: assessment.d1 });
    }
    if (assessment.c2 || assessment.d2 || assessment.SalarySelectField2) {
      this.incomeDetails.push({ category: 'Salary', source: InvestigationFindingStoreConstants[assessment.SalarySelectField2], clientIncome: assessment.c2, spouseIncome: assessment.d2 });
    }

    if (assessment.c3 || assessment.d3 || assessment.VeteransBenefitsSelectField3) {
      this.incomeDetails.push({ category: 'Veterans Benefits', source: InvestigationFindingStoreConstants[assessment.VeteransBenefitsSelectField3], clientIncome: assessment.c3, spouseIncome: assessment.d3 });
    }
  }

  setIncomeDetailsc7toc9(assessment){
    if (assessment.c7 || assessment.d7 || assessment.AlimonySelectField7) {
      this.incomeDetails.push({ category: 'Alimony', source: InvestigationFindingStoreConstants[assessment.AlimonySelectField7], clientIncome: assessment.c7, spouseIncome: assessment.d7 });
    }

    if (assessment.c8 || assessment.d8 || assessment.RentalIncomeSelectField8) {
      this.incomeDetails.push({ category: 'Rental Income', source: InvestigationFindingStoreConstants[assessment.RentalIncomeSelectField8], clientIncome: assessment.c8, spouseIncome: assessment.d8 });
    }
    if (assessment.c9 || assessment.d9 || assessment.InterestIncomeSelectField9) {
      this.incomeDetails.push({ category: 'Interest Income', source: InvestigationFindingStoreConstants[assessment.InterestIncomeSelectField9], clientIncome: assessment.c9, spouseIncome: assessment.d9 });
    }
  }

  setIncomeDetailsc10toc12(assessment){
    if (assessment.c10 || assessment.d10 || assessment.AnnuitiesSelectField10) {
      this.incomeDetails.push({ category: 'Annuities', source: InvestigationFindingStoreConstants[assessment.AnnuitiesSelectField10], clientIncome: assessment.c10, spouseIncome: assessment.d10 });
    }

    if (assessment.c11 || assessment.d11 || assessment.ReverseMortgageSelectField11) {
      this.incomeDetails.push({ category: 'Reverse Mortgage', source: InvestigationFindingStoreConstants[assessment.ReverseMortgageSelectField11], clientIncome: assessment.c11, spouseIncome: assessment.d11 });
    }

    if (assessment.c12 || assessment.d12 || assessment.Other111TextField1) {
      this.incomeDetails.push({ category: 'Other', source: assessment.Other111TextField1 ? assessment.Other111TextField1 : '', clientIncome: assessment.c12, spouseIncome: assessment.d12 });
    }
  }

  setAssetDetailse1toe5(assessment){
    if (assessment.e1) {
      this.assetDetails.push({ category: 'Saving Account', source: this.accountstmt, totalValue: assessment.e1 });
    }
    if (assessment.e2) {
      this.assetDetails.push({ category: 'Checking Account', source: this.accountstmt, totalValue: assessment.e2 });
    }
    if (assessment.e3) {
      this.assetDetails.push({ category: 'Certificate Of Deposit', source: this.accountstmt, totalValue: assessment.e3 });
    }
    if (assessment.e4) {
      this.assetDetails.push({ category: 'Value Of Stock', source: this.accountstmt, totalValue: assessment.e4 });
    }
    if (assessment.e5) {
      this.assetDetails.push({ category: 'Value Of Bonds', source: this.accountstmt, totalValue: assessment.e5 });
    }
  }

  setAssetDetailse6toe11(assessment){
    if (assessment.e6) {
      this.assetDetails.push({ category: 'Value Of IRA', source: this.accountstmt, totalValue: assessment.e6 });
    }
    if (assessment.e7) {
      this.assetDetails.push({ category: 'Value Of Deferred Compensation', source: this.accountstmt, totalValue: assessment.e7 });
    }
    if (assessment.e8) {
      this.assetDetails.push({ category: 'Property Value (Not Primary Residence)', source: 'Tax Assessment', totalValue: assessment.e8 });
    }
    if (assessment.e9) {
      this.assetDetails.push({ category: 'Trust Fund', source: 'Policy/Fund Statement', totalValue: assessment.e9 });
    }
    if (assessment.e10) {
      this.assetDetails.push({ category: 'Cash Surrender Value Of Life Insurance', source: 'Policy(ies)', totalValue: assessment.e10 });
    }
    if (assessment.e11) {
      this.assetDetails.push({ category: 'Other', source: assessment.OtherTextField123 ? assessment.OtherTextField123 : '', totalValue: assessment.e11 });
    }
  }

  saveInvestigationFinding() {
    this.investigationFinding = Object.assign({}, new InvestigationFinding);
    const maltreamentForm = this.maltreatementForm.value;
    const serviceworkerForm = this.serviceworkerForm.value;
    const legalInformation = this.legalInformationFormGroup.value;
    const clientLiving = this.clientsLivingSituationFormGroup.value;
    const medicationForm = this.medicationForm.value;
    this.investigationFinding.intakeserviceid = this.id;
    this.investigationFinding.invsfindingjurisdiction = maltreamentForm.countyid;
    this.investigationFinding.invsfindingaddress = maltreamentForm.address;
    this.investigationFinding.investigationfindingdate = maltreamentForm.insertedon;
    this.investigationFinding.socialhistorydesc = clientLiving.description;
    this.investigationFinding.familyhistorydesc = clientLiving.familyhistory;
    this.investigationFinding.educationalfactors = clientLiving.education;
    this.investigationFinding.psychiatricdesc = medicationForm.psychiatricdesc;
    this.investigationFinding.psychiatricimportinfo = this.psychiatricimportinfo;
    this.investigationFinding.financialimportinfo = this.financialimportinfo;
    this.investigationFinding.assetdetailsdesc = this.finacialDesc;
    this.investigationFinding.legalinfopoa = legalInformation.poa;
    this.investigationFinding.legalinforeppayee = legalInformation.reppayee;
    this.investigationFinding.legalinfocourtinvolved = legalInformation.courtinvolvement;
    this.investigationFinding.legalinfodesc = legalInformation.description;
    this.investigationFinding.clentcapacitydesc = this.clientCapacity;
    this.investigationFinding.reasonclosingdesc = this.closingReason;
    this.investigationFinding.apsworkersigndate = serviceworkerForm.workersigndate;
    this.investigationFinding.supervisorsigndate = serviceworkerForm.supervisorsigndate;
    this.investigationFinding.investigationfindingtypeperson = this.supportedPersonsSave;
    this.investigationFinding.investigationfindingguardian = this.guardian;
    this._commonHttpService.create(this.investigationFinding, 'Investigationfindings/addupdate').subscribe((data) => {
      if (data) {
        this._alertService.success('Investigation Finding Added Successfully');
      }
    });
  }
}
