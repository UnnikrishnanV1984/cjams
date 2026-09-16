
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { AlertService, DataStoreService, CommonHttpService } from '../../../../@core/services';
// tslint:disable-next-line:import-blacklist
import { Subject ,  Observable ,  forkJoin } from 'rxjs';
import { CaseWorkerUrlConfig } from '../../../case-worker/case-worker-url.config';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { InvolvedPersonsConstants } from '../../../case-worker/dsds-action/involved-persons/_entities/involvedPersons.constants';
import { Employer, Work } from '../../../case-worker/dsds-action/involved-persons/_entities/involvedperson.data.model';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'work-profile',
    templateUrl: './work-profile.component.html',
    styleUrls: ['./work-profile.component.scss'],
    standalone: false
})
export class WorkProfileComponent implements OnInit { 
  @Input()
  workFormReset$ = new Subject<boolean>();
  suggestedAddress$!: Observable<any[]>;
  addresstypeDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  phoneTypeDropdownItems$!: Observable<DropdownModel[]>;
  emailTypeDropdownItems$!: Observable<DropdownModel[]>;
  papperiodDropdownItems$!: Observable<DropdownModel[]>;
  employerForm!: FormGroup;
  selectedState: any=[];
  careerForm!: FormGroup;
  employer: Employer[] = [];
  careergoals: string='';
  work: any= {};
  minDate = new Date();
  maxDate = new Date();
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;
  addresstypeLabel!: string;
  phoneTypeDescription: string[] = [];
  countyDropDownItems$!: Observable<DropdownModel[]>;
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Work;
  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService) { }

  ngOnInit() {
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.employerForm = this.formbulider.group({
      employername: '',
      currentemployer: false,
      noofhours: new FormControl('', [Validators.pattern('^[0-9]*$')]),
      duties: '',
      startdate: '',
      enddate: '',
      reasonforleaving: '',
      addresstype:'',
      address1:'',
      Address2:'',
      city:'',
      state:'',
      zipcode:'',
      county:'',
      EmailID:'',
      EmailType:'',
      fax:'',
      extension:'',
      contactnumber:'',
      contacttype:'',
      position:'',
      occupationstartdate:'',
      occupationenddate:'',
      occupationtype:'',
      comments:'',
      income:'',
      payperiod:'',
      firstname:'',
      middlename:'',
      lastname:'',
      suffix:'',
      prefix:'',
      careergoals:''
    });
    this.careerForm = this.formbulider.group({
      careergoals: ''
    });
    this.workFormReset$.subscribe((res) => {
      if (res === true) {
        this.work = this._dataStoreService.getData(this.constants.Work);
        if (this.work && this.work.employer) {
          this.employer = this.work.employer;
        } else {
          this.employer = [];
        }

        this.careergoals = this.work.careergoals;
        this.careerForm = this.formbulider.group({
          careergoals: ''
        });
      }
    });
    this.work = this._dataStoreService.getData(this.constants.Work);

    this.careerForm.valueChanges.subscribe((res) => {
      this.work = this._dataStoreService.getData(this.constants.Work);
      this.work.careergoals = this.careerForm.getRawValue().careergoals;
      this._dataStoreService.setData(this.constants.Work, this.work);
    });

    if (this.work && this.work.employer) {
      this.employer = this.work.employer;
    }
    if (this.work && this.work.careergoals) {
      this.careerForm.patchValue({ 'careergoals': this.careergoals });
    }
    this.loadDropDown();
  }
  getSuggestedAddress() {
    if (this.employerForm.value.address1 &&
        this.employerForm.value.address1.length >= 3 ) {
         this.suggestAddress();
     }
 }
 suggestAddress() { 
     this.suggestedAddress$ = this._commonHttpService
         .getArrayListWithNullCheck(
             {
                 method: 'post',
                 where: {
                     prefix: this.employerForm.value.address1,
                     cityFilter: '',
                     stateFilter: '',
                     geolocate: '',
                     geolocate_precision: '',
                     prefer_ratio: 0.66,
                     suggestions: 25,
                     prefer: 'MD'
                 }
             },
             NewUrlConfig.EndPoint.Intake.SuggestAddressUrl
         );
     }
 selectedAddress(model:any) {
     this.employerForm.patchValue({
        address1: model.streetLine ? model.streetLine : '',
        city: model.city ? model.city : '',
        state: model.state ? model.state : ''
     });
 }
  private updateData() {
    this.work = this._dataStoreService.getData(this.constants.Work);
    this.work.employer = this.employer;
    this._dataStoreService.setData(this.constants.Work, this.work);
  }
  changeAddressType(event:any) {
    this.addresstypeLabel = event.value;
}
  private loadDropDown() {
    const source = forkJoin([
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                nolimit: true,
                activeflag: 1,
                order: 'typedescription'
            },
            CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
                .PersonAddressUrl + '?filter'
        ),
        this._commonHttpService.getArrayList(
          {
              method: 'get',
              nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
              .StateListUrl + '?filter'
      ),
      this._commonHttpService.create(
        {
            nolimit: true,
            order: 'countyname asc'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
    ),
    this._commonHttpService.getArrayList( 
      {
          method: 'get',
          nolimit: true,
          filter: {}
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
          .PhoneTypeUrl + '?filter'
  ),
  this._commonHttpService.getArrayList(
    {
        method: 'get',
        nolimit: true,
        filter: {}
    },
    CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .EmailTypeUrl + '?filter'
)
    ]).pipe(
        map(result => {
            return {
                addresstype: result[0].map(
                    res =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.personaddresstypekey
                        })
                ),
                states: result[1].map(
                  res =>
                      new DropdownModel({
                          text: res.statename,
                          value: res.stateabbr
                      })
              ), 
              counties: result[2].map(
                (res:any) =>
                    new DropdownModel({
                        text: res.countyname,
                        value: res.countyname
                    })
            ),
            phonetype: result[3].map(
              res =>
                  new DropdownModel({
                      text: res.typedescription,
                      value: res.personphonetypekey
                  })
          ),
          emailtype: result[4].map(
            res =>
                new DropdownModel({
                    text: res.typedescription,
                    value: res.personemailtypekey
                })
        ),
            };
        }),
        share(),);
    this.stateDropdownItems$ = source.pipe(pluck('states'));
    this.addresstypeDropdownItems$ = source.pipe(pluck('addresstype'));
    this.countyDropDownItems$ = source.pipe(pluck('counties'));
    this.phoneTypeDropdownItems$ = source.pipe(pluck('phonetype'));
    this.emailTypeDropdownItems$ = source.pipe(pluck('emailtype'));
    this.phoneTypeDropdownItems$.subscribe((res) => {
      if (res) {
          res.forEach(type => {
              this.phoneTypeDescription[type.value] = type.text;
          });
      }
  });
}
  private add() {
    this.employer.push(this.employerForm.getRawValue());
    this.updateData();
    this._alertSevice.success('Added Successfully');
    this.resetForm();
  }

  private resetForm() {

    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.employerForm.reset();
    this.employerForm.enable();
    this.employerForm?.get('enddate')?.enable();
    this.employerForm?.get('enddate')?.setValidators([Validators.required]);
    this.employerForm?.get('enddate')?.updateValueAndValidity();
    this.employerForm?.get('reasonforleaving')?.enable();
    this.employerForm?.get('reasonforleaving')?.setValidators([Validators.required]);
    this.employerForm?.get('reasonforleaving')?.updateValueAndValidity();
  }

  private update() {
    if (this.modalInt !== -1) {
      this.employer[this.modalInt] = this.employerForm?.getRawValue();
    }
    this.updateData();
    this.resetForm();
    this._alertSevice.success('Updated Successfully');
  }

  private view(modal:any) {
    this.reportMode = 'edit';
    this.editMode = false;
    this.patchForm(modal);
    this.employerForm.disable();
  }

  private edit(modal:any, i:any) {
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.employerForm.enable();
    this.isCurrentEmployerSaved(modal.currentemployer);
  }

  private delete(index:any) {
    this.employer.splice(index, 1);
    this.updateData();
    this._alertSevice.success('Deleted Successfully');
    this.resetForm();
  }



  private cancel() {
    this.resetForm();
  }

  isCurrentEmployer(control:any) {
    if (control.checked) {

      this.employerForm?.get('enddate')?.disable();
      this.employerForm?.get('enddate')?.clearValidators();
      this.employerForm?.get('enddate')?.updateValueAndValidity();
      this.employerForm?.get('reasonforleaving')?.disable();
      this.employerForm?.get('reasonforleaving')?.clearValidators();
      this.employerForm?.get('reasonforleaving')?.updateValueAndValidity();
    } else {

      this.employerForm?.get('enddate')?.enable();
      this.employerForm?.get('enddate')?.setValidators([Validators.required]);
      this.employerForm?.get('enddate')?.updateValueAndValidity();
      this.employerForm?.get('reasonforleaving')?.enable();
      this.employerForm?.get('reasonforleaving')?.setValidators([Validators.required]);
      this.employerForm?.get('reasonforleaving')?.updateValueAndValidity();
    }
  }

  isCurrentEmployerSaved(control:any) {
    if (control) {

      this.employerForm?.get('enddate')?.disable();
      this.employerForm?.get('enddate')?.clearValidators();
      this.employerForm?.get('enddate')?.updateValueAndValidity();
      this.employerForm?.get('reasonforleaving')?.disable();
      this.employerForm?.get('reasonforleaving')?.clearValidators();
      this.employerForm?.get('reasonforleaving')?.updateValueAndValidity();
    } else {

      this.employerForm?.get('enddate')?.enable();
      this.employerForm?.get('enddate')?.setValidators([Validators.required]);
      this.employerForm?.get('enddate')?.updateValueAndValidity();
      this.employerForm?.get('reasonforleaving')?.enable();
      this.employerForm?.get('reasonforleaving')?.setValidators([Validators.required]);
      this.employerForm?.get('reasonforleaving')?.updateValueAndValidity();
    }
  }

  dateChanged() {
    const empForm = this.employerForm?.getRawValue();
    this.minDate = new Date(empForm.startdate);
  }

  private patchForm(modal: Employer) {
    this.employerForm.patchValue(modal);
  }


}
