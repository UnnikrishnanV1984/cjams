import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { ServiceCasePermanencyPlanService } from './service-case-permanency-plan.service';
import { FormGroup } from '@angular/forms';

@Component({
    selector: 'service-case-permanency-plan',
    templateUrl: './service-case-permanency-plan.component.html',
    styleUrls: ['./service-case-permanency-plan.component.scss'],
    standalone: false
})
export class ServiceCasePermanencyPlanComponent implements OnInit {

  childList = [];
  permanencyPlanList = [];
  accountpayableList = [];
  placementList = [];
  selectedChildren!: any[];
  selectedChild: any;
  id!: string;
  permanencyType: any;
  primaryPlanSubType: any;
  isAppla!: boolean;
  permanencyPlanForm!: FormGroup;
  personsInvolved: any;
  placementchk: any;
  paginationInfo: PaginationInfo = new PaginationInfo();
  moduleview: any;
  constructor(private _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService,
    private commonHttpService: CommonHttpService,
    private route: ActivatedRoute,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService) {
    this.route.data.subscribe(data => {
      if (data && data.hasOwnProperty('result')) {
        _authService.setAuthDetail('permanencyplan', data.result);
      }
    });
  }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('permanencyplan', 'permanencyplan');
    this.id = this._dataStoreService.getData('CASEUID');
    this.childList = this._serviceCasePermanencyPlanService.placementList;
    this._serviceCasePermanencyPlanService.refresh$.subscribe(_ => {
      this.childList = this._serviceCasePermanencyPlanService.placementList;
      this.permanencyPlanList = this._serviceCasePermanencyPlanService.permanencyPlanList;
    });
    this.selectedChildren = this._serviceCasePermanencyPlanService.selectedChildren;

    this.loadInvolvedPersons();
  }


  private loadInvolvedPersons() {

    this.commonHttpService
        .getPagedArrayList(
            {
                method: 'get',
                where: { intakeservreqid: this.id }
            },
            'Intakeservicerequestactors/GetPersonList' + '?data'
        )
        .subscribe(res => {
            this.personsInvolved = res.data;
        });
}




}
