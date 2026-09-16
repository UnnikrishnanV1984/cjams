import { Component, OnInit } from '@angular/core';
import { CommonHttpService, AlertService,DataStoreService } from '../../../../@core/services';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { NavigationUtils } from '../../../_utils/navigation-utils.service';
import { PersonInfoService } from '../person-info.service';
declare var $: any;
@Component({
    selector: 'mdm-person-info',
    templateUrl: './mdm-person-info.component.html',
    styleUrls: ['./mdm-person-info.component.scss'],
    standalone: false
})
export class MdmPersonInfoComponent implements OnInit {

  clientInfo: any=[];
  mergeClientIndex :any= null;
  mdmInfo1: any=[];
  showSsnMask:boolean=true;
  acknowlegedData: any = {};
  isAuthorized:any=[];
  constructor(
    private _commonHttpService: CommonHttpService,
    private _navgationUtills: NavigationUtils,
    private _alertService: AlertService,
    public _personInfoService: PersonInfoService,
    public _datastoreService: DataStoreService
  ) { }

  ngOnInit() {
    this.loadMDMPerson();
    this.isAuthorized= this._datastoreService.isAuthorized(); //for fortify issues 
  }

  loadMDMPerson() {
    this.getMDMPersonInfo().subscribe(response => {
      if (Array.isArray(response) && response.length && response[0].getmdmpersondetailslist
        && Array.isArray(response[0].getmdmpersondetailslist) && response[0].getmdmpersondetailslist.length) {
        const detail = response[0].getmdmpersondetailslist[0];
        this.clientInfo = detail.clientinfo;
        const mdmInfo = detail.mdminfo;
        if (Array.isArray(mdmInfo) && mdmInfo.length) {
          this.mdmInfo1 = mdmInfo[0];
        }
        this.acknowlegedData = {};


      }
    });
  }



  getMDMPersonInfo() {
    const requestParam = this._navgationUtills.getPersonRequestParam();
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: requestParam.personid }
        }),
        'People/getmdmpersondetailslist?filter'
      );
  }

  confirmMergeClient() {
    if (this.mergeClientIndex !== null) {
      $('#confirm-merge').modal('show');
    } else {
      this._alertService.error('Please select any merged client');
    }
  }

  mergeClient() {
    $('#confirm-merge').modal('hide');
    const caseInfo = Object.assign(this._personInfoService.getCaseInfo());
    caseInfo.isMDM = true;
    this.clientInfo.caseInfo = caseInfo;
    this.acknowlegedData.clientInfo = this.clientInfo;
    this.acknowlegedData.personid = this.clientInfo.personid;

    return this._commonHttpService.create(this.acknowlegedData, 'People/updatepostGoldenRecord').subscribe(response => {
      this._alertService.success('Person information updated sucessfully');
      this.loadMDMPerson();
      this.updatePersonProfile();
      this.mergeClientIndex = null;
    });
  }

  mdmChanged(data:any, selectedItem:any, keyName:any, indexName:any) {
    this.mergeClientIndex = 1;
    const parsedItem = JSON.parse(JSON.stringify(selectedItem));
    parsedItem.active_sw = data.value;
    if (this.acknowlegedData.hasOwnProperty(keyName)) {
      this.acknowlegedData[keyName] = this.acknowlegedData[keyName].filter((item:any) => item[indexName] !== parsedItem[indexName]);
      this.acknowlegedData[keyName].push(parsedItem);
    } else {
      this.acknowlegedData[keyName] = [];
      this.acknowlegedData[keyName].push(parsedItem);
    }

  }

  cancel() {
    this.loadMDMPerson();
  }

  updatePersonProfile() {
    this._personInfoService.getPersonDetails().subscribe(response => {
      this._personInfoService.setPersonInfo(response);
    });
  }

}
