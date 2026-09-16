import { Component, OnInit, Input, Output, EventEmitter, SimpleChanges, OnChanges, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CommonDropdownsService, AuthService, DataStoreService, CommonHttpService, AlertService } from '../../../../../@core/services';
import _ from 'lodash';
import moment from 'moment';
import { config } from '../../../../../../environments/config';
@Component({
    selector: 'goal',
    templateUrl: './goal.component.html',
    styleUrls: ['./goal.component.scss'],
    standalone: false
})
export class GoalComponent implements OnInit, OnChanges, OnDestroy {
  @Input() goalFormData: any;
  @Input() autoflag: any;
  @Output() saveGoal = new EventEmitter<any>();
  servicePlanGoal!: FormGroup;
  goalReferenceValues: any[] = [];
  goalStatusReferenceValues: string[] = [];
  selectedService: any;
  selectedGoal: any;
  savedGoalData: any;
  autoSaveIntervalTimer!: NodeJS.Timer;
  goalAutoSaved: boolean = false;
  lastUpdatedTime: any = null;
  goalAutoSaveInitiated: boolean = false;
  constructor(
    private _commonDropdownService: CommonDropdownsService,
    private _authService: AuthService,
    private _formBuilder: FormBuilder,
    private _datastore: DataStoreService,
    private _commonhttp: CommonHttpService,
    private _alertservice: AlertService
  ) { this.initiateForm();
    this.selectedService = this._datastore.getData('SelectedService');
    this.selectedGoal = this._datastore.getData('SelectedGoal');
  }

  ngOnInit() {
    this.getGoalReferenceValues();
    this.existingForm();
    this.disableGoalNameFn();
    this.servicePlanGoal.valueChanges.subscribe((val) => {
      const latestGoalData = this.servicePlanGoal.getRawValue();
      if(latestGoalData.goalname !== null) {
        const isGoalChanged = _.isEqual(this.savedGoalData, latestGoalData); 
        if(!isGoalChanged && !this.goalAutoSaveInitiated) {
          this.initiateAutoSave();
        }
      }
    });
  }

  private disableGoalNameFn() {
    const goalName: any = this.servicePlanGoal?.get('goalname');
    if (this.autoflag === 1) {
      goalName.disable({ emitEvent: false });
    } else {
      goalName.enable({ emitEvent: false });
    }
  }

  ngOnDestroy() {
    clearInterval(this._datastore.getData('editServicePlaceGoalTimer'));
  }

  ngOnChanges(changes: SimpleChanges) {
    if (changes.goalFormData) {
      this.goalFormData = changes.goalFormData.currentValue ? changes.goalFormData.currentValue : null;
      if (this.goalFormData) {
        this.servicePlanGoal.patchValue(this.goalFormData);
      }
    }
  }

  initiateForm() {
    this.servicePlanGoal = this._formBuilder.group({
      goalname: [null],
      splangoalid: [null],
      status: ['']
     });
  }

  addGoal(activeflag: any, isAutoSave: any) {
    if(!isAutoSave) {
      this.saveGoal.emit({
        goalForm: this.servicePlanGoal.getRawValue()
      });
    }
    const goal = this.servicePlanGoal.getRawValue();
    goal.activeflag = activeflag;
    goal['serviceplanid'] = this.selectedService.serviceplanid;
    this._commonhttp.create(goal, 'splangoal/addupdate').subscribe(
      response => {
        if (response) {
          this.selectedGoal = response;
          this.savedGoalData = this.servicePlanGoal.getRawValue();
          if(isAutoSave) {
            this.goalAutoSaved = true;
            this.lastUpdatedTime = moment().format('MM/DD/YYYY h:mm:ss A');
            this._alertservice.success('Goal Auto-Saved Successfully!'); 
          } else {
            this.goalAutoSaveInitiated = false;
            this.goalAutoSaved = false;
            this._alertservice.success('Goal Updated successfully!'); 
            this.saveGoal.emit(response)
          }
        }
      }
    );
  }

  getGoalReferenceValues() {
    this._commonDropdownService.getReferenveValuesByTypeIdandTeam('106', this._authService.getAgencyName() ).subscribe(
      (resultresp) => {
        this.goalReferenceValues = resultresp;
      });
      this.goalStatusReferenceValues = ['In Progress', 'Achieved', 'Not Achieved'];
  }

  cancelGoal() {
    this.saveGoal.emit('close');
  }

  existingForm(){
    setTimeout(()=>{
        this.savedGoalData = this.servicePlanGoal.getRawValue();
    }, 3000);
  }

  initiateAutoSave() {

    let isGoalChanged = true;
    this.goalAutoSaveInitiated = true;
  
    this.autoSaveIntervalTimer = setInterval(() => {
      
      const latestGoalData = this.servicePlanGoal.getRawValue();
      isGoalChanged = _.isEqual(this.savedGoalData, latestGoalData); 
        
      if(!isGoalChanged){
        if(latestGoalData.goalname !== null && latestGoalData.status !== null && latestGoalData.status !== '') {
          this.addGoal(1,true)
        } else {
          this._alertservice.error('Auto Save cannot be triggered at this time as the mandatory fields are not filled to proceed.');
        }
      }
  
    }, config.AutoSaveTimer);
    this._datastore.setData('editServicePlaceGoalTimer', this.autoSaveIntervalTimer);
  }

}