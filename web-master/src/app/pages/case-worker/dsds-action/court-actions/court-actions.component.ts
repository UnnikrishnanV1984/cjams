import { Component, OnInit, AfterViewInit } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';

@Component({
    selector: 'court-actions',
    templateUrl: './court-actions.component.html',
    styleUrls: ['./court-actions.component.scss'],
    standalone: false
})
export class CourtActionsComponent implements OnInit, AfterViewInit {
  petitions: any[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  intakenumber!: string;
  totalRecords!: number;
  constructor(private _httpService: CommonHttpService,
    private _datastoreService: DataStoreService, private _authService: AuthService) { }

  ngOnInit() {
    this.intakenumber = this._datastoreService.getData('da_intakenumber');
    this.loadCourtActions();
  }
  ngAfterViewInit() {
      const intakeCaseStore = this._datastoreService.getData('IntakeCaseStore');
      if (this._authService.isDJS() && intakeCaseStore && intakeCaseStore.action === 'view') {
          (<any>$(':button')).prop('disabled', true);
          (<any>$('span')).css({'pointer-events': 'none',
                      'cursor': 'default',
                      'opacity': '0.5',
                      'text-decoration': 'none'});
          (<any>$('i')).css({'pointer-events': 'none',
                                  'cursor': 'default',
                                  'opacity': '0.5',
                                  'text-decoration': 'none'});
          (<any>$('th a')).css({'pointer-events': 'none',
                                  'cursor': 'default',
                                  'opacity': '0.5',
                                  'text-decoration': 'none'});
      }
  }

  loadCourtActions() {
    this._httpService.getArrayList(
      new PaginationRequest({
        page: this.paginationInfo.pageNumber,
        limit: this.paginationInfo.pageSize,
        where: {
          intakenumber: this.intakenumber
        },
        method: 'get'
      }
      ), CaseWorkerUrlConfig.EndPoint.DSDSAction.courtactions.CourtActionsList).subscribe(res => {
        this.petitions = res;
        this.totalRecords = res.length;
      });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadCourtActions();
  }

  toggleTable(id: any) {
    (<any>$('#' + id)).collapse('toggle');
  }

}
