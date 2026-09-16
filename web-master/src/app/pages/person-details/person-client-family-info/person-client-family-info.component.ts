import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';
import { Observable } from 'rxjs';
import { AlertService, CommonDropdownsService } from '../../../@core/services';
import { PersonDetailsService } from '../person-details.service';
import { PersonClientFamilyInfoService } from './person-client-family-info.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-client-family-info',
    templateUrl: './person-client-family-info.component.html',
    styleUrls: ['./person-client-family-info.component.scss'],
    standalone: false
})
export class PersonClientFamilyInfoComponent implements OnInit {

  familyInfoForm!: FormGroup;

  maritalDropdownItems$!: Observable<any[]>;
  primarySourceOfIncomes$!: Observable<any[]>;
  constructor(private _alertService: AlertService,
    private _formBuilder: FormBuilder,
    public personService: PersonDetailsService,
    private dropdownService: CommonDropdownsService,
    private _service: PersonClientFamilyInfoService) { }

  ngOnInit() {
    this.maritalDropdownItems$ = this.dropdownService.getMaritalStatus();
    this.primarySourceOfIncomes$ = this._service.getPrimarySourceOfIncomes();
    this.initiateFormGroup();
    this.loadFamilyInfo();
  }

  initiateFormGroup() {
    this.familyInfoForm = this._formBuilder.group({
      personid: new FormControl(this.personService.person.personid),
      personfamilyinfoid: new FormControl(''),
      numofsiblings: new FormControl(''),
      numofpersons: new FormControl(''),
      grossincome: new FormControl(''),
      primarysource: new FormControl(''),
      titleiveeligible: new FormControl(''),
      amoutwillpay: new FormControl(''),
      notes: new FormControl(''),
      placeofbirth: new FormControl(''),
      historyfamilyprob: new FormControl(''),
      runaway: new FormControl(''),
      ungovernable: new FormControl(''),
      stealing: new FormControl(''),
      truancy: new FormControl(''),
      assaultive: new FormControl(''),
      residential: new FormControl(''),
      outpatient: new FormControl(''),
      personrelativeid: new FormControl(''),
      maritalstatustypekey: new FormControl(''),

    });
  }

  /*  */
  updateFamilyInfo() {
    const familyInfo = this.familyInfoForm.getRawValue();
    this._service.updateFamilyInfo(familyInfo).subscribe(response => {
      this._alertService.success('Family Information Updated Successfully');
      this.loadFamilyInfo();
    });

  }

  loadFamilyInfo() {
    this._service.getFamilyInfo(this.personService.person.personid).subscribe(response => {
      if (response && response.data.length) {
        const familyInfo = response.data[0];
        this.familyInfoForm.patchValue(familyInfo);
        if (familyInfo.maritalstatus) {
          this.familyInfoForm.patchValue({ maritalstatustypekey: familyInfo.maritalstatus.maritalstatustypekey });
          this.familyInfoForm.get('maritalstatustypekey')?.disable();
        }

      }
    });
  }

}
