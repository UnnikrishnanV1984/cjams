import {share, map, concatMap, first, catchError, tap, pairwise, startWith, filter, pluck, takeUntil, take} from 'rxjs/operators';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { Component, Injector, OnInit } from '@angular/core';
import { of,  from, concat, Observable, Subject, combineLatest, forkJoin } from 'rxjs';
import { FormBuilder, FormGroup, Validators, ValidatorFn, ValidationErrors, FormControl, AbstractControl } from '@angular/forms';
import { ValidationService, DataStoreService, CommonDropdownsService, CommonHttpService, AuthService, GenericService, SessionStorageService, AlertService } from '../../../@core/services';
import { PersonInfoService } from '../../shared-pages/person-info/person-info.service';
import { InvolvedPersonsService } from '../../shared-pages/involved-persons/involved-persons.service';
import { NavigationUtils, PersonInfoStore } from '../../_utils/navigation-utils.service';
import { Router, ActivatedRoute } from '@angular/router';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { InvolvedPersonSearchResponse, PersonDsdsAction, PersonDsdsActionByType, PriorAuditLog } from '../../provider-referral/new-private-referral/_entities/newintakeModel';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { PersonSearch, People, InvolvedPerson } from '../../../@core/common/models/involvedperson.data.model';
import { ObjectUtils } from '../../../@core/common/initializer';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { Assignments } from '../../case-worker/dsds-action/cw-assignments/assignments.data.model';
import { ProgramParticipationService } from '../../../lib/programParticipation/programParticipation.service';
import { Sort } from '@angular/material/sort';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import moment from 'moment';
import { environment } from '../../../../../src/environments/environment';
import { config } from '../../../../../src/environments/config';
import { FindUrlConfig } from '../../find/find.url.config';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
@Component({
    selector: 'cw-search',
    templateUrl: './cw-search.component.html',
    styleUrls: ['./cw-search.component.scss'],
    standalone: false
})
export class CwSearchComponent implements OnInit {

  involvedPersonSearchForm!: FormGroup;
  private involvedPersonSearch!: InvolvedPerson;
  genderDropdownItems$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  countyDropdownItems$!: Observable<any[]>;
  findClicked = false;
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;
  preserveDataFlag:boolean = false;
  preserveDataStore: any;
  preserveSessionData: any;
  personSearchForm!: InvolvedPerson;
  paginationInfo: PaginationInfo = new PaginationInfo();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  personSearchResult$!: Observable<PersonSearch[]>;
  personDSDSActions$!: Observable<PersonDsdsAction[]>;
  providerDSDSActions$!: Observable<any[]>;
  asDSDSActions$!: Observable<any[]>;
  searchpriordsdsactionResults$!: Observable<PersonDsdsAction[]>;
  private priorAuditLogRequest = new PriorAuditLog();
  userOnDisplay: any;
  activePanel!: number;
  intakeNumber!: string;
  priorHistoryCheck: any;
  showPersonDetail = -1;
  private EDITABLE_ROLES = [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR];
  isEditable = false;
  isSearch!: boolean;
  personSearchResult!: InvolvedPersonSearchResponse[];
  filteredPersonSearchResult!: InvolvedPersonSearchResponse[];
  allPersonRows: InvolvedPersonSearchResponse[] = [];
  pagedPersonSearchResult: InvolvedPersonSearchResponse[] = [];
  currentSortColumn: string | null = null;
  currentSortDirection: 'asc' | 'desc' | '' = '';
  searchText: string = '';
  totalRecords!: number;
  personSearch!: People;
  selectedPerson: any;
  selectedPersonHistory:any;
  selectedPersonGapHistory: any;
  selectedPersonAdoptionHistory: any;
  selectedCaseInfo: any = [];
  assignmentsList$!: Observable<Assignments[]>;
  public environment = environment;
  displayAddNewButton = false;
  isReadonly = true;
  selectedPriorPerson: any;
  errorMessage: string | null = null;
  enableSelectionUX = false;

  isAuditVisible = false;
  isIveVisible= false;
  placementHistory : any;
  fetchedResults: any = [];
  securityusersid!: string;
  envName: any;
  restrictedcaseenable: boolean = false;
  pagelength = 50;
  persondetails: any;
  sortInput: any;
  searchtypelist$!: Observable<any[]>;
  serverPage = 1;
  serverLastPage = false;
  isExpunged: boolean = false;
  uiErrorMsg: string | null = null;

  uiOnlyErrorMsg: string | null = null;
  allSearchTypes = [
    { ref_key: 'EXM', description: 'Exact' },
    { ref_key: 'EXP', description: 'Exact Plus' },
    { ref_key: 'SXM', description: 'Soundex' },
    { ref_key: 'SYN', description: 'Synonym' },
    { ref_key: 'FZM', description: 'Fuzzy' }
  ];  
  selectedDobOption: 'DOB' | 'AGE' | null = 'DOB';

  smartyAddr = this.defaultSmartyAddr();
  hasNextPage: any;
  private defaultSmartyAddr() {
    return { address1:'', address2:'', city:'', state:'', zipcode:'', county:'', disable:false };
  }
  private _formBuilder: FormBuilder;
  private _involvedPersonsService?: InvolvedPersonsService;
  private router: Router;
  private route: ActivatedRoute;
  private _dataStoreService: DataStoreService;
  private dropdownService: CommonDropdownsService;
  private _commonHttpService: CommonHttpService;
  public _authService: AuthService;
  private _session: SessionStorageService;
  private _navigationUtils: NavigationUtils;
  public programParticipationService: ProgramParticipationService;
  private _involvedPersonSeachService: GenericService<InvolvedPersonSearchResponse>;
  private _alertService?: AlertService;
  private _personInfoService: PersonInfoService;
  internalFindFlag: any = false;
  private destroy$ = new Subject<void>();
  private suppressAgeClear = false;
  isExpungementSuperUser:number = 0;
  isDobRange: boolean = false;

  constructor(private injector : Injector,
    private sanitizer: DomSanitizer
    ) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
	  this.router = this.injector.get<Router>(Router);
		this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.dropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);	
    this._authService = this.injector.get<AuthService>(AuthService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
    this.programParticipationService = this.injector.get<ProgramParticipationService>(ProgramParticipationService);
    this._involvedPersonSeachService = this.injector.get<GenericService<InvolvedPersonSearchResponse>>(GenericService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this.isEditable = this.hasEditAccess();
  }

  //https://eservices.paychex.com/secure/HRO_PNG/ssn_itin_fed_id_other.html
  //These cannot be valid ssns, so should be prevented.
  validateSSN(c: FormControl) {
    const invalidssn = ['000000000'];
    return invalidssn.includes(c.value) ? {
      validateSSN: {
        valid: false
      }
    } : null;
  }


  ngOnInit() {
    this.restrictedcaseenable = config.restrictedcaseenable && environment.envName !== 'Production';
    this.enableSelectionUX = !!this.route.snapshot.data?.['selectionUX'];
    this.initSearchForm();
    this.loadDropdowns();
    this.involvedPersonSearchForm.get('county')?.disable();
    this.isSearch = false;
    this.paginationInfo.sortBy = 'asc';
    this.paginationInfo.sortColumn = null;
    this.isAuditVisible = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR) || this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER) ;
    this._authService.hasAccess('IV-E Search').subscribe(result => {
      this.isIveVisible = result || this._authService.selectedRoleIs('IV-E Supervisor') || this._authService.selectedRoleIs('IV-E Specialist') || this._authService.selectedRoleIs('IV-E Eligibility Analyst') || this._authService.selectedRoleIs('IV-E Eligibility Quality Assurance') 
                          || this._authService.selectedRoleIs('IV-E Eligibility Administrator Assistant') || this._authService.selectedRoleIs('IV-E Eligibility Administrator') ;
    }) ;
    const activeModuleRole = this._session?.getItem('activeModuleRole');
    if (activeModuleRole === 'CJAMS_SSA_FTDM_FACILITATOR'
    || activeModuleRole === 'CJAMS_SSA_QUALIFIED_INDIVIDUAL'
    || activeModuleRole === 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access', 'add-edit-person');
    }
    this.securityusersid = this._authService.getCurrentUser().user.securityusersid;
    this.isExpungementSuperUser = this._authService.isExpungementSuperUser();
    this.applyPrefillFromSearchHandoff();
    if (!this.prefillFromHandoffApplied) {
      this.loadFromCache();
    }

    this.involvedPersonSearchForm.get('advancedsearch')?.valueChanges.subscribe(isAdvanced => {
      if (!isAdvanced) {
        this.involvedPersonSearchForm.patchValue({
          address1: '',
          address2: '',
          zip: '',
          city: '',
          stateid: null,
          county: null,
          email: '',
          phone: '' 
        });
        this.involvedPersonSearchForm.get('county')?.disable(); 
        this.smartyAddr = this.defaultSmartyAddr();
      }
    });
    this.watchDateFieldForActualDayChange('fromDate');
    this.watchDateFieldForActualDayChange('toDate');
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }
  initSearchForm() {
    this.involvedPersonSearchForm = this._formBuilder.group({
      lastname: [''],
      firstname: [''],
      maidenname: [''],
      gender: [''],
      dateofdeath: [''],
      ssn: ['', [this.validateSSN]],
      mediasrc: [''],
      mediasrctxt: [''],
      occupation: [''],
      dl: [''],
      stateid: [''],
      address1: [''],
      address2: [''],
      zip: [''],
      city: [''],
      county: [''],
      isdeceased: [true],
      selectedPerson: [''],
      cjisnumber: [''],
      complaintnumber: [''],
      fein: [''],
      age: [''],
      email: ['', [ValidationService.mailFormat]],
      phone: [''],
      petitionid: [''],
      alias: [''],
      oldId: [''],
      chessieid: [''],
      middlename: [''],
      cjamspid: [''],
      mdmId: [''],
      fromDate: [null],
      toDate: [null],
      dob: [null],
      searchtypes: [this.allSearchTypes],
      advancedsearch: [false]
    }, { validators: [ this.searchCriteriaValidator(), this.dateRangeValidator() ] });
  }

  private ensureSubtabDeps(): boolean {
    try {
      if (!this._alertService) {
        this._alertService = this.injector.get(AlertService);
      }
    } catch {}
    try {
      if (!this._involvedPersonsService) {
        this._involvedPersonsService = this.injector.get(InvolvedPersonsService);
      }
    } catch {}
  
    if (!this._involvedPersonsService) {
      return false;
    }
    return true;
  }

selectPerson(row: any) {
  this.selectedPerson = row;
}

private prefillFromHandoffApplied = false;

private toDisplayGenderValue(raw: any): '' | 'M' | 'F' | 'Unknown' | 'None' | 'TGIM' | 'TGIF' { 
  if (raw === null || raw === undefined) return '';
  const s = String(raw).trim().toLowerCase();
  if (!s) return '';

  if (s === 'm' || s === 'M' || s === 'male') return 'M';
  if (s === 'f' ||  s === 'F' || s === 'female') return 'F';
  if (s === 'tgif' || s === 'TGIF') return 'TGIF';
  if (s === 'tgim' ||  s === 'TGIM') return 'TGIM';

  return 'Unknown';
 }

private parseDateValue(raw: any): Date | null { 
  if (!raw) return null;
  if (raw instanceof Date && !isNaN(raw.getTime())) return raw;

  const str = String(raw).trim();

  // ISO or "YYYY-MM-DD"
  const iso = new Date(str);
  if (!isNaN(iso.getTime())) return iso;

  // MM/DD/YYYY
  const m = str.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/);
  if (m) {
    const d = new Date(+m[3], +m[1] - 1, +m[2]);
    if (!isNaN(d.getTime())) return d;
  }
  return null;
 }

