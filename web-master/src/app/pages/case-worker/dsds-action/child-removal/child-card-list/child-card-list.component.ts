import { Component, Input, OnInit } from '@angular/core';
import { ChildRemovalService } from '../child-removal.service';
import { PersonInfoService } from '../../../../shared-pages/person-info/person-info.service';
import { DataStoreService, AuthService, SessionStorageService, CommonHttpService } from '../../../../../@core/services';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { map, pluck, share } from 'rxjs/operators';
import { SharedChildData } from '../_entities/childremoval.model';
import { NavigationUtils } from '../../../../_utils/navigation-utils.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    selector: 'child-card-list',
    templateUrl: './child-card-list.component.html',
    styleUrls: ['./child-card-list.component.scss'],
    standalone: false
})
export class ChildCardListComponent implements OnInit {

  childList: any[] = [];
  selectedChild: any;
  isClosed: boolean = false;
  isCpsIRorAR: any;
  childSelected: any;
  isReadonly: boolean = false;
  removalCircumstancesObj : any[]  = [];
  isNulEndDatEmail: boolean = false;
  @Input() sharedChildData: SharedChildData = { isNulEndDatPhonNumb: false, isNulEndDatEmail: false, age: 0, dod: "", emailIds: [], phoneNumbers: [] };
  constructor(
    private _childRemovalService: ChildRemovalService,
    private _personInfoService: PersonInfoService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _commonHttpService: CommonHttpService,
    private storage: SessionStorageService,
    private _navigationUtils: NavigationUtils) { }

  ngOnInit() {
    const statusobj = this._dataStoreService.getData('object');
    this.childList = this._childRemovalService.getChildList();
   
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    if (caseInfo && (caseInfo.da_subtype === 'CPS-IR' || caseInfo.da_subtype === 'CPS-AR')) {
      this.isCpsIRorAR = true;
    }
    this.childList.forEach((item: { isRemoved: boolean; removalHistory: any; }) => {
      item.isRemoved = false;
      if (item.removalHistory && item.removalHistory.length > 0) {
        item.removalHistory = item.removalHistory.sort((remove1: any, remove2: any) => { return new Date(remove2.removaldate).getTime() - new Date(remove1.removaldate).getTime() });
      }
    });
    if (statusobj) {
      if (statusobj.da_status === 'Closed' || statusobj.da_status === 'Completed') {
        this.isClosed = true;
      } else {
        this.isClosed = false;
      }
    }
    const activeModuleRole = this.storage.getItem('activeModuleRole');
    if (activeModuleRole == 'CJAMS_SSA_FTDM_FACILITATOR' || activeModuleRole == 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' || activeModuleRole == 'CJAMS_SSA_FTDM_QI_SUPERVISOR') {
      this.isReadonly = false;
    } else {
      this.isReadonly = this._authService.readonlyButton('read_only_access', 'readonly-childCardList');
    }
  }

  onChildChecked(event: { checked: any; }, child: { isbioadoptedflag: number; }) {
    if (child.isbioadoptedflag === 1) {
      this.childSelected = child;
      this.onCheckedChild(child, event.checked);
      (<any>$('#bioadoptedflag')).modal('show');
      return;
    }
    if (!this._childRemovalService.childselection(child, event.checked)) {
      (<any>$('#childselection')).modal('show');
    } else {
      this.onCheckedChild(child, event.checked);
    }
  }

  onCheckedChild(child: { isbioadoptedflag?: number; isRemoved?: any; personid?: any; }, checked: any) {
    child.isRemoved = checked;
    this._personInfoService.setPersonId(child.personid);
    this._childRemovalService.removeChild(child, checked);
    this._authService.hasSupervisor();
  }

