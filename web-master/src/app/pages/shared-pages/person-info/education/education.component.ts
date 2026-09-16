import { Component, OnInit } from '@angular/core';
import { EducationInfoService } from './education.service';
import { PersonInfoService } from '../person-info.service';
import { AuthService } from '../../../../@core/services/auth.service';


@Component({
    selector: 'education',
    templateUrl: './education.component.html',
    styleUrls: ['./education.component.scss'],
    standalone: false
})
export class EducationComponent implements OnInit {

  isShowAddEmployment = false;
  Flag =  true;
  childremovaldates: any;
  cachedEducationalInfo: any;
  constructor(
    private _educationService: EducationInfoService,
    public _personInfoService: PersonInfoService,
    public _authService: AuthService
  ) { }

  ngOnInit() {
    this.listenToEnableAddEmployment();
  }

  enableAddEmployment() {
   this.isShowAddEmployment = !this.isShowAddEmployment;
   this.isEdit = false;
  }
  
isEdit: boolean = false;
  listenToEnableAddEmployment() {
    this._educationService.isShowAddEducation$.subscribe((data) => {
      this.isShowAddEmployment = (data) ? true : false;
      this.isEdit =  (data) ? true : false;
    });
  }


  educationSubmit(flag:any) {
    if (flag) {
      this.isShowAddEmployment = false;
      this.Flag = false;
      const _this = this;
      setTimeout(() => {
        _this.Flag = true;
      });
    }

  }
  setChildRemovalDate(dates: any) {
    this.childremovaldates = dates ? dates : []; 
  }
  setCachedEducationalInfo(data: any) {
    this.cachedEducationalInfo = data;
  }

}