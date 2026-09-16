import { Component, OnInit, AfterViewInit } from '@angular/core';
import { Transportation } from '../../_entities/caseworker.data.model';
import { TransportService } from './transport.service';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, AlertService, AuthService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    selector: 'transport',
    templateUrl: './transport.component.html',
    styleUrls: ['./transport.component.scss'],
    standalone: false
})
export class TransportComponent implements OnInit, AfterViewInit {
  transportations: Array<Transportation> = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  id: string;
  totalRecords!: number;
  transportid!: string;

  constructor(private _transportationService: TransportService, private route: ActivatedRoute,
    private _dataStore: DataStoreService, private _alert: AlertService, private _router: Router,
    private _authService: AuthService) {
    this.id = this._dataStore.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  ngOnInit() {
    this.loadTransportations();
  }
  ngAfterViewInit() {
      const intakeCaseStore = this._dataStore.getData('IntakeCaseStore');
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

  loadTransportations() {
    this._transportationService.getTransportations(this.id, this.paginationInfo).subscribe(transportations => {
      this.transportations = transportations.data;
      if (this.transportations.length > 0) {
        this.totalRecords = transportations.data[0].totalcount;
      }
    });
  }

  openTransportationRequest() {
    this._router.navigate(['add'], { relativeTo: this.route });
  }

  pageChanged(pageInfo: { page: number; }) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadTransportations();
  }

  openDeleteTransportConfirmation(transportid: string) {
    this.transportid = transportid;
    (<any>$('#delete-popup')).modal('show');
  }

  deleteTransport() {
    this._transportationService.deleteTransport(this.transportid).subscribe(res => {
      if (res.affectedRows) {
        this._alert.success('Trasnportation Request deleted successfully.');
        this.loadTransportations();
      }
    });
  }

  editTransportation(transportid: string) {
    this._router.navigate(['edit/' + transportid], { relativeTo: this.route });
  }

}
