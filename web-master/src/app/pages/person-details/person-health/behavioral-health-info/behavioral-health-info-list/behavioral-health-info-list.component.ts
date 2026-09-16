
import {pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { BehaviouralHealthInfo } from '../../../../../@core/common/models/involvedperson.data.model';
import { AlertService } from '../../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
// tslint:disable-next-line:import-blacklist
import { Subject, Observable } from 'rxjs';
import { BehavioralHealthInfoService } from '../behavioral-health-info.service';
import { PersonDetailsService } from '../../../person-details.service';
import { Router, ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'behavioral-health-info-list',
    templateUrl: './behavioral-health-info-list.component.html',
    styleUrls: ['./behavioral-health-info-list.component.scss'],
    standalone: false
})
export class BehavioralHealthInfoListComponent implements OnInit {
  id!: string | null;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageStream$ = new Subject<number>();
  behaviorHealth$ = new Observable<BehaviouralHealthInfo[]>();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  resourceID!: string | null;
  deletebehaviorhealthinfopopup = '#delete-behaviorHealthInfo-popup';

  constructor(private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _behaviorHealthService: BehavioralHealthInfoService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.id = this.route.snapshot.parent?.parent?.parent?.parent?.parent?.params['id'];
    this.pageStream$.subscribe((pageNumber) => {
      this.paginationInfo.pageNumber = pageNumber;
      this.getPage(this.paginationInfo.pageNumber);
    });
    this.getPage(1);
  }

  getPage(page: number) {
    const source = this._behaviorHealthService.getbehaviorHealth(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: this.paginationInfo.pageNumber,
        limit: this.paginationInfo.pageSize,
      }), this.paginationInfo.pageSize);

    this.behaviorHealth$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }

  view(id: string) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'view' }], { relativeTo: this.route });
  }

  edit(id: string) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'edit' }], { relativeTo: this.route });
  }

  showDeletePop(resourceid: any) {
    this.resourceID = resourceid;
    (<any>$(this.deletebehaviorhealthinfopopup)).modal('show');
  }

  delete() {
    this._behaviorHealthService.delete(this.resourceID).subscribe((response: any) => {
        this.getPage(1);
        this.resourceID = null;
        this._alertSevice.success('Behavior Health Information deleted successfully');
        (<any>$(this.deletebehaviorhealthinfopopup)).modal('hide');
      }, (_error: any) => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletebehaviorhealthinfopopup)).modal('hide');
      }
    );
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }

}
