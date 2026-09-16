import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService } from '../../../../../../../@core/services/data-store.service';
import { DynamicObject, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { AlertService } from '../../../../../../../@core/services/alert.service';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { AuthService } from '../../../../../../../@core/services/auth.service';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'ap-narrative',
    templateUrl: './ap-narrative.component.html',
    standalone: false
})
export class ApNarrativeComponent implements OnInit {
    private id: string;
    apNarrativeForm!: FormGroup;
    store: DynamicObject;
    private childActorId!: string;
    daNumber: string;
    permanencyplanid: string;
    isAdoptionCreated!: boolean;
    displayValidationMessages = false;
    private readonly _formBuilder: FormBuilder;
    private readonly route: ActivatedRoute;
    private readonly _store: DataStoreService;
    private readonly _commonHttp: CommonHttpService;
    private readonly _alertService: AlertService;
    private readonly _router: Router;
    private readonly _PlacementAdoptionService: PlacementAdoptionService;

    constructor(private readonly injector : Injector, private readonly _dataStoreService: DataStoreService, public _authService: AuthService) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);
        this._PlacementAdoptionService = this.injector.get<PlacementAdoptionService>(PlacementAdoptionService);

        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.store = this._store.getCurrentStore();
        const placement_child = this.store['placement_child'];
        this.permanencyplanid = (placement_child) ? placement_child.permanencyplanid : null;
    }

    ngOnInit() {
        if (this.store['permanencyPlan']) {
            this.childActorId = this.store['permanencyPlan'].intakeservicerequestactorid;
        }
        this.apNarrativeForm = this._formBuilder.group({
            adoptiondate: [null, Validators.required],
            narrative: ['', Validators.required]
        });
        this.getNarrative();
        this.getBreaklink();

    }
    private getNarrative() {
        this._commonHttp
            .getSingle(
                new PaginationRequest({
                    where: {
                        permanencyplanid: this.permanencyplanid
                        // intakeserviceid: this.id,
                        // intakeservicerequestactorid: this.childActorId
                    },
                    method: 'get'
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
            )
            .subscribe(res => {
                if (res && res.length && res[0].getadoptionplanning) {
                    this.apNarrativeForm.patchValue(res[0].getadoptionplanning[0]);
                    this._store.setData('adoptionEffort', res[0].getadoptionplanning[0]);
                }
                this.onChanges();
                const unsavedForm = false;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
            });
    }
    private onChanges() {
        this.apNarrativeForm.valueChanges.subscribe(effort => {

            const unsavedForm = true;
            this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);

        });
    }
    addNarrative(nextNavigation: any) {
        if (this.apNarrativeForm.invalid) {
            this.displayValidationMessages =true;
            this.apNarrativeForm.markAllAsTouched();
            return;
        }
        const model = this.apNarrativeForm.value;
        model.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        this._commonHttp.create(model, 'adoptionplanning/updateadoptionnarrative').subscribe(
            result => {
                this._alertService.success('Adoption Narrative saved successfully!');
                const unsavedForm = false;
                this._PlacementAdoptionService.setAdoptionPlanningData('effort', unsavedForm);
                if (nextNavigation === 'Next') {
                    const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/aca-form';
                    this._router.navigate([redirectUrl]);
                }
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
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
        if(this.apNarrativeForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }

    saveEmotionalTie(_data: any) {
        // No data or function to add or call
    }
}
