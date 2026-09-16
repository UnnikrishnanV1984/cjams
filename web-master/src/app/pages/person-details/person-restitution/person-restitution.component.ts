import { Component, OnInit } from '@angular/core';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../@core/services';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-restitution',
    templateUrl: './person-restitution.component.html',
    styleUrls: ['./person-restitution.component.scss'],
    standalone: false
})
export class PersonRestitutionComponent implements OnInit {
  restitutionList: any[] = [];
  totalCount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  personid!: string | undefined | null;

  constructor(private _commonService: CommonHttpService,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.personid = this.route?.snapshot?.parent?.parent?.paramMap.get('personid');
    this.paginationInfo.pageNumber = 1;
    this.loadList();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadList();
  }

  loadList() {
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'get',
        where: {
          restitutionno: null,
          youthpersonid: this.personid
        }
      }),
      CommonUrlConfig.EndPoint.RESTITUTION.RESTITUTION_PAYMENTDETAILS + '?filter'
    ).subscribe((result: any) => {
      if (result) {
        this.restitutionList = result.data;
        this.totalCount = result.data.length ? result.data[0].totalcount : 0;
      }

    });
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }

  resetList() {
    this.restitutionList = [];
    this.totalCount = 0;
  }

}
