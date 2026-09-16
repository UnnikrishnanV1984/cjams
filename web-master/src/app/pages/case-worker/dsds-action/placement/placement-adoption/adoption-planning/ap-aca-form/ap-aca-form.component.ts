import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, AuthService } from '../../../../../../../@core/services';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { CASE_STORE_CONSTANTS } from '../../../../../_entities/caseworker.data.constants';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { environment } from '../../../../../../../../environments/environment';
@Component({
    selector: 'ap-aca-form',
    templateUrl: './ap-aca-form.component.html',
    standalone: false
})
export class ApAcaFormComponent implements OnInit {
  clientIDInput: any;
  removalIDInput : any ;
  hasAdoptionApplicabilityInf!: boolean;
  id: any;
  daNumber: any;
  child: any;

  //Disabling send to supervisor in prod and enabling it in all other environments, temporarily till IV-E goes live
  productionEnv: any;

  @ViewChild('childassessment') childassessment!: any;
  constructor( private _commonHttp: CommonHttpService, private route: ActivatedRoute,
    private _router: Router,
    private _dataStoreService: DataStoreService,
    //private viewContainerRef: ViewContainerRef,
    private _placementAdoptionService: PlacementAdoptionService,
    public _authService: AuthService) { }

  ngOnInit() {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.clientIDInput = this._dataStoreService.getData('childforGAP');
    this.removalIDInput = this._dataStoreService.getData('childremovalid');
    this._dataStoreService.setData('adoption_clientid',this.clientIDInput);
    this._dataStoreService.setData('adoption_removalid',this.removalIDInput);
    this.productionEnv = environment.title4eProduction;
    this.hasAdoptionApplicabilityInfo();
  }

  saveData(){
    this.childassessment.saveData();
    this.childassessment.saveAlertmessage = true;
  }

  bypassIVE(){
    this.childassessment.saveData();
    const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/checklist';
    this._router.navigate([redirectUrl]);
    //Added to replicate the flow, value doesn't seemed to be used anywhere
    this._placementAdoptionService.broadStoreDataPatched('TPRRecommend');
  }

  sendToIVE() {
    this._dataStoreService.setData('adoption_sendtoive', true);
    this.childassessment.disablesendtosupervisor = true;
    this.childassessment.saveAlertmessage = false;
    this.childassessment.saveData();
    this._commonHttp.create({ ivestatus: 'REVIEW',
      clientId:this.clientIDInput,
    removalId:this.removalIDInput},
      'iveadoption/updatestatus'
    ).subscribe();
  }

  hasAdoptionApplicabilityInfo(){
    if(this.hasAdoptionApplicabilityInf){
      return true;
    }else{
      return this._dataStoreService.getData('hasAdoptionApplicabilityInfo');
    }
  }

  /*
  bypassIVE(){
    this.viewContainerRef[ '_data' ].componentView.component.
    viewContainerRef[ '_view' ].viewContainerParent.parent.viewContainerParent.component.bypassIVE = true;
    this._placementAdoptionService.broadStoreDataPatched('TPRRecommend');
  }
  */
}
