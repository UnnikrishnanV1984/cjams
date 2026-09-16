import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';

import { DynamicObject } from '../../../../../../@core/entities/common.entities';
import { CommonHttpService, SessionStorageService, AuthService } from '../../../../../../@core/services';
import { AlertService } from '../../../../../../@core/services/alert.service';
import { DataStoreService } from '../../../../../../@core/services/data-store.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { TprRecommendation } from '../_entities/adoption.model';
import { DSDS_STORE_CONSTANTS } from '../../../dsds-action.constants';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { PlacementAdoptionService } from '../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import _ from 'lodash';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-tpr-recomendation',
    templateUrl: './adoption-tpr-recomendation.component.html',
    styleUrls: ['./adoption-tpr-recomendation.component.scss'],
    standalone: false
})
export class AdoptionTprRecomendationComponent implements OnInit {
    recommendedForm!: FormGroup;
    tprRecommendation!: TprRecommendation;
    private id: string;
    reasonTypeDropDown!: any[];
    childActorId!: string;
    permanencyPlanId!: string;
    private store: DynamicObject;
    isSupervisor!: boolean;
    isCourtHearingOccurs = false;
    roleId!: AppUser;
    isSaved!: boolean;
    child15to22CheckboxChanged = false;
    caseCreated!: boolean;
    checkrequired= false;
    private readonly _commonHttp: CommonHttpService;
    private readonly _alert: AlertService;
    private readonly route: ActivatedRoute;
    private readonly _store: DataStoreService;
    private readonly _session: SessionStorageService;
    public _authService: AuthService;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;
    
    constructor(private readonly _formBuilder: FormBuilder, private readonly injector : Injector, private readonly _dataStoreService: DataStoreService) {
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alert = this.injector.get<AlertService>(AlertService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.roleId = this._authService.getCurrentUser();
        this.initializeForm();
        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
            if (data === 'TPRRecommend') {
        this.ValidateStoreValues();
          }
        });
        this.getReasonTypeDropDown();
        this.caseCreated = this._dataStoreService.getData('adoption_case_created');
    }
    ValidateStoreValues() {
        if (this.store['placement_child']) {
            this.childActorId = this.store['placement_child'].intakeservicerequestactorid;
            this.permanencyPlanId = this.store['placement_child'].permanencyplanid;
        }
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.id = this.store['CASEUID'];
            this.permanencyPlanId = this.store['PERMANENCY_PLAN_ID'];
        }
        this.tprRecommendation = this.store['TPRRecommendationList'];
        if (this.tprRecommendation) {
            this.tprRecommendation.tprlist = _.sortBy(this.tprRecommendation.tprlist,'description');
            this.recommendedForm.patchValue(this.tprRecommendation);
            if (this.tprRecommendation.tprrecommendationid) {
                this.recommendedForm.patchValue({ isrecommended: '' + this.tprRecommendation.isrecommended });
                this.recommendedForm.disable();
            } else {
                this.recommendedForm.enable();
            }
            this.getRecommendedList();
        } else {
            this.getRecommendedList();
        }
    }
    onTprChecklistChange(event: any, index: any) {
        if(this.tprRecommendation.tprlist[index].checklistid === '24b96c2b-6a6a-4f5c-aaab-1b702fd5e549'){
            this.child15to22CheckboxChanged = !this.child15to22CheckboxChanged; }
        this.tprRecommendation.tprlist[index].isvalidated = event.checked ? 1 : 0;
    }
    saveRecommendation() {
        this.checkrequired  =true;
        if(this.recommendedForm.valid){
        if (this.tprRecommendation.tprlist && this.tprRecommendation.tprlist.length) {
            const isChecklistPending = this.tprRecommendation.tprlist.filter(item => item.isvalidated === 0)
            .filter(tpr => (tpr.checklistid !== 'a5178100-d87e-4aa0-b730-cff58f28f4d4' && tpr.checklistid !== '99817c6c-efe1-43eb-b390-efed9251a0f5'
                                && tpr.checklistid !== '24b96c2b-6a6a-4f5c-aaab-1b702fd5e549'));
            if (!isChecklistPending.length) {
                const validateRecommended: any[] = [];
                this.tprRecommendation.tprlist.forEach(rec => {
                    validateRecommended.push({
                        checklistid: rec.checklistid,
                        isselected: rec.isvalidated
                    });
                });
                const recInput = this.recommendedForm.value;
                if (this.tprRecommendation.tprrecommendationid) {
                    recInput.tprrecommendationid = this.tprRecommendation.tprrecommendationid;
                }
                recInput.tprrecommendationchecklist = validateRecommended;
                recInput.intakeserviceid = null;
                recInput.servicecaseid = this.id;
                recInput.intakeservicerequestactorid = this.childActorId;
                recInput.permanencyplanid = this.permanencyPlanId;
                recInput.child15to22CheckboxChanged = this.child15to22CheckboxChanged;
                this._commonHttp.create(recInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.TprRecommendationAdd).subscribe(success => {
                    this.recommendedForm.reset();
                    this.getRecommendedList();
                    this._alert.success('TPR Recommended Successfully!');
                    this.child15to22CheckboxChanged = false;
                });
            } else {
                this._alert.error('Checklist Not Satisfied');
            }
        }
        else{
            this._alert.error('Please fill all required fields');
        }   
        }
    }
    private getRecommendedList() {
           this.isCourtHearingOccurs = false;
           this._PlacementAdoptionService.getRecommendedList(this.id, this.permanencyPlanId)
            .subscribe(res => {
                if (res.tprrecommendationid) {
                    this.isSaved = true;
                    this._store.setData('TPRRecommendationId', res.tprrecommendationid);
                    this.recommendedForm.disable();
                    this.recommendedForm.patchValue(res);
                    this.recommendedForm.patchValue({ isrecommended: '' + res.isrecommended });
                } else {
                    this.recommendedForm.enable();
                }
                this.tprRecommendation = res;
                if(this.tprRecommendation && this.tprRecommendation.tprlist) {
                    this.tprRecommendation.tprlist = _.sortBy(this.tprRecommendation.tprlist,'description');
                    const tprList = this.tprRecommendation.tprlist;
                    if(tprList.length && Array.isArray(tprList)){
                        tprList.forEach(tpr => {
                            if(tpr.checklistname === 'courthearing' && tpr.isvalidated === 1) {
                               this.isCourtHearingOccurs = true;
                            }
                        });
                    }
                }
                this._store.setData(DSDS_STORE_CONSTANTS.TPR_RECOMENDATION_LIST, res.tprlist);
            });
    }

    private initializeForm() {
        this.recommendedForm = this._formBuilder.group({
            isrecommended: [null],
            remarks: [null],
            reasontypekey: [null, [Validators.required]]
        });
    }

    getReasonTypeDropDown() {
               this._PlacementAdoptionService.getReasonTypeDropDown(23, 'CW').subscribe( data => {
                    this.reasonTypeDropDown = data;
                });
    }

    restictTabAccess() {
    this._PlacementAdoptionService.setTabAccess(false);
    }

    isCheckboxDisabled(checklistname: any) {
        if(checklistname === 'childplacement' && !this.caseCreated){
            return false;
        }else if (this.isSaved){
            return true;
        }else if (checklistname === 'Unknownparent'){
            return false;
        }else{
            return true;}
    }
}