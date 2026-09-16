import { OnInit, Component, EventEmitter, Input, Output, ChangeDetectorRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService } from '../../../../../../@core/services';

@Component({
    selector: 'ebp-referral-made',
    templateUrl: './ebp-referral-made.component.html',
    styleUrls: ['./ebp-referral-made.component.scss'],
    standalone: false
})
export class EBPReferralMadeComponent implements OnInit {
  ebpFormGroup: FormGroup;
  @Input() imminentrisks: any = [];
  @Input() id: any;
  @Output() outData = new EventEmitter();
  _isDisabled!: boolean;
  @Input() isVerticalAlign!: boolean;
  @Input() ebpUtilizationTypes: any;
  constructor(private fb: FormBuilder,private _commonhttp: CommonHttpService,private cdr: ChangeDetectorRef) {
    this.ebpFormGroup = this.fb.group ({
        isebpreferralmade: [null, [Validators.required]],
        familyFirstPrevention: false,
        utilized: [null],
        utilizedtypes: [null],
        additionalinfo: [null],
        noadditionalinfo: [null],
        notes: [null]
      });
  }
  ngOnInit() {
    if (this.imminentrisks && this.imminentrisks.length > 0 && this.imminentrisks[0].includes('NONE')) {
      this.ebpFormGroup.get('isebpreferralmade')?.disable();
      this.ebpFormGroup.get('noadditionalinfo')?.disable();
      this.patchFormIfNone();
    } else {
      this.ebpFormGroup.get('isebpreferralmade')?.enable();
      this.ebpFormGroup.get('noadditionalinfo')?.enable();
    }
    this.disableForm();
    this._commonhttp.candidacyDropDownChange.subscribe((data: any) => {
      if (data.id === this.id) {
        this.imminentrisks = data.imminentrisks;
        this.setImminentrisks();
      }
    });
  }

  private disableForm() {
    if (this.isDisabled) {
      this.ebpFormGroup.get('familyFirstPrevention')?.disable();
      this.ebpFormGroup.get('isebpreferralmade')?.disable();
      this.ebpFormGroup.get('utilized')?.disable();
      this.ebpFormGroup.get('utilizedtypes')?.disable();
      this.ebpFormGroup.get('additionalinfo')?.disable();
      this.ebpFormGroup.get('notes')?.disable();
      this.ebpFormGroup.get('noadditionalinfo')?.disable();
    }
  }

  private patchFormIfNone() {
    this.ebpFormGroup.patchValue({
      isebpreferralmade: 'No',
      utilized: null,
      utilizedtypes: null,
      additionalinfo: null,
      familyFirstPrevention: false,
      notes: null,
      noadditionalinfo: 'YNE'
    });
  }

  @Input() set formData(value: any) {
    if (value) {
      this.ebpFormGroup.patchValue(value);
    }
  }
  @Input() set isDisabled(value: any) {
    if (value) {
      this._isDisabled = value;
    }
  }
 setImminentrisks() {
    this.ebpFormGroup.get('isebpreferralmade')?.enable();
    this.ebpFormGroup.get('noadditionalinfo')?.enable();
    if (this.imminentrisks && this.imminentrisks.length > 0 && this.imminentrisks[0].includes('NONE')) {
        this.patchFormIfNone();
        this.ebpFormGroup.get('isebpreferralmade')?.disable();
        this.ebpFormGroup.get('noadditionalinfo')?.disable();
        this.send();
        return;
    }
    this.ebpFormGroup.patchValue({
      isebpreferralmade: null,
      familyFirstPrevention: false,
      utilized: null,
      utilizedtypes: null,
      additionalinfo: null,
      noadditionalinfo: null,
      notes: null
    });
    this.send();
  }
  get isDisabled() {
    return this._isDisabled;
  }
  changeIsEbpReferralMade(value: any) {
      this.ebpFormGroup.patchValue({
        utilized: null,
        utilizedtypes: null,
        additionalinfo:  null,
        noadditionalinfo: null,
        notes: null
      });
      this.ebpFormGroup.controls.utilized.setValidators((value === 'Yes') ? [Validators.required] : null);
      this.ebpFormGroup.controls.utilized.updateValueAndValidity();
      this.ebpFormGroup.controls.additionalinfo.setValidators(null);
      this.ebpFormGroup.controls.additionalinfo.updateValueAndValidity();
      this.ebpFormGroup.controls.noadditionalinfo.setValidators((value === 'No') ? [Validators.required] : null);
      this.ebpFormGroup.controls.noadditionalinfo.updateValueAndValidity();
      this.ebpFormGroup.controls.notes.setValidators(null);
      this.ebpFormGroup.controls.notes.updateValueAndValidity();
      this.ebpFormGroup.controls.utilizedtypes.setValidators(null);
      this.ebpFormGroup.controls.utilizedtypes.updateValueAndValidity();
      this.send();
  }
  changeUtilized(value: any) {
    this.ebpFormGroup.patchValue({
      additionalinfo:  null,
      notes: null,
      utilizedtypes: null
    });
    this.ebpFormGroup.controls.additionalinfo.setValidators((value === 'No') ? [Validators.required] : null);
    this.ebpFormGroup.controls.additionalinfo.updateValueAndValidity();
    this.ebpFormGroup.controls.utilizedtypes.setValidators((value === 'Yes') ? [Validators.required] : null);
    this.ebpFormGroup.controls.utilizedtypes.updateValueAndValidity();
    this.ebpFormGroup.controls.notes.setValidators(null);
    this.ebpFormGroup.controls.notes.updateValueAndValidity();
    this.send();
  }
  changeUtilizedTypes(value: any) {
    this.ebpFormGroup.patchValue({
      notes:  null
    });
    this.ebpFormGroup.controls.notes.setValidators((value === 'Other') ? [Validators.required] : null);
    this.ebpFormGroup.controls.notes.updateValueAndValidity();
    this.send();
  }
  changeadditionalinfo(value: any) {
    this.updateAdditionalInfo(value);
  }
  changenoadditionalinfo(value: any) {
   this.updateAdditionalInfo(value);
  }

  updateAdditionalInfo(value: any){
    this.ebpFormGroup.patchValue({
      notes: null
    });
    this.updatenotesValidation(value);
  }

  updatenotesValidation(value: any) {
    this.ebpFormGroup.controls.notes.setValidators((value === 'Yes') ? [Validators.required] : null);
    this.ebpFormGroup.controls.notes.updateValueAndValidity();
    this.send();
  }
  send() {
    this.outData.emit({
      status: this.ebpFormGroup.valid,
      data: this.ebpFormGroup.valid ? this.ebpFormGroup.value : undefined
    });
  }
}