private applyPrefillFromSearchHandoff(): void {
  const handoff: any = this._dataStoreService.getData(IntakeStoreConstants.PERSON_TO_SEARCH);
  if (!handoff) return;

  const firstName   = handoff.firstname ?? handoff.first_name ?? '';
  const lastName    = handoff.lastname  ?? handoff.last_name  ?? '';
  const dobInput    = handoff.dob ?? handoff.date_of_birth ?? handoff.birthdate ?? null;
  const genderInput = handoff.gender ?? handoff.gendertypekey ?? handoff.gender_cd ?? '';
  const ssnInput    = handoff.ssn ?? handoff.ssnnumber ?? handoff.socialsecuritynumber ?? '';
  const fromDate = this.parseDateValue(dobInput);
  const gender   = this.toDisplayGenderValue(genderInput);
  const ssnDigits = this.extractDigits(ssnInput ?? '');
   const ssn = ssnDigits.length === 9 ? ssnDigits : '';

  const patch: any = {};
  if (firstName) patch.firstname = firstName;
  if (lastName)  patch.lastname  = lastName;
  if (fromDate)  patch.dob  = fromDate;
  if (gender)    patch.gender    = gender;
  if (ssn) {
    patch.ssn = ssn;
  }
  if (Object.keys(patch).length) {
    this.involvedPersonSearchForm.patchValue(patch, { emitEvent: true });
    this.involvedPersonSearchForm.markAsDirty();
    this.involvedPersonSearchForm.get('dob')?.markAsDirty();
    this.involvedPersonSearchForm.get('dob')?.markAsTouched();
if (ssn) {
  this.involvedPersonSearchForm.get('ssn')?.markAsDirty();
  this.involvedPersonSearchForm.get('ssn')?.markAsTouched();
}
    this.prefillFromHandoffApplied = true;
  }

  this._dataStoreService.setData(IntakeStoreConstants.PERSON_TO_SEARCH, null);
}



private getSsnFromInputs(): string | null {
  const ssnCtrl = (this.involvedPersonSearchForm?.get('ssn')?.value ?? '').toString();
  const q = (this.searchText ?? '').toString();

  const onlyDigits = (s: string) => s.replace(/\D/g, '');
  const ssnFromForm = onlyDigits(ssnCtrl);
  const ssnFromQuick = onlyDigits(q);

  if (ssnFromForm.length === 9) return ssnFromForm;
  if (ssnFromQuick.length === 9) return ssnFromQuick;
  return null;
}

private ssnExists$(ssn: string) {
  return this._personInfoService.searchPersonWithSsnCritera({ ssn }).pipe(
    map((res: any) => (res?.count || (res?.data?.length ?? 0)) > 0)
  );
}



onSmartyAddressChanged(addr: {
  address1: string; address2: string; city: string; state: string; zipcode: string; county: string;
}) {
  if (!addr) return;

  this.involvedPersonSearchForm.patchValue({
    address1: addr.address1 || '',
    address2: addr.address2 || '',
    city:     addr.city     || '',
    zip:      (addr.zipcode || '').toString().slice(0, 10), 
  }, { emitEvent: true });

  if (addr.state) {
    this.involvedPersonSearchForm.patchValue({ stateid: addr.state }, { emitEvent: true });
    this.involvedPersonSearchForm.get('county')?.enable({ emitEvent: false });

    this.loadCounty();

    this.dropdownService.getPickListByMdmcode(addr.state)
      .pipe(take(1))
      .subscribe({
        next: (countyList: any[] = []) => {
          const match = countyList.find(c =>
            (c?.description || '').toLowerCase() === (addr.county || '').toLowerCase()
          );
          const countyRefKey = match?.ref_key ?? null;
          this.involvedPersonSearchForm.patchValue({ county: countyRefKey }, { emitEvent: true });
        },
        error: () => {
          this.involvedPersonSearchForm.patchValue({ county: null }, { emitEvent: false });
        }
      });
      this.involvedPersonSearchForm.markAsDirty(); 
  } else {
    this.involvedPersonSearchForm.patchValue({ stateid: null, county: null }, { emitEvent: false });
    this.involvedPersonSearchForm.get('county')?.disable({ emitEvent: false });
  }
}

showProfileErrorMessage(message: string) {
  this.errorMessage = message;
  (<any>$('#profile-error-message')).modal('show');
}
closeErrorMessage() {
  this.errorMessage = null;
  (<any>$('#profile-error-message')).modal('hide');
}

validateAddNew() {
  if (!this.enableSelectionUX || !this.ensureSubtabDeps()) return;

  const ssn = this.getSsnFromInputs();

  if (ssn) {
    this.ssnExists$(ssn).subscribe((exists) => {
      if (exists) {
        this.showProfileErrorMessage('The SSN entered already exists in CJAMS');
        return;
      }
      this.addNewPerson();
    });
  } else {
    // No SSN provided anywhere => allow Add New
    this.addNewPerson();
  }
}


private addNewPerson() {
  if (!this.enableSelectionUX || !this.ensureSubtabDeps()) return;
  const searchdata: any = { ...(this.involvedPersonSearchForm?.getRawValue?.() || {}) };
  searchdata.exist = 1;

  if (searchdata.clientflag === 0 && searchdata.personid) {
    this._involvedPersonsService?.editPerson(searchdata.personid);
    return;
  }

  const qp = this._dataStoreService.getData('QUICK_PERSON_ID');
  if (qp && qp.persontype === 'QP') {
    searchdata.clientflag = 1;
    searchdata.qptype = qp.persontype;
    searchdata.qpid  = qp.quickpersonid;
  } else {
    searchdata.clientflag = 1;
    searchdata.qptype = null;
    searchdata.qpid  = null;
  }
  this._involvedPersonsService?.newPerson(searchdata);
}

validateSelectedPerson() {
  if (!this.enableSelectionUX || !this.ensureSubtabDeps()) return;

  if (!this.selectedPerson) {
    this._alertService?.error('Please select person');
    return;
  }

  if (this.selectedPerson.source === 'SDR') {
    this.editSelectedPerson();
    return;
  }

  const personInfo = Object.create(PersonInfoStore);
  personInfo.source = this._involvedPersonsService?.getSource();
  personInfo.sourceID = this._involvedPersonsService?.getUniqueNumber();
  personInfo.personId = this.selectedPerson?.personid;

  this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);

  const url = FindUrlConfig.EndPoint.PersonSearch.getpersonexists;

  this._commonHttpService.getArrayList(
    { where: this._navigationUtils.getPersonRequestParam(), method: 'get' },
    url
  ).subscribe((data: any[]) => {
    if (data && data.length > 0 && data[0].count > 0) {
      this.showProfileErrorMessage('Person entered already exists in this Case');
    } else {
      this.editSelectedPerson();
    }
  });
}

