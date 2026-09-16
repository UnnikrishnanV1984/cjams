import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { CommonHttpService, DataStoreService, AlertService, SessionStorageService } from '../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { Router } from '@angular/router';

@Component({
    selector: 'case-connected',
    templateUrl: './case-connected.component.html',
    standalone: false
})
export class CaseConnectedComponent implements OnInit {

  connectedCasesList: any;
  id!: string;
  selectedCase: any;
  selecteditemnumber!: string;
  confirmpopupid = '#confirm-navigation';
  
  @Output() closeModalAndRoute = new EventEmitter();

  constructor(
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _alertService: AlertService,
    private _router: Router,
    private _session: SessionStorageService
  ) { }

  ngOnInit() {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.getConnectedCases();
  }

  getConnectedCases() {
    this._commonHttpService.getAll(
      'Intakeservicerequests/getcaseconnected/' + this.id
    ).subscribe(
      (response) => {
        this.connectedCasesList = response;
      }
    );
  }

  getSelectedItemNumber(itemType: string) {
    if (itemType === 'SERVICE_CASE') {
      this.selecteditemnumber = this.selectedCase.servicecasenumber;
    } else if (itemType === 'INTAKE_SERVICE_REQUEST') {
      this.selecteditemnumber = this.selectedCase.servicerequestnumber;
    } else if (itemType === 'INTAKE') {
      this.selecteditemnumber = this.selectedCase.intakenumber;
    }
  }


  selectCaseAndConfirmNavigation(item: any, itemType: string) {
    this.selectedCase = item;
    this.selectedCase.selecteditemtype = itemType;
    this.getSelectedItemNumber(itemType);
    (<any>$(this.confirmpopupid)).modal('show');

  }

  confirmNavigation() {
    (<any>$(this.confirmpopupid)).modal('hide');
    this.closeModalAndRoute.emit(this.selectedCase);
  }

  cancelNavigation() {
    (<any>$(this.confirmpopupid)).modal('hide');
  }


  // There are certain dummy intake service request cases created which need to be excluded
  isExcludeISR(item: { isr_type: string; isr_subtype: string; }):boolean { 
    // The intake service request created from RFS is not needed
    if (item.isr_type === 'Request for services') {
      return true;
    }

    // This is for the 'Risk of Harm' scenario when the intake service request is not needed
    // as a service case is directly created from the intake
    if (item.isr_type === 'CHILD' && item.isr_subtype === 'Default') {
      return true;
    }
    
    return false;
  }
}