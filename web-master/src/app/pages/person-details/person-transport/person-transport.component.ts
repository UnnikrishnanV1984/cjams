import { Component, OnInit } from '@angular/core';
import { Transportation } from '../../case-worker/_entities/caseworker.data.model';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { PersonTransportService } from './person-transport.service';
import { PersonDetailsService } from '../person-details.service';

@Component({
    selector: 'person-transport',
    templateUrl: './person-transport.component.html',
    styleUrls: ['./person-transport.component.scss'],
    standalone: false
})
export class PersonTransportComponent implements OnInit {
  transportations: Array<Transportation> = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  personid!: string | null | undefined;
  totalRecords!: number;
  constructor(private _transportationService: PersonTransportService, private route: ActivatedRoute, private _router: Router, public personService: PersonDetailsService) {
    this.personid = route?.snapshot?.parent?.parent?.paramMap.get('personid');
  }

  ngOnInit() {
    this.loadTransportations();
  }

  loadTransportations() {
    this._transportationService.getTransportations(this.personid, this.paginationInfo).subscribe(transportations => {
      this.transportations = transportations.data;
      if (this.transportations.length > 0) {
        this.totalRecords = transportations.data[0].totalcount;
      }
    });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadTransportations();
  }

  editTransportation(transport: Transportation) {
    const url = '/pages/case-worker/' + transport.intakeserviceid + '/' + transport.servicerequestnumber + '/dsds-action/transport/edit/' + transport.persontransportationid;
    this._router.navigate([url]);
  }

}
