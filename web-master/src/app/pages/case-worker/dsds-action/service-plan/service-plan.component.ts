import { Subject ,  Observable  } from 'rxjs';
import { AddActivity } from './_entities/service-plan.model';
import { Component, OnInit, Input } from '@angular/core';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { SessionStorageService, DataStoreService, AuthService } from '../../../../@core/services';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { FormGroup, FormBuilder } from '@angular/forms';
import { AlertService } from '../../../../@core/services/alert.service';
import { ActivatedRoute } from '@angular/router';
import { ServicePlanResolverService } from './service-plan-resolver-service';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'service-plan',
    templateUrl: './service-plan.component.html',
    styleUrls: ['./service-plan.component.scss'],
    standalone: false
})
export class ServicePlanComponent implements OnInit {
  isServiceCase!: boolean;
  id: any;
  servicePlans$!: Observable<any[]>;
  servicePlansCount$!: Observable<number>;
  addNewService!: FormGroup;
  clientProgramNames$!: Observable<DropdownModel[]>;
  agencyServiceNames$!: Observable<DropdownModel[]>;
  frequencyCds$!: Observable<DropdownModel[]>;
  durationCds$!: Observable<DropdownModel[]>;
  personInvolved$!: Observable<DropdownModel[]>;

  @Input()
  activityPlanActivityiId!: string;
  // @Input()
  // activityPlanActivityi: string;
  @Input()
  editServicePlanOutputSubject$ = new Subject<AddActivity | null>();
  moduleview: any;
  isCpsIRorAR!: boolean;
  constructor(
    private _session: SessionStorageService, 
    private _datastore: DataStoreService,
    private _alertService: AlertService,
    public _authService: AuthService,
    private route: ActivatedRoute,
    private formBuilder: FormBuilder,private servicePlanResolverService: ServicePlanResolverService) {
    //   this.route.data.subscribe(data => {
    //     if (data && data.hasOwnProperty('result')) {
    //       _authService.setAuthDetail('services',data.result);
    //     }
    // });
     }

  ngOnInit() {
    this.servicePlanResolverService.getServices().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail('services',data);
        }
    })
    this.moduleview = this._authService.isModuleAccessable('services', 'services');
    this.isServiceCase = this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const caseInfo = this._datastore.getData('dsdsActionsSummary');
    if (caseInfo && (caseInfo.da_subtype === 'CPS-IR' || caseInfo.da_subtype === 'CPS-AR')) {
      this.isCpsIRorAR = true;
      
    }
    if (this.isServiceCase || this.isCpsIRorAR) {
      this.formInitialize();
    }
  }
  private formInitialize() {
    this.addNewService = this.formBuilder.group(
      {
        intakeservicerequestactorid: [''],
        clientprogramnameid: [''],
        servicetypeid: [''],
        frequencyCdId: [''],
        durationCdId: [''],
        estbegindate: [''],
        actbegindate: [''],
        estenddate: [''],
        actenddate: [''],
        actbegintime: [''],
        actendtime: [''],
        agencynotes: ['']
      });
  }
editServicePlan(ativity: AddActivity) {
    this.activityPlanActivityiId = ativity.serviceplanactivityid;
    ativity.isAddEdit = 'view';
    this.editServicePlanOutputSubject$.next(ativity);
}

addAgency() {
  $('#add-newagencyprovider').modal('hide');
  this._alertService.success('Added successfully.');
}

}
