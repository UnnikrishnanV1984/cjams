import { Component, OnInit, OnDestroy } from '@angular/core';
import { PlacementSummaryService } from './placement-summary.service';
import { Router, ActivatedRoute } from '@angular/router';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { Subscription } from 'rxjs';
import { PersonDetailsService } from '../../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-summary',
    templateUrl: './placement-summary.component.html',
    styleUrls: ['./placement-summary.component.scss'],
    standalone: false
})
export class PlacementSummaryComponent implements OnInit, OnDestroy {

  placementList: any[] = [];
  statusList = [
    {
      key: 'open',
      value: 'Open'
    },
    {
      key: 'closed',
      value: 'Closed'
    },
    {
      key: 'all',
      value: 'All'
    }
  ];
  status!: string;
  personid: string | null | undefined;
  totalRecords!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  personSubscribtion!: Subscription;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: PlacementSummaryService,
    private _personDetail: PersonDetailsService) {
    this.route.data.subscribe(response => {
      this.placementList = response.placementList.data;
      if (this.placementList.length > 0) {
        this.totalRecords = this.placementList[0].totalcount;
      }
    });
    this.personid = route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
  }

  ngOnInit() {
    this.status = 'all';
    this.listenPersonStatus();
  }
  private listenPersonStatus() {
    this.personSubscribtion = this._personDetail.personStatus$.subscribe((status: any) => {
      this.pageChanged({ page: 1 });
    });
  }

  loadPlacementSummary() {
    this.paginationInfo.where = { personid: this.personid, personstatus: this._personDetail.personStatus };
    this._service.getPlacementSummaryList(this.status, this.paginationInfo).subscribe(res => {
      this.placementList = res.data;
      if (this.placementList.length > 0) {
        this.totalRecords = this.placementList[0].totalcount;
      }
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadPlacementSummary();
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }
  ngOnDestroy() {
    this.personSubscribtion.unsubscribe();
  }
}
