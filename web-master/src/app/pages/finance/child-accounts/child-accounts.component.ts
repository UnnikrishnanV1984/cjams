import { Component, OnInit } from '@angular/core';
import { SessionStorageService, DataStoreService } from '../../../@core/services';

@Component({
    selector: 'child-accounts',
    templateUrl: './child-accounts.component.html',
    styleUrls: ['./child-accounts.component.scss'],
    standalone: false
})

export class ChildAccountsComponent implements OnInit {
  constructor(
    private _sessionStorage: SessionStorageService,
    private _datastoreService: DataStoreService
   ) { }

  ngOnInit() {
    if (this._sessionStorage.getItem('searchByClientFirstName') || this._sessionStorage.getItem('searchByClientLastName')) {
      this._sessionStorage.removeItem('searchByClientLastName');
      this._sessionStorage.removeItem('searchByClientFirstName');
    }
    if (this._sessionStorage.getItem('searchByClientId')) {
      this._sessionStorage.removeItem('searchByClientId');
    }
    this._datastoreService.setData('childAccountPage', null);
    this._datastoreService.setData('clientSearch', null);
  }

}