  showChildRemovalDetails(child: { personid: any; isRemoved: boolean; intakeservreqchildremovalid: any; dob: any; dateofdeath: any;}, type: any) {
    this._personInfoService.setPersonId(child.personid);
    this._personInfoService.setPerson(child);
    child.isRemoved = true;
    this._childRemovalService.showChildRemovalInformation(child.intakeservreqchildremovalid, type);
    this.getPhoneNumber(child.personid);
    this.getEmailPage(child.personid);
    const age = this.getAgeFromDOB(child?.dob);
    this.sharedChildData.age = age;
    this.sharedChildData.dod = child?.dateofdeath || "";
    this.updatePersonId(child.personid);
  }
  updatePersonId(personid: string) { /* Updating person info for redirecting between CHILDREMOVAL ~ CONTACT page  */
    const sourceID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    const caseNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    const navigationInfo: any = { data: { caseNumber: '' } };
    navigationInfo.personId = personid;
    navigationInfo.source = 'Service Case';
    navigationInfo.sourceID = sourceID;
    navigationInfo.data.caseNumber = caseNumber;
    this._navigationUtils.setNavigationInfo(navigationInfo);
  }
  getPhoneNumber(personid: any) {
    const source = this._commonHttpService.getPagedArrayList(
      new PaginationRequest(
        {
          method: 'get',
          where: { personid: personid },
          page: 1, 
          limit: 10
        }),
      CommonUrlConfig.EndPoint.PERSON.PHONE.ListPhoneUrl + '?filter').pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0
        };
      }), share());
    const phoneNumber = source.pipe(pluck('data'));
    phoneNumber.subscribe(
      result => {
        const phoneNumbers = result;
        this.sharedChildData.phoneNumbers = phoneNumbers;
        this.sharedChildData.isNulEndDatPhonNumb =  phoneNumbers.some((item: any) => item.enddate === null);
      }
    );
  }
  getEmailPage(personid: any) {
    const source = this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest(
          {
            method: 'get',
            where: { personid: personid },
            page: 1, 
            limit: 10
          }),
        CommonUrlConfig.EndPoint.PERSON.EMAIL.ListEmail + '?filter'
      ).pipe(map((result: any) => {
        return {
          data: result,
          count: result.length > 0 ? result[0].totalcount : 0,
        };
      }), share());
    const emailID = source.pipe(pluck('data'));
    emailID.subscribe(
      result => {
        const emailIds = result;
        this.sharedChildData.emailIds = emailIds;
        this.sharedChildData.isNulEndDatEmail =  emailIds.some((item: any) => item.enddate === null);
      }
    );
  }
  getAgeFromDOB(dobString: string): number {
    const dob = new Date(dobString);
    const today = new Date();
  
    let age = today.getFullYear() - dob.getFullYear();
    const monthDiff = today.getMonth() - dob.getMonth();
    const dayDiff = today.getDate() - dob.getDate();
    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
      age--;
    }
  
    return age;
  }

  showRemovalHistory(child: any) {
    this.selectedChild = child;

  }

 

  getKeyValuesInArrayFormat(obj: any, removalItemObj: any){
    
    this.removalCircumstancesObj = this._childRemovalService.removalCircumstances;
    let removalInstancesObj = obj;
    if(removalItemObj && removalItemObj.revisionrecord && removalItemObj.revisionrecord[0] 
      && removalItemObj.revisionrecord[0].actualdata
      && removalItemObj.revisionrecord[0].actualdata.removalcircumstances
      && removalItemObj.approvalstatus !== 'Approved'
      ) {
        removalInstancesObj = removalItemObj.revisionrecord[0].actualdata.removalcircumstances;
      }
      if(removalInstancesObj) {
  let arr: any =  Object.entries(removalInstancesObj).map(([key, value]) => ({ key, value }));
   arr = arr.filter((item: any)=>item.value)
   arr = arr.map((item:any)=> {
     const index = this.removalCircumstancesObj.findIndex((rObj)=> rObj.ref_key == item.key);
     if(index > -1) {
       item.key =  this.removalCircumstancesObj[index]['ref_key']
       item.description = this.removalCircumstancesObj[index]['description'];
     } else {
      item.description = "";
     }
     
      return item;
    })
   return arr;
  }
  }

  viewRemovalInfo(removalInfo: any, isViewOrNot: any) {
    (<any>$('#ChildHistory')).modal('hide');
    removalInfo.exittime = removalInfo.exittime ? removalInfo.exittime : this.returnEnitdatTimeFn(removalInfo);
    this._childRemovalService.showChildRemovalHistoryInfo(this.selectedChild, removalInfo, isViewOrNot);
  }

  private returnEnitdatTimeFn(removalInfo: any): any {
    return removalInfo.exitdate ? removalInfo.exitdate : '';
  }

  viewChildRemoval(child: any) {
    const list = child.removalHistory.filter((item: { intakeservreqchildremovalid: any; }) => item.intakeservreqchildremovalid === child.intakeservreqchildremovalid)
    this.selectedChild = child;
    this.viewRemovalInfo(list[0], true);
  }

  validateExit(child: any) {
    const removalInfo = child.removalHistory.find((item: { intakeservreqchildremovalid: any; }) => item.intakeservreqchildremovalid === child.intakeservreqchildremovalid);
    if (child.removalStatus === 'Draft') {
      return false;
    } else if ((child.removalStatus === 'Review' || child.removalStatus === 'Rejected') && removalInfo && removalInfo.exitdate === null && removalInfo.revisionrecord === null) {
      return false;
    } else {
      return true;
    }
  }
} 