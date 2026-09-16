import { Component, OnInit,Input } from '@angular/core';

import { CommonHttpService } from '../../../@core/services';
  import { PaginationRequest } from '../../../@core/entities/common.entities';

@Component({
    selector: 'approval-history',
    templateUrl: './approval-history.component.html',
    styleUrls: ['./approval-history.component.scss'],
    standalone: false
})
export class ApprovalHistoryComponent implements OnInit {

  @Input()
  assessmentId!: string;
  assesment: any[] =[];
  constructor(private _commonService: CommonHttpService,) { }

  ngOnInit(): void {
    this.getapprovalhistory(this.assessmentId)
  }


  getapprovalhistory(assessmentid:any) {
    this._commonService.getPagedArrayList(
      new PaginationRequest({
        limit: 30,
        page: 1,
        method: 'get',
        where: { 
            assessmentid: assessmentid
      }

      }),
      'servicecase/getapprovalhistory?filter').subscribe((result) => {
        if (result && result.data) {
            this.assesment = result.data;
        }
    });
}

}
