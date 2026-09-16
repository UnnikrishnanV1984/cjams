import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AlertService, DataStoreService } from '../../../../../../@core/services';
import { YouthTransitionPlanService } from '../youth-transition-plan.service';
import _ from 'lodash';
import { Params } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { catchError, tap } from 'rxjs/operators';
@Component({
    selector: 'ytp-supportive-relationships',
    templateUrl: './ytp-supportive-relationships.component.html',
    styleUrls: ['./ytp-supportive-relationships.component.scss'],
    standalone: false
})
export class YtpSupportiveRelationshipsComponent implements OnInit {

  supportiveFormGroup!: FormGroup;
  supportiveShortTermGoals = [];
  relationship: any[] = [];
  supportiveRelations: any = [];
  communityActions = [];
  ytpData: any;
  store: any;
  isDisabled: boolean = false;
  permanencyPlanId: any;
  mandatoryFields : boolean = false;

  constructor(private formBuilder: FormBuilder,
    private _alertservice: AlertService,
    private _ytpService: YouthTransitionPlanService,
    private _dataStoreService: DataStoreService) {
    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.supportiveFormGroup = this.formBuilder.group({
      legalGoal: [null, Validators.required],
      concurrentPlan: [{value: null,disabled:true}],
      renunification: [{value: null,disabled:true}],
      adoption: [{value: null,disabled:true}],
      guardianShip: [{value: null,disabled:true}],
      plannedPermanent: [{value: null,disabled:true}],
      livingArrangementDesc: [null],
      notes: [null],
      progessGoals: [null],
    });

    this.ytpData = this.store['YTPDATA'];
    this.isDisabled = this.ytpData.approvalstatuskey == 'Pending' || this.ytpData.approvalstatuskey == 'Approved';

    if (this.ytpData && this.ytpData.new_connections_json) {
      this.supportiveFormGroup.patchValue(this.ytpData.new_connections_json);
      if (this.ytpData.new_connections_json.supportiveRelations) {
        this.supportiveRelations = this.ytpData.new_connections_json.supportiveRelations;
      }
      if (this.ytpData.new_connections_json.relationship) {
        this.relationship = this.ytpData.new_connections_json.relationship;
      }
      this.checkCommunityActionsFn();
    }
        this.getPlanDetails();

  }
  // Associated with ngOnInit function
  private checkCommunityActionsFn() {
    if (this.ytpData.new_connections_json.communityActions) {
      this.communityActions = this.ytpData.new_connections_json.communityActions;
      if (Array.isArray(this.communityActions) && this.communityActions.length) {
        this.communityActions.forEach((item: any) => {
          item.start_date = item.start_date ? new Date(item.start_date) : '';
          item.projected_date = item.projected_date ? new Date(item.projected_date) : '';
        });
      }
    }
  }

  buildPermanencyPlanUrl(): string {
    const id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    return `/pages/case-worker/${id}/${daNumber}/dsds-action/sc-permanency-plan`;
  }
  
  buildQueryParams(): Params {
    return {
      origin: 'ytp',
      permanencyplanid: this.permanencyPlanId,
      personid: this.ytpData.clientid
    };
  }

  saveMethod = () => this.saveObservable();

  saveObservable() {
    const data = this.supportiveFormGroup.getRawValue();
    data.relationship = this.relationship;
    data.supportiveRelations = this.supportiveRelations;
    data.communityActions = this.communityActions;
  
    return this._ytpService.patchData('new_connections_json', data).pipe(
      tap(response => {
        this.store['YTPDATA'].new_connections_json = data;
        this._alertservice.success('Supportive relationship details entered successfully!');
      }),
      catchError(error => {
        this._alertservice.error('Error in entering supportive relationship details!');
        throw error;
      })
    );
  }
  

  save() {
    const data = this.supportiveFormGroup.getRawValue();
    data.relationship = this.relationship;
    data.supportiveRelations = this.supportiveRelations;
    data.communityActions = this. communityActions;
    this.mandatoryFields = true;
    
    if(this.supportiveFormGroup.status=='INVALID'){
    return;
    }

    this._ytpService.patchData('new_connections_json', data)
      .subscribe(
        response => {
          this.store['YTPDATA'].new_connections_json = data;
          this._alertservice.success('Supportive relationship details entered successfully!');
        },
        error => {
          this._alertservice.error('Error in entering supportive relationship details!');
        }
      );
  }

  getPlanDetails() {
    this._ytpService.getPermanencyPlanList().subscribe((data) => {

      if(data && data.length) {
        const permanencyplanList = data.filter(item => item.personid == this.ytpData.clientid);
        if (permanencyplanList && permanencyplanList.length) {
         const list = permanencyplanList[0].permanencyplans.filter((item: any) => item.status == "Approved");
         const latestRecord = _.sortBy(list, 'establisheddate').reverse();
         this.checkLatestRecordFn(latestRecord);
        }

      }
    });
  }
  // Associated with getPlanDetails function
  private checkLatestRecordFn(latestRecord: any[]) {
    if (latestRecord && latestRecord.length) {
      this.permanencyPlanId = latestRecord[0]?.primarypermanency[0]?.permanencyplanid;
      this.supportiveFormGroup.patchValue({
        renunification: latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'Reunification' ? true : false,
        adoption: (latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'ADOPTR' || latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'ADOPTNR') ? true : false,
        guardianShip: (latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'GUARDR' || latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'Guardianship') ? true : false,
        plannedPermanent: latestRecord[0]?.primarypermanency[0]?.permanencyplantypekey == 'APPLA' ? true : false,
        concurrentPlan: latestRecord[0]?.concurrentpermanency[0]?.concurrentplandescription ? latestRecord[0].concurrentpermanency[0].concurrentplandescription : ''
      });
    }
  }

  addRelationship() {
    this.relationship.push({ name: '', roles: '', availability: '', contact: '' });
  }

  deleteRelationship(index: any) {
    this.relationship.splice(index, 1);
  }

  addSupport() {
    this.supportiveRelations.push({ name: '', phone: '', address: '' , email: '', relationships: "", supportprovided: "", notes: '' });
  }

  deleteSupport(index: any){
    this.supportiveRelations.splice(index, 1);

  }


  clear() {
    this.supportiveFormGroup.reset();
  }


}
