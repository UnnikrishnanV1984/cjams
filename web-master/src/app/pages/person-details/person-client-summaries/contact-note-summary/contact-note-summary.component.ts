import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { ContactNoteSummaryService } from './contact-note-summary.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';
import { Subscription } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'contact-note-summary',
    templateUrl: './contact-note-summary.component.html',
    styleUrls: ['./contact-note-summary.component.scss'],
    standalone: false
})
export class ContactNoteSummaryComponent implements OnInit, OnDestroy {
  totalRecords!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  contactNotes: any[] = [];
  personid: string | null | undefined;
  personStatus: any;
  personSubscribtion!: Subscription;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: ContactNoteSummaryService,
    private _personDetail: PersonDetailsService) {
    this.route.data.subscribe(response => {
      this.contactNotes = response.contactNotes;
      if (this.contactNotes.length > 0) {
        this.totalRecords = this.contactNotes[0].totalcount;
      }
    });
    this.personid = route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.personStatus = this._personDetail.personStatus;
  }
  ngOnInit() {
    this.listenPersonStatus();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.where = { personid: this.personid, personstatus: this.personStatus };
    this._service.getContactNoteSummaryList(this.paginationInfo).subscribe(response => {
      this.contactNotes = response;
      if (this.contactNotes.length > 0) {
        this.totalRecords = this.contactNotes[0].totalcount;
      }
    });
  }

  private listenPersonStatus() {
       this.personSubscribtion = this._personDetail.personStatus$.subscribe(status => {
      this.personStatus = status;
      this.pageChanged({ page: 1 });
    });
  }

  ngOnDestroy() {
    this.personSubscribtion.unsubscribe();
  }

}
