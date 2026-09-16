import { Component, OnInit } from '@angular/core';
import { ServiceCasePermanencyPlanService } from '../service-case-permanency-plan.service';
import { DataStoreService, AuthService, SessionStorageService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Router, ActivatedRoute } from '@angular/router';
import { PlacementConstants } from '../../service-case-placements/constants';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { AppConstants } from '../../../../../@core/common/constants';
import { ChildRemovalService } from '../../child-removal/child-removal.service';
import _ from 'lodash';
import moment from 'moment';
import { environment } from '../../../../../../environments/environment';

@Component({
    selector: 'child-wrapper',
    templateUrl: './child-wrapper.component.html',
    styleUrls: ['./child-wrapper.component.scss'],
    standalone: false
})
export class ChildWrapperComponent implements OnInit {
  childList: any[] = [];
  permanencyPlanList= [];
  accountpayableList = [];
  placementList = [];
  selectedChildren!: any[];
  selectedChild: any;
  id!: string;
  permanencyType: any;
  primaryPlanSubType: any;
  isAppla!: boolean;
  formAction!: string;
  isSuperVisor!: boolean;
  personsInvolved: any;
  placementchk: any;
  isClosed = false;
  list!: any[];
  paginationInfo: PaginationInfo  = new PaginationInfo();
  childSelected: any;
  environment = environment;
  constructor(private _serviceCasePermanencyPlanService: ServiceCasePermanencyPlanService,
    private _childRemovalService: ChildRemovalService,
    private _dataStoreService: DataStoreService,
    private router: Router,
    private storage: SessionStorageService,
    private _authService: AuthService,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this._serviceCasePermanencyPlanService.resetValues();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this._serviceCasePermanencyPlanService.resetValues();
    this._serviceCasePermanencyPlanService.getChildRemovalInfoAndPlacements();
    this.getChildList();
    this.isSuperVisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this.childList.forEach((res: any) => {
      res.fullname = res.prefx + ' ' + res.firstname + ' ' + res.middlename + ' ' + res.lastname + ' ' + res.suffix;
    });
    this.formAction = this._serviceCasePermanencyPlanService.formAction;
    this.selectedChildren = this._serviceCasePermanencyPlanService.selectedChildren;
    const da_status = this.storage.getItem('da_status');
    if (da_status) {
     if (da_status === 'Closed' || da_status === 'Completed') {
         this.isClosed = true;
     } else {
         this.isClosed = false;
     }
    }
  }

  getChildList() {
    this._childRemovalService.getPersonsAndChildRemovalInfo().subscribe(result => {
      this.list = this._childRemovalService.getChildList();
      const childList1: any[] = [];
      this.list.filter(p => (
        !!p.placementList && p.placementList.length && !!p.removalInfo
      )).forEach((child) => {
        child.removalHistory.forEach((element: any) => {
          if (element.servicecaseid == this.id) {
            const placementList = _.orderBy(child.placementList, ['removaldate'], ['desc']);
            if (placementList[0]) {
              const isExist = childList1.filter((item: any) => item == placementList[0]);
              if (isExist.length == 0) {
                const placement = placementList[0];
                placement.isbioadoptedflag = child.isbioadoptedflag;
                placement['intakeservicerequestactorid'] = child.intakeservicerequestactorid;
                childList1.push(placement);
              }
            }
          }
        });
      })
      this.childList = this.setApprovedFlag(childList1);
    });
  }

  setApprovedFlag(list: any) {
    list.forEach((child: { hasActivePlacement: boolean; placements: any; }) => {
      child.hasActivePlacement = false;
      if (Array.isArray(child.placements)) {
        child.hasActivePlacement = this._serviceCasePermanencyPlanService.checkForChildHasProviderPlacements(child.placements);
      }
    });
     return list;
  }
  onChildChecked(event: any, child: any) {
    if(child.isbioadoptedflag === 1){
      this.childSelected = child;
      (<any>$('#bioadoptedflag')).modal('show');
    
    }
   const childExistsInCase  = this.list.find(item => item.personid === child.personid);
   if (childExistsInCase !== null && childExistsInCase !== undefined) {
    this._serviceCasePermanencyPlanService.selectChild(child, event.checked);
   }
  }

  onCheckedChild(child: any) {
    const childExistsInCase  = this.list.find(item => item.personid === child.personid);
    if (childExistsInCase !== null && childExistsInCase !== undefined) {
     this._serviceCasePermanencyPlanService.selectChild(child, false);
    }
   }

  showPlacementDetails(placement: any) {
    this._serviceCasePermanencyPlanService.placementDetails = this._serviceCasePermanencyPlanService.placementList;
    this.router.navigate(['details/' + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });
  }

  isEditForm() {
    return ( this._serviceCasePermanencyPlanService.formAction === 'Edit' ) ;
  }

 getAge(dateValue: any) {
  if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dateValue), 'MM/DD/YYYY').toDate();
      return moment().diff(rCDob, 'years');
  } else {
      return '';
  }
}

}