private editSelectedPerson() {
  if (!this.enableSelectionUX || !this.ensureSubtabDeps()) return;

  if (this.selectedPerson?.isbioadoptedflag === 1) {
    (<any>$('#bioadoptedflag')).modal('show');
    return;
  }

  if (this.selectedPerson.source === 'SDR') {
    this._dataStoreService.setData('personsdrsource', true);
    const pid = this.selectedPerson?.cjamspid;
    if (!pid) {
      this._involvedPersonsService?.newSDRPerson(this.selectedPerson);
      return;
    }

    const url = FindUrlConfig.EndPoint.PersonSearch.identifier;

    this._commonHttpService.getArrayList(
      { where: { cjamspid: pid }, method: 'get' },
      url
    ).subscribe((data: any[]) => {
      if (data?.[0]) this.selectedPerson.personid = data[0].personid;
      if (this.selectedPerson.personid) this._involvedPersonsService?.editSDRPerson(this.selectedPerson);
      else this._involvedPersonsService?.newSDRPerson(this.selectedPerson);
    });
    return;
  }

  this._dataStoreService.setData('personsdrsource', false);
  this._involvedPersonsService?.editPerson(this.selectedPerson.personid);
}


  private getSortValue(row: any, col: string): any {
    switch (col) {
      case 'prefix': return row?.prefix ?? row?.prefx ?? '';
      case 'suffix': return row?.suffix ?? '';
      case 'firstname': return row?.firstname ?? '';
      case 'middlename': return row?.middlename ?? '';
      case 'lastname': return row?.lastname ?? '';
      case 'dob': return row?.dob ? new Date(row.dob) : null;
      case 'dod': return row?.death_date ? new Date(row.death_date) : null;
      case 'gendertypekey': return row?.gendertypekey ?? '';             
      case 'cjamspid': return row?.cjamspid ?? '';
      case 'cisclientid': return row?.cisclientid ?? '';          
      case 'mdm_id': return row?.mdm_id ?? '';                  
      case 'isprovider': return row?.isprovider ?? '';                                     
      case 'dl': return row?.dl ?? '';
      case 'matchtype': return row?.matchtype ?? '';
      case 'score': return row?.score ?? '';
      case 'rank': return row?.rank ?? '';
      default: return '';                                       
    }
  }

  private sortClient(personList: InvolvedPersonSearchResponse[]): InvolvedPersonSearchResponse[] {
    const sortColumn = this.currentSortColumn;
    const sortDirection = this.currentSortDirection;
  
    if (!sortColumn || !sortDirection) {
      return [...personList];
    }
  
    const isAscending = sortDirection === 'asc';
  
    return [...personList].sort((rowA, rowB) => {
      const valueA = this.getSortValue(rowA, sortColumn);
      const valueB = this.getSortValue(rowB, sortColumn);

      if (sortColumn === 'priors') {
        const hasCjamspidA = !!rowA?.cjamspid;
        const hasCjamspidB = !!rowB?.cjamspid;
        if (hasCjamspidA !== hasCjamspidB) {
          return (hasCjamspidA ? -1 : 1) * (isAscending ? 1 : -1);
        }
      }
  
      // normalize null/undefined to empty string
      const normalizedValueA = valueA ?? '';
      const normalizedValueB = valueB ?? '';
  
      // Dates
      if (normalizedValueA instanceof Date && normalizedValueB instanceof Date) {
        return (
          (normalizedValueA.getTime() - normalizedValueB.getTime()) *
          (isAscending ? 1 : -1)
        );
      }
  
      // Numbers
      if (
        typeof normalizedValueA === 'number' &&
        typeof normalizedValueB === 'number'
      ) {
        return (normalizedValueA - normalizedValueB) * (isAscending ? 1 : -1);
      }
  
      // Strings (case-insensitive compare)
      const stringA = String(normalizedValueA).toLowerCase();
      const stringB = String(normalizedValueB).toLowerCase();
  
      if (stringA < stringB) return isAscending ? -1 : 1;
      if (stringA > stringB) return isAscending ? 1 : -1;
      return 0;
    });
  }
  
  get pageSize(): number {
    return this.paginationInfo.pageSize || this.pagelength || 10;
  }
  get pageStart(): number {
    if (!this.totalRecords) return 0;
    return ((this.paginationInfo.pageNumber || 1) - 1) * this.pageSize + 1;
  }
  get pageEnd(): number {
    if (!this.totalRecords) return 0;
    const end = this.pageStart + this.pageSize - 1;
    return Math.min(end, this.totalRecords);
  }
  get canPrevPage(): boolean {
    return (this.paginationInfo.pageNumber || 1) > 1;
  }
  get canNextPage(): boolean {
    return (this.paginationInfo.pageNumber || 1) < this.totalPages;
  }
  
  prevPage() {
    if (!this.canPrevPage) return;
    this.paginationInfo.pageNumber = (this.paginationInfo.pageNumber || 1) - 1;
    this.recomputeView();
  }
  nextPage() {
    if (!this.canNextPage) return;
    this.paginationInfo.pageNumber = (this.paginationInfo.pageNumber || 1) + 1;
    this.recomputeView();
  }
  

  private recomputeView(): void {
    this.internalFindFlag = false;
    const filtered = this.filteredPersonSearchResult ?? [];
    const sorted = this.sortClient(filtered);
    this.displayAddNewButton = !this.filteredPersonSearchResult || this.filteredPersonSearchResult.length === 0;
  
    this.totalRecords = sorted.length;
  
    const pageSize = this.paginationInfo.pageSize || this.pagelength || 50;
    const page = this.paginationInfo.pageNumber || 1;
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
  
    this.pagedPersonSearchResult = sorted.slice(start, end);
  
    // show/enable “Add New” appropriately
    this.displayAddNewButton = this.totalRecords === 0;
  }

  private dateRangeValidator(): ValidatorFn {
    return (group: AbstractControl): ValidationErrors | null => {
      const from = group.get('fromDate')?.value;
      const to = group.get('toDate')?.value;
  
      if (!from) return null;
  
      const fromTime = new Date(from).setHours(0,0,0,0);
      const toTime = new Date(to).setHours(0,0,0,0);
  
      return fromTime < toTime ? null : { dateRange: true };
    };
  }

  onFromDateChange(value: any) {
    this.selectedDobOption = 'AGE';
    this.involvedPersonSearchForm.get('dob')?.setValue(null);
    const toCtrl = this.involvedPersonSearchForm.get('toDate');
    if (!value) {
      toCtrl?.setValue(null);
      this.resetAgeField();
      return;
    } 
  
    const toVal = toCtrl?.value;
    if (toVal) {
      const fromTime = new Date(value).setHours(0,0,0,0);
      const toTime = new Date(toVal).setHours(0,0,0,0);
      if (fromTime >= toTime) {
        toCtrl?.setValue(null);
        this.isDobRange = false;
      }
    } else{
      this.isDobRange = true;
    }

    this.resetAgeField();
  }

  onDobChange(evt: any){
    this.selectedDobOption = 'DOB';
    this.involvedPersonSearchForm.get('fromDate')?.setValue(null);
    this.involvedPersonSearchForm.get('toDate')?.setValue(null);
    this.resetAgeField();
  }

  onDobOptionChange(evt: any){
    const age = this.involvedPersonSearchForm.get('age')?.value;
    const defaultRadio = age ? 'AGE' : 'DOB';
    if (!!!this.selectedDobOption || !evt.value) {
      this.selectedDobOption = evt.value || defaultRadio;
      return;
    }
    this.selectedDobOption = evt.value || defaultRadio;
    this.involvedPersonSearchForm.get('fromDate')?.setValue(null);
    this.involvedPersonSearchForm.get('toDate')?.setValue(null);
    this.involvedPersonSearchForm.get('dob')?.setValue(null);
    this.resetAgeField();
  }
  
  onToDateChange(value: any) {
    this.selectedDobOption = 'AGE';
    this.involvedPersonSearchForm.get('dob')?.setValue(null);
    const fromCtrl = this.involvedPersonSearchForm.get('fromDate');
    const fromVal = fromCtrl?.value;
    this.isDobRange = fromVal ? false : true;
    this.resetAgeField();
  }


  atLeastOne = (validator: ValidatorFn) => (
    group: FormGroup,
  ): ValidationErrors | null => {
    const hasAtLeastOne = group && group.controls && Object.keys(group.controls)
      .some(k => !validator(group.controls[k]));
    return hasAtLeastOne ? null : {
      atLeastOne: true,
    };
  }

  onpagelengthchange(pagelength: number) {
    this.pagelength = pagelength;
    this.paginationInfo.pageSize = pagelength;
    this.paginationInfo.pageNumber = 1;
    this.recomputeView();
  }
  compareRefKey = (a: any, b: any) => (a && b ? a.ref_key === b.ref_key : a === b);

  isSelected(code: string): boolean {
    const sel = (this.involvedPersonSearchForm.get('searchtypes')?.value || []) as Array<{ref_key:string}>;
    return sel.some(x => x.ref_key === code);
  }

  onSearchTypesChange(_: any) {
    const ctrl = this.involvedPersonSearchForm.get('searchtypes');
    let sel = (ctrl?.value || []) as Array<{ ref_key: string; description?: string }>;
    
    if(sel.some(x => x.ref_key === 'EXM')){
      sel = [{ ref_key: 'EXP', description: 'Exact Plus' }, ...sel];
    }
    if(sel.some(x => x.ref_key === 'FZM')){
      sel = [...sel, { ref_key: 'SXM', description: 'Soundex' }, { ref_key: 'SYN', description: 'Synonym' }];
    }
    // if (!sel.some(x => x.ref_key === 'EXM')) {
    //   sel = [{ ref_key: 'EXM', description: 'Exact' }, ...sel];
    // }
    const uniq = Array.from(new Map(sel.map(x => [x.ref_key, x])).values());
    ctrl?.setValue(uniq, { emitEvent: false });
  }
  

  displaySelectedSearchTypes = (vals: Array<{ ref_key: string; description?: string }>) => {
    const list = Array.isArray(vals) ? vals : [];
    const names = list
      .map(v => v?.description || this.refKeyToLabel(v?.ref_key))
      .filter(Boolean);
    const exactFirst = [
      ...names.filter(n => n === 'Exact'),
      ...names.filter(n => n === 'Exact Plus'),
      ...names.filter(n => (n !== 'Exact' && n !== 'Exact Plus'))
    ];
    const exactGroup = names.filter(n => n === 'Exact' || n === 'Exact Plus');
    const otherGroup = names.filter(n => n !== 'Exact' && n !== 'Exact Plus');
    const result = [];
    if (exactGroup.length) {
      result.push('Exact/Exact Plus');
    }
    if (otherGroup.length) {
      result.push('Fuzzy/Soundex/Synonym');
    }
    return result.join(', ');
  };

  private refKeyToLabel(code?: string): string {
    switch ((code || '').toUpperCase()) {
      case 'EXM': return 'Exact';
      case 'EXP': return 'Exact Plus';
      case 'SXM': return 'Soundex';
      case 'SYN': return 'Synonym';
      case 'FZM': return 'Fuzzy';
      default:    return code || '';
    }
  }


  loadDropdowns() {
    this.genderDropdownItems$ = this.dropdownService.getGenders();
    this.stateDropdownItems$ = this.dropdownService.getPickListByName('state');
    this.searchtypelist$ = this.dropdownService
      .getReferenveValuesByTypeIdandTeam(500200,'CW')
      .pipe(
        map(items =>
          items
            .filter(i => ['EXM','EXP','SXM','SYN','FZM'].includes(i.ref_key))
            .sort((a, b) => a.displayorder - b.displayorder)
        )
      );
  }
  clearPersonSearch() {
    this.findClicked = false;
    this.involvedPersonSearchForm.reset({ searchtypes: this.allSearchTypes,
    isdeceased: true });
    this.involvedPersonSearchForm.get('cjamspid')?.setValue('');
    this.involvedPersonSearchForm.get('cjisnumber')?.setValue('');
    this.uiOnlyErrorMsg = null;
    this.uiErrorMsg = null;
    this.involvedPersonSearchForm.get('county')?.disable(); // ADDED FOR ADDRESS SEARCH
    this.isSearch = false;
    this.selectedDobOption = 'DOB';
    this.resetResultControls(50);
    this.personSearchResult = [];
    this.showPersonDetail = -1;
    this.enableEntries();
    this._session.removeItem('personSearchParams');

    this.smartyAddr = this.defaultSmartyAddr();
  }

  loadCounty() {
    this.involvedPersonSearchForm.get('county')?.enable();
    const stateKey = this.involvedPersonSearchForm.getRawValue().stateid;
    this.dropdownService.getPickListByMdmcode(stateKey).subscribe(countyList => {
      this.countyDropdownItems$ = of(countyList);
    });
  }
  disableNonCJISEntries(){
    if (this.involvedPersonSearchForm.get('cjisnumber')?.value != ''){
      this.involvedPersonSearchForm.get('cjamspid')?.setValue('');
      this.involvedPersonSearchForm.get('cjamspid')?.disable();
      this.disableEntries();
    } else {
      this.enableEntries();
    }
  }

  disableNonCJAMSPidEntries(){

    if (this.involvedPersonSearchForm.get('cjamspid')?.value != ''){
      this.involvedPersonSearchForm.get('cjisnumber')?.setValue('');
      this.involvedPersonSearchForm.get('cjisnumber')?.disable();
      this.disableEntries();
    } else {
      this.enableEntries();
    }
  }
  

  disableEntries(){
    this.involvedPersonSearchForm.get('firstname')?.setValue('');
    this.involvedPersonSearchForm.get('middlename')?.setValue('');
    this.involvedPersonSearchForm.get('lastname')?.setValue('');
    this.involvedPersonSearchForm.get('ssn')?.setValue('');
    this.involvedPersonSearchForm.get('dl')?.setValue('');
    this.involvedPersonSearchForm.get('age')?.setValue('');
    this.involvedPersonSearchForm.get('mdmId')?.setValue('');
    this.involvedPersonSearchForm.get('fromDate')?.setValue(null);
    this.involvedPersonSearchForm.get('toDate')?.setValue(null);
    this.involvedPersonSearchForm.get('dob')?.setValue(null);

    this.smartyAddr = this.defaultSmartyAddr();
    this.involvedPersonSearchForm.get('address1')?.setValue('');
    this.involvedPersonSearchForm.get('address2')?.setValue('');
    this.involvedPersonSearchForm.get('zip')?.setValue('');
    this.involvedPersonSearchForm.get('city')?.setValue('');
    this.involvedPersonSearchForm.get('stateid')?.setValue('');
    this.involvedPersonSearchForm.get('county')?.setValue('');
    this.involvedPersonSearchForm.get('email')?.setValue('');
    this.involvedPersonSearchForm.get('phone')?.setValue('');

    this.involvedPersonSearchForm.get('firstname')?.disable();
    this.involvedPersonSearchForm.get('middlename')?.disable();
    this.involvedPersonSearchForm.get('lastname')?.disable();
    this.involvedPersonSearchForm.get('ssn')?.disable();
    this.involvedPersonSearchForm.get('dl')?.disable();
    this.involvedPersonSearchForm.get('age')?.disable();
    this.involvedPersonSearchForm.get('mdmId')?.disable();
    this.involvedPersonSearchForm.get('fromDate')?.disable();
    this.involvedPersonSearchForm.get('toDate')?.disable();
    this.involvedPersonSearchForm.get('dob')?.disable();

    this.involvedPersonSearchForm.get('address1')?.disable();
    this.involvedPersonSearchForm.get('address2')?.disable();
    this.involvedPersonSearchForm.get('zip')?.disable();
    this.involvedPersonSearchForm.get('city')?.disable();
    this.involvedPersonSearchForm.get('stateid')?.disable();
    this.involvedPersonSearchForm.get('county')?.disable();
    this.involvedPersonSearchForm.get('email')?.disable();
    this.involvedPersonSearchForm.get('phone')?.disable(); 
    this.smartyAddr.disable = true;
  }
  
  enableEntries(){
    this.involvedPersonSearchForm.get('firstname')?.enable();
    this.involvedPersonSearchForm.get('middlename')?.enable();
    this.involvedPersonSearchForm.get('lastname')?.enable();
    this.involvedPersonSearchForm.get('ssn')?.enable();
    this.involvedPersonSearchForm.get('age')?.enable();
    this.involvedPersonSearchForm.get('cjamspid')?.enable();
    this.involvedPersonSearchForm.get('cjisnumber')?.enable();
    this.involvedPersonSearchForm.get('dl')?.enable();
    this.involvedPersonSearchForm.get('mdmId')?.enable();
    this.involvedPersonSearchForm.get('fromDate')?.enable();
    this.involvedPersonSearchForm.get('toDate')?.enable();
    this.involvedPersonSearchForm.get('dob')?.enable();

    this.involvedPersonSearchForm.get('address1')?.enable();
    this.involvedPersonSearchForm.get('address2')?.enable();
    this.involvedPersonSearchForm.get('zip')?.enable();
    this.involvedPersonSearchForm.get('city')?.enable();
    this.involvedPersonSearchForm.get('stateid')?.enable();
    this.involvedPersonSearchForm.get('county')?.enable();
    this.involvedPersonSearchForm.get('email')?.enable();
    this.involvedPersonSearchForm.get('phone')?.enable();
    this.smartyAddr.disable = false;
  }
  

  toggleSsn = (row: any) => {
    row.isSsnHidden = (row.isSsnHidden !== null && row.isSsnHidden !== undefined ? !row.isSsnHidden : !this.isSsnHidden);
    if (row.isSsnHidden) {
      row.ssnEye = 'fa-eye';
      row.showSsnMask = true;
    } else {
      row.ssnEye = 'fa-eye-slash';
      row.showSsnMask = false;
    }
  }
 
  calculateDobFromAge() {
    this.involvedPersonSearchForm?.get('dob')?.setValue(null);
    const ageControl = this.involvedPersonSearchForm.get('age');
    const fromCtrl   = this.involvedPersonSearchForm.get('fromDate');
    const toCtrl     = this.involvedPersonSearchForm.get('toDate');
  
    const ageNum = Number(ageControl?.value);
    if (!Number.isFinite(ageNum) || ageNum <= 0) {
      fromCtrl?.reset();
      toCtrl?.reset();
      return;
    }
  
    const approxDob = moment().startOf('day').subtract(ageNum, 'years');
    const fromDate = approxDob.clone().subtract(6, 'months').toDate();
    const toDate = approxDob.clone().add(6, 'months').toDate();

    this.suppressAgeClear = true;
    fromCtrl?.setValue(fromDate, { emitEvent: true });
    toCtrl?.setValue(toDate, { emitEvent: true });
    setTimeout(() => { this.suppressAgeClear = false; }, 0);
  
    fromCtrl?.markAsDirty();
    toCtrl?.markAsDirty();
  }
  
  private formatDateForApi(value: any): string | undefined {
    if (!value) return undefined;
    return moment(value).isValid()
      ? moment(value).format('MM/DD/YYYY')
      : value;
  }

  getRemovalHistoryByPerson(person: any){
    this._commonHttpService
    .getSingle(
      {
        where: { objectid: person.personid,
           cjamspid: person.cjamspid,
          'objecttypekey': 'personid'},
        method: 'get'
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
        .GetChildRemovalList + '?filter'
    ).subscribe(data => {
        this.selectedPersonHistory = {
          removalHistory : data,
          fullname : person.fullname,
          age : person.age,
          gender : person.gender,
          cjamspid : person.cjamspid
        }
        if (this.selectedPersonHistory) {
            (<any>$('#fostercare-history')).modal('show');
        }
    });
  }

  getGapHistoryByPerson(person: any){
    this._commonHttpService.getAll('ivegap/gap/gap-history/' + person.cjamspid
    ).subscribe(data => {
        this.selectedPersonGapHistory = {
          gapHistory : data
        }
        if (this.selectedPersonGapHistory) {
            (<any>$('#gap-history')).modal('show');
        }
    });
  }

  getAdoptionHistoryByPerson(person: any){
    // adoption-history declares clientId as a required number, so a row with no
    // cjamspid produces a 400 before the query runs rather than an empty history.
    if (!person || !person.cjamspid || isNaN(Number(person.cjamspid))) {
      return;
    }
    this._commonHttpService.getAll('iveadoption/adoption/adoption-history/' + person.cjamspid
    ).subscribe(data => {
        this.selectedPersonAdoptionHistory = {
          adoptionHistory : data
        }
        if (this.selectedPersonAdoptionHistory) {
            (<any>$('#adoption-history')).modal('show');
        }
    });
  }

  sortValues(a: any, b: any) {
    const isAsc = this.sortInput.direction === 'asc';
    switch (this.sortInput.active) {
      case 'id': return compare(a.id, b.id, isAsc);
      case 'source': return compare(a.source, b.source, isAsc);
      case 'program': return compare(a.program, b.program, isAsc);
      case 'subProgram': return compare(a.subProgram, b.subProgram, isAsc);
      case 'status': return compare(a.status, b.status, isAsc);
      case 'start': return compare(new Date(a.start), new Date(b.start), isAsc);
      case 'end': return compare(new Date(a.end), new Date(b.end), isAsc);
      case 'worker': return compare(a.worker, b.worker, isAsc);
      case 'supervisor': return compare(a.supervisor, b.supervisor, isAsc);
      case 'localOffice': return compare(a.localOffice, b.localOffice, isAsc);
      default: return 0;
    }
  }

  sortData(sort: Sort) {
    this.sortInput = sort;
    const data = this.programParticipationService.loadedPrograms.slice();
    if (!sort.active || sort.direction === '') {
      this.programParticipationService.loadedPrograms = data;
      return;
    }
    this.programParticipationService.loadedPrograms = data;
    this.programParticipationService.loadedPrograms.sort(this.sortValues);
  }

  private getApproximateSearchNameWarning(formGroup: FormGroup): string | null {
    const readTrimmed = (controlName: string) =>
      (formGroup.get(controlName)?.value ?? '').toString().trim();
  
    const firstNameValue = readTrimmed('firstname');
    const lastNameValue  = readTrimmed('lastname');
  
    // Supports either string codes ['EXM','SXM'] or objects [{ ref_key:'SXM' }]
    const selectedSearchTypesRaw = formGroup.get('searchtypes')?.value ?? [];
    const selectedTypeCodes: string[] = (Array.isArray(selectedSearchTypesRaw) ? selectedSearchTypesRaw : [])
      .map((item: any) => (typeof item === 'string' ? item : (item?.ref_key || '')))
      .map((code: string) => code.toUpperCase());
  
    const approximateTypes = ['FZM', 'SXM', 'SYN']; // exact plus, fuzzy, soundex, synonym
    const requiresBothNames = approximateTypes.some(code => selectedTypeCodes.includes(code));
  
    const bothNamesProvided = !!(firstNameValue && lastNameValue);
  
    if (requiresBothNames && !bothNamesProvided) {
      return 'Both First name and last name are required for Fuzzy, Soundex and Synonym search';
    }
    return null;
  }
  


  searchInvolvedPersons(model: People, mode: string) {
    this.findClicked = true;
    this.isSearch = false;
    this.selectedPerson = null;
    this.personSearchResult = [];
    this.filteredPersonSearchResult = [];
    const { county, ...restControls } = this.involvedPersonSearchForm.controls;
    // const uiOnlyErr = this.uiOnlyRulesValidator()(this.involvedPersonSearchForm);
    const uiOnlyErr = this.searchCriteriaValidator()(this.involvedPersonSearchForm);
    this.uiOnlyErrorMsg = uiOnlyErr?.searchIdentifierInvalid?.message ?? null;

    if (this.uiOnlyErrorMsg) {
      this.involvedPersonSearchForm.markAllAsTouched();
      return;
    }

    // const uiValidator = this.searchCriteriaValidator()(this.involvedPersonSearchForm);
    // const isvalid = uiValidator?.invalidSearchCriteria ?? null;

    // if (isvalid) {
    //   this.involvedPersonSearchForm.markAllAsTouched();
    //   this.uiOnlyErrorMsg = 'Enter First & Last Name, or one primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or Name + a supporting attribute (DOB, Address, City, Zip, State, or Gender).';
    //   return;
    // }else {
    //   this.uiOnlyErrorMsg = null;
    // }
    

    const warnMsg = this.getApproximateSearchNameWarning(this.involvedPersonSearchForm as FormGroup);
    this.uiOnlyErrorMsg = warnMsg || null;


    const tempGroup = new FormGroup(restControls);
    if (tempGroup.invalid) {
      return;
    }
    this.showPersonDetail = -1;
    if (mode === 'new') {
      this.paginationInfo.sortBy = 'asc';
      this.paginationInfo.sortColumn = null;
      this.resetResultControls(50);
    }
    
    const raw = this.involvedPersonSearchForm.getRawValue();
    const payload: any = { ...raw };
    payload.fromDate = this.formatDateForApi(raw.fromDate);
    payload.toDate = this.formatDateForApi(raw.toDate);

    if(!raw.fromDate && !!raw.dob){
      payload.fromDate = this.formatDateForApi(raw.dob);
    }

    payload.es_include_deceased = !!raw.isdeceased;
    delete payload.isdeceased;
    if (raw.phone) {
      const digitsOnly = String(raw.phone).replace(/\D/g, '');
      payload.phone = digitsOnly;
    }
    this.personSearch = payload;
    this.involvedPersonSearch = Object.assign(new InvolvedPerson(), payload);
    if (this.involvedPersonSearchForm.value.address1) {
      this.involvedPersonSearch.address = this.involvedPersonSearchForm.value.address1 + '' + this.involvedPersonSearchForm.value.address2;
    }
    this.getPage(1, this.involvedPersonSearch);
  }


  searchCriteriaValidator(): ValidatorFn {
    return (form: AbstractControl): ValidationErrors | null => {
      const formGroup = form as FormGroup;
      const getControlValue = (controlName: string): string =>
        (formGroup.get(controlName)?.value ?? '').toString().trim();
  
      // Names
      const firstName  = getControlValue('firstname');
      const lastName   = getControlValue('lastname');
      const middleName = getControlValue('middlename');
      const hasAnyName = !!(firstName || lastName || middleName);
  
      // Fields
      const hasAddress1 = !!getControlValue('address1');
      const hasSSN      = !!getControlValue('ssn');
      const hasIRN      = !!getControlValue('cjisnumber');
      const hasMDM      = !!getControlValue('mdmId');
      const hasCJAMS    = !!getControlValue('cjamspid');
      const hasDL       = !!getControlValue('dl');
      const hasPhone    = !!getControlValue('phone');
      const hasEmail    = !!getControlValue('email');
      const hasDob    = !!getControlValue('dob');
  
      // Supportive & DOB
      const hasDobFrom  = !!getControlValue('fromDate');
      const hasDobTo    = !!getControlValue('toDate');
      const hasDobRange = hasDobFrom && hasDobTo;
  
      const supportiveAttributeFields = ['address2', 'city', 'zip', 'stateid', 'gender'];
      const hasSupportiveAttribute =
        hasDobTo || supportiveAttributeFields.some(
          (fieldName) => !!getControlValue(fieldName)
        );

      // Address1 alone does NOT count
      const hasPrimaryIdentifier =
        hasIRN || hasMDM || hasCJAMS || hasDL || hasPhone || hasEmail ||
        hasAddress1;
  
      // Passing conditions
      if (firstName && lastName) return null;
      if (hasPrimaryIdentifier)  return null;
      if (hasSupportiveAttribute) {
        if (hasDobRange) {
          if ((firstName && lastName) || hasPrimaryIdentifier ) return null;
        } else {
          if (firstName && lastName) return null;
        }
      }

      if (lastName) {
        if(hasDobFrom && !hasDobTo) {
          if (!hasPrimaryIdentifier) {
            return null;
          }
        }
      } 

      if((hasAnyName && hasDob) || (lastName && hasDobRange) || (hasSSN && !hasPrimaryIdentifier && !hasAnyName && !hasDobRange && !hasDob)){
        return null;
      }

      // ---------- Message builder ----------
      const label: Record<string, string> = {
        mdmId: 'MDM ID',
        cjamspid: 'CJAMS PID',
        ssn: 'SSN',
        cjisnumber: 'CIS/IRN',
        dl: 'DL No.',
        address1: 'Address Line 1',
        phone: 'Phone',
        email: 'Email',
        address2: 'Address Line 2',
        city: 'City',
        zip: 'Zip Code',
        stateid: 'State',
        gender: 'Gender'
      };
  
      const listify = (items: string[]) => {
        if (items.length === 0) return '';
        if (items.length === 1) return items[0];
        if (items.length === 2) return `${items[0]} and ${items[1]}`;
        return `${items.slice(0, -1).join(', ')}, and ${items[items.length - 1]}`;
      };
  
      const namesProvided: string[] = [];
      if (firstName)  namesProvided.push('First Name');
      if (middleName) namesProvided.push('Middle Name');
      if (lastName)   namesProvided.push('Last Name');
  
      const supportiveProvided: string[] = [];
      if (hasDobFrom) supportiveProvided.push('DOB From');
      if (hasDobTo)   supportiveProvided.push('DOB To');
      supportiveProvided.push(
        ...supportiveAttributeFields
          .filter((fieldName) => !!getControlValue(fieldName))
          .map((fieldName) => label[fieldName])
      );
  
      let message =
        'Enter First & Last Name, or one primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or Name + a supporting attribute (DOB, Address, City, Zip, State, or Gender).';
  
      if (hasDobRange && !((firstName && lastName) || hasPrimaryIdentifier)) {
        if((!hasAnyName && !hasPrimaryIdentifier) || hasSSN){
          message = message;
        }
        if (firstName && !lastName) {
          message = 'DOB From & To and firstname are selected. Add Last Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else if (lastName && !firstName) {
          message = 'DOB From & To and lastname are selected. Add First Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else if (firstName && middleName && !lastName) {
          message = 'DOB From & To are selected with First + Middle. Add Last Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else {
          message = message;
        }
      }
      // Other targeted cases
      else if (hasSupportiveAttribute && !(firstName && lastName)) {
        message = `Enter First & Last Name, or one primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or Name + a supporting attribute (DOB, Address, City, Zip, State, or Gender).`;
      } else if (hasSupportiveAttribute) {
          if (firstName && !lastName && middleName) {
          message = 'You entered First Name and Middle Name and a supportive attribute. Add Last Name (Both First and Last names are required)';
        } else if (lastName && !firstName && middleName) {
          message = 'You entered Last Name and Middle Name and a supportive attribute. Add First Name (Both First and Last names are required)';
        } else if (firstName && !lastName) {
          message = 'You entered First Name and Supportive Atrribute only. Add Last Name(Both First and Last names are required)';
        } else if (lastName && !firstName) {
          message = 'You entered Last Name and Supportive Atrribute only. Add First Name(Both First and Last names are required)';
        } else if (!firstName && middleName && !lastName) {
          message = 'You entered Middle Name and Supportive Attribute only. Both First and Last names are required';
        } else if (!hasSupportiveAttribute) {
          if (firstName && !lastName && middleName) {
            message = 'You entered First Name and Middle Name. Add Last Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (lastName && !firstName && middleName) {
            message = 'You entered Last Name and Middle Name. Add First Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (firstName && !lastName) {
            message = 'You entered First Name. Add Last Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (lastName && !firstName) {
            message = 'You entered Last Name. Add First Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (!firstName && middleName && !lastName) {
            message = 'You entered Middle Name only. Add Both Names, and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender), or a primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email).';
          }
      } else if (hasAnyName && !(firstName && lastName) && !hasSupportiveAttribute) {
        const namesSummary = listify(namesProvided);
        message = `You entered ${namesSummary}. Add ${firstName ? 'Last Name' : 'First or Last Name'}, or a supportive attribute (DOB range, City, Zip Code, State, Gender), or a primary identifier.`;
      } else if (!hasAnyName && !hasPrimaryIdentifier && !hasSupportiveAttribute) {
        message = 'Start a search by either: (1) entering First & Last name, or (2) providing a primary identifier (SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or (3) typing any name plus a supportive attribute (DOB range, Address Line 2, City, Zip Code, State, or Gender).';
      }
  
    };
    return { searchIdentifierInvalid: { message } };
  }
}


  private resetResultControls(defaultPageSize = 50): void {
    this.searchText = '';
    this.pagelength = defaultPageSize;
    this.paginationInfo.pageSize = defaultPageSize;
    this.paginationInfo.pageNumber = 1;
  }

  onSortedPerson($event: ColumnSortedEvent) {
    this.currentSortColumn = $event.sortColumn || null;
    this.currentSortDirection = ($event.sortDirection as any) || '';
    this.paginationInfo.pageNumber = 1;
    this.recomputeView();
  }

  private uiOnlyRulesValidator(): ValidatorFn {
    return (form: AbstractControl): ValidationErrors | null => {
      const formGroup = form as FormGroup;
      const getControlValue = (controlName: string): string =>
        (formGroup.get(controlName)?.value ?? '').toString().trim();
  
      // Names
      const firstName  = getControlValue('firstname');
      const lastName   = getControlValue('lastname');
      const middleName = getControlValue('middlename');
      const hasAnyName = !!(firstName || lastName || middleName);
  
      // Fields
      const hasAddress1 = !!getControlValue('address1');
      const hasSSN      = !!getControlValue('ssn');
      const hasIRN      = !!getControlValue('cjisnumber');
      const hasMDM      = !!getControlValue('mdmId');
      const hasCJAMS    = !!getControlValue('cjamspid');
      const hasDL       = !!getControlValue('dl');
      const hasPhone    = !!getControlValue('phone');
      const hasEmail    = !!getControlValue('email');
  
      // Supportive & DOB
      const hasDobFrom  = !!getControlValue('fromDate');
      const hasDobTo    = !!getControlValue('toDate');
      const hasDobRange = hasDobFrom && hasDobTo;
  
      const supportiveAttributeFields = ['address2', 'city', 'zip', 'stateid', 'gender'];
      const hasSupportiveAttribute =
        hasDobTo || supportiveAttributeFields.some(
          (fieldName) => !!getControlValue(fieldName)
        );

      // Address1 alone does NOT count
      const hasPrimaryIdentifier =
        hasSSN || hasIRN || hasMDM || hasCJAMS || hasDL || hasPhone || hasEmail ||
        hasAddress1;
  
      // Passing conditions
      if (firstName && lastName) return null;
      if (hasPrimaryIdentifier)  return null;
      if (hasSupportiveAttribute) {
        if (hasDobRange) {
          if ((firstName && lastName) || hasPrimaryIdentifier ) return null;
        } else {
          if (firstName && lastName) return null;
        }
      }

      if (lastName) {
        if(hasDobFrom && !hasDobTo) {
          if (!hasPrimaryIdentifier) {
            return null;
          }
        }
      } 
  
      // ---------- Message builder ----------
      const label: Record<string, string> = {
        mdmId: 'MDM ID',
        cjamspid: 'CJAMS PID',
        ssn: 'SSN',
        cjisnumber: 'CIS/IRN',
        dl: 'DL No.',
        address1: 'Address Line 1',
        phone: 'Phone',
        email: 'Email',
        address2: 'Address Line 2',
        city: 'City',
        zip: 'Zip Code',
        stateid: 'State',
        gender: 'Gender'
      };
  
      const listify = (items: string[]) => {
        if (items.length === 0) return '';
        if (items.length === 1) return items[0];
        if (items.length === 2) return `${items[0]} and ${items[1]}`;
        return `${items.slice(0, -1).join(', ')}, and ${items[items.length - 1]}`;
      };
  
      const namesProvided: string[] = [];
      if (firstName)  namesProvided.push('First Name');
      if (middleName) namesProvided.push('Middle Name');
      if (lastName)   namesProvided.push('Last Name');
  
      const supportiveProvided: string[] = [];
      if (hasDobFrom) supportiveProvided.push('DOB From');
      if (hasDobTo)   supportiveProvided.push('DOB To');
      supportiveProvided.push(
        ...supportiveAttributeFields
          .filter((fieldName) => !!getControlValue(fieldName))
          .map((fieldName) => label[fieldName])
      );
  
      let message =
        'Enter either First & Last name, or any one primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or a name plus a supportive attribute (DOB range, Address Line 2, City, Zip Code, State, or Gender). Note: Address Line 1 must be paired with SSN, DOB (From & To), IRN, or MDM ID.';
  
      if (hasDobRange && !((firstName && lastName) || hasPrimaryIdentifier)) {
        if (firstName && !lastName) {
          message = 'DOB From & To and firstname are selected. Add Last Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else if (lastName && !firstName) {
          message = 'DOB From & To and lastname are selected. Add First Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else if (firstName && middleName && !lastName) {
          message = 'DOB From & To are selected with First + Middle. Add Last Name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        } else {
          message = 'DOB From & To are selected. Provide First & Last name or provide CIS/IRN,SSN, DOB, MDM-ID or CJAMS PID.';
        }
      }
      // Other targeted cases
      else if (hasSupportiveAttribute && !(firstName && lastName)) {
        const supportiveSummary = listify(supportiveProvided);
        message = `You entered ${supportiveSummary}. Date of Birth, Date of Entry, Address, and Demographics require either an Primary Identifier or both First & Last Name.`;
      } else if (hasSupportiveAttribute) {
          if (firstName && !lastName && middleName) {
          message = 'You entered First Name and Middle Name and a supportive attribute. Add Last Name (Both First and Last names are required)';
        } else if (lastName && !firstName && middleName) {
          message = 'You entered Last Name and Middle Name and a supportive attribute. Add First Name (Both First and Last names are required)';
        } else if (firstName && !lastName) {
          message = 'You entered First Name and Supportive Atrribute only. Add Last Name(Both First and Last names are required)';
        } else if (lastName && !firstName) {
          message = 'You entered Last Name and Supportive Atrribute only. Add First Name(Both First and Last names are required)';
        } else if (!firstName && middleName && !lastName) {
          message = 'You entered Middle Name and Supportive Attribute only. Both First and Last names are required';
        } else if (!hasSupportiveAttribute) {
          if (firstName && !lastName && middleName) {
            message = 'You entered First Name and Middle Name. Add Last Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (lastName && !firstName && middleName) {
            message = 'You entered Last Name and Middle Name. Add First Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (firstName && !lastName) {
            message = 'You entered First Name. Add Last Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (lastName && !firstName) {
            message = 'You entered Last Name. Add First Name (Both First and Last names are required) and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender)';
          } else if (!firstName && middleName && !lastName) {
            message = 'You entered Middle Name only. Add Both Names, and a supportive attribute (e.g., DOB range, City, Zip Code, State, Gender), or a primary identifier (CJAMS PID, SSN, CIS/IRN, DL No., MDM ID, Phone, or Email).';
          }
      } else if (hasAnyName && !(firstName && lastName) && !hasSupportiveAttribute) {
        const namesSummary = listify(namesProvided);
        message = `You entered ${namesSummary}. Add ${firstName ? 'Last Name' : 'First or Last Name'}, or a supportive attribute (DOB range, City, Zip Code, State, Gender), or a primary identifier.`;
      } else if (!hasAnyName && !hasPrimaryIdentifier && !hasSupportiveAttribute) {
        message = 'Start a search by either: (1) entering First & Last name, or (2) providing a primary identifier (SSN, CIS/IRN, DL No., MDM ID, Phone, or Email), or (3) typing any name plus a supportive attribute (DOB range, Address Line 2, City, Zip Code, State, or Gender).';
      }
  
    };
    return { searchIdentifierInvalid: { message } };
  }
}
  

  hasEditAccess() {
    const user: AppUser = this._authService.getCurrentUser();
    let hasAccess = false;
    const found = this.EDITABLE_ROLES.indexOf(user?.role?.name);
    if (found !== -1) {
      hasAccess = true;
    }
    return hasAccess;
  }
  // Converts any date-like value to a YYYY-MM-DD string (day granularity).
  // Returns null for invalid or empty values.
  private dateToDayKey(value: any): string | null {
    if (!value) return null;
    const date = new Date(value);
    if (isNaN(date.getTime())) return null;

    const mm = String(date.getMonth() + 1).padStart(2, '0');
    const dd = String(date.getDate()).padStart(2, '0');
    return `${date.getFullYear()}-${mm}-${dd}`;
  }

  // Clears the Age field without re-triggering dependent logic.
  // Also restores "pristine/untouched" visuals.
  private resetAgeField(): void {
    const ageControl = this.involvedPersonSearchForm.get('age');
    ageControl?.setValue(null, { emitEvent: false });
    ageControl?.markAsPristine();
    ageControl?.markAsUntouched();
  }

  // Subscribes to a date control and clears Age ONLY when the selected day actually changes.
  // - Ignores emissions caused by Age→DOB auto-fill via `this.suppressAgeClear`.
  // - Unsubscribes automatically via `this.destroy$`.
  private watchDateFieldForActualDayChange(controlName: 'fromDate' | 'toDate') {
    const dateControl = this.involvedPersonSearchForm.get(controlName);
    if (!dateControl) return;

    dateControl.valueChanges
      .pipe(
        map(value => this.dateToDayKey(value)),
        startWith(this.dateToDayKey(dateControl.value)),
        pairwise(), // [previousDayKey, currentDayKey]
        filter(([previousDayKey, currentDayKey]) => !!currentDayKey && previousDayKey !== currentDayKey),
        filter(() => !this.suppressAgeClear),
        takeUntil(this.destroy$)
      )
      .subscribe(() => this.resetAgeField());
  }

  formatDate(mmddyyyy?: string | null): string | null {
    if (!mmddyyyy || typeof mmddyyyy !== 'string') return null;
    // Accept both MM/DD/YYYY
    if (mmddyyyy.includes('/')) {
      const [mm, dd, yyyy] = mmddyyyy.split('/');
      if (mm && dd && yyyy) return `${yyyy}-${mm.padStart(2, '0')}-${dd.padStart(2, '0')}`;
      return null;
    }
    if (mmddyyyy.includes('-')) {
      const [yyyy,mm, dd] = mmddyyyy.split('-');
      if (mm && dd && yyyy) return `${yyyy}-${mm.padStart(2, '0')}-${dd.padStart(2, '0')}`;
      return null;
    }

    // If it's already YYYY-MM-DD, just return
    if (/^\d{4}-\d{2}-\d{2}$/.test(mmddyyyy)) return mmddyyyy;
    return null;
  }

  private extractIdValues(item: any): { cjamspid?: string; irns: string[] } {
    let cjams: string | undefined = item?.cjams_id;
    const irnSet = new Set<string>();

    if (Array.isArray(item?.identificationTypes)) {
      for (const id of item.identificationTypes) {
        if (!cjams && id?.identification_source_system === 'CJAMS' && id?.identification_source_key) {
          cjams = id.identification_source_key; 
        }
        if (id?.identification_irn) {
          irnSet.add(id.identification_irn);
        }
      }
    }

    return { cjamspid: cjams, irns: Array.from(irnSet).filter(Boolean) };
  }

  makePrimaryAddress(item: any): string {
    const addr1 = item?.resi_address_line_1 || item?.address_line_1 || '';
    const addr2 = item?.resi_address_line_2 || item?.address_line_2 || '';
    const city  = item?.resi_city || item?.mailing_city || '';
    const zip   = item?.resi_zip_code || item?.mailing_zip_code || '';
    const state = item?.resi_state || item?.mailing_state || item?.mailing_state_cd_desc || item?.resi_state_cd_desc || '';
    return [addr1, addr2, city, zip, '', state].join('~');
  }

  private buildRowKeys(item: any): Array<{ cjamspid: string; irn: string }> {
    const toTrimmed = (v: any) => (v ?? '').toString().trim();
  
    const identifications: any[] = Array.isArray(item?.identificationTypes)
      ? item.identificationTypes
      : [];
  
    // Case A: If CJAMS entries exist => only use CJAMS; one row per CJAMS object
    const cjamsIdentifications = identifications.filter(
      (ident) => toTrimmed(ident?.identification_source_system).toUpperCase() === 'CJAMS'
    );
  
    if (cjamsIdentifications.length > 0) {
      const rows: Array<{ cjamspid: string; irn: string }> = [];
  
      for (const cjamsIdent of cjamsIdentifications) {
        const cjamsPid = toTrimmed(cjamsIdent?.identification_source_key);
        if (!cjamsPid) continue; // skip invalid
  
        rows.push({
          cjamspid: cjamsPid,
          irn: toTrimmed(cjamsIdent?.identification_irn), // can be empty
        });
      }
  
      // Remove duplicates by (PID, IRN)
      const seenSignatures = new Set<string>();
      return rows.filter((row) => {
        const sig = `${row.cjamspid}||${row.irn}`;
        if (seenSignatures.has(sig)) return false;
        seenSignatures.add(sig);
        return true;
      });
    }
  
    // Case B: No CJAMS Source System => use item.cjams_id and ALL distinct IRNs from any system
    const fallbackCjamsPid = toTrimmed(item?.cjams_id);
  
    // No IRNs anywhere => single PID-only row regular
    return [{ cjamspid: fallbackCjamsPid, irn: '' }];
  }
  
  

  private mapMdmToCompatibleRow(item: any, bucket: 'Exact' | 'ExactPlus' | 'Soundex' | 'Synonym' | 'Fuzzy',
    keys: { cjamspid: string; irn: string,  },irnOverride?: string,
  ) {
    const { cjamspid, irns } = this.extractIdValues(item);
    const cisclientid = irnOverride ?? irns[0] ?? '';
    const dobIso = this.formatDate(item?.date_of_birth) || null;
    const dodIso = this.formatDate(item?.death_date) || null;
    let aliennumber:any = '';
    
    if (item && item.alien_number && item.alien_number !=='N/A'){
      aliennumber = item.alien_number;
    }

    const gender =
      item?.gender_cd ||
      (typeof item?.gender === 'string' && item.gender.length ? item.gender[0].toUpperCase() : '');

    const prefix = item?.legal_prefix ?? item?.prefix ?? '';
    const prefx  = prefix;

    const row = {
      exactmatch: bucket === 'Exact',
      matchtype: this.bucketToLabel(bucket),
      source: 'SDR',
      personid: '',
      cjamspid: keys.cjamspid || '',
      cisclientid: keys.irn || '', 
      assistpid: keys.irn || '',
      firstname: item?.first_name || '',
      middlename: item?.middle_name || '',
      lastname: item?.last_name || '',
      suffix: item?.legal_suffix || '',
      prefix,
      prefx,
      dob: dobIso,
      dod: dodIso,
      deceased: null,
      email: item?.email,
      phone_number: item?.phone_number,
      ssn: item?.ssn || '',
      ssnverified: '',
      mdm_id: item?.mdm_id || '',
      dl: item?.driver_license_number || '',
      primaryaddress: this.makePrimaryAddress(item),
      gendertypekey: gender || '',
      dangerlevel: 0,
      dcn: null,
      homephone: '',
      loadnumber: null,
      teamname: null,
      priors: '',
      relationscount: '',
      relations: '',
      alias: [
        { aliasid: null, firstname: '', lastname: '', middlename: '', sfxname: '', akatypetypekey: 'AN', prefixtypekey: '', personid: null },
        { aliasid: null, firstname: '', lastname: '', middlename: '', sfxname: '', akatypetypekey: 'MN', prefixtypekey: '', personid: null },
      ],

      percentage: '',
      primarylanguage: item?.primary_language_cd || '',
      ethnicity: item?.ethnicity_cd || '',
      nationality: '',
      race: item?.race_cd || '',

      stateid: '',
      aliennumber: aliennumber,
      alienstatus: item?.immigration_status || '',
      primarycitizenship: item?.primary_citizenship || '',
      isprovider: item?.is_cjamsprovider || '',

      score: item?.score ? Number(item.score).toFixed(3) : '',
      rank: item?.rank
    };

    return row;
  }

  private searchTypesToBuckets(codes: string[]): Array<'Exact'|'ExactPlus'|'Soundex'|'Synonym'|'Fuzzy'> {
    const set = new Set<string>(['Exact']); // EXM always included
    for (const c of codes || []) {
      switch ((c || '').toUpperCase()) {
        case 'EXM': set.add('Exact'); break;
        case 'EXP': set.add('ExactPlus'); break;
        case 'SXM': set.add('Soundex'); break;
        case 'SYN': set.add('Synonym'); break;
        case 'FZM': set.add('Fuzzy'); break;
      }
    }
    // Maintain stable order
    // if (set.has('Exact')) set.add('ExactPlus');

    const order: Array<'Exact'|'ExactPlus'|'Soundex'|'Synonym'|'Fuzzy'> = ['Exact','ExactPlus','Soundex','Synonym','Fuzzy'];
    return order.filter(x => set.has(x));
  }
  
  
  transformEnhancedResponseToLegacy(
    resp: any,
    buckets: Array<'Exact'|'ExactPlus'|'Soundex'|'Synonym'|'Fuzzy'>
  ): any[] {
    const rows: any[] = [];
    this.hasNextPage = resp.hasNextPage;
    for (const b of buckets) {
      const arr = Array.isArray(resp?.[b]) ? resp[b] : [];
      for (const item of arr) {
        const keyRows = this.buildRowKeys(item); 
        const isSplit = keyRows.length > 1;
        for (const keys of keyRows) {
          const row = this.mapMdmToCompatibleRow(item, b, keys);
          (row as any).__splitRow = isSplit;
          rows.push(row);
        }
      }
    } 
    if(resp.errorMessage != '' || resp.errorMessage == 'First name and last name both are required for fuzzy, soundex and synonym search'){
      if(rows.length > 0 || resp.errorMessage == 'First name and last name both are required for fuzzy, soundex and synonym search'){
        this._alertService?.warn(resp.errorMessage);
      } else {
        this._alertService?.error(resp.errorMessage);
      }
    } 
    return rows;
  }
  
  bucketToLabel(bucket: 'Exact'|'ExactPlus'|'Soundex'|'Synonym'|'Fuzzy'): string {
    switch (bucket) {
      case 'Exact': return 'Exact';
      case 'ExactPlus': return 'Exact Plus';
      case 'Soundex': return 'Soundex';
      case 'Synonym': return 'Synonym';
      case 'Fuzzy': return 'Fuzzy';
      default: return String(bucket);
    }
  }

  private getPage(pageNumber: number, involvedPersonSearch: any) {
    this.personSearchForm = involvedPersonSearch;
    this.personSearchForm.es_pageNumber = pageNumber;
    this.personSearchForm.es_pageLength = 500;
    this.personSearchForm.es_cjamsFlag = true;
    this.personSearchForm.sortcolumn = null;
    this.personSearchForm.sortorder = null;
    this.personSearchForm.gender = this.personSearchForm.gender === 'None' ? '' : this.personSearchForm.gender;
    ObjectUtils.removeEmptyProperties(this.personSearchForm);
  
    this._involvedPersonSeachService
      .getPagedArrayList(
        {
          nolimit: true,
          order: null,
          page: 1,
          count: null,
          where: this.personSearchForm,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      )
      .pipe(
        map((result: any) => {
          const selected = (this.involvedPersonSearchForm?.get('searchtypes')?.value || []) as Array<{ref_key:string}>;
          const selectedCodes = selected.map(s => (s?.ref_key || '').toUpperCase());
          const buckets = this.searchTypesToBuckets(selectedCodes);
          const rows = this.transformEnhancedResponseToLegacy(result, buckets) as InvolvedPersonSearchResponse[];
          return { data: rows, count: rows.length };
        })
      )
      .subscribe(response => {
        this.serverPage = pageNumber;
        this.serverLastPage = (response.data?.length ?? 0) < 500;
        this.allPersonRows = response.data;
  
        this.personSearchResult = [...this.allPersonRows];
        this.filteredPersonSearchResult = [...this.allPersonRows];
        // reset paging and sort for a fresh search
        this.paginationInfo.pageNumber = 1;
        this.currentSortColumn = 'rank';
        this.currentSortDirection = 'asc';
        this.isSearch = true;
        // show first page
        this.recomputeView();
      });
  }
  
  get totalPages(): number {
    return Math.ceil((this.totalRecords || 0) / (this.paginationInfo.pageSize || this.pagelength || 1));
  }
  
  get jumpPages(): number {
    const size = this.paginationInfo.pageSize || this.pagelength || 1;
    return Math.ceil(500 / size);
  }
  
  jumpBy(deltaRecords: number) {
    this.getPage(2, this.involvedPersonSearch);  }
  

  public get searchTerms() {
    return this.involvedPersonSearchForm.getRawValue();
  }
  onSearchCase() {
    if (!this.searchText || this.searchText.trim() === '') {
      this.filteredPersonSearchResult = [...this.personSearchResult ?? []];
    } else {
      const q = this.normalizeText(this.searchText);
      this.filteredPersonSearchResult = this.personSearchResult ? this.personSearchResult.filter(p => {
        const genderMatch     = this.safeIncludes(p.gender ?? p.gendertypekey, q);
        const matchTypeMatch  = this.safeIncludes(p.matchtype, q);
        const ssnMatch = this.ssnMatchesQuery(p.ssn, this.searchText);
  
        const dobMatch        = this.dobMatchesQuery(p.dob, this.searchText);
        const dodMatch        = this.dobMatchesQuery(p.dod, this.searchText);
  
        const firstNameMatch  = this.safeIncludes(p.firstname, q);
        const lastNameMatch   = this.safeIncludes(p.lastname,  q);
        const middleNameMatch = this.safeIncludes(p.middlename, q);
  
        const cjamsIdMatch    = this.safeIncludes(p.cjamspid,   q);
        const cisIdMatch      = this.safeIncludes(p.cisclientid, q);
        const mdmIdMatch      = this.safeIncludes(p.mdm_id,     q);
  
        const dlMatch         = this.safeIncludes(p.dl, q);
        const scoreMatch      = this.safeIncludes(p.score, q);

        const prefixMatch      = this.safeIncludes(p.prefix, q);
        const suffixMatch      = this.safeIncludes(p.suffix, q);
  
        return matchTypeMatch ||
              firstNameMatch || 
              lastNameMatch || 
              cjamsIdMatch || 
              cisIdMatch || 
              mdmIdMatch ||
              middleNameMatch ||
              dobMatch ||
              dodMatch ||
              genderMatch ||
              dlMatch ||
              scoreMatch ||
              ssnMatch ||
              prefixMatch ||
              suffixMatch;
    }) : [];
      if (this.filteredPersonSearchResult?.length === 0) {
        this.internalFindFlag = true;
      }
    }
    this.paginationInfo.pageNumber = 1;
    this.recomputeView();
  }

  onNext500() {
    if (this.serverLastPage) return;          // nothing beyond last chunk
    this.getPage(this.serverPage + 1, this.involvedPersonSearch);
  }
  
  onPrev500() {
    if (this.serverPage <= 1) return;         // already at first chunk
    this.getPage(this.serverPage - 1, this.involvedPersonSearch);
  }
  
  private normalizeText(value: any): string {
    const normalizedText = String(value ?? '').toLowerCase().trim();
    return normalizedText;
  }
  
  private extractDigits(value: any): string {
    const digitsOnly = String(value ?? '').replace(/\D/g, '');
    return digitsOnly;
  }

  private ssnMatchesQuery(rowSsn: any, searchInputRaw: string): boolean {
    const rowDigits = this.extractDigits(rowSsn);
    const queryDigits = this.extractDigits(searchInputRaw);
    if (!rowDigits || !queryDigits) return false;
    return rowDigits.includes(queryDigits);
  }
  
private escapeHtml(value: string): string {
    return value
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#39;');
  }

  private escapeRegExp(literal: string): string {
    return literal.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }
  
  maskAndHighlightSsn(ssnRaw: any, showMask: boolean, searchInputRaw: string): SafeHtml {
    const ssnDigits = this.extractDigits(ssnRaw);
    // Sending safe html content for empty values
    if (!ssnDigits) return this.sanitizer.bypassSecurityTrustHtml('');
  
    const formattedFull = `${ssnDigits.slice(0,3)}-${ssnDigits.slice(3,5)}-${ssnDigits.slice(5,9)}`;
    const visibleSsn = showMask ? `***-**-${ssnDigits.slice(-4)}` : formattedFull;
    // Formatting the input
    const escapedVisibleSsn = this.escapeHtml(visibleSsn);
  
    if (!searchInputRaw || !searchInputRaw.trim()) {
      return this.sanitizer.bypassSecurityTrustHtml(escapedVisibleSsn);
    }
  
    const rawQuery = searchInputRaw.trim();
    const normalizedQuery = this.normalizeText(rawQuery);
    const queryDigits = this.extractDigits(rawQuery);
    // If user typed non-digits, do a safe substring highlight on the visible string.
    if (!queryDigits) {
      const htmlEscapedSearch = this.escapeHtml(rawQuery);
      const safePattern = new RegExp(this.escapeRegExp(htmlEscapedSearch), 'gi');
      const highlighted = escapedVisibleSsn.replace(
        safePattern,
        match => `<span class="beige-highlight">${match}</span>`
      );
      return this.sanitizer.bypassSecurityTrustHtml(highlighted);
    }
    // If user typed digits, highlight only visible digits.
    const visibleDigitsOnly = this.extractDigits(escapedVisibleSsn);
    // If masked, only match against the visible last 4 digits
    let effectiveQueryDigits = queryDigits;
    if (showMask) {
      const last4 = ssnDigits.slice(-4);
      if (queryDigits.length > 4) {
        effectiveQueryDigits = queryDigits.slice(-4);
      }
      if (!last4.includes(effectiveQueryDigits)) {
        return this.sanitizer.bypassSecurityTrustHtml(escapedVisibleSsn);
      }
    }

    const matchStartIdxInDigits = visibleDigitsOnly.indexOf(effectiveQueryDigits);
  
    if (matchStartIdxInDigits === -1) {
      return this.sanitizer.bypassSecurityTrustHtml(escapedVisibleSsn);
    }
  
    // Walk the visible string and wrap only the matching visible digit range.
    const matchLength = effectiveQueryDigits.length;
    let runningDigitIndex = 0;
    let resultHtml = '';
    let isOpenSpan = false;
  
    for (const ch of escapedVisibleSsn) {
      const isDigitChar = ch >= '0' && ch <= '9';
  
      if (isDigitChar && runningDigitIndex === matchStartIdxInDigits) {
        resultHtml += '<span class="beige-highlight">';
        isOpenSpan = true;
      }
  
      resultHtml += ch;
  
      if (isDigitChar) {
        runningDigitIndex++;
        if (isOpenSpan && runningDigitIndex === matchStartIdxInDigits + matchLength) {
          resultHtml += '</span>';
          isOpenSpan = false;
        }
      }
    }
    if (isOpenSpan) resultHtml += '</span>';
  
    return this.sanitizer.bypassSecurityTrustHtml(resultHtml);
  }

  private safeIncludes(hay: any, needleNorm: string): boolean {
    const h = this.normalizeText(hay);
    return needleNorm ? h.includes(needleNorm) : false;
  }

  /** Format DOB to the same string users see: MM/DD/YYYY */
  private formatDobMMDDYYYY(dob: any): string {
    if (!dob) return '';
    return moment(dob).isValid() ? moment(dob).format('MM/DD/YYYY') : '';
  }
  
  /* build YYYY-MM-DD and a digits-only version for robust matching */
  private getDobVariants(dob: any): { mmddyyyy: string; iso: string; digits: string } {
    const mmddyyyy = this.formatDobMMDDYYYY(dob);
    let iso = '';
    if (mmddyyyy) {
      const [mm, dd, yyyy] = mmddyyyy.split('/');
      iso = `${yyyy}-${mm}-${dd}`;
    }
    const digits = this.extractDigits(mmddyyyy || dob);
    return { mmddyyyy, iso, digits };
  }
  
  private dobMatchesQuery(dob: any, queryRaw: string): boolean {
    if (!dob) return false;
    const { mmddyyyy, iso, digits } = this.getDobVariants(dob);
    const qNorm   = this.normalizeText(queryRaw);
    const qDigits = this.extractDigits(queryRaw);
  
    // Match against the formatted DOB users see (handles "09/" queries),
    // the ISO-ish version, and digits-only (e.g., 09122025).
    return (
      this.safeIncludes(mmddyyyy, qNorm) ||
      this.safeIncludes(iso, qNorm) ||
      (!!qDigits && digits.includes(qDigits))
    );
  }

    // Normalize selected search type codes from the form (supports strings or objects)
  private getSelectedSearchTypeCodes(): string[] {
    const raw = this.involvedPersonSearchForm.get('searchtypes')?.value || [];
    return (Array.isArray(raw) ? raw : [])
      .map((x: any) => (typeof x === 'string' ? x : (x?.ref_key || '')))
      .map((c: string) => c.toUpperCase())
      .filter(Boolean);
  }

  // True if the user picked any of Soundex/Synonym/Fuzzy
  get hasSoftTypes(): boolean {
    const codes = this.getSelectedSearchTypeCodes();
    return codes.some(c => c === 'EXP' || c === 'FZM' || c === 'SXM' || c === 'SYN');
  }

  // Exact is always included/disabled; "exact-only" means no soft types selected
  get isExactOnly(): boolean {
    const codes = this.getSelectedSearchTypeCodes();
    return codes.includes('EXM') && !this.hasSoftTypes;
  }

  
  settimein12hr(strtime: any) {
    if (strtime && moment(new Date(strtime), 'HH:mm', true).isValid()) {
      return moment(new Date(strtime), 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm', true).isValid()) {
      return moment(strtime, 'HH:mm', true).toDate();
    }
    else if (strtime && moment(strtime, 'HH:mm:ss', true).isValid()) {
      return moment(strtime, 'HH:mm:ss', true).toDate();
    }
  }

  getPlacementHistoryByPerson(person: any){
    if (person && (person.personid || person.cjamspid)) {
     this._commonHttpService
     .getSingle(
       {
        where: { personid: person.personid, cjamspid: person.cjamspid },
        method: 'get'
      },

      'placement/getplacementbyperson?filter'
    ).subscribe(data => {
        this.placementHistory = data;
    });
   }
  }

  searchPersonDetailsTypeRow(id: number, type: string) {
    //Get prior history only when source is local and person id exists
    let actionType = '';

    this.fetchedResults = this.resetFetchedResults(this.fetchedResults, id)

    switch (type) {
      case 'Service Case':
        actionType = 'servicecase'
        break;
      case 'Information and Referral':
        actionType = 'referral'
        break;
      case 'Intake':
        actionType = 'intake'
        break;
      case 'Child Protective Services':
        actionType = 'cps'
        break;
      case 'Adoption Case':
        actionType = 'adoptioncase'
        break;
      case 'ROA-CPS':
        actionType = 'roa'
        break;
    }
    this.activePanel = id;
    if (this.userOnDisplay && (this.userOnDisplay.cisclientid != '' || this.userOnDisplay.mdm_id != '' || this.userOnDisplay.personid != '') && type && type != '') {
      this.getPersonDSDSActionByType(id, {
        personid: this.userOnDisplay.personid,
        mdm_id: this.userOnDisplay.mdm_id,
        cisclientid: this.userOnDisplay.cisclientid,
        cjamspid: this.userOnDisplay.cjamspid,
        type: actionType
      });
    }
  }

  resetFetchedResults(arr: any[], id: number) {
    return arr.filter(item => item.id !== id);
  }

  searchPersonDetailsRow(id: number, model: any, isCompact: number = 0) {
    this.isExpunged = false;
    this.searchPersonDetails(id, model);
    //Get prior history only when source is local and person id exists
    if (model && (model.cisclientid != '' || model.mdm_id != '' || model.personid != '')) {
      this.getpersonadrressdetails(model.personid);
      this.getPersonDSDSAction(model, isCompact);
    }
  }

  getpersonadrressdetails(personid: any) {
    this.persondetails = [];
    if (personid) {
      this._commonHttpService
      .getSingle(
        {
         where: { personid: personid},
         method: 'get'
       },
 
       'People/getpersondetailsaftersearch?filter'
     ).subscribe(data => {
         this.persondetails = data;
     });
    }
  }

  getPersonDSDSActionByType(id: number, model: PersonDsdsActionByType) {
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrl + `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + '&type=' + model.type + '&filter';
    this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          method: 'get',
          where: { intakerequestid: null, cjamspid:  model.cjamspid}
        }),
        url
      ).subscribe((response: any) => {
        const { data } = response;
        data.map((address: any) => {
          address.daDetails.map((addressdata: any) => {
            if (addressdata.roles) {
              const uniqueRoles = addressdata.roles.filter((elem: any, i: number, arr: any[]) => {
                if (arr.indexOf(elem) === i) {
                  return elem;
                }
              });
              addressdata.roles = uniqueRoles;
            }

            if (addressdata.dasubtype === 'Peace Order') {
              address.highLight = true;
              return address;
            }
          })
          if (data && data.length) {
            this.priorHistoryCheck = data.length;
          }
          this.updateFetchedResults(this.fetchedResults, { data: data[0], id });
        })
      })
  }

  updateFetchedResults(arr: any[], newValue: any) {
    const idx = arr.findIndex(item => item.id == newValue.id)

    if (idx != -1) {
      arr[idx].data = newValue.data
    } else {
      arr.push(newValue)
    }
  }

  getPersonDSDSActionRequest(model: PersonDsdsAction, isCompact: any) {
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrl + `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + `&compact=` + isCompact + '&filter';
    return this._commonHttpService
    .getArrayList(
      new PaginationRequest({
          method: 'get',
          where: {
              intakerequestid: null,
              cjamspid: model.cjamspid
          }
      }),
      url
    );
  }

  getPersonDSDSActionProviderRequest(model: PersonDsdsAction){
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsProvUrl + `?cjamspid=` + model.cjamspid + '&filter';
    return this._commonHttpService
    .getArrayList(
      new PaginationRequest({
          method: 'get',
          where: {
              intakerequestid: null
          }
      }),
      url
    );
  }

  getPersonDSDSActionASRequest(model: PersonDsdsAction){
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsASUrl + `?cjamspid=` + model.cjamspid + '&filter';
    return this._commonHttpService
    .getArrayList(
      new PaginationRequest({
          method: 'get',
          where: {
              intakerequestid: null
          }
      }),
      url
    );
  }

  getPersonDSDSAction(model: PersonDsdsAction, isCompact: any) {
    const source = forkJoin({
      person: this.getPersonDSDSActionRequest(model, isCompact).pipe(catchError(() => of({ data: [] }))),
      provider: this.getPersonDSDSActionProviderRequest(model).pipe(catchError(() => of({ data: [] }))),
      adult: this.getPersonDSDSActionASRequest(model).pipe(catchError(() => of({ data: [] })))
    }).pipe(
    map((resultvalue: any) => {
      return {
        personDSDSActions: resultvalue.person.data,
        providerDSDSActions: resultvalue.provider.data,
        asDSDSActions: resultvalue.adult.data
      }
    }), share());
    
    this.personDSDSActions$ = source.pipe(pluck('personDSDSActions'));
    this.providerDSDSActions$ = source.pipe(pluck('providerDSDSActions'));
    this.asDSDSActions$ = source.pipe(pluck('asDSDSActions'));
    this.personDSDSActions$.pipe(
      map((data) => {
        if (data && data.length) {
            this.priorHistoryCheck = data.length;
        }
        return data;
      })).subscribe();
   
  }

    getExpungedPersonDSDSAction(model: any, isCompact: any, event: any) {
      if(!event.checked) {
        return this.getPersonDSDSAction(model, isCompact);
      }

        const requestPayload = new PaginationRequest({
            method: 'get',
            where: {
                intakerequestid: null,
                cjamspid: model.cjamspid
            }
        });
        const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrl + `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + `&compact=` + isCompact + '&filter';
        const source1$: Observable<DataItem[]> = this._commonHttpService
            .getArrayList(requestPayload, url)
            .pipe(pluck('data')) as Observable<DataItem[]>;

        const url1 = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrlExpunged +
            `?personid=${model.personid}&cisclientid=${model.cisclientid}&mdm_id=${model.mdm_id}&compact=${isCompact}&filter`
        const source2$: Observable<DataItem[]> = this._commonHttpService
            .getArrayList(requestPayload, url1)
            .pipe(pluck('data')) as Observable<DataItem[]>;

        this.personDSDSActions$ = combineLatest([source1$, source2$]).pipe(
            map(([data1, data2]) => {
                let dataVal: any[] = (data2 as any[]) || [];
                dataVal = dataVal.map(item => {
                  item.daDetails = item.daDetails.map((value: any) => {
                      value.isExpungedVal = true;
                      return value;
                    })
                    return item;
                });
  
                const combined = this.mergeDataByType(data1, data2);
                if (combined.length) {
                    this.priorHistoryCheck = combined.length;
                }
                return combined;
            }),
            share()
        );

        this.personDSDSActions$.subscribe();
    }

isValidDate(value: any): boolean {
  const d = new Date(value);
  return !isNaN(d.getTime());
}

    mergeDataByType (...dataArrays: DataItem[][]): PersonDsdsAction[] {
      const map = new Map();
    
      dataArrays.flat().forEach(({ daTypeName, daDetails }) => {
        if (!map.has(daTypeName)) {
          map.set(daTypeName, []);
        }
        map.get(daTypeName).push(...daDetails);
      });
    
      return Array.from(map, ([daTypeName, daDetails]) => ({ daTypeName, daDetails, highLight: false, cjamspid: ''  }));
    };

  viewAssignmentHistory(item: any) {
    this.assignmentsList$ = this._commonHttpService.getArrayList(
      {
          where: { servicecaseid: item.intakeserviceid},
          method: 'get'
      },
      'Caseassignments/getworkload?filter'
  );
  }

  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.recomputeView();
  }

  searchPersonDetails(id: number, model: any) {
    if (this.showPersonDetail !== id) {
      this.showPersonDetail = id;
      this.userOnDisplay = model;
    } else {
      this.showPersonDetail = -1;
      this.userOnDisplay = null;
    }
  }

  openPersonInDetail(person: any, action: string) {
    this.router.navigate(['/pages/person-details/' + action + '/' + person.personid + '/basic']);

  }

  getPrimaryRelationname(listdata: any[]) {
    const finddata = listdata.find((data: any) => data.relationcategory === 'Primary');
    if (finddata) {
      return (finddata.relationtype + ': ' + finddata.personname);
    }
    return '';
  }
  replaceALL(str: any) {
    if (str) {
      return str.replace(/~/gi, ',').replace(',,', ',');
    }
  }

  parseInteger(priors: string){
    return (priors =='' || priors==null || priors==undefined) ? 0 : parseInt(priors);
  }

  priorAuditLog(item: any) {
    this._session.setItem('cpsSkipApproval', 'false');
    if(item.restrictedstatus === 'EXCLUDE' || (item.restrictedstatus === 'INCLRES' && this.restrictedcaseenable)){
      (<any>$('#exclude')).modal('show');
    }
    else if (item['datype'] && item['datype'] === 'Adoption Case'){
      item['servicerequestnumber'] = item.intakeserviceid;
      item['adoptioncaseid'] = item.intakeserviceid;
      item['adoptioncasenumber'] = item.danumber;
      item['startdate'] = item['datereceived'];
      this._session.setItem('ISADOPTION', true);
      this._navigationUtils.routToAdoptionCase(item);
    } else {
      this._session.removeItem('ISADOPTION');
      this._navigationUtils.openRespectiveItem(item);
    }
  }

  priorremovalive(cjamspid: string, item: any) {
    (<any>$('#fostercare-history')).modal('hide');
    const currentUrl = '/pages/title4e/foster-car/' + cjamspid + '/' + item.removalid;
    this.router.navigate([currentUrl]);

  }

  priorgapive(cjamspid: string, item: any) {
    const currentUrl = '#/pages/title4e/guardianship/' + cjamspid + '/' + item?.guardian_subsidy_id;
    sessionStorage.setItem('currentItem', JSON.stringify(item)); //For CIDM-8407
    window.open(currentUrl);
  }

  prioradoptionive(client_id: string, item: any) {
      // The title4e adoption page carries the client id in the route and its tab
      // components read it back off the URL, so a history row with no client id
      // opens '/adoption/null/...' and every id-keyed call from that page is
      // rejected with a bare 400. Refuse the navigation instead.
      if (client_id === null || client_id === undefined || client_id === ''
          || isNaN(Number(client_id))) {
          this._alertService?.error('This record has no client ID, so the Title IV-E page cannot be opened.');
          return;
      }
      this._dataStoreService.setData('adoption_dashboard', 'adoption');
      const currentUrl = '#/pages/title4e/adoption/' + client_id + '/' + item?.removalid;
      window.open(currentUrl);
  }

  showOutcome(person: any, caseInfo: any) {
    this.selectedPerson = person;
    this.selectedCaseInfo = caseInfo;
    if(caseInfo.datype ==='Child Protective Services') {
      (<any>$('#person-out-come')).modal('show');
    }
  }
  close() {
    (<any>$('#person-out-come')).modal('hide');
    this.selectedCaseInfo = null;
    this.selectedPerson = null;
  }

  getFindingList(da_investigationid: string, person: any) {
    const expungedUser = this._authService.getCurrentUser().resources.filter(item => item.name === 'EXPUNGED_SEXUAL_ABUSE_DETAILS_VIEW');
    const isExpungedUser = expungedUser.length ? 1 : 0;
    this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          where: {
            investigationid: da_investigationid,
            isExpungedUser: isExpungedUser
          },
          method: 'get'
        }),
        'Investigationallegations/getmaltreatmentfinding?filter'
      )
      .subscribe((res) => {
        if (res) {
          //No operation needed here
        }
      });
  }

  isMaltreator(roles: any) {
    let hasMaltreator = false;
    if (Array.isArray(roles)) {
      const maltreatorIndex = roles.indexOf('Alleged Maltreator');
      if (maltreatorIndex !== -1) {
        hasMaltreator = true;
      }
    }
    return hasMaltreator;
  }

  
 
  private fetchPersonIdByIdentifier$(typeKey: string, value: string): Observable<string | null> {
    if (!value) return of(null);
    const pid =  this._session.getObj('personSearchSelectedPerson')?.cjamspid;
    return this._commonHttpService.getArrayList(
      { where: { personidentifiervalue: value, personidentifiertypekey: typeKey, cjamspid: pid }, method: 'get' },
      FindUrlConfig.EndPoint.PersonSearch.identifier
    ).pipe(
      map((data: any[]) => (data?.[0]?.personid ?? null)),
      catchError(() => of(null))
    );
  }

  private resolvePersonId$(row: any): Observable<string | null> {
    if (row?.personid) return of(row.personid);

    const mdm = (row?.mdm_id ?? '').toString().trim();
    if (!mdm) return of(null);

    return this.fetchPersonIdByIdentifier$('MDM_ID', mdm);
  }


  showAuditLog(person: any) {
    /* (<any>$('#person-audit-logs')).modal('show');
    this.selectedPerson = person;
     this.loadAuditLogs(1);*/
     this._session.setObj('personSearchSelectedPerson', person);
    this._session.setObj('personSearchParams', this.involvedPersonSearchForm.getRawValue());
  
    this.resolvePersonId$(person).subscribe((pid) => {
      if (pid) {
        person.personid = pid;
        this.router.navigate(['../demographic-log', pid], { relativeTo: this.route });
        return;
      }
  
      if (person?.source === 'SDR') {
        (<any>$('#audit-log')).modal('show');
      }
    });
  }

  loadFromCache() {
    this.hasFormValues();
    const searchParams = this._session.getObj('personSearchParams');
    if (searchParams) {
      this.involvedPersonSearchForm.patchValue(searchParams);
      this.searchInvolvedPersons(searchParams, 'new');

    }
  }

  hasFormValues(): boolean {
  // Returns true if at least one control in the form has a value
  const ignoredControls = ['searchtypes'];
  return Object.keys(this.involvedPersonSearchForm.controls)
    .some(key => {
      // 1. Skip if this control name is in our ignore list
      if (ignoredControls.includes(key)) {
        return false; 
      }

      // 2. Otherwise, check the control value normally
      const control = this.involvedPersonSearchForm.get(key);
      return control?.value !== null && control?.value !== '' && control?.value !== false;
    });
  }
}



function compare(a: number | string | Date, b: number | string | Date, isAsc: boolean) {
  return (a < b ? -1 : 1) * (isAsc ? 1 : -1);
}

interface DataItem {
  daTypeName: string;
  daDetails: any[];
}

