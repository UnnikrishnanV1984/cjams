import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { InvolvedPerson, People } from '../../../../@core/common/models/involvedperson.data.model';
import { Router, ActivatedRoute } from '@angular/router';
import { DataStoreService, ValidationService, CommonDropdownsService } from '../../../../@core/services';
import { Observable } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'search-relationship',
    templateUrl: './search-relationship.component.html',
    styleUrls: ['./search-relationship.component.scss'],
    standalone: false
})
export class SearchRelationshipComponent implements OnInit {

  personSearchForm!: FormGroup;
  private personSearch!: InvolvedPerson;
  genderDropdownItems$!: Observable<any[]>;
  showResults!: boolean;
  constructor(private _formBuilder: FormBuilder,
    private router: Router,
    private _dataStoreService: DataStoreService,
    private route: ActivatedRoute,
    private dropdownService: CommonDropdownsService
  ) { }

  ngOnInit() {
    this.initSearchForm();
    this.loadDropdowns();
    this.showResults = false;
  }

  initSearchForm() {
    this.personSearchForm = this._formBuilder.group({
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
      oldId: ['']
    });
  }

  loadDropdowns() {
    this.genderDropdownItems$ = this.dropdownService.getGenders();
  }
  clearPersonSearch() {
    this.personSearchForm.reset();
  }
  searchInvolvedPersons(model: People) {
    this.personSearch = Object.assign(new InvolvedPerson(), model);
    if (this.personSearchForm.value.address1) {
      this.personSearch.address = this.personSearchForm.value.address1 + '' + this.personSearchForm.value.address2;
    }
    this.personSearch.stateid = this.personSearchForm.value.dl;
    this._dataStoreService.setData('RELATION_PERSON_SEARCH_FORM', this.personSearch);
    this.showResults = true;
  }
}