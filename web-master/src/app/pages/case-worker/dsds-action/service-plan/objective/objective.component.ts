import { Component, OnInit, OnChanges, SimpleChanges, Input, Output, EventEmitter, OnDestroy } from '@angular/core';
import { CommonDropdownsService } from '../../../../../@core/services/common-dropdowns.service';
import { AuthService } from '../../../../../@core/services/auth.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonHttpService, DataStoreService, AlertService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import _ from 'lodash';
import moment from 'moment';
import { config } from '../../../../../../environments/config';
@Component({
    selector: 'objective',
    templateUrl: './objective.component.html',
    styleUrls: ['./objective.component.scss'],
    standalone: false
})
export class ObjectiveComponent implements OnInit, OnChanges, OnDestroy {

  @Input() objectiveFormData: any;
  @Input() autoflag: any;
  @Input() requiredField:boolean=false;
  @Output() saveObjective = new EventEmitter<any>();
  focusPlanFormGroup!: FormGroup;
  objectiveStatusReferenceValues!: string[];
  cansFStrengthsData!: any[];
  cansStrengthsData!: any[];
  focusStrengths!: any[];
  cansFStrengthList!: any[];
  isAssementCompleted!: boolean;
  intakeserviceid: any;
  cansFNeedsData!: any[];
  cansNeedsData!: any[];
  focusNeeds!: any[];
  cansFNeedsList!: any[];
  selectedGoal: any;
  selectedService: any;
  hideForm!: boolean;
  savedObjectiveData: any;
  autoSaveIntervalTimer!: any;
  lastObjectiveUpdatedTime: any = null;
  objectiveAutoSaved: boolean = false;

  objectiveAutoSaveInitiated: boolean = false;
  checkforrequired: boolean =false;

  constructor(
    private _commonDropdownService: CommonDropdownsService,
    private _authService: AuthService,
    private _formBuilder: FormBuilder,
    private _commonhttp: CommonHttpService,
    private _datastore: DataStoreService,
    private _alertservice: AlertService
  ) { this.initiateForm();
    this.selectedService = this._datastore.getData('SelectedService');
    this.selectedGoal = this._datastore.getData('SelectedGoal');
  }

  ngOnInit() {
    this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.getObjectiveStatus();
    this.getNeeds();
    this.getStrengths();
    this.existingForm();

    this.focusPlanFormGroup.valueChanges.subscribe((val) => {

      const latestObjectiveData = this.focusPlanFormGroup.getRawValue();

      latestObjectiveData.comments = (latestObjectiveData.comments === null) ? '' : latestObjectiveData.comments;
      this.savedObjectiveData.comments = (this.savedObjectiveData.comments === null) ? '' : this.savedObjectiveData.comments;
      const isObjectiveChanged = _.isEqual(this.savedObjectiveData, latestObjectiveData); 

      if(!this.objectiveAutoSaveInitiated && !isObjectiveChanged) {
        this.initiateAutoSave(); 
      }
      
  });
  }

  ngOnDestroy(): void {
    clearInterval(this._datastore.getData('editServicePlaceObjectiveTimer'));
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes.objectiveFormData) {
      this.objectiveFormData = changes.objectiveFormData.currentValue ? changes.objectiveFormData.currentValue : null;
      if (this.objectiveFormData) {
        this.focusPlanFormGroup.patchValue(this.objectiveFormData);
      }
    }
  }

  getObjectiveStatus() {
    this.objectiveStatusReferenceValues = ['In Progress', 'Achieved', 'Not Achieved'];
  }

  initiateForm() {
    this.focusPlanFormGroup = this._formBuilder.group({
      objectivename: [null, Validators.required],
      needs: [null],
      strengths: [null],
      splanobjectiveid: [null],
      otherneeds: [null],
      otherstrength: [null],
      comments: [''],
      status: [null, Validators.required]
    });
  }

  getStrengths() {
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: {
        intakeserviceid : this.intakeserviceid
      }
    };
    this._commonhttp.getPagedArrayList(payload, 'serviceplanstrength/list?filter').subscribe(
      response => {
        if (response && response.data && response.data.length) {
        this.cansFStrengthsData = response.data.filter(x => x.assessmenttype === 'cansF');
        this.cansStrengthsData = response.data.filter(x => x.assessmenttype === 'cansOutOfHomePlacementService');
        this.focusStrengths = response.data.map(x => x.serviceplanstrengthname);
        this.cansFStrengthList = response.data;

        if (this.cansFStrengthList.length) {
          this.isAssementCompleted = true;
        }

        }
      });
  }

  getNeeds() {
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: {
        intakeserviceid : this.intakeserviceid
      }
    };
    this._commonhttp.getPagedArrayList(payload, 'serviceplanneed/list?filter').subscribe(
      response => {
        if (response && Array.isArray(response.data)) {
          this.cansFNeedsData = response.data.filter(x => x.assessmenttype === 'cansF');
          this.cansNeedsData = response.data.filter(x => x.assessmenttype === 'cansOutOfHomePlacementService');
          this.focusNeeds = response.data.map(x => x.serviceplanneedname);
          this.cansFNeedsList = response.data;
          if (this.cansFNeedsList.length) {
             this.isAssementCompleted = true;
          }
         }
      });
  }

  addFocusPlan(activeflag: any, isAutoSave: any) {

    if (isAutoSave && !this.focusPlanFormGroup.valid) {
      this._alertservice.error('Auto Save cannot be triggered at this time as the mandatory fields are not filled to proceed.');
      return false;
    }

    let objectivealertmsg;
    if (this.requiredField && this.focusPlanFormGroup.invalid) {
      this.checkforrequired = true;
      this._alertservice.error("Please fill required fields");

    }
    else {
      const objective = this.focusPlanFormGroup.getRawValue();
      objectivealertmsg = this.getObjectivealertmsg(objective, isAutoSave);
      objective.needs = JSON.stringify(objective.needs);
      objective.strengths = JSON.stringify(objective.strengths);
      objective.activeflag = activeflag;
      objective.splangoalid = this.selectedGoal.splangoalid;
      objective.serviceplanid = this.selectedService.serviceplanid;
      this.selectedService.serviceplanfocus = (this.selectedService.serviceplanfocus && this.selectedService.serviceplanfocus.length) ? this.selectedService.serviceplanfocus : [];
      this.saveFocusPlan(objective, isAutoSave, objectivealertmsg, activeflag);
    }

  }

  getObjectivealertmsg(objective: any, isAutoSave: any){
    let objectivealertmsg;
    if (objective.splanobjectiveid == undefined || objective.splanobjectiveid == null || objective.splanobjectiveid == '') {
      objectivealertmsg = isAutoSave ? 'Objective Auto-Saved Successfully!' : 'Objective is added successfully.';
    } else {
      objectivealertmsg = isAutoSave ? 'Objective Auto-Saved Successfully!' : 'Objective is updated successfully.';
    }
    return objectivealertmsg;
  }

  saveFocusPlan(objective: any, isAutoSave: any, objectivealertmsg: any, activeflag: any){
    this._commonhttp.create(objective, 'splanobjective/addupdate').subscribe(
      response => {
        objective.splanobjectiveid = response.splanobjectiveid;
        if (isAutoSave) {
          this.objectiveAutoSaved = true;
          this.lastObjectiveUpdatedTime = moment().format('MM/DD/YYYY h:mm:ss A');
          this.focusPlanFormGroup.patchValue({ splanobjectiveid: response.splanobjectiveid }, { emitEvent: false, onlySelf: true });
          this.savedObjectiveData = this.focusPlanFormGroup.getRawValue();
          this._alertservice.success(objectivealertmsg);
        } else {
          this.saveObjective.emit(response);
          const objectFocus = this.selectedService.serviceplanfocus.filter((fdata: { splanobjectiveid: any; }) =>
            fdata.splanobjectiveid === response.splanobjectiveid
          );
          this.selectedServiceFocusPlan(response, objective, objectFocus);
          this.focusPlanFormGroup.reset();
          this.objectiveAutoSaveInitiated = false;
          clearInterval(this.autoSaveIntervalTimer);
          this.savedObjectiveData = this.focusPlanFormGroup.getRawValue();
          const message = (activeflag === 1) ? objectivealertmsg : 'Objective is deleted successfully.';
          this._alertservice.success(message);
          (<any>$('#add-focus')).modal('hide');
        }

      },
      error => {
        this.focusPlanFormGroup.reset();
        this.objectiveAutoSaveInitiated = false;
        clearInterval(this.autoSaveIntervalTimer);
        const message = (activeflag === 1) ? 'Error in updating Objective.' : 'Error in deleting Objective.';
        this._alertservice.error(message);
        (<any>$('#delete-popup')).modal('hide');
      }
    );
  }

  selectedServiceFocusPlan(response: any, objective: any, objectFocus: any){
    if (objectFocus && objectFocus.length === 0) {
      this.selectedService.serviceplanfocus.unshift(objective);
    } else {
      for (const i in this.selectedService.serviceplanfocus) {
        if (this.selectedService.serviceplanfocus[i].splanobjectiveid === response.splanobjectiveid) {

          if (objective.activeflag === 1) {
            this.selectedService.serviceplanfocus[i] = objective;
            break;
          } else {
            this.selectedService.serviceplanfocus.splice(objective, 1);
            break;
          }
          // Stop this loop, we found it!
        }
      }
    }
  }

  cancelObjective() {
    this.saveObjective.emit('close');
    this.focusPlanFormGroup.reset();
    this.objectiveAutoSaveInitiated = false;
    clearInterval(this.autoSaveIntervalTimer);
    this.savedObjectiveData = this.focusPlanFormGroup.getRawValue();
  }

  existingForm(){
    setTimeout(()=>{
        this.savedObjectiveData = this.focusPlanFormGroup.getRawValue();
    }, 3000);
  }

  initiateAutoSave() {

    this.objectiveAutoSaveInitiated = true;
    let isObjectiveChanged = true;
  
    this.autoSaveIntervalTimer = setInterval(() => {
      
      const latestObjectiveData = this.focusPlanFormGroup.getRawValue();
      isObjectiveChanged = _.isEqual(this.savedObjectiveData, latestObjectiveData); 
        
      if(!isObjectiveChanged){
        this.addFocusPlan(1,true)
      }
  
    }, config.AutoSaveTimer);
    this._datastore.setData('editServicePlaceObjectiveTimer', this.autoSaveIntervalTimer);
  }

}