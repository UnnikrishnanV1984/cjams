import { Component, OnInit } from '@angular/core';
import { MilitaryService } from './military.service';
import { PersonInfoService } from '../person-info.service';

@Component({
    selector: 'military',
    templateUrl: './military.component.html',
    styleUrls: ['./military.component.scss'],
    standalone: false
})
export class MilitaryComponent implements OnInit {


  isShowAddMilitary: boolean = false;
  Flag = true;

  constructor(private _militaryService: MilitaryService,
    public _personService: PersonInfoService) { }

  ngOnInit() {
    this.listenToEnableAddMilitary();

  }


  enableAddMilitary() {
    this.isShowAddMilitary = !this.isShowAddMilitary;
  }



  listenToEnableAddMilitary() {
    this._militaryService.isShowAddMilitary$.subscribe((data) => {
      this.isShowAddMilitary = (data) ? true : false;
    });
  }


  militarySubmit(flag:any) {
    if (flag) {
      this.isShowAddMilitary = false;
      this.Flag = false;
      var _this = this;
      setTimeout(() => {
        _this.Flag = true;
      }, 1000);
    }
  }

}


