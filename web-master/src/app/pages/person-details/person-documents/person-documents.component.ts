import { Component } from '@angular/core';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonDocumentsService } from './person-documents.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-documents',
    templateUrl: './person-documents.component.html',
    styleUrls: ['./person-documents.component.scss'],
    standalone: false
})
export class PersonDocumentsComponent {

  totalRecords!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  items: any[] = [];
  personid: string | null | undefined;
  constructor(private router: Router,
    private route: ActivatedRoute,
    private _service: PersonDocumentsService) {
    this.route.data.subscribe(response => {
      this.items = response.items;
      if (this.items.length > 0) {
        this.totalRecords = this.items[0].totalcount;
      }
    });
    this.personid = route.snapshot.parent?.parent?.paramMap.get('personid');
  }

  pageChanged(_event: any) {
    // No data ot function to assign or call
  }
}
