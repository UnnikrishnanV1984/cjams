import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AlertService, DataStoreService, CommonDropdownsService, ValidationService } from '../../../../../@core/services';
import { PersonDetailsService } from '../../../person-details.service';
import { Observable } from 'rxjs';
import { PhysicianInformationService } from '../physician-information.service';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'physician-information-create-edit',
    templateUrl: './physician-information-create-edit.component.html',
    styleUrls: ['./physician-information-create-edit.component.scss'],
    standalone: false
})
export class PhysicianInformationCreateEditComponent implements OnInit {
  physicianForm!: FormGroup;
  stateDropdownItems$!: Observable<any[]>;
  countyDropDownItems$!: Observable<any[]>;
  reportMode!: string;
  editMode!: boolean;
  personphycisianinfoid!: string | null;
  minDate = new Date();
  maxDate = new Date();

  constructor(private _physicianInfoService: PhysicianInformationService,
    private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _commonDropdownsService: CommonDropdownsService,
    private personService: PersonDetailsService,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.loadDropdowns();
    this.physicianForm = this.formbulider.group({
      'isprimaryphycisian': [false, Validators.required],
      'name': ['', Validators.required],
      'facility': ['', Validators.required],
      'phone': ['', Validators.required],
      'email': ['', ValidationService.mailFormat],
      'address1': '',
      'address2': '',
      'city': '',
      'state': '',
      'county': ['', Validators.required],
      'zip': '',
      'startdate': [null, Validators.required],
      'enddate': null,
    });
    this.reportMode = 'add';
    this.editMode = false;
    this.personphycisianinfoid = null;

    this.route.params.subscribe(params => {
      this._physicianInfoService.physician$.subscribe(data => {
        data.forEach(element => {
          if (element.personphycisianinfoid === params.id) {
            this.loadCounty(element.state);
            setTimeout(() => {
              this.physicianForm.patchValue({
                isprimaryphycisian: element.isprimaryphycisian,
                name: element.name,
                facility: element.facility,
                phone: element.phone,
                email: element.email,
                address1: element.address1,
                address2: element.address2,
                city: element.city,
                state: element.state,
                county: element.countyid,
                zip: element.zip,
                startdate: element.startdate,
                enddate: element.enddate
              });
            }, 1000);
            if (params.reportMode === 'edit') {
              this.reportMode = 'edit';
              this.editMode = true;
              this.personphycisianinfoid = params.id;
            } else if (params.reportMode === 'view') {
              this.physicianForm.disable();
              this.reportMode = 'view';
              this.editMode = false;
              this.personphycisianinfoid = params.id;
            }
          }
        });
      });
    });
  }

  private loadDropdowns() {
    this.stateDropdownItems$ = this._commonDropdownsService.getStateList();
  }

  public loadCounty(countystate?: any) {
    const state = countystate ? countystate : this.physicianForm.getRawValue().state;
    if (state) {
      this.countyDropDownItems$ = this._commonDropdownsService.getCountyList(state);
    }
  }

  addPhysicianInfo(physicianForm: any) {
    physicianForm.personid = this.personService.person.personid;
    physicianForm.personphycisianinfoid = this.personphycisianinfoid;
    physicianForm.physicianspecialtytypekey = null;
    if (physicianForm.startdate) {
      if (!(physicianForm.startdate instanceof Date)) {
        physicianForm.startdate = new Date(physicianForm.startdate);
      }
    }
    if (physicianForm.enddate) {
      if (!(physicianForm.enddate instanceof Date)) {
        physicianForm.enddate = new Date(physicianForm.enddate);
      }
    }
    this._physicianInfoService.addUpdatePhysicianInfo(physicianForm).subscribe(result => {
      this.resetForm();
      const element: HTMLElement | null = document.getElementById('backbuttonPhysicalInfo');
      element?.click();
      this._alertSevice.success('Physician Information details saved successfully!');
    }, error => {
      const element: HTMLElement | null = document.getElementById('backbuttonPhysicalInfo');
      element?.click();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  public startDateChanged() {
    this.physicianForm.patchValue({ enddate: '' });
    const empForm = this.physicianForm.getRawValue();
    this.maxDate = new Date(empForm.enddate);
  }
  public endDateChanged() {
    this.physicianForm.patchValue({ startdate: '' });
    const empForm = this.physicianForm.getRawValue();
    this.minDate = new Date(empForm.startdate);
  }

  resetForm() {
    this.physicianForm.reset();
  }

}
