import { Component,Injector,OnInit } from "@angular/core";
import { FormBuilder,FormGroup,Validators,AbstractControl, FormControl } from '@angular/forms';
import { AlertService,AuthService,CommonHttpService,DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import _ from 'lodash';
import { Observable } from "rxjs";
import { catchError, pluck, share, tap } from 'rxjs/operators';
import moment from 'moment';
import { NavigationUtils } from "../../../../../_utils/navigation-utils.service";
import { PaginationRequest } from "../../../../../../@core/entities/common.entities";
import { CaseWorkerUrlConfig } from "../../../../../case-worker/case-worker-url.config";
import { AppConstants } from "../../../../../../@core/common/constants";
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { DatePipe } from "@angular/common";
@Component({
    selector: 'ytp-fc-gs-checklist',
    templateUrl: './ytp-fc-gs-checklist.component.html',
    styleUrls: ['./ytp-fc-gs-checklist.component.scss'],
    standalone: false
})
export class YtpFosterCareGaurdianshipChecklistComponent implements OnInit {
    private _commonHttpService: CommonHttpService;
    private formBuilder: FormBuilder;
    private _alertservices: AlertService;
    private _dataStoreService: DataStoreService;
    private _ytpService: YouthTransitionPlanService;
    private _navigationUtils?: NavigationUtils

    fosterGaurdFormGroup!: FormGroup;
    store: any;
    suggestedAddress$!: Observable<any[]>;
    mandatoryField: boolean = false;
    isSaveTriggered: boolean = false;
    address = { address1: null,address2: null,city: null,state: null,zipcode: null,county: null,disable: false };
    dob: Date | null = null;
    ytpData: any;
    isDisabled: boolean = false;
    ssiStatus: boolean | null = null;
    currentDate = moment();
    personList: any[] = [];
    personNameDescription!: string;
    id!: string;

    dropdown: any[] = [
        {key: "1",text:"Assisted Living"},
        {key: "2",text:"Correctional Facility"},
        {key: "3",text:"DDA Group Home"},
        {key: "4",text:"Family member or friend's home"},
        {key: "5",text:"Own Home"},
        {key: "6",text:"Hospital"},
        {key: "7",text:"Nursing Home"},
        {key: "8",text:"Psychiatric Facility"},
        {key: "9",text:"Respite"},
        {key: "10",text:"Non-DDA Group Home"},
        {key: "11",text:"Other"}
        ]
    private _authService: AuthService;
    isSupervisor!: boolean;

        constructor(private injector: Injector) {
        this.formBuilder = this.injector.get < FormBuilder > (FormBuilder);
        this._commonHttpService = this.injector.get < CommonHttpService > (CommonHttpService);
        this._dataStoreService = this.injector.get < DataStoreService > (DataStoreService);
        this._alertservices = this.injector.get < AlertService > (AlertService);
        this._authService = injector.get<AuthService>(AuthService);
        this._ytpService = this.injector.get < YouthTransitionPlanService > (YouthTransitionPlanService);
        this._navigationUtils = this.injector.get < NavigationUtils > (NavigationUtils);
        this.store = this._dataStoreService.getCurrentStore();

    }

    ngOnInit() {
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.intializeForm();
        this.ytpData = this.store['YTPDATA'];
        this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';
        if (this.ytpData && this.ytpData.newfcgschecklistjson) {
            this.fosterGaurdFormGroup.patchValue(this.ytpData.newfcgschecklistjson);
        }
        this.updateQ7PetitionValidators();

        this.dob = this.ytpData?.new_summary_json?.dob;
        this.address = this.ytpData?.newfcgschecklistjson?.address || this.address;
        this.getInvolvedPerson();
        this.onChangeDdaService();
        this.onChangeSsi();
        this.checkValidators();
        
    }

    intializeForm() {
        this.fosterGaurdFormGroup = this.formBuilder.group({
            isTransitionpast18th: [null,[Validators.required]],
            restictiveAlternative: [null],
            willRemaintill21: [null],
            needTransition: [null],
            ddaServices: [null],
            isDdaServices: [null],
            enrollmentDate: [null],
            narrative: [null],
            comments: [null],
            ssi: [null],
            ssienrollmentDate: [null],
            ssinarrative: [null],
            ableAcc: [null],
            ableAccEstablishDate: [null],
            ableAccNarrative: [null],
            ableEligibility: [null],
            trustChecked: [false],
            ableChecked: [false],
            ableEligInstitution: [null],
            ableAccEligNarrative: [null],
            trustAccEligNarrative: [null],
            ddaReceivingJurisdiction: [null],
            ddaJurisdicationComments: [null],
            isDdaReceiving: [false],
            oasNarrative: [null],
            isAddressTbd: [null],
            placementName: [null],
            willGuardianProvideCare: [null],
            petitionFillingDate: [null],
            transistionMeeting: [null],
            typeOfPlacement:[null],
            guardian:[null],
            personid: [null],
            petitionSentToDssAttorneyOn: [null],
            petitionSkip: [false],
            petitionSkipComment: [null]
        });

        if (this.isSupervisor) {
            this.fosterGaurdFormGroup.disable();
        }

        this.fosterGaurdFormGroup.get('ableAcc')!.valueChanges.subscribe((v) => {
          const estDate = this.fosterGaurdFormGroup.get('ableAccEstablishDate')!;
          const insNarr = this.fosterGaurdFormGroup.get('ableAccNarrative')!;
          const ableEligibility = this.fosterGaurdFormGroup.get('ableEligibility')!;
          const ableEligInstitution = this.fosterGaurdFormGroup.get('ableEligInstitution')!;
          const ableAccEligNarrative = this.fosterGaurdFormGroup.get('ableAccEligNarrative')!;
          const trustAccEligNarrative = this.fosterGaurdFormGroup.get('trustAccEligNarrative')!;
        
          if (v === '1') {
            estDate.enable({ emitEvent: false });

            ableEligibility.setValue(null, { emitEvent: false });
            ableEligibility.clearValidators(); ableEligibility.updateValueAndValidity({ emitEvent: false });
            ableEligInstitution.setValue(null, { emitEvent: false });
            ableEligInstitution.clearValidators(); ableEligInstitution.updateValueAndValidity({ emitEvent: false });
            ableAccEligNarrative.setValue(null, { emitEvent: false });
            ableAccEligNarrative.clearValidators(); ableAccEligNarrative.updateValueAndValidity({ emitEvent: false });
            trustAccEligNarrative.setValue(null, { emitEvent: false });
            trustAccEligNarrative.clearValidators(); trustAccEligNarrative.updateValueAndValidity({ emitEvent: false });
        
          } else {
            estDate.disable({ emitEvent: false });
            estDate.reset(null, { emitEvent: false });
        
            insNarr.reset(null, { emitEvent: false });
          }
          this.onChangeAbleAcc();
        });
        
        this.fosterGaurdFormGroup.get('isDdaReceiving')!.valueChanges.subscribe((checked: boolean) => {
            const enr = this.fosterGaurdFormGroup.get('ddaReceivingJurisdiction')!;
            if (checked) {
                enr.disable({ emitEvent: false });
                enr.reset(null, { emitEvent: false });
            } else {
                enr.enable({ emitEvent: false });
            }
        });

        const ableAccVal = this.fosterGaurdFormGroup.get('ableAcc')!.value;
        this.fosterGaurdFormGroup.get('ableAcc')!.setValue(ableAccVal, { emitEvent: true });

        const isNA = this.fosterGaurdFormGroup.get('isDdaReceiving')!.value;
        this.fosterGaurdFormGroup.get('isDdaReceiving')!.setValue(isNA, { emitEvent: true });

        this.fosterGaurdFormGroup.get('petitionSkip')!.valueChanges.subscribe(() => {
          this.onChangeQ7PetitionSkip();
        });
        
    }

    private isSkipLocked(): boolean {
      // Once saved as Skip=true, it becomes read-only on next loads AND immediately after save.
      return !!this.store?.['YTPDATA']?.newfcgschecklistjson?.petitionSkip;
    }
    
    private updateQ7PetitionValidators(): void {
      const dateCtrl: FormControl = this.fosterGaurdFormGroup.get('petitionSentToDssAttorneyOn') as FormControl;
      const skipCtrl: FormControl = this.fosterGaurdFormGroup.get('petitionSkip') as FormControl;
      const commentCtrl: FormControl = this.fosterGaurdFormGroup.get('petitionSkipComment') as FormControl;

      const showSection =
        this.returnFieldValues('willGuardianProvideCare') === '0' &&
        this.returnFieldValues('isDdaServices') === 'eligible';
    
      // Disable skip at/after 6 months prior to 21st birthday
      const deadlineReached = this.compareDates(this.currentDate, this.getDateAroundBirthdayMoment(21, -6));
    
      // If section not applicable, clear validators and values
      // if (!showSection) {
      //   dateCtrl.clearValidators();
      //   dateCtrl.updateValueAndValidity({ emitEvent: false });
        
      //   commentCtrl.clearValidators(); 
      //   commentCtrl.updateValueAndValidity({ emitEvent: false });
    
      //   // reset values only when section is not shown 
      //   dateCtrl.setValue(null, { emitEvent: false });
      //   skipCtrl.setValue(false, { emitEvent: false });
      //   commentCtrl.setValue(null, { emitEvent: false });
    
      //   // re-enable if it was disabled by earlier logic
      //   if (!this.isSupervisor && !this.isDisabled) {
      //     skipCtrl.enable({ emitEvent: false });
      //     commentCtrl.enable({ emitEvent: false });
      //   }
      // }
    
      // Skip checkbox disabled once deadline reached OR once already saved as skip
      if (this.isSkipLocked() || deadlineReached) {
        skipCtrl.disable({ emitEvent: false });
      } else if (!this.isSupervisor && !this.isDisabled) {
        skipCtrl.enable({ emitEvent: false });
      }
    
      // Mandatory only when Q2 eligibility is Eligible 
      const shouldBeRequired = this.isRequired('willGuardianProvideCare');
    
      if (shouldBeRequired) {
        if (!!skipCtrl.value) {
          // Skip => comment required, date NOT required
          dateCtrl.clearValidators();
          dateCtrl.updateValueAndValidity({ emitEvent: false });
    
          commentCtrl.setValidators([Validators.required]);
          commentCtrl.updateValueAndValidity({ emitEvent: false });
        } else {
          // Not skipping => date required, comment NOT required
          commentCtrl.clearValidators();
          commentCtrl.setValue(null, { emitEvent: false });
          commentCtrl.updateValueAndValidity({ emitEvent: false });
          dateCtrl.clearValidators();
          dateCtrl.setValue(null, { emitEvent: false });
          dateCtrl.updateValueAndValidity({ emitEvent: false });
        }
      } else {
        dateCtrl.clearValidators(); dateCtrl.updateValueAndValidity({ emitEvent: false });
        commentCtrl.clearValidators(); commentCtrl.updateValueAndValidity({ emitEvent: false });
      }
    
      // Once saved with skip=true, comment should be read-only
      if (this.isSkipLocked()) {
        commentCtrl.disable({ emitEvent: false });
      } else if (!this.isSupervisor && !this.isDisabled) {
        commentCtrl.enable({ emitEvent: false });
      }
    }
    
    onChangeQ7PetitionSkip(): void {
      const skip = !!this.returnFieldValues('petitionSkip');
      if (!skip) {
        // If skipping, clear the date so UI/audit doesn’t end up with irrelevant date.
        this.fosterGaurdFormGroup.get('petitionSentToDssAttorneyOn')?.setValue(null, { emitEvent: false });
        this.fosterGaurdFormGroup.get('petitionSkipComment')?.setValue(null, { emitEvent: false });
      } 
      this.updateQ7PetitionValidators();
    }
    

    getDateAroundBirthdayMoment(
        targetAge: number,
        monthOffset: number
    ): Date {
        if (typeof targetAge !== 'number' || typeof monthOffset !== 'number') {
            throw new Error('Invalid input');
        }
        const birthdayMoment = moment(this.dob).add(targetAge,'years');
        const finalDate = birthdayMoment.add(monthOffset,'months');
        return finalDate.toDate();
    }

  validateMandatoryFields(controlName: any) {
    return this.isSaveTriggered &&
      this.fosterGaurdFormGroup.get(controlName) &&
      this.fosterGaurdFormGroup.get(controlName)?.invalid;
  }

  validateMandatoryFieldsIfRequired(controlName: any) {
    return this.isSaveTriggered &&
      this.fosterGaurdFormGroup.get(controlName)?.errors?.['required'];
  }

    returnFieldValues(field: string) {
        return this.fosterGaurdFormGroup.get(field)?.value;
    }

    setValidationFn(formControlName: string): void {
        const control = this.fosterGaurdFormGroup.get(formControlName) as FormControl;
        if (control) {
          control.setValidators([Validators.required]);
          control.updateValueAndValidity();
        }
    } 
    
    removeValidationFn(formControlName: string): void {
        const control = this.fosterGaurdFormGroup.get(formControlName) as FormControl;
        if (control) {
          control?.clearValidators();
          control.updateValueAndValidity();
        }
    }

    markAsTouchFn(formControlName: string): void {
        const control = this.fosterGaurdFormGroup.get(formControlName) as FormControl;
        if (control) {
          control?.markAsTouched();
        }
    } 

    checkValidators() {
      const typeVal = this.fosterGaurdFormGroup.get('typeOfPlacement')?.value;

      this.address.disable = !!this.fosterGaurdFormGroup.get('isAddressTbd')?.value;
        if (typeVal === '11') {
            this.setValidationFn('oasNarrative');
            this.fosterGaurdFormGroup.get('placementName')?.clearValidators();
        } else {
            // Restore address disabled state based on TBD checkbox
            this.removeValidationFn('oasNarrative');
            this.resetFields('oasNarrative');
      }

        if(this.compareDates(this.currentDate, this.getDateAroundBirthdayMoment(18, -6))){
            this.fosterGaurdFormGroup.get('typeOfPlacement')?.setValidators([Validators.required]);
        }else {
            this.fosterGaurdFormGroup.get('typeOfPlacement')?.clearValidators();
        }
        if (this.fosterGaurdFormGroup.get('needTransition')?.value) {
            Object.values(this.fosterGaurdFormGroup.controls).forEach(control => {
                control.setValidators(null);
                control.updateValueAndValidity();
            });
            this.fosterGaurdFormGroup.disable();
            this.fosterGaurdFormGroup.get('needTransition')?.enable();
            this.fosterGaurdFormGroup.get('isTransitionpast18th')?.enable();
            this.isDisabled = true;
            this.mandatoryField = false;
        } else {
            this.checkValidatorsElseFn();
            Object.values(this.fosterGaurdFormGroup.controls).forEach(control => {
                control.updateValueAndValidity();
            });
            this.isDisabled = false;
            if(!this.isSupervisor) {
                this.fosterGaurdFormGroup.enable();
            }
            if (this.fosterGaurdFormGroup.get('isAddressTbd')?.value) {
                this.address.disable = true;
            } else if (typeVal !== '11') {
                this.address.disable = false;
              }
        }

        // Questions 2–4 (DDA, SSI, ABLE) required if:
        // - youth is 14+ years old, OR
        // - youth will remain till 21 AND we are within 3 months of turning 21
        const youthAgeYears = this.calculateAge(this.dob);
        const isWithinThreeMonthsBeforeTwentyOne = this.compareDates(
          this.currentDate,
          this.getDateAroundBirthdayMoment(21, -3)
        );
        const willRemainInCareTillTwentyOne = !!this.fosterGaurdFormGroup.get('willRemaintill21')?.value;
      
        ['ddaServices', 'ssi', 'ableAcc'].forEach(controlName => {
          const shouldBeRequired =
            youthAgeYears >= 14 || (willRemainInCareTillTwentyOne && isWithinThreeMonthsBeforeTwentyOne);
      
          if (shouldBeRequired) {
            this.setValidationFn(controlName);
          } else {
            this.removeValidationFn(controlName);
          }
          this.fosterGaurdFormGroup.get(controlName)?.updateValueAndValidity({ onlySelf: true });
        });

      if (typeVal === '11') {
        this.setValidationFn('oasNarrative');
        this.fosterGaurdFormGroup.get('oasNarrative')?.updateValueAndValidity({ onlySelf: true });
    }
  }

    private checkValidatorsElseFn() {
        const willRemainInCareTillTwentyOne =
          !!this.fosterGaurdFormGroup.get('willRemaintill21')?.value;
        const isWithinSixMonthsBeforeTwentyOne = this.compareDates(
          this.currentDate,
          this.getDateAroundBirthdayMoment(21, -6)
        );
      
        const requireField = (name: string) => this.setValidationFn(name);
        const clearFieldRequirement = (name: string) => this.removeValidationFn(name);
        const getControlValue = (name: string) => this.fosterGaurdFormGroup.get(name)?.value;
        const setFieldRequired = (name: string, required: boolean) =>
          required ? requireField(name) : clearFieldRequirement(name);
      
        const applyQ5Validators = (required: boolean) => {
          const isNotApplicableChecked = !!getControlValue('isDdaReceiving');
          if (required) {
            if (isNotApplicableChecked) {
              requireField('ddaJurisdicationComments');
              clearFieldRequirement('ddaReceivingJurisdiction');
            } else {
              requireField('ddaReceivingJurisdiction');
              clearFieldRequirement('ddaJurisdicationComments');
            }
          } else {
            clearFieldRequirement('ddaReceivingJurisdiction');
            clearFieldRequirement('ddaJurisdicationComments');
          }
        };
      
        const applyQ6Validators = (required: boolean) => {
          const selectedPlacementType = getControlValue('typeOfPlacement');
          if (required) {
            requireField('typeOfPlacement');
      
            if (selectedPlacementType === '11') {
              requireField('oasNarrative');
              clearFieldRequirement('placementName');
            } else {
              clearFieldRequirement('oasNarrative');
              requireField('placementName');
            }
            this.mandatoryField = true;
          } else {
            clearFieldRequirement('typeOfPlacement');
            clearFieldRequirement('placementName');
            clearFieldRequirement('oasNarrative');
            this.mandatoryField = false;
          }
        };
      
        // Q1 & Q5–Q9 should be required when:
        // - NOT remaining till 21, OR
        // - remaining till 21 AND we are within 6 months of turning 21
        const shouldRequireQ1AndQ5ToQ9 =
          !willRemainInCareTillTwentyOne ||
          (willRemainInCareTillTwentyOne && isWithinSixMonthsBeforeTwentyOne);
      
        setFieldRequired('restictiveAlternative', shouldRequireQ1AndQ5ToQ9);
      
        applyQ5Validators(shouldRequireQ1AndQ5ToQ9);
      
        applyQ6Validators(shouldRequireQ1AndQ5ToQ9);
      
        setFieldRequired('willGuardianProvideCare', shouldRequireQ1AndQ5ToQ9);
        if (shouldRequireQ1AndQ5ToQ9 && getControlValue('willGuardianProvideCare') === '1') {
          requireField('personid');
        } else {
          clearFieldRequirement('personid');
        }
      
        setFieldRequired('petitionFillingDate', shouldRequireQ1AndQ5ToQ9);
      
        setFieldRequired('transistionMeeting', shouldRequireQ1AndQ5ToQ9);
      
        Object.values(this.fosterGaurdFormGroup.controls).forEach(control =>
          control.updateValueAndValidity({ onlySelf: true })
        );

        this.updateQ7PetitionValidators();
      }
      
      
    compareDates(date1:any, date2:any){
        return date1.isSameOrAfter(date2);
    }

    isRequired(controlName: string): boolean {
        const control = this.fosterGaurdFormGroup.get(controlName);
        if (!control) {
            return false
        };
        const validator = control.validator?.({} as AbstractControl);
        return !!(validator && validator['required']);
      }

    private getEmptyAddress() {
        return { address1: null, address2: null, city: null, state: null, zipcode: null, county: null, disable: false };
    }
    
    private buildClearedPayloadForNo(): any {
        const clearedFormValues: any = {};
        Object.keys(this.fosterGaurdFormGroup.controls).forEach(key => {
            clearedFormValues[key] = (key === 'isTransitionpast18th') ? '0' : null;
        });
        return {
            ...clearedFormValues,
            address: this.getEmptyAddress()
        };
    }

    save() {
        this.isSaveTriggered = true;
        this.checkValidators();
        if (this.fosterGaurdFormGroup.invalid && this.fosterGaurdFormGroup.get('isTransitionpast18th')?.value === '1') {
          this.fosterGaurdFormGroup.markAllAsTouched();
          this._alertservices.error('Please fill all mandatory fields');
          return;
        }
        
        const isTransitionpast18th = this.fosterGaurdFormGroup.get('isTransitionpast18th')?.value;

        if(!isTransitionpast18th){
          this._alertservices.error('Please fill all mandatory fields');
          return;
        }
        if (isTransitionpast18th === "0") {
            ['ddaServices', 'ssi', 'ableAcc', 'ddaReceivingJurisdiction'].forEach(controlName => this.removeValidationFn(controlName));
            const clearedData = this.buildClearedPayloadForNo();
        
            this._ytpService.patchData('newfcgschecklistjson', clearedData)
              .pipe(
                tap(() => {
                  this.store['YTPDATA'].newfcgschecklistjson = clearedData;
                  this._alertservices.success('Fostercare Guardianship Checklist entered successfully!');
        
                  // reset form after saving, but keep the radio as "No"
                  this.fosterGaurdFormGroup.reset({ isTransitionpast18th: '0' });
                  this.address = this.getEmptyAddress();
                }),
                catchError(error => {
                  this._alertservices.error('Error in entering Fostercase Gaurdianship Checklist!');
                  throw error;
                })
              )
              .subscribe();
            return;
        }

        if (isTransitionpast18th === "0") {
            const ddaReceivingJurisdiction = this.fosterGaurdFormGroup.get('ddaReceivingJurisdiction');
            ddaReceivingJurisdiction?.clearValidators();
            ddaReceivingJurisdiction?.updateValueAndValidity();
        }

        // const doPatch$ = () => this.saveObservable();
        // doPatch$().subscribe();
        this.saveObservable().subscribe();
        }

    saveMethod = () => this.saveObservable();
  
    saveObservable(): Observable<any> {
        const data = {
            ...this.fosterGaurdFormGroup.getRawValue(),
            address: this.address
          };
        return this._ytpService.patchData('newfcgschecklistjson', data)
        .pipe(
            tap(response => {
                    this.store['YTPDATA'].newfcgschecklistjson = data;
                    this.updateQ7PetitionValidators();
                    this._alertservices.success('Fostercare Guardianship Checklist entered successfully!');
            }),
            catchError(error => {
                this._alertservices.error('Error in entering Fostercase Gaurdianship Checklist!');
                throw error;
            })
        );
    }

      clear() {
        this.fosterGaurdFormGroup.reset();
        this.address = { address1: null,address2: null,city: null,state: null,zipcode: null,county: null,disable: false };
      }

    onChangeDdaService() {
        const ddaDataControl: FormControl = this.fosterGaurdFormGroup.get('ddaServices') as FormControl;
        const commentsControl: FormControl = this.fosterGaurdFormGroup.get('comments') as FormControl;
        const ddaReceivingJurisdictionControl: FormControl = this.fosterGaurdFormGroup.get('ddaReceivingJurisdiction') as FormControl;

        if(ddaDataControl.value === 'not applicable') {
            this.resetFields('isDdaServices', 'enrollmentDate', 'narrative');
            commentsControl?.setValidators([Validators.required]);
            commentsControl?.updateValueAndValidity();
        } else if(ddaDataControl.value === 'completed') {
            this.resetFields('comments');
            commentsControl?.clearValidators();
            ddaReceivingJurisdictionControl?.updateValueAndValidity();
        }else{
            this.resetFields('isDdaServices', 'enrollmentDate', 'narrative','comments');
            commentsControl?.clearValidators();
        }

        if(ddaDataControl.value) {
            ddaReceivingJurisdictionControl?.setValidators([Validators.required]);
            ddaReceivingJurisdictionControl?.updateValueAndValidity();
        }
        this.onChangeIsDdaService();
    }

    resetFields(...fields: string[]) {
        fields.forEach(field => {
            this.fosterGaurdFormGroup.get(field)?.setValue(null);
            this.fosterGaurdFormGroup.get(field)?.markAsPristine();
            this.fosterGaurdFormGroup.get(field)?.markAsUntouched();
        });
    }
      
    onChangeIsDdaService() {
        const formData: any = this.fosterGaurdFormGroup.getRawValue();
        const narrativeControl: FormControl = this.fosterGaurdFormGroup.get('narrative') as FormControl;
        const enrollmentDateControl: FormControl = this.fosterGaurdFormGroup.get('enrollmentDate') as FormControl;
        if(formData.isDdaServices === 'eligible') {
            enrollmentDateControl?.setValidators([Validators.required]);
            narrativeControl?.clearValidators();
            narrativeControl?.setValue(null);
        } else if(formData.isDdaServices === 'not eligible') {
            narrativeControl?.setValidators([Validators.required]);
            enrollmentDateControl?.clearValidators();
            enrollmentDateControl?.setValue(null);
        } else {
            narrativeControl?.clearValidators();
            enrollmentDateControl?.clearValidators();
            narrativeControl?.setValue(null);
            enrollmentDateControl?.setValue(null);
        }
        narrativeControl?.updateValueAndValidity();
        enrollmentDateControl?.updateValueAndValidity();
        ['narrative', 'enrollmentDate'].forEach(controlName => this.markAsTouchFn(controlName));
        this.onChangeWillGuardianProvideCare();

        this.updateQ7PetitionValidators();
    }
    

    onChangeSsi() {
      this.ssiStatus = null;
      const ssi = this.fosterGaurdFormGroup.get('ssi') as FormControl;
      const narr = this.fosterGaurdFormGroup.get('ssinarrative') as FormControl;
      const enr = this.fosterGaurdFormGroup.get('ssienrollmentDate') as FormControl;
    
      const val = ssi?.value;
    
      if (!val) {
        narr.clearValidators();
        narr.updateValueAndValidity();
        return;
      }
    
      if (val === 'eligible') {
        this.ssiStatus = false;
        narr.clearValidators();
        narr.setValue(null, { emitEvent: false });
        narr.updateValueAndValidity();
      } else if (val === 'not eligible') {
        this.ssiStatus = true;
        narr.setValidators([Validators.required]);
        enr.setValue(null, { emitEvent: false });
        narr.updateValueAndValidity();
      } else if (val === 'not apply') {
        this.ssiStatus = true;
        narr.clearValidators();
        narr.setValidators([Validators.required]);
        narr.updateValueAndValidity();
        enr.setValue(null, { emitEvent: false });
      }
    
      narr.markAsTouched();
      enr.markAsTouched();
    }
    
  onChangeAbleAcc(){
    const ableAccControl = this.fosterGaurdFormGroup.get('ableAcc') as FormControl;
    const ableEligibilityControl = this.fosterGaurdFormGroup.get('ableEligibility') as FormControl;

    if (ableAccControl.value == '0') {
      if (this.compareDates(this.currentDate, this.getDateAroundBirthdayMoment(18, -6))) {
        ableEligibilityControl?.setValidators([Validators.required]);
      } else {
        ableEligibilityControl?.clearValidators();
        // do not clear value here, keep API patched value and saved value
      }
    } else {
      ableEligibilityControl?.clearValidators();
      ableEligibilityControl?.setValue(null, { emitEvent: false });
    }

    ableEligibilityControl?.updateValueAndValidity();
  }
  private handleReqObjFn(data: any) {
    return data.servicecaseid ?
      {
        objectid: data.servicecaseid,
        objecttypekey: 'servicecase'
      } :
      {
        intakeserviceid: data.intakeserviceid
      }
  }
  getInvolvedPerson() {
    const reqObj: any = {
      objectid: this.id,
      objecttypekey: 'servicecase'
    };
    const personsList = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 100,
          nolimit: true,
          method: 'get',
          where: reqObj
        }),
        `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl}?filter`
      ).pipe(
        share(),
        pluck('data'),);
    personsList.subscribe((items: any) => {
      this.personList = items || [];

      this.getcollateral();
    });
  }
  getcollateral() {
    const request = {
      objectid: this.id,
      objecttype: 'case'
    };
    this._commonHttpService.getArrayList(
      {
        where: request,
        method: 'get',
        nolimit: true
      },
      'collateral/list?filter'
    ).subscribe(res => {
      if (res?.length && res[0]?.getcollateraldetails?.length) {
        res[0].getcollateraldetails.forEach((element: any) => {
          const roleExist = element.collateralroleconfig.find((role:any) => ["CACA"].includes(role.actortypekey));
          if(roleExist) {
            this.personList.push({
              personid: element.collateralid,
              fullname: element.fullname,
              dob: element.dob,
              roles:  element.collateralroleconfig
            });
          }
        });
      }
      const apiPersonId = (this.ytpData?.newfcgschecklistjson?.personid || '').trim().toLowerCase();
      const selected = this.personList.find((x: any) =>
        (x?.personid || '').trim().toLowerCase() === apiPersonId
      );

      this.fosterGaurdFormGroup.patchValue({
        personid: selected ? selected.personid : null
      });

      this.personNameDescription = selected ? selected.fullname : '';
    });
  }
  selectedPerson(event: any) {
    const selectedId = (event?.value || '').trim().toLowerCase();

    const persondetails = this.personList.find((x: any) =>
      (x?.personid || '').trim().toLowerCase() === selectedId
    );

    this.personNameDescription = persondetails ? persondetails.fullname : '';
  }

    getPersonRoleDescription(role:any) {
        if (role) {
          if (role.hasOwnProperty("description")) {
            return role.description;
          } else if (role.hasOwnProperty("typedescription")) {
            return role.typedescription;
          }
        } else {
          return;
        }
    }

    showComma(array:any, index:any) {
        return !((array.length - 1) === index);
    }

    onChangeWillGuardianProvideCare() {
        if(this.returnFieldValues('willGuardianProvideCare') !== '1') {
            this.resetFields('personid');
        }

        const isDdaServicesData: any = this.fosterGaurdFormGroup.get('isDdaServices')?.value;
        const personidControl: FormControl = this.fosterGaurdFormGroup.get('personid') as FormControl;

        if(this.returnFieldValues('willGuardianProvideCare') === '1' && isDdaServicesData === 'eligible') {
            personidControl?.setValidators([Validators.required]);
            personidControl?.updateValueAndValidity();
            ['personid'].forEach(controlName => this.markAsTouchFn(controlName));
        } else {
            personidControl?.setValue(null);
            personidControl?.clearValidators();
            personidControl?.updateValueAndValidity();
        }

        if (this.returnFieldValues('willGuardianProvideCare') !== '0') {
          this.fosterGaurdFormGroup.get('petitionSentToDssAttorneyOn')?.setValue(null, { emitEvent: false });
          this.fosterGaurdFormGroup.get('petitionSkip')?.setValue(false, { emitEvent: false });
          this.fosterGaurdFormGroup.get('petitionSkipComment')?.setValue(null, { emitEvent: false });
        }

        this.updateQ7PetitionValidators();

    }

    calculateAge(dob: any): number {
        return moment().diff(moment(dob, 'YYYY-MM-DD'), 'years');
    }

    noticationFn() {
        const ddaServicesControl: FormControl = this.fosterGaurdFormGroup.get('ddaServices') as FormControl;
        const ssiControl: FormControl = this.fosterGaurdFormGroup.get('ssi') as FormControl;
        const ableAccControl: FormControl = this.fosterGaurdFormGroup.get('ableAcc') as FormControl;
        const isAddressTbdControl: FormControl = this.fosterGaurdFormGroup.get('isAddressTbd') as FormControl;

        if(ddaServicesControl.value === 'started' || ddaServicesControl.value === 'not started') {
            // Notification to be sent
            // Message: Developmental Disabilities Administration (DDA) Services Application Status need to be updated for the Youth “(NAME) CJAMS PID(#####)
        } else if(ssiControl.value === 'eligible') {
            // Notification to be sent on 7 months before the youth turning 18
        } else if(ableAccControl.value === '1') {
            // Message: Youth “NAME” Exited Foster care. Please update if the TRUST or ABLE Account transition into an Adult Service account.
        } else if(isAddressTbdControl.value) {
            // 1st Notification at 30 days before the 18th Birthday of the Client, 
            // 2nd Notification at 30 days before the 21st Birthday of the Client.
        }
    }
}