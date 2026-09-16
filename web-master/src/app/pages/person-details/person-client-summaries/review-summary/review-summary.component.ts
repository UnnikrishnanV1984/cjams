import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ReviewSummaryService } from './review-summary.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'review-summary',
    templateUrl: './review-summary.component.html',
    styleUrls: ['./review-summary.component.scss'],
    standalone: false
})
export class ReviewSummaryComponent {
  reviewList: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  personid: string | null | undefined;
  personStatus: string;

  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: ReviewSummaryService,
    private _personDetail: PersonDetailsService) {
    this.route.data.subscribe(response => {
      this.reviewList = response.reviewList;
      if (this.reviewList.length > 0) {
        this.totalRecords = this.reviewList[0].totalcount;
      }
    });
    this.personid = route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.personStatus = this._personDetail.personStatus;
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.where = { personid: this.personid, personstatus: this.personStatus };
    this._service.getReviewSummaryList(this.paginationInfo).subscribe(response => {
      this.reviewList = response;
      if (this.reviewList.length > 0) {
        this.totalRecords = this.reviewList[0].totalcount;
      }
    });
  }

}
