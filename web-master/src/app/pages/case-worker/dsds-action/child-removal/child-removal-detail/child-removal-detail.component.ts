import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../../../@core/services';
import { AppConstants } from '../../../../../@core/common/constants';
import { SharedChildData } from '../_entities/childremoval.model';

@Component({
    selector: 'child-removal-detail',
    templateUrl: './child-removal-detail.component.html',
    styleUrls: ['./child-removal-detail.component.scss'],
    standalone: false
})
export class ChildRemovalDetailComponent implements OnInit {

  isCaseworker = false;

  sharedChildData: SharedChildData  = {
    isNulEndDatPhonNumb: false,
    isNulEndDatEmail: false,
    age: 0,
    dod: "",
    emailIds: [],
    phoneNumbers: []
  }
  constructor(private _authService: AuthService) { }

  ngOnInit() {
    this.isCaseworker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);

  }

}