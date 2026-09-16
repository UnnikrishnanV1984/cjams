import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ValidatorFn, ValidationErrors  } from '@angular/forms';
import { DataStoreService } from '../../../../@core/services';
import { FinanceAdjustment } from '../../finance.constants';

@Component({
    selector: 'adjustment-search',
    templateUrl: './adjustment-search.component.html',
    styleUrls: ['./adjustment-search.component.scss'],
    standalone: false
})
export class AdjustmentSearchComponent implements OnInit {

  ancillaryAdjustmentFormGroup!: FormGroup;
  @Output() searchEmitter = new EventEmitter<any>();

  constructor(private formBuilder: FormBuilder, private _datatoreService: DataStoreService) { }

  ngOnInit() {
      this.ancillaryAdjustmentFormGroup = this.formBuilder.group({
        providerid: [null],
        paymentid: [null],
        providername: [null],
        clientid: [null],
        taxid: [null],
        clientname: [null],
        daterangeto: [null],
        daterangefrom: [null],
       // ayear: ['Y'],
        dobdaterangefrom: [null],
        dobdaterangeto: [null]
      }, { validators: this.atleastOne(Validators.required) });
      this.ancillaryAdjustmentFormGroup.get('daterangeto')?.disable();
      this.ancillaryAdjustmentFormGroup.get('dobdaterangeto')?.disable();
      this._datatoreService.clearStore();
      setTimeout(() => {
          const searchParams = this._datatoreService.getData(FinanceAdjustment.AncillaryAdjustmentSearchParams);
          if (searchParams) {
              this.ancillaryAdjustmentFormGroup.patchValue(searchParams);
          }
      }, 100);
  }

  atleastOne = (validator: ValidatorFn) => (group: FormGroup): ValidationErrors | null => {
    const controls = group.controls;
    const validFields = Object.keys(controls).filter(
      (k) => !validator(controls[k])
    );

    return validFields.length >= 1 ? null : { atleastOne: true }
  };

  onChangeDate(form: any, field: string) {
    if ( field === 'startdate' && form?.get('daterangefrom')?.value ) {
      form?.get('daterangeto')?.enable();
    } else if ( field === 'startdobdate' && form?.get('dobdaterangefrom')?.value) {
      form?.get('dobdaterangeto')?.enable();
    }
  }

  searchProviders() {
      const searchParams = this.ancillaryAdjustmentFormGroup.getRawValue();
      this._datatoreService.setData(FinanceAdjustment.AncillaryAdjustmentSearchParams, searchParams);
      this.searchEmitter.emit();
  }

  clearSearch() {
      this.ancillaryAdjustmentFormGroup.reset();
      this._datatoreService.setData(FinanceAdjustment.AncillaryAdjustmentSearchParams, null);
      this.searchEmitter.emit();
  }

}
