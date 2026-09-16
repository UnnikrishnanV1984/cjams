import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { OffenseSummaryService } from './offense-summary.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'offense-summary',
    templateUrl: './offense-summary.component.html',
    styleUrls: ['./offense-summary.component.scss'],
    standalone: false
})
export class OffenseSummaryComponent {

  offensSummaries: any[] = [];
  totalRecords!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  personid: string | null | undefined;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: OffenseSummaryService) {
    this.route.data.subscribe(response => {
      this.offensSummaries = response.offensSummaries;
      if (this.offensSummaries.length > 0) {
        this.totalRecords = this.offensSummaries[0].totalcount;
      }
    });
    this.personid = route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this._service.getOffenseSummaryList(this.personid, this.paginationInfo).subscribe(response => {
      this.offensSummaries = response;
      if (this.offensSummaries.length > 0) {
        this.totalRecords = this.offensSummaries[0].totalcount;
      }
    });
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }

}
