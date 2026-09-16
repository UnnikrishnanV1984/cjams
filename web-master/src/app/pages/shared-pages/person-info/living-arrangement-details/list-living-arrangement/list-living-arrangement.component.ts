import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { PersonInfoService } from '../../person-info.service';
import { LivingArrangementDetailsService } from '../living-arrangement-details.service';
import { GenericService, AlertService, AuthService } from '../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';


@Component({
    selector: 'list-living-arrangement',
    templateUrl: './list-living-arrangement.component.html',
    styleUrls: ['./list-living-arrangement.component.scss'],
    standalone: false
})
export class ListlivingArrangementComponent implements OnInit {
  personId: any;
  person: any;
  livingArrangementList: any[] = [];
  deleteLivingArrangementId: any;
  booleanValue: boolean = false;
  sortColumnName: any;
  isClosed = false;
  deletepopupid = '#delete-popup';
  @Output() clearAddForm = new EventEmitter<void>();
  
  constructor(
    private _commonHttpService: CommonHttpService,
    private _livingArrangementDetailsService: LivingArrangementDetailsService,
    private _personService: PersonInfoService,
    private _alertService: AlertService,
    private _service_address: GenericService<any>,
    public _authService: AuthService
  ) {
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personlivingarrangement');
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : null;
    this.person = this._personService.personInfo;
    this.getLivingArragementList();
  }

  getLivingArragementList() {
    this.livingArrangementList = [];
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: this.personId },
            page: 1, 
            limit: 10
          }),
        CommonUrlConfig.EndPoint.PERSON.LIVINGARRANGEMENT.ListUrl + '?filter'
      ).subscribe((data : any) => {
        if (data && data.length > 0) {
          this.livingArrangementList = data;
          if (this.person && this.person.personbasicdetails) {
            this.person.personbasicdetails.livingarrangementdesc = this.livingArrangementList[0].remarks;
            this.person.personbasicdetails.livingarrangementkey = this.livingArrangementList[0].livingarrangementtypekey;
            this._personService.setPersonInfo(this.person);
          }
        } else {
          this.livingArrangementList = [];
        }
      });
  }

  editLivingArrangement(modal: any) {
    this._livingArrangementDetailsService.isShowAddLivingArrangementEnabled(true);
    modal['action'] = 'edit';
    setTimeout( () => {
      this._livingArrangementDetailsService.getLivingArrangement(modal);
    }, 500);
  }

  viewLivingArrangement(modal: any) {
    this._livingArrangementDetailsService.isShowAddLivingArrangementEnabled(true);
    modal['action'] = 'view';
    setTimeout( () => {
      this._livingArrangementDetailsService.getLivingArrangement(modal);
    }, 500);
  }

  confirmDelete(livingid: any) {
    this.deleteLivingArrangementId = livingid;
    (<any>$(this.deletepopupid)).modal('show');
  }

  declineDelete() {
    this.deleteLivingArrangementId = null;
    (<any>$(this.deletepopupid)).modal('hide');
  }

  deleteLivingArrangement() {
    if (this.deleteLivingArrangementId) {
      this._service_address.endpointUrl = CommonUrlConfig.EndPoint.PERSON.LIVINGARRANGEMENT.DeleteUrl;
      this._service_address.remove(this.deleteLivingArrangementId).subscribe(
        response => {
          (<any>$(this.deletepopupid)).modal('hide');
          this._alertService.success('Living Arrangement deleted successfully');
          this.clearAddForm.emit();
          this.getLivingArragementList();
        },
        error => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
      (<any>$(this.deletepopupid)).modal('hide');
    }
  }

  sort(colName: any, boolean: any) {
    this.sortColumnName = colName;
    if (boolean === true){
        this.livingArrangementList.sort((a, b) => a[colName] < b[colName] ? 1 : this.livingArrangementListFalseCon1(a, colName, b))
        this.booleanValue = !this.booleanValue
    } else{
        this.livingArrangementList.sort((a, b) => a[colName] > b[colName] ? 1 : this.livingArrangementListFalseCon2(a, colName, b))
        this.booleanValue = !this.booleanValue
    }
  }


  private livingArrangementListFalseCon2(a: any, colName: any, b: any): number {
    return a[colName] < b[colName] ? -1 : 0;
  }

  private livingArrangementListFalseCon1(a: any, colName: any, b: any): number {
    return a[colName] > b[colName] ? -1 : 0;
  }
}
