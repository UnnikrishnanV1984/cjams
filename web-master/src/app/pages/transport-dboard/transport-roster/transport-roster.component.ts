import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';

@Component({
    selector: 'transport-roster',
    templateUrl: './transport-roster.component.html',
    standalone: false
})
export class TransportRosterComponent implements OnInit {
  rosterresult = [];

  constructor(private _commonHttp: CommonHttpService,) { }

  ngOnInit() {
    this.getRosterList();
  }
  getRosterList() {
    this._commonHttp
     .getPagedArrayList(
       new PaginationRequest({
         page: 1,
         limit: 10,
         method: 'get',
         where: {
          pickupstarttime: '',
          Pickupendtime: '',
          Dropstarttime: '',
          Dropendtime: '',
          dateoftransport: ''
          }
       }),
        'persontransportation/gettransportrosterwithalerts?filter'
       )
       .subscribe((result) => {
           this.rosterresult  = result.data[0];
     });

   }

}
