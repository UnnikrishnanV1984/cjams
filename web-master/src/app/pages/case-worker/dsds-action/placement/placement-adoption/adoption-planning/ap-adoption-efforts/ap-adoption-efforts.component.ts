
import {map} from 'rxjs/operators';
import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, Validators, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { DynamicObject, DropdownModel, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { DataStoreService, AuthService } from '../../../../../../../@core/services';
import { AlertService } from '../../../../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { EffortDetail } from '../_entities/adoption-planning.model';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { Observable } from 'rxjs';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'ap-adoption-efforts',
    templateUrl: './ap-adoption-efforts.component.html',
    styleUrls: ['./ap-adoption-efforts.component.scss'],
    standalone: false
})
export class ApAdoptionEffortsComponent implements OnInit {
    effortForm!: FormGroup;
    planningForm!: FormGroup;
    id: string;
    daNumber: string;
    store: DynamicObject;
    effortDetail: EffortDetail[] = [];
    private childActorId: string;
    effortTypes$!: Observable<DropdownModel[]>;
    permanencyplanid: string;
    selectedEffort?: { index: number; action: string };
    unsavedForm!: boolean;
    isAdoptionCreated!: boolean;
    isEditDisabled = false;
    displayValidationMessages = false;

    private readonly _formBuilder: FormBuilder;
    private readonly _store: DataStoreService;
    private readonly _commonHttp: CommonHttpService;
    private readonly route: ActivatedRoute;
    private readonly _alert: AlertService;
    private readonly _router: Router;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;

