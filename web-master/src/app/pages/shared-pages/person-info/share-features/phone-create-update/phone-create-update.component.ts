import { Component, OnInit, Input } from '@angular/core';
import { CommonDropdownsService } from '../../../../../@core/services';

@Component({
    selector: 'phone-create-update',
    templateUrl: './phone-create-update.component.html',
    styleUrls: ['./phone-create-update.component.scss'],
    standalone: false
})
export class PhoneCreateUpdateComponent implements OnInit {

  @Input() list: any[]=[];
  contactTypes: any[]=[];
  constructor(private _commonDropDownService: CommonDropdownsService) { }

  ngOnInit() {
    this._commonDropDownService.getPickListByName('phonetype').subscribe(contactTypes => {
      if (contactTypes && Array.isArray(contactTypes)) {
        this.contactTypes = contactTypes;
      }
    });
  }

  addItem() {
    this.list.push({
      personphonetypekey: null,
      phonenumber: null
    });
  }

  removeItem(index:any) {
    this.list.splice(index, 1);
  }

}
