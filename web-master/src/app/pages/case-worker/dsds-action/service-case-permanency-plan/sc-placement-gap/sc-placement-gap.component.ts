import { Component, OnInit } from '@angular/core';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { Placement, InvolvedPerson } from '../../service-plan/_entities/service-plan.model';
import { Observable } from 'rxjs';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ServiceCasePermanencyPlanService } from '../service-case-permanency-plan.service';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    selector: 'sc-placement-gap',
    templateUrl: './sc-placement-gap.component.html',
    styleUrls: ['./sc-placement-gap.component.scss'],
    standalone: false
})
export class ScPlacementGapComponent implements OnInit {
  paginationInfo: PaginationInfo = new PaginationInfo();
  id: string;
  placement: Placement[];
  permanencyPlanList: any;
  cjamsPid: string;
  isSelectChild = false;
  selectedChild: InvolvedPerson;
  involevedPerson$: Observable<InvolvedPerson[]>;
  childForm: FormGroup;
  private daNumber: string;
  constructor(private _formBuilder: FormBuilder, private _httpService: CommonHttpService, private route: ActivatedRoute, private _dataStoreService: DataStoreService,
      private _ServiceCasePermanencyPlanService: ServiceCasePermanencyPlanService,
      private _router: Router) {}

  ngOnInit() {
      this.childForm = this._formBuilder.group({
          selectchild: ['']
      });

      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
      this.getPlacement(1);
      this._ServiceCasePermanencyPlanService.getPermanencyPlanList(1, 10).subscribe(data => {
          this.permanencyPlanList = data;
          this.checkforChildId();
      });
  }

  checkforChildId() {
      this.cjamsPid = this._dataStoreService.getData('childforGAP');
  }
  getPlacement(page: number) {
      this._httpService
          .getPagedArrayList(
              new PaginationRequest({
                  page: page,
                  limit: 50,
                  where: {
                      intakeserviceid: this.id,
                      casenumber: this.daNumber
                  },
                  method: 'get'
              }),
              CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fostercarereferallistUrl + '?filter'
          )
          .subscribe(res => {
              this.placement = res.data;
              if (this.placement && this.placement.length) {
                  this.childForm.patchValue({
                      selectchild: this.placement[0]
                  });
                  this.selectChild({ value: this.placement[0] });
              }
          });
  }
  selectChild(modal) {
      if (modal.value) {
          this._dataStoreService.setData('placement_child', modal.value);
          this.selectedChild = modal.value;
          this.isSelectChild = true;
      }
  }

  isGAPApproved(child) {
      this.cjamsPid = this._dataStoreService.getData('childforGAP');
      let status = false;
      if (child) {
          if ( child.cjamspid &&  child.cjamspid === this.cjamsPid) {
              status = true;
          }
      }

      // For GAP Approval Check
      // if (child && child.permanencyplans && child.permanencyplans.length) {
      //     const permanencyPlan = child.permanencyplans;
      //     permanencyPlan.forEach(plan => {
      //          if (plan.status === 'Approved' && plan.primarypermanency && plan.primarypermanency.length && plan.primarypermanency[0].permanencyplantypekey  === 'Guardianship') {
      //            status = true;
      //          }
      //     });
      // }
      return status;
  }

}

