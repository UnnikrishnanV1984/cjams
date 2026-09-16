
import {of as observableOf,  Observable } from 'rxjs';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormControl, Validators, FormBuilder, ValidationErrors, ValidatorFn } from '@angular/forms';
import { ValidationService, CommonDropdownsService, DataStoreService } from '../../../../../@core/services';
import { FindIndividualService } from '../find-individual.service';
import { IntakeStoreConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { IntakeUtils } from '../../../../_utils/intake-utils.service';

@Component({
    selector: 'search-criteria',
    templateUrl: './search-criteria.component.html',
    styleUrls: ['./search-criteria.component.scss'],
    standalone: false
})
export class SearchCriteriaComponent implements OnInit {

  involvedPersonSearchForm!: FormGroup;
  validation_messages: any;
  genderDropdownItems$!: Observable<any[]>;

  //SSN
  isSsnHidden = true;
  ssnEye = 'fa-eye';
  showSsnMask = true;

  stateDropdownItems$!: Observable<any[]>;
  countyDropdownItems$!: Observable<any[]>;

  today = new Date();
  dd = this.today.getDate();
  mm = this.today.getMonth();
  yyyy = this.today.getFullYear();
  senHistoryFlag: string = '';

  minDate = new Date(1900, 0, 1);
  maxDate = new Date(this.yyyy, this.mm, this.dd);
  
  constructor(private _router: Router,
    private route: ActivatedRoute,
    private _formBuilder: FormBuilder,
    private _findIndividualService: FindIndividualService,
    private _dataStoreService: DataStoreService,
    private _commonDropdownService: CommonDropdownsService,
    private _intakUtils: IntakeUtils
  ) { }

  validateSSN(c: FormControl) {
    const invalidssn = ['000000000'];
    return invalidssn.includes(c.value) ? {
      validateSSN: {
        valid: false
      }
    } : null;
  }

  ngOnInit() {
    this.initForm();
    this.validation_messages = {
      'lastname': [
        { type: 'pattern', message: 'Enter a valid Last Name' }
      ],
      'firstname': [
        { type: 'pattern', message: 'Enter a valid First Name' }
      ]
    };
    this.involvedPersonSearchForm.get('county')?.disable();
    this.loadDropDowns();
  }

  loadDropDowns() {
    this.genderDropdownItems$ = this._commonDropdownService.getPickListByName('gender');
    this.stateDropdownItems$ = this._commonDropdownService.getPickListByName('state');
    this.countyDropdownItems$ = this._commonDropdownService.getPickListByName('county');
  }

  initForm() {
    this.involvedPersonSearchForm = this._formBuilder.group({
      lastname: new FormControl('', Validators.compose([
        Validators.pattern('[a-zA-Z-\' ]*$') // [a-zA-Z]+(\s+[a-zA-Z]+)*
      ])),
      firstname: new FormControl('', Validators.compose([
        Validators.pattern('^[a-zA-Z-\' ]*$')
      ])),
      maidenname: [''],
      gender: [''],
      dob: [''],
      dateofdeath: [''],
      ssn: ['', [this.validateSSN]],
      mediasrc: [''],
      mediasrctxt: [''],
      occupation: [''],
      dl: [''],
      stateid: [''],
      address1: [''],
      address2: [''],
      zip: ['' ],
      city: [''],
      county: [''],
      selectedPerson: [''],
      cjisnumber: [''],
      cjamspid: [''],
      complaintnumber: [''],
      fein: [''],
      age: [''],
      email: ['', [ValidationService.mailFormat]],
      phone: [''],
      petitionid: [''],
      alias: [''],
      oldId: [''],
      mdmId: [''],
      clientflag: [null],
      personid: [null]
    }, { validators: this.atLeastOne(Validators.required) });
    if (this._findIndividualService.searchCriteria) {
      this.involvedPersonSearchForm.patchValue(this._findIndividualService.searchCriteria);
      if (this._findIndividualService.searchCriteria.dob) {
        this.involvedPersonSearchForm.patchValue({
          dob: new Date(this._findIndividualService.searchCriteria.dob)
        });
      }
      this.involvedPersonSearchForm.markAsDirty();
      this.involvedPersonSearchForm.markAsTouched();
     
    }
    const quickNarattiveSearchData = this._dataStoreService.getData(IntakeStoreConstants.PERSON_TO_SEARCH);
    if (quickNarattiveSearchData) {
      this.involvedPersonSearchForm.patchValue({
        lastname: quickNarattiveSearchData.lastname,
        firstname: quickNarattiveSearchData.firstname,
        dob: quickNarattiveSearchData.dob ? new Date(quickNarattiveSearchData.dob) : null,
        gender: quickNarattiveSearchData.gendertypekey ? quickNarattiveSearchData.gendertypekey : null,
         clientflag: quickNarattiveSearchData.clientflag ? quickNarattiveSearchData.clientflag : null,
        personid: quickNarattiveSearchData.personid ? quickNarattiveSearchData.personid : null,
      });
      this.involvedPersonSearchForm.markAsDirty();
      this.involvedPersonSearchForm.markAsTouched();
    }
    this.involvedPersonSearchForm.updateValueAndValidity();

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

  goBack() {
    this._router.navigate(['../'], { relativeTo: this.route });
  }
  goToSearchResult() {
    this._router.navigate(['../search-result'], { relativeTo: this.route });
  }

  ssnChange(val: Event) {
    const value = (val.target as HTMLInputElement).value;
    if (value === '') {
      this.involvedPersonSearchForm.patchValue({
        ssn: value
      });
    }
  }

  searchPersons() {
    if (this.involvedPersonSearchForm.valid) {
      this._findIndividualService.searchCriteria = this.involvedPersonSearchForm.getRawValue();
      this._findIndividualService.searchCriteria.sortorder = 'asc';
      this._findIndividualService.searchCriteria.sortcolumn = null;
      this.goToSearchResult();

    }

  }

  clearPersonSearch() {
    this.enableEntries();
    this.involvedPersonSearchForm.get('county')?.disable();
    this.loadDropDowns();
    this._findIndividualService.searchCriteria = null;
    this.involvedPersonSearchForm.reset();
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
    this.involvedPersonSearchForm.get('lastname')?.setValue('');
    this.involvedPersonSearchForm.get('dob')?.setValue('');
    this.involvedPersonSearchForm.get('age')?.setValue('');
    this.involvedPersonSearchForm.get('gender')?.setValue('');
    this.involvedPersonSearchForm.get('email')?.setValue('');
    this.involvedPersonSearchForm.get('phone')?.setValue('');
    this.involvedPersonSearchForm.get('gender')?.setValue('');
    this.involvedPersonSearchForm.get('email')?.setValue('');
    this.involvedPersonSearchForm.get('phone')?.setValue('');
    this.involvedPersonSearchForm.get('occupation')?.setValue('');
    this.involvedPersonSearchForm.get('ssn')?.setValue('');
    this.involvedPersonSearchForm.get('dl')?.setValue('');
    this.involvedPersonSearchForm.get('fein')?.setValue('');
    this.involvedPersonSearchForm.get('complaintnumber')?.setValue('');
    this.involvedPersonSearchForm.get('mdmId')?.setValue('');
    this.involvedPersonSearchForm.get('petitionid')?.setValue('');
    this.involvedPersonSearchForm.get('oldId')?.setValue('');
    this.involvedPersonSearchForm.get('maidenname')?.setValue('');
    this.involvedPersonSearchForm.get('alias')?.setValue('');
    this.involvedPersonSearchForm.get('mediasrc')?.setValue('');
    this.involvedPersonSearchForm.get('address1')?.setValue('');
    this.involvedPersonSearchForm.get('address2')?.setValue('');
    this.involvedPersonSearchForm.get('zip')?.setValue('');
    this.involvedPersonSearchForm.get('stateid')?.setValue('');
    this.involvedPersonSearchForm.get('city')?.setValue('');
    this.involvedPersonSearchForm.get('county')?.setValue('');

    this.involvedPersonSearchForm.get('firstname')?.disable();
    this.involvedPersonSearchForm.get('lastname')?.disable();
    this.involvedPersonSearchForm.get('dob')?.disable();
    this.involvedPersonSearchForm.get('age')?.disable();
    this.involvedPersonSearchForm.get('gender')?.disable();
    this.involvedPersonSearchForm.get('email')?.disable();
    this.involvedPersonSearchForm.get('phone')?.disable();
    this.involvedPersonSearchForm.get('occupation')?.disable();
    this.involvedPersonSearchForm.get('ssn')?.disable();
    this.involvedPersonSearchForm.get('dl')?.disable();
    this.involvedPersonSearchForm.get('fein')?.disable();
    this.involvedPersonSearchForm.get('complaintnumber')?.disable();
    this.involvedPersonSearchForm.get('mdmId')?.disable();
    this.involvedPersonSearchForm.get('petitionid')?.disable();
    this.involvedPersonSearchForm.get('oldId')?.disable();
    this.involvedPersonSearchForm.get('maidenname')?.disable();
    this.involvedPersonSearchForm.get('alias')?.disable();
    this.involvedPersonSearchForm.get('mediasrc')?.disable();
    this.involvedPersonSearchForm.get('address1')?.disable();
    this.involvedPersonSearchForm.get('address2')?.disable();
    this.involvedPersonSearchForm.get('zip')?.disable();
    this.involvedPersonSearchForm.get('stateid')?.disable();
    this.involvedPersonSearchForm.get('city')?.disable();
    this.involvedPersonSearchForm.get('county')?.disable();
  }

  enableEntries(){
    this.involvedPersonSearchForm.get('firstname')?.enable();
    this.involvedPersonSearchForm.get('lastname')?.enable();
    this.involvedPersonSearchForm.get('dob')?.enable();
    this.involvedPersonSearchForm.get('age')?.enable();
    this.involvedPersonSearchForm.get('gender')?.enable();
    this.involvedPersonSearchForm.get('email')?.enable();
    this.involvedPersonSearchForm.get('phone')?.enable();
    this.involvedPersonSearchForm.get('occupation')?.enable();
    this.involvedPersonSearchForm.get('ssn')?.enable();
    this.involvedPersonSearchForm.get('dl')?.enable();
    this.involvedPersonSearchForm.get('fein')?.enable();
    this.involvedPersonSearchForm.get('complaintnumber')?.enable();
    this.involvedPersonSearchForm.get('mdmId')?.enable();
    this.involvedPersonSearchForm.get('petitionid')?.enable();
    this.involvedPersonSearchForm.get('oldId')?.enable();
    this.involvedPersonSearchForm.get('maidenname')?.enable();
    this.involvedPersonSearchForm.get('alias')?.enable();
    this.involvedPersonSearchForm.get('mediasrc')?.enable();
    this.involvedPersonSearchForm.get('address1')?.enable();
    this.involvedPersonSearchForm.get('address2')?.enable();
    this.involvedPersonSearchForm.get('zip')?.enable();
    this.involvedPersonSearchForm.get('stateid')?.enable();
    this.involvedPersonSearchForm.get('city')?.enable();
    this.involvedPersonSearchForm.get('county')?.enable();
    this.involvedPersonSearchForm.get('cjisnumber')?.enable();
    this.involvedPersonSearchForm.get('cjamspid')?.enable();
  }

  toggleSsn = () => {
    this.isSsnHidden = !this.isSsnHidden;
    if (this.isSsnHidden) {
      this.ssnEye = 'fa-eye';
      this.showSsnMask = true;
    } else {
      this.ssnEye = 'fa-eye-slash';
      this.showSsnMask = false;
    }
  }
  loadCounty() {
    this.involvedPersonSearchForm.get('county')?.enable();
    const stateKey = this.involvedPersonSearchForm.getRawValue().stateid;
    this._commonDropdownService.getPickListByMdmcode(stateKey).subscribe(countyList => {
      this.countyDropdownItems$ = observableOf(countyList);
    });
  }


  get f() {
    return this.involvedPersonSearchForm.controls;
  }

}
