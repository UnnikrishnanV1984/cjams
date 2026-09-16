import { Component, OnInit } from '@angular/core';
import {  FormBuilder, FormGroup } from '@angular/forms';
import { ValidationService, DataStoreService, CommonDropdownsService,  AuthService } from '../../../@core/services';

import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import {  PaginationInfo } from '../../../@core/entities/common.entities';
import { InvolvedPersonSearchResponse, PersonDsdsAction, PriorAuditLog  } from '../../provider-referral/new-private-referral/_entities/newintakeModel';
import { AppConstants } from '../../../@core/common/constants';
import { PersonSearch, People, InvolvedPerson} from '../../../@core/common/models/involvedperson.data.model';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'search',
    templateUrl: './search.component.html',
    styleUrls: ['./search.component.scss'],
    standalone: false
})
export class SearchComponent implements OnInit {

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
  isDJS!: boolean;
  user!: string;
  constructor(private _formBuilder: FormBuilder,
     private router: Router,
     private _dataStoreService: DataStoreService,
     private dropdownService: CommonDropdownsService,
    private _authService: AuthService ) {
    }

  ngOnInit() {
    this.initSearchForm();
    this.loadDropdowns();
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
      dlno: [''],
      chessieid: [''],
      middlename: [''],
      cjamsid: ['']
  });
  }

  loadDropdowns() {
    this.genderDropdownItems$ = this.dropdownService.getGenders();
    this.stateDropdownItems$  = this.dropdownService.getStateList();
  }
  clearPersonSearch() {
    this.involvedPersonSearchForm.reset();
  }
  searchInvolvedPersons(model: People) {
    this.involvedPersonSearch = Object.assign(new InvolvedPerson(), model);
    if (this.involvedPersonSearchForm.value.address1) {
        this.involvedPersonSearch.address = this.involvedPersonSearchForm.value.address1 + '' + this.involvedPersonSearchForm.value.address2;
    }
    this.involvedPersonSearch.stateid = this.involvedPersonSearchForm.value.dl;
      this._dataStoreService.setData('PERSON_SEARCH_FORM', this.involvedPersonSearch);
      this.router.navigate(['/pages/person-search/search-result']);
}


}
