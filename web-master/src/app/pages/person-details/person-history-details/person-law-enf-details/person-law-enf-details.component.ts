import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { LegalActionHistoryService } from './legal-action-history.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';
import { Subscription } from 'rxjs';
import { IntakeUtils } from '../../../_utils/intake-utils.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-law-enf-details',
    templateUrl: './person-law-enf-details.component.html',
    styleUrls: ['./person-law-enf-details.component.scss'],
    standalone: false
})
export class PersonLawEnfDetailsComponent implements OnInit, OnDestroy {

  legalActionsHistories: any = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  personSubscribtion!: Subscription;
  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private _service: LegalActionHistoryService,
    private personService: PersonDetailsService,
    private _intakeUtils: IntakeUtils) {
    this.listenPersonStatus();

  }

  ngOnInit() {
     this.loadLegalActionsHistory();
  }

  private listenPersonStatus() {

    this.personSubscribtion = this.personService.personStatus$.subscribe(status => {
      this.loadLegalActionsHistory();
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadTable();
  }

  private loadTable() {
    const params = { personid: this.personService.person.personid, foldersearch: null, statussearch: null, personstatus: this.personService.personStatus };
    this.paginationInfo.where = params;
    this._service.getLegalActionHistory(this.paginationInfo).subscribe(response => {
      this.legalActionsHistories = response;
      if (this.legalActionsHistories.length) {
        this.totalRecords = this.legalActionsHistories[0].totalcount;
      }
    });
  }

  private loadLegalActionsHistory() {
    // load data
    this.paginationInfo.pageNumber = 1;
      this.paginationInfo.pageSize = 10;
      this.pageChanged(this.paginationInfo);
  }

  openComplaintDetail(item: any) {
    this.router.navigate(['../complaint-detail/' + item.intakeservicerequestevaluationid], { relativeTo: this.route });
  }

  openIntake(item: any) {
    if (this.personService.isEditable) {
      this._intakeUtils.redirectIntake(item.intakenumber, 'edit');
    } else {
      this._intakeUtils.redirectIntake(item.intakenumber, 'view');
    }
  }

  openCase(item: any) {
    if (this.personService.isEditable) {
      this._intakeUtils.redirectToCase(item.intakeserviceid, item.servicerequestnumber, 'edit');
    } else {
      this._intakeUtils.redirectToCase(item.intakeserviceid, item.servicerequestnumber, 'view');
    }
  }

  ngOnDestroy() {
    this.personSubscribtion.unsubscribe();
  }
}
