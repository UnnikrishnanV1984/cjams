
import {of as observableOf,  Observable } from 'rxjs';

import {share, map, pluck} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, ValidatorFn, ValidationErrors } from '@angular/forms';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { PersonSearch, People, InvolvedPerson } from '../../../@core/common/models/involvedperson.data.model';
import { PersonDsdsAction, InvolvedPersonSearchResponse } from '../../provider-referral/new-private-referral/_entities/newintakeModel';
import { PriorAuditLog } from '../../provider-applicant/new-public-applicant/_entities/newintakeModel';
import { AppConstants } from '../../../@core/common/constants';
import { Router, ActivatedRoute } from '@angular/router';
import { DataStoreService, CommonDropdownsService, CommonHttpService, GenericService, AuthService, SessionStorageService, ValidationService } from '../../../@core/services';
import { NavigationUtils } from '../../_utils/navigation-utils.service';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { AppUser } from '../../../@core/entities/authDataModel';
import { ObjectUtils } from '../../../@core/common/initializer';
import { NewUrlConfig } from '../../newintake/newintake-url.config';

@Component({
    selector: 'address-search',
    templateUrl: './address-search.component.html',
    styleUrls: ['./address-search.component.scss'],
    standalone: false
})
export class AddressSearchComponent implements OnInit {

  involvedPersonSearchForm!: FormGroup;
  private involvedPersonSearch!: InvolvedPerson;
  genderDropdownItems$!: Observable<any[]>;
  stateDropdownItems$!: Observable<any[]>;
  personSearchForm!: InvolvedPerson;
  paginationInfo: PaginationInfo = new PaginationInfo();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  personSearchResult$!: Observable<PersonSearch[]>;
  personDSDSActions$!: Observable<PersonDsdsAction[]>;
  private priorAuditLogRequest = new PriorAuditLog();
  intakeNumber!: string;
  showPersonDetail = -1;
  private EDITABLE_ROLES = [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR];
  isEditable = false;
  isSearch!: boolean;
  personSearchResult!: InvolvedPersonSearchResponse[];
  totalRecords!: number;
  personSearch!: People;
  selectedPerson: any;
  selectedCaseInfo: any = [];
  showSsnMask :boolean =true;
  isAuditVisible = false;
  countyDropdownItems$!: Observable<any[]>;

  private _formBuilder: FormBuilder;
  private router: Router;
  private route: ActivatedRoute;
  private _dataStoreService: DataStoreService;
  private dropdownService: CommonDropdownsService;
  private _commonHttpService: CommonHttpService;
  private _involvedPersonSeachService: GenericService<InvolvedPersonSearchResponse>;
  private _authService: AuthService;
  private _navigationUtils: NavigationUtils;
  private _session: SessionStorageService;

