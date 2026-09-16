import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { PersonInfoService } from '../../person-info.service';
import { MilitaryService } from '../military.service';
import { AlertService } from '../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';


@Component({
    selector: 'list-military',
    templateUrl: './list-military.component.html',
    styleUrls: ['./list-military.component.scss'],
    standalone: false
})
export class ListMilitaryComponent implements OnInit {

  personId: any;
  militaryPersonList:any = [];
  deleteMilitaryId: any=[];
  @Output() addflag: EventEmitter<boolean> = new EventEmitter();
  deletepopupid = '#delete-popup';
  constructor(private _commonHttpService: CommonHttpService,
    private _militaryService: MilitaryService,
    public _personService: PersonInfoService,
    private _alertService: AlertService) { }

    ngOnInit() {
      this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
      this._militaryService.getMilitaryList();
      this.listenMilitaryListChange();
    }


    listenMilitaryListChange() {
      this._militaryService.militaryPersonType$.subscribe( (data:any) => {
        if (data) {
         this.militaryPersonList = data['getmilitarydetails'];
        }
      });
    }



    editAddress(modal:any) {
      this._militaryService.isShowAddMilitaryEnabled(true);
      setTimeout( () => {
        this._militaryService.getAddress(modal);
      }, 500);
    }
  
    confirmDelete(personaddressid: any) {
      this.deleteMilitaryId = personaddressid;
      (<any>$(this.deletepopupid)).modal('show');
    }
  
    declineDelete() {
      this.deleteMilitaryId = null;
      (<any>$(this.deletepopupid)).modal('hide');
    }
  
    deleteAddress() {
      if (this.deleteMilitaryId) {
        this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MILITARY.DeleteMilitary;
        this._commonHttpService.remove(this.deleteMilitaryId).subscribe(
          response => {
            (<any>$(this.deletepopupid)).modal('hide');
            this._alertService.success('Military Information deleted successfully..');
            this._militaryService.getMilitaryList();
            this.listenMilitaryListChange();
            this.addflag.emit(true);
          },
          error => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
          }
        );
      } else {
        (<any>$(this.deletepopupid)).modal('hide');
      }

}

  getContactPhone(phone: any[]) {
    if (phone && Array.isArray(phone)) {
      const cellNo = phone.find((data) => data.personphonetypekey == 'CL');
      if (cellNo) {
        return cellNo?.phonenumber?.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
      } else {
        return phone[0]?.phonenumber?.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
      }
    }
    return '';
  }

}



