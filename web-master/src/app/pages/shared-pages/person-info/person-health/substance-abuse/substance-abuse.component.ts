import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
// tslint:disable-next-line:import-blacklist
import { Health, SubstanceAbuse } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { AlertService, DataStoreService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { FileError } from 'ngxf-uploader';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'substance-abuse',
    templateUrl: './substance-abuse.component.html',
    styleUrls: ['./substance-abuse.component.scss'],
    standalone: false
})
export class SubstanceAbuseComponent implements OnInit {

  substanceabuseForm!: FormGroup;
  health: Health = {};
  modalInt!: number;
  editMode!: boolean;
  reportMode!: string;  
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  alchoholSelectionEnabled!: boolean;
  drugSelectionEnabled!: boolean;
  drugorAlchoholSelectionEnabled!: boolean;
  tobaccoSelectionEnabled!: boolean;
  substanceAbusecw: SubstanceAbuse[] = [];
  uploadedFile!: File;
  isAddEdit = false;
  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    private _dataStoreService: DataStoreService,
    private _healthService: PersonHealthService) { }

  ngOnInit() {
    this.editMode = false;
    this.modalInt = -1;
    this.reportMode = 'add';
    this.substanceabuseForm = this.formbulider.group({
      isusetobacco: null,
   //   isusedrugoralcohol: null,
      isusedrug: null,
      drugfrequencydetails: '',
      drugageatfirstuse: '',
      isusealcohol: null,
      alcoholfrequencydetails: '',
      alcoholageatfirstuse: '',
      drugoralcoholproblems: '',
      tobaccofrequencydetails: '',
      tobaccoageatfirstuse: '',
      uploadpath: ''
    });

    this.health = this._dataStoreService.getData(this.constants.Health);
    this.alchoholSelectionEnabled = false;
    this.drugSelectionEnabled = false;
    this.drugorAlchoholSelectionEnabled = false;
    if (this.health && this.health.substanceAbuse) {
      this.drugSelection(this.health.substanceAbuse.isusedrug ? '1' : '');
      this.alchoholSelection(this.health.substanceAbuse.isusealcohol ? '1' : '');
      this.tobaccoSelection(this.health.substanceAbuse.isusetobacco ? '1' : '');
      setTimeout(() => {
        if (this.health.substanceAbuse) {
          this.substanceabuseForm.patchValue(this.health.substanceAbuse);
        }
        this.substanceabuseForm.get('isusetobacco')?.setValue(this.health.substanceAbuse?.isusetobacco);
        this.substanceabuseForm.get('isusedrug')?.setValue(this.health.substanceAbuse?.isusedrug);
        this.substanceabuseForm.get('isusealcohol')?.setValue(this.health.substanceAbuse?.isusealcohol);
      }, 10);
    }

    this.substanceabuseForm.valueChanges.subscribe();
  }

  resetdrugalcoholfields() {
    this.substanceabuseForm.patchValue({ 'isusedrug': null });
    this.substanceabuseForm.patchValue({ 'isusealcohol': null });
  }

  resetdrugfields() {
    this.substanceabuseForm.patchValue({ 'drugfrequencydetails': null });
    this.substanceabuseForm.patchValue({ 'drugageatfirstuse': null });
  }

  resetalcoholfields() {
    this.substanceabuseForm.patchValue({ 'alcoholfrequencydetails': null });
    this.substanceabuseForm.patchValue({ 'alcoholageatfirstuse': null });
  }

  resettobaccorfields() {
    this.substanceabuseForm.patchValue({ 'tobaccofrequencydetails': null });
    this.substanceabuseForm.patchValue({ 'tobaccoageatfirstuse': null });
  }

  drugSelection(control: any) {
    if (control === '1') {
      this.drugSelectionEnabled = true;
      this.substanceabuseForm.get('drugfrequencydetails')?.enable();
      this.substanceabuseForm.get('drugfrequencydetails')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('drugfrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugageatfirstuse')?.enable();
      this.substanceabuseForm.get('drugageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('drugageatfirstuse')?.updateValueAndValidity();

    } else {
      this.resetdrugfields();
      this.drugSelectionEnabled = false;
      this.substanceabuseForm.get('drugfrequencydetails')?.disable();
      this.substanceabuseForm.get('drugfrequencydetails')?.clearValidators();
      this.substanceabuseForm.get('drugfrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('drugageatfirstuse')?.disable();
      this.substanceabuseForm.get('drugageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('drugageatfirstuse')?.updateValueAndValidity();
    }
  }

  alchoholSelection(control: any) {
    if (control === '1') {
      this.alchoholSelectionEnabled = true;
      this.substanceabuseForm.get('alcoholfrequencydetails')?.enable();
      this.substanceabuseForm.get('alcoholfrequencydetails')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('alcoholfrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.enable();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
    } else {
      this.resetalcoholfields();
      this.alchoholSelectionEnabled = false;
      this.substanceabuseForm.get('alcoholfrequencydetails')?.disable();
      this.substanceabuseForm.get('alcoholfrequencydetails')?.clearValidators();
      this.substanceabuseForm.get('alcoholfrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.disable();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('alcoholageatfirstuse')?.updateValueAndValidity();
    }
  }

  tobaccoSelection(control: any) {
    if (control === '1') {
      this.tobaccoSelectionEnabled = true;
      this.substanceabuseForm.get('tobaccofrequencydetails')?.enable();
      this.substanceabuseForm.get('tobaccofrequencydetails')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('tobaccofrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.enable();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.setValidators([Validators.required]);
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
    } else {
      this.resettobaccorfields();
      this.tobaccoSelectionEnabled = false;
      this.substanceabuseForm.get('tobaccofrequencydetails')?.disable();
      this.substanceabuseForm.get('tobaccofrequencydetails')?.clearValidators();
      this.substanceabuseForm.get('tobaccofrequencydetails')?.updateValueAndValidity();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.disable();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.clearValidators();
      this.substanceabuseForm.get('tobaccoageatfirstuse')?.updateValueAndValidity();
    }
  }

  resetForm() {
    this.substanceabuseForm.reset();
    this.drugSelection('2');
    this.alchoholSelection('2');
    this.tobaccoSelection('2');
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.substanceabuseForm.enable();
  }
  save() {
    const substanceAbuseData = this.substanceabuseForm.getRawValue();
    this.substanceAbusecw.push(substanceAbuseData);
    this._healthService.saveHealth({ 'personHealthSubstanceAbuse': this.substanceAbusecw }).subscribe(response => {
      this._alertSevice.success('Added Behavioral Health Successfully');
    });
    this.resetForm();
  }

  uploadFile(file: any): void {
    if (!(file instanceof File)) {
      return;
    }

    this.uploadedFile = file;
  }
  addSubstanceAbuse() {
    this.isAddEdit = true;
  }

  private edit(modal: any, i: any) {
    this.isAddEdit = true;
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.substanceabuseForm.enable();
  }

}
