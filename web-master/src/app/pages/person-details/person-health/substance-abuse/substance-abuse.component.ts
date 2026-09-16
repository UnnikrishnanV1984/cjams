import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { SubstanceAbuse } from '../../../../@core/common/models/involvedperson.data.model';
import { MyNewintakeConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { AlertService, DataStoreService, CommonDropdownsService } from '../../../../@core/services';
import { SubstanceAbuseService } from './substance-abuse.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'substance-abuse',
    templateUrl: './substance-abuse.component.html',
    styleUrls: ['./substance-abuse.component.scss'],
    standalone: false
})
export class SubstanceAbuseComponent implements OnInit {

  substanceabuseForm!: FormGroup;
  constants = MyNewintakeConstants.Intake.PersonsInvolved.Health;
  alchoholSelectionEnabled!: boolean;
  drugSelectionEnabled!: boolean;
  drugorAlchoholSelectionEnabled!: boolean;
  tobaccoSelectionEnabled!: boolean;
  frequencyList$: any[] = [];
  substanceAbuse!: SubstanceAbuse | null;
  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _dropdownService: CommonDropdownsService,
    private _service: SubstanceAbuseService) { }

  ngOnInit() {
    this.substanceabuseForm = this.formbulider.group({
      isusetobacco: null,
      isusedrugoralcohol: null,
      isusedrug: null,
      drugfrequencytypekey: null,
      drugageatfirstuse: null,
      isusealcohol: null,
      alcoholfrequencytypekey: null,
      alcoholageatfirstuse: null,
      drugoralcoholproblems: null,
      tobaccofrequencytypekey: null,
      tobaccoageatfirstuse: null,
      tobaccotimes: null,
      drugtimes: null,
      alcoholtimes: null,
      personabusesubstanceid: null,
      perosnid: null
    });

    this.alchoholSelectionEnabled = false;
    this.drugSelectionEnabled = false;
    this.drugorAlchoholSelectionEnabled = false;
    this.tobaccoSelectionEnabled = false;
    this.loadDropdowns();
    this.loadSubstanceDetails();
  }

  loadDropdowns() {
    this._dropdownService.getFrequencyDetails().subscribe(res => {
      this.frequencyList$ = res;
    });
  }

  loadSubstanceDetails() {
    this._service.getSubstanceAbuseDetails().subscribe(res => {
      this.substanceAbuse = (res && res.length > 0) ? res[0] : null;
      if (this.substanceAbuse) {
        this.substanceabuseForm.patchValue(this.substanceAbuse);
        this.drugSelection(this.substanceAbuse.isusedrug);
        this.alchoholSelection(this.substanceAbuse.isusealcohol);
        this.tobaccoSelection(this.substanceAbuse.isusetobacco);
      }
    });
  }

  resetdrugalcoholfields() {
    this.substanceabuseForm.patchValue({ 'isusedrug': null });
    this.substanceabuseForm.patchValue({ 'isusealcohol': null });
  }

  resetdrugfields() {
    this.substanceabuseForm.patchValue({ 'drugfrequencytypekey': null, 'drugageatfirstuse': null, drugtimes: null });
  }

  resetalcoholfields() {
    this.substanceabuseForm.patchValue({ 'alcoholfrequencytypekey': null, 'alcoholageatfirstuse': null, alcoholtimes: null });
  }

  resettobaccofields() {
    this.substanceabuseForm.patchValue({ 'tobaccofrequencytypekey': null, 'tobaccoageatfirstuse': null, tobaccotimes: null });
  }

  drugSelection(control: any) {
    if (control) {
      this.drugSelectionEnabled = true;
      this.substanceabuseForm.get('drugfrequencytypekey')?.enable();
      this.substanceabuseForm.get('drugfrequencytypekey')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('drugfrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugageatfirstuse')?.enable();
      this.substanceabuseForm.get('drugageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('drugageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugtimes')?.enable();
      this.substanceabuseForm.get('drugtimes')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('drugtimes')?.updateValueAndValidity();

    } else {
      this.resetdrugfields();
      this.drugSelectionEnabled = false;
      this.substanceabuseForm.get('drugfrequencytypekey')?.disable();
      this.substanceabuseForm.get('drugfrequencytypekey')?.clearValidators();
      this.substanceabuseForm.get('drugfrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugageatfirstuse')?.disable();
      this.substanceabuseForm.get('drugageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('drugageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugtimes')?.disable();
      this.substanceabuseForm.get('drugtimes')?.clearValidators();
      this.substanceabuseForm.get('drugtimes')?.updateValueAndValidity();
    }
  }

  alchoholSelection(control: any) {
    if (control) {
      this.alchoholSelectionEnabled = true;
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.enable();
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.enable();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholtimes')?.enable();
      this.substanceabuseForm.get('alcoholtimes')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('alcoholtimes')?.updateValueAndValidity();
    } else {
      this.resetalcoholfields();
      this.alchoholSelectionEnabled = false;
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.disable();
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.clearValidators();
      this.substanceabuseForm.get('alcoholfrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.disable();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholtimes')?.disable();
      this.substanceabuseForm.get('alcoholtimes')?.clearValidators();
      this.substanceabuseForm.get('alcoholtimes')?.updateValueAndValidity();
    }
  }

  tobaccoSelection(control: any) {
    if (control) {
      this.tobaccoSelectionEnabled = true;
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.enable();
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.enable();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccotimes')?.enable();
      this.substanceabuseForm.get('tobaccotimes')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('tobaccotimes')?.updateValueAndValidity();
    } else {
      this.resettobaccofields();
      this.tobaccoSelectionEnabled = false;
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.disable();
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.clearValidators();
      this.substanceabuseForm.get('tobaccofrequencytypekey')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.disable();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccotimes')?.disable();
      this.substanceabuseForm.get('tobaccotimes')?.clearValidators();
      this.substanceabuseForm.get('tobaccotimes')?.updateValueAndValidity();
    }
  }

  resetForm() {
    this.substanceabuseForm.reset();
    this.drugSelection(false);
    this.alchoholSelection(false);
    this.tobaccoSelection(false);
  }
  save() {
    this.substanceAbuse = this.substanceabuseForm.getRawValue();
    this._service.saveOrUpdateSubstanceAbuse(this.substanceAbuse).subscribe((_res: any) => {
      this._alertSevice.success('Substance Abuse details saved successfully.');
      this.loadSubstanceDetails();
    });
  }
}
