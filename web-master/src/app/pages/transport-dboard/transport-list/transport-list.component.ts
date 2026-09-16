import { Component, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
@Component({
    selector: 'transport-list',
    templateUrl: './transport-list.component.html',
    standalone: false
})
export class TransportListComponent implements OnInit {
  transportresult= [];
  transportForm: FormGroup;
  youthName: string;
  dob: string;
  editTransport: boolean;

  constructor(private _commonHttp: CommonHttpService, private _formBuilder: FormBuilder,) { }

  ngOnInit() {
    this.getTransportList('pending')
    this.initAddTransportForm();
  }
  initAddTransportForm() {
    this.transportForm = this._formBuilder.group({
      intakeserviceid: null,
      dateoftransport: [null, Validators.required],
      dateoftransportdrop: [null, Validators.required],
      pickuptime: '08:00',
      droptime: '08:00',
      youthname: { value: this.youthName, disabled: true },
      courttime: '08:00',
      dob: { value: this.dob, disabled: true },
      courtlocation: null,
      locationfromtypekey: [null, Validators.required],
      otherlocationto: null,
      chargereason: null,
      notes: null,
      locationtotypekey: [null, Validators.required],
      otherlocationfrom: null,
      allegationid: null,
      day: [{ value: null, disabled: true }, Validators.required]
    });
  }
  getTransportList(casemode) {
    this._commonHttp
     .getPagedArrayList(
       new PaginationRequest({
         page: 1,
         limit: 10,
         method: 'get',
         where: {  status: casemode,
         sortcolumn: '',
         sortorder: '',
         searchval: '',
         searchcol: ''
 }
       }),
        'persontransportation/gettransportationdashboardlist?filter'
       )
       .subscribe((result) => {
           this.transportresult  = result.data;
     });

   }

   editTransportation(transportid) {
    (<any>$('#myModal-recordings')).modal('show');
     this.editTransport = true;
  }

}