  constructor(private injector : Injector) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this.router = this.injector.get<Router>(Router);
		this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.dropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);	
    this._involvedPersonSeachService = this.injector.get<GenericService<InvolvedPersonSearchResponse>>(GenericService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._navigationUtils = this.injector.get<NavigationUtils>(NavigationUtils);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this.isEditable = this.hasEditAccess();
  }

  ngOnInit() {
    this.initSearchForm();
    this.loadDropdowns();
    this.involvedPersonSearchForm.get('county')?.disable();
    this.isSearch = false;
    this.paginationInfo.sortBy = 'asc';
    this.paginationInfo.sortColumn = null;
    this.isAuditVisible = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR) || this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.loadFromCache();
  }
  initSearchForm() {
    this.involvedPersonSearchForm = this._formBuilder.group({
      lastname: [''],
      firstname: [''],
      maidenname: [''],
      gender: [''],
      dob: [''],
      dateofdeath: [''],
      ssn: [''],
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
      cjamspid: ['']
    }, { validators: this.atLeastOne(Validators.required) });
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

  loadDropdowns() {
    this.stateDropdownItems$ = this.dropdownService.getPickListByName('state');
    this.countyDropdownItems$ = this.dropdownService.getPickListByName('county');
  }
  clearPersonSearch() {
    this.involvedPersonSearchForm.reset();
    this.involvedPersonSearchForm.get('county')?.disable();
    this.isSearch = false;
    this.personSearchResult = [];
    this.showPersonDetail = -1;
    this.loadDropdowns();
    this._session.removeItem('personSearchParams');
  }
  clearFilter() {
    this.searchInvolvedPersons(this.personSearch, 'new');
  }
  searchInvolvedPersons(model: People, mode: string) {
    if (mode === 'new') {
      this.paginationInfo.sortBy = 'asc';
      this.paginationInfo.sortColumn = null;
    }
    this.personSearch = model;
    this.involvedPersonSearch = Object.assign(new InvolvedPerson(), model);
    if (this.involvedPersonSearchForm.value.address1) {
      this.involvedPersonSearch.address = this.involvedPersonSearchForm.value.address1 + '' + this.involvedPersonSearchForm.value.address2;
    }
    this.isSearch = true;
    this.paginationInfo.pageNumber = 1;
    this.getPage(1, this.involvedPersonSearch);
  }

  onSortedPerson($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.searchInvolvedPersons(this.personSearch, 'exist');
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

  private getPage(pageNumber: number, involvedPersonSearch: any) {

    this.personSearchForm = involvedPersonSearch;
    this.personSearchForm.sortcolumn = this.paginationInfo.sortColumn;
    this.personSearchForm.sortorder = this.paginationInfo.sortBy;
    ObjectUtils.removeEmptyProperties(this.personSearchForm);
    this._involvedPersonSeachService
      .getPagedArrayList(
        {
          limit: this.paginationInfo.pageSize,
          order: this.paginationInfo.sortBy,
          page: pageNumber,
          count: this.paginationInfo.total,
          where: this.personSearchForm,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      ).pipe(
      map((result) => {
        return {
          data: result.data,
          count: result.count,
          canDisplayPager: result.count > this.paginationInfo.pageSize
        };
      })).subscribe(response => {
        this.personSearchResult = response.data;
        if (pageNumber === 1) {
          this.totalRecords = response.count;
        }
      });

  }

  searchPersonDetailsRow(id: number, model: any) {
    this.searchPersonDetails(id);
    this.getPersonDSDSAction(model);
  }

  getPersonDSDSAction(model: PersonDsdsAction) {
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsCWUrl + `?personid=` + model.personid + `&cisclientid=` + model.cisclientid + `&mdm_id=` + model.mdm_id + '&filter';
    const source = this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          method: 'get',
          where: { intakerequestid: null }
        }),
        url
      ).pipe(
      share());
    this.personDSDSActions$ = source.pipe(pluck('data')) as Observable<PersonDsdsAction[]>;
    this.personDSDSActions$.pipe(
      map((data) => {
        data.forEach((address) => {
          address.daDetails.forEach((addressdata) => {

            // filter the duplicate roles
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
          });
        });
        return data;
      })).subscribe();
  }


  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.getPage(this.paginationInfo.pageNumber, this.personSearchForm);
  }

  searchPersonDetails(id: number) {
    if (this.showPersonDetail !== id) {
      this.showPersonDetail = id;
    } else {
      this.showPersonDetail = -1;
    }
  }

  openPersonInDetail(person: any, action: string) {
    this.router.navigate(['/pages/person-details/' + action + '/' + person.personid + '/basic']);

  }

  getPrimaryRelationname(listdata: any[]) {
    const finddata = listdata.find(data => data.relationcategory === 'Primary');
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

  priorAuditLog(item: any) {
    this._navigationUtils.openRespectiveItem(item);
  }

  showOutcome(person: any, caseInfo: any) {
    this.selectedPerson = person;
    this.selectedCaseInfo = caseInfo;
    if(caseInfo.datype == 'Child Protective Services') {
      (<any>$('#person-out-come')).modal('show');
    }
  }
  close() {
    (<any>$('#person-out-come')).modal('hide');
    this.selectedCaseInfo = null;
    this.selectedPerson = null;
  }

  getFindingList(da_investigationid: string, person: any) {
    this._commonHttpService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          where: {
            investigationid: da_investigationid
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

  showAuditLog(person: any) {
    /* (<any>$('#person-audit-logs')).modal('show');
    this.selectedPerson = person;
     this.loadAuditLogs(1);*/
     this._session.setObj('personSearchSelectedPerson', person);
    this._session.setObj('personSearchParams', this.involvedPersonSearchForm.getRawValue());
    this.router.navigate(['../demographic-log/' + person.personid], { relativeTo: this.route });

  }

  loadFromCache() {
    const searchParams = this._session.getObj('personSearchParams');
    if (searchParams) {
      this.involvedPersonSearchForm.patchValue(searchParams);
      this.searchInvolvedPersons(searchParams, 'new');

    }
  }
  loadCounty() {
    this.involvedPersonSearchForm.get('county')?.enable();
    const stateKey = this.involvedPersonSearchForm.getRawValue().stateid;
    this.dropdownService.getPickListByMdmcode(stateKey).subscribe(countyList => {
      this.countyDropdownItems$ = observableOf(countyList);
    });
  }
}
