import { Component } from '@angular/core';
import { PersonInfoService } from '../person-info.service';

@Component({
    selector: 'finance',
    templateUrl: './finance.component.html',
    styleUrls: ['./finance.component.scss'],
    standalone: false
})
export class PersonFinanceComponent {


  isShowAddMilitary: boolean = true;


  constructor(    private _personInfoService: PersonInfoService) { }

  enableAddMilitary() {
    this.isShowAddMilitary = !this.isShowAddMilitary;
  }


}


