import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthService, AlertService, DataStoreService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { ServiceCasePlacementsService } from '../service-case-placements.service';
import moment from 'moment';


@Component({
    selector: 'placment-wrapper',
    templateUrl: './placment-wrapper.component.html',
    standalone: false
})
export class PlacmentWrapperComponent implements OnInit {

  decidedPage!: string | null;
  LIVING_ARRANGEMENT = 'LR';
  PLACEMENT_REFERRAL = 'PR';
  isSupervisor = false;
  isCaseWorker = false;
  isChildSelected = false;
  constructor(private router: Router, private route: ActivatedRoute,
    private _authService: AuthService,
    private _alertService: AlertService,
    private _dataStoreService: DataStoreService,
    private _service: ServiceCasePlacementsService) { }

  ngOnInit() {
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this._service.childSelection$.subscribe(_ => {
      if (this._service.selectedChildren.length > 0) {
        this.isChildSelected = true;
      }
    });
  }
  decidePage(_event: any) {
    if (this.decidedPage === this.LIVING_ARRANGEMENT) {
        this.router.navigate(['living-arrangement'], { relativeTo: this.route });  
    } else if (this.decidedPage === this.PLACEMENT_REFERRAL) {
      if (this._service.selectedChildren) {
        const activePlacementChildren = this._service.selectedChildren.filter(child => child.hasActivePlacement);
        const anyGapsinPlacements = this.getPlacementGaps();

        if (!this.isChildRemoved() && !anyGapsinPlacements) {
          (<any>$('#noChildRemovalAlert')).modal('show');
          setTimeout(() => {
            this.decidedPage = null;
          }, 100);
        } else if ((activePlacementChildren.length > 0 && !anyGapsinPlacements) || (anyGapsinPlacements)) {
          this._dataStoreService.setData('isOutOfSequencePlacement', true);
          this.router.navigate(['referral'], { relativeTo: this.route });
        } else {
          this._dataStoreService.setData('isOutOfSequencePlacement', false);
          this.router.navigate(['referral'], { relativeTo: this.route });
        }
      }
    }
  }

  getPlacementGaps() {
    let anyGapsinPlacements = false;
    let activeremovals ;
    if(this._service.selectedChildren.length && this._service.selectedChildren[0].childremoval &&  this._service.selectedChildren[0].childremoval.length) {
      activeremovals = this._service.selectedChildren[0].childremoval.filter((cd: { exitdate: null; }) => cd.exitdate === null);
    }
    if (this._service.selectedChildren.length && this._service.selectedChildren[0].placements && this._service.selectedChildren[0].childremoval && this._service.selectedChildren[0].childremoval.length && !(activeremovals && activeremovals.length >0)) {
      const clientplacementdetails = this._service.selectedChildren[0].placements.filter((menu: { placementtypekey: string; isvoided: number; }) => menu.placementtypekey === 'PRPL' && menu.isvoided !== 1);
      const sortorderchanges = clientplacementdetails.sort((a: { startdate: any; }, b: { startdate: any; }) => moment(a.startdate).format('YYYY-MM-DD').localeCompare(moment(b.startdate).format('YYYY-MM-DD'))).reverse();
      anyGapsinPlacements = this.checkPlacementGaps(sortorderchanges);
    }
    return anyGapsinPlacements;
  }

  checkPlacementGaps(sortorderchanges: any) {
    let anyGapsinPlacements = false;
    for (let i = 0; i < sortorderchanges.length; i++) {
      const stdate = moment(sortorderchanges[i].startdate, "YYYY-MM-DD H:m:s a");
      let endDate;
      let resultdt;
      if (i !== sortorderchanges.length - 1) {
        endDate = moment(sortorderchanges[i + 1].enddate, "YYYY-MM-DD H:m:s a");
      }
      if (endDate && stdate) {
        resultdt = endDate.diff(stdate, 'days');
      }
      if (resultdt && resultdt < 0) {
        anyGapsinPlacements = true;
      }
    }
    return anyGapsinPlacements;
  }

  
  isChildRemoved() {
    let flag = false;
    const noremovaldate = this._service.selectedChildren.filter(child => child.removaldate === null);
    const chldrmvl = this._service.selectedChildren.map(cd => cd.childremoval);
    const childrmvlstatus = this._service.selectedChildren?.some(chld => chld.childremoval?.some((removal: { approvalstatus: string; }) => removal.approvalstatus === 'Rejected'));
    let rem = '';
    if (!noremovaldate || noremovaldate.length == 0) {
      if (chldrmvl && chldrmvl.length > 0 && chldrmvl[0] && !childrmvlstatus) {
        for(let element of chldrmvl) {
          rem = element.filter((cd: { exitdate: null; }) => cd.exitdate === null);
          if (rem.length === 0) {
            break;
          }
        }
      }
    }
    if (rem.length > 0) {
      flag = true;
    }

    return flag;
  }

  goBack() {
    this._service.getChildRemovalInfoAndPlacements().subscribe(response => {
      this._service.broadCastPageRefresh();
      this.router.navigate(['../list'], { relativeTo: this.route });
    });
  }

}
