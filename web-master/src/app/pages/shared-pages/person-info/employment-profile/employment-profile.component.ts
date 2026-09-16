import { Component, OnInit } from '@angular/core';
import { EmploymentProfileService } from './employment-profile.service';
import { ActivatedRoute } from '@angular/router';
import { PersonInfoService } from '../person-info.service';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { AuthService } from '../../../../@core/services/auth.service';

@Component({
    selector: 'employment-profile',
    templateUrl: './employment-profile.component.html',
    styleUrls: ['./employment-profile.component.scss'],
    standalone: false
})
export class EmploymentProfileComponent implements OnInit {
  personid= '';
  isShowAddEmployment: boolean = false;
  // workInfo: any;
  constructor(
    private _employmentService: EmploymentProfileService,
    private route: ActivatedRoute,
    private _commonHttpService: CommonHttpService,
    public _personInfoService: PersonInfoService,
    public _authService: AuthService
  ) {
    this.workUpdateListener();
  }
  workUpdateListener() {
    const _self = this;
    this._personInfoService.workInfoListener$.subscribe(workInfo => {
      if (workInfo && workInfo.personid) {
        _self.isShowAddEmployment = true;
      }
    });
  }
  ngOnInit() {
    this.listenToEnableAddEmployment();
  }

  enableAddEmployment() {
    this._personInfoService.setWorkInfo({});
    this.isShowAddEmployment = true;
    this._personInfoService.empActionText = 'ADD';
  }

  listenToEnableAddEmployment() {
    this._employmentService.isShowAddEmployment$.subscribe((data) => {
      this.isShowAddEmployment = (data) ? true : false;
    });
  }

}
