import { Component, OnInit } from '@angular/core';
import { LivingArrangementDetailsService } from './living-arrangement-details.service';
import { PersonInfoService } from '../person-info.service';

@Component({
    selector: 'living-arrangement',
    templateUrl: './living-arrangement-details.component.html',
    styleUrls: ['./living-arrangement-details.component.scss'],
    standalone: false
})
export class LivingArrangementDetailsComponent implements OnInit {

  Flag = true;
  isShowAddLivingArrangement= false;
  constructor(
    private readonly _livingArragnementService: LivingArrangementDetailsService,
    public readonly  _personService: PersonInfoService
  ) { }

  ngOnInit() {
    this.listenToEnableAddLivingArrangement();
  }

  enableAddLivingArrangement() {
    this.isShowAddLivingArrangement = !this.isShowAddLivingArrangement;
    return this.isShowAddLivingArrangement;
  }

  listenToEnableAddLivingArrangement() {
    this._livingArragnementService.isShowAddLivingArrangement$.subscribe((data) => {
      this.isShowAddLivingArrangement = (data) ? true : false;
    });
  }

  livingArrangementAdd(flag:any) {
    if (flag) {
      this.isShowAddLivingArrangement = false;
      this.Flag = false;
      var _this = this;
      setTimeout(() => {
        _this.Flag = true;
      }, 1000);
    }

  }
  clearAddForm() {
    this.isShowAddLivingArrangement = false;
  }
}