    constructor(private readonly injector : Injector, private readonly _dataStoreService: DataStoreService, public _authService: AuthService) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alert = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.store = this._store.getCurrentStore();
        const placement = this.store['placement_child'];
        this.permanencyplanid = (placement) ? placement.permanencyplanid : null;
        this.childActorId = (placement) ? placement.intakeservicerequestactorid : null;
    }

    ngOnInit() {
        this.isEditDisabled = this._authService.isDisabled('adoptionplanning','adoptionplanning.planning.effortsedit');
        this.initializeForm();
        this.loadDropdown();
        this.effortListing();
        this.getBreaklink();
        this.planningForm.get('isnoeffort')?.valueChanges.subscribe(effort => {
            if (effort && (!this.effortDetail || !this.effortDetail.length)) {
                (<any>$('#info-pop')).modal('show');
            }
        });

    }
    manageEffort(action: string, i?: any) {
        this.displayValidationMessages =false;
        this.effortForm.get('effortdate')?.clearValidators();
        this.effortForm.get('effortdate')?.updateValueAndValidity();
        this.effortForm.enable();
        this.effortForm.reset();
        this.selectedEffort = {
            index: i,
            action: action
        };
        (<any>$('#manage-effort')).modal('show');
        if (action !== 'Add') {
            this.effortForm.patchValue(this.effortDetail[i]);
        }
        if (action === 'View') {
            this.effortForm.disable();
        }
    }

    onEffortTypeChange(event: any) {
        this.effortForm.patchValue({ description: '' });
    }

    saveEffort() {
        this.displayValidationMessages =false;
        this.effortForm.get('effortdate')?.setValidators([Validators.required]);
        this.effortForm.get('effortdate')?.updateValueAndValidity();
        if (this.effortForm.invalid) {
            this.displayValidationMessages =true;
            this.effortForm.markAllAsTouched();
            return;
        }
        if (!this.selectedEffort?.index && this.selectedEffort?.index !== 0) {
            this.effortDetail.push(this.effortForm.value);
        } else if (this.selectedEffort?.index || this.selectedEffort?.index === 0) {
            this.effortDetail[this.selectedEffort?.index] = this.effortForm.value;
        }
        this.unsavedForm = true;
        this._PlacementAdoptionService.setAdoptionPlanningData('effort', this.unsavedForm);
        (<any>$('#manage-effort')).modal('hide');
        this.effortForm.reset();
    }
    saveAdoption(nextNavigation: any) {
        if (this.validateEffort()) {
            const adoptionEffortInput = Object.assign(this.planningForm.value);
            if (this.effortDetail && this.effortDetail.length) {
                adoptionEffortInput.adoptionefforts = this.effortDetail;
            }
            adoptionEffortInput.intakeserviceid = null;
            adoptionEffortInput.servicecaseid = this.id;
            adoptionEffortInput.permanencyplanid =  this.permanencyplanid;
            adoptionEffortInput.intakeservicerequestactorid = this.childActorId ? this.childActorId : null;
            if (!adoptionEffortInput.adoptionplanningid) {
                delete adoptionEffortInput.adoptionplanningid;
            }
            adoptionEffortInput.isnoeffort = adoptionEffortInput.isnoeffort ? 1 : 0;
            adoptionEffortInput.isexceptiongranted = adoptionEffortInput.isexceptiongranted ? 1 : 0;
            this._commonHttp.create(adoptionEffortInput, CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortAdd).subscribe(
                res => {
                    //When saving data for the first time, the api has been changed to return the adoptionplanningid
                    //This can be used so that next save will update the same record instead of creating a new one.
                    this.handleAdoptionEffortAddRespFn(adoptionEffortInput, res, nextNavigation);
                },
                err => {
                    this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
        }
    }
    // Assosiated with saveAdoption method
    private handleAdoptionEffortAddRespFn(adoptionEffortInput: any, res: any, nextNavigation: any) {
        if (!adoptionEffortInput.adoptionplanningid) {
            this.planningForm.patchValue({ 'adoptionplanningid': res });
        }
        this._alert.success('Adoption Effort saved successfully');
        this.unsavedForm = false;
        this._PlacementAdoptionService.setAdoptionPlanningData('effort', this.unsavedForm);
        if (nextNavigation === 'Next') {
            const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/emotion-ties';
            this._router.navigate([redirectUrl]);
        } else {
            this.unsavedForm = false;
            this._PlacementAdoptionService.setAdoptionPlanningData('effort', this.unsavedForm);
        }
    }

    private validateEffort() {
        if (!((this.planningForm.value.isnoeffort) || (this.effortDetail.length) ||
                (this.planningForm.value.isexceptiongranted && this.planningForm.value.dateofexceptiongranted))) {
            this._alert.error('Effort Detail Listing or Exception Granted is empty!');
            return false;
        }
        if (this.planningForm.value.isnoeffort && (!this.planningForm.value.remarks && !this.effortDetail.length)) {
            this._alert.error('Please update notes to proceed!');
            return false;
        } else {
            return true;
        }
    }
    private initializeForm() {
        this.planningForm = this._formBuilder.group({
            isnoeffort: [''],
            remarks: [''],
            isexceptiongranted: [''],
            dateofexceptiongranted: [null],
            adoptionplanningid: [null]
        });
        this.effortForm = this._formBuilder.group({
            notes: [''],
            effortdate: ['', Validators.required],
            efforttype: ['']
        });
    }
    private effortListing() {
        this._commonHttp
            .getSingle(
                new PaginationRequest({
                    where: {
                         permanencyplanid: this.permanencyplanid
                        // intakeserviceid: this.id,
                        //  intakeservicerequestactorid: this.childActorId ? this.childActorId : null
                    },
                    method: 'get',
                    page : 1,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
            )
            .subscribe(res => {
                if (res && res.length && res[0].getadoptionplanning) {
                    this.effortDetail = (res[0].getadoptionplanning[0].adoptioneffortsdetails) ? res[0].getadoptionplanning[0].adoptioneffortsdetails : [];
                    this.planningForm.patchValue(res[0].getadoptionplanning[0]);
                    this._store.setData('adoptionEffort', res[0].getadoptionplanning[0]);
                    this._PlacementAdoptionService.setAdoptionPlanning(res[0].getadoptionplanning[0]);
                }
                this.onChanges();
                const unsavedForm = false;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
            
            });
    }
    private onChanges() {
        this.planningForm.valueChanges.subscribe(effort => {
            // Object.keys(this.planningForm.controls).forEach(key => {
            //     if(this.planningForm.get(key).value() && this.planningForm.get(key).value() !== '') {
            // console.log(key, this.planningForm.get(key).value());
            // if(!this.planningForm.pristine) {
            this.unsavedForm = true;
            this._PlacementAdoptionService.setAdoptionPlanningData('effort', this.unsavedForm);
            // }
            //     }
            //   });
        });
    }
    private loadDropdown() {
        this.effortTypes$ = this._commonHttp
            .getArrayList(
                {
                    where: {
                        referencetypeid: '42',
                        teamtypekey: null
                    },
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Court.hearingoutComeUrl + '?filter'
            ).pipe(
            map(result => {
                return result.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        })
                );
            }));
    }

    private getBreaklink() {
        this._commonHttp
          .getArrayList({
            method: 'get', where: {
              adoptionplanningid: this._PlacementAdoptionService.getAdoptionPlanning().adoptionplanningid
            }
          }, 'adoptionbreakthelink/getadoptionbreakthelink?filter')
          .subscribe(res => {
            if (res && res.length) {
              res.forEach((item) => {
                if(item && item.getadoptionbreakthelink){
                    this.returnBreaklinkFn(item);
                }
              });
            }
          });
      }
      // Assosiated with getBreaklink method
    private returnBreaklinkFn(item: any) {
        return item.getadoptionbreakthelink.map((breaklink: { adoptioncasenumber: any; }) => {
            this.isAdoptionCreated = (breaklink.adoptioncasenumber) ? true : false;
            return breaklink;
        });
    }

      getErrorsMessage(ControlName: any, displayName: any){
        if(this.effortForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }
}
