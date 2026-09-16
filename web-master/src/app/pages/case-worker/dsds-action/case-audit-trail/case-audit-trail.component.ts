import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { Subject, Observable } from 'rxjs';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { DataStoreService, AuthService, CommonHttpService, CommonDropdownsService, SessionStorageService } from '../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { AppConstants } from '../../../../@core/common/constants';
import moment from 'moment';
import { CaseAuditTrailConstant } from './case-audit-trail.constant';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-audit-trail',
    templateUrl: './case-audit-trail.component.html',
    styleUrls: ['./case-audit-trail.component.scss'],
    standalone: false
})

export class CaseAuditTrailComponent implements OnInit {
  caseAuditTrail!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  moduletype$!: Observable<any[]>;
  auditinfo$!: Observable<any[]>;
  caseWorkerList: any;
  teamList: any;
  teamtypekey: any;
  roleDetails!: AppUser;
  departmentList: any;
  user: any;
  workloadsearch!: boolean;
  minFromDate = new Date();
  maxToDate = new Date();
  searchResults: any;
  searchCount: any;
  caseType!: string;
  entityType!: string;
  daNumber!: string;
  filterBasedonUser!: boolean;
  assigneduserslist: any[] = [];
  childList: any[] = [];
  caseAuditFormat!: string | null;
  headerConfig: any = CaseAuditTrailConstant.HEADERS["Contacts"];
  selectedFilter: any = CaseAuditTrailConstant.FILTERS["Contacts"];
  private pageStream$ = new Subject<number>();
  constructor(
    private formBuilder: FormBuilder,
    private _authService: AuthService,
    private route: ActivatedRoute,
    private _CommonDropdownsService: CommonDropdownsService,
    private _commonHttpService: CommonHttpService,
    private _session: SessionStorageService,
    private _dataStoreService: DataStoreService,
) {}

  ngOnInit() {
    this.moduletype$ = this._CommonDropdownsService.getPickList('10060');
    this.user = this._authService.getCurrentUser();
    this.getDeptList();
    this.caseType = this.getCurrentCaseType();
    this.entityType = this.getEntityType();
    this.daNumber = this.getCaseNumber();
    this.roleDetails = this._authService.getCurrentUser();
    this.getAssignmentsList();
    this.getInvolvedPerson();
    if(this.roleDetails && this.roleDetails.role && this.roleDetails.role.teamtypekey){
      this.teamtypekey = this.roleDetails.role.teamtypekey;
    }

    this.caseAuditTrail = this.formBuilder.group({
      moduleCategory: [''],
      fromDate: [''],
      toDate: [''],
      assigneduser: [''],
      clientid: [''],
      localdeptid: [''],
      teamid: [''],
      toworkerid: ['']
    });

  }

  getDeptList() {
     this._commonHttpService.getSingle(
              {
                where: { activeflag: 1, teamtypekey: 'LDSS' },
                method: 'get', nolimit: true
              },
             'manage/team/list?filter'
          ).subscribe(response => {
              if (response && response.data && response.data.length) {
                this.departmentList = response.data;
              }
          });
  }

  getteamlist() {
    const id = this.caseAuditTrail.get('localdeptid')?.value;
    this.caseAuditTrail.get('teamid')?.patchValue('');
    this.caseAuditTrail.get('toworkerid')?.patchValue('');
    this.caseAuditTrail.get('teamid')?.disable();
    this.caseAuditTrail.get('toworkerid')?.disable();
    
    const obj: any = {
      activeflag: 1
    }
    if (id !== '' && id !== undefined && id !== null) {
      obj['countyid'] = id;
    } else {
      obj['countyid'] = null;
    }
    const teamkey = (typeof this.roleDetails.role.teamtypekey === 'string') ? this.user?.teamtypekey?.toUpperCase() : this.user.teamtypekey;
    obj['teamtypekey'] = this.teamtypekey ? this.teamtypekey : teamkey;
    this.getUnitlist(obj);
  }


  getUnitlist(obj: any) {
    this._commonHttpService.getSingle(
             {
               where: obj,
               method: 'get', nolimit: true
             },
            'manage/team/list?filter'
         ).subscribe(response => {
             if (response && response.data && response.data.length) {
               this.teamList = response.data;
               this.caseAuditTrail.get('teamid')?.enable();
               if (!this.workloadsearch) {
                 const teamid = this.roleDetails.user.userprofile.teammemberassignment.teammember.team.id;
                 this.caseAuditTrail.controls['teamid'].patchValue(teamid);
               }
               this.loadUnitWorkers();
             }
    });
 }


 loadUnitWorkers() {
  const id = this.caseAuditTrail.get('teamid')?.value;
  this.caseAuditTrail.get('toworkerid')?.patchValue('');
  const obj = {
    teamid: id === '' ? null : id,
    filtertypekey: 'worker'
  }
  this.getCaseWorkerlist(obj);
}

getCaseWorkerlist(obj: any) {
  this._commonHttpService.getSingle(
           {
             where: obj,
             method: 'get', nolimit: true
           },
          'manage/team/getteamusers?filter'
       ).subscribe(response => {
           if (response) {
            this.caseWorkerList = response;
            this.caseAuditTrail.get('toworkerid')?.enable();
            this.workloadsearch = true;
           }
  });
}

getCurrentCaseType() {
  if (this.isServiceCaseData()) {
      return 'Service Case';
  } else if (this.isIntakeMode()) {
      return 'Intake';
  } else if (this.isAdoptionCase()) {
      return 'Adoption Case';
  } else {
      return 'CPS';
  }
}

getEntityType() {
  let entitytype = '';
  if (this.isIntakeMode()) {
      entitytype = 'intake';
  } else if (this.isServiceCaseData()) {
      entitytype = 'servicecase';
  } else if (this.isAdoptionCase()) {
      entitytype = 'adoption';
  } else {
      entitytype = 'intakeservicerequest';
  }
  return entitytype;
}

isAdoptionCase() {
  if (this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE) == AppConstants.CASE_TYPE.ADOPTION_CASE) { return true; }
  const dsds = this._dataStoreService.getData('dsdsActionsSummary');
  if (dsds && dsds.adoptioncasenumber != null) { return true; }
  return false;
}
isServiceCaseData() {
  return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
}

isIntakeMode() {
  return this.getIntakeNumber() ? true : false;
}

getIntakeNumber() {
  const intakeStore = this._dataStoreService.getObj('intake');
  if (intakeStore && intakeStore.number) {
      return intakeStore.number;
  } else {
      return null;
  }
}

getCaseNumber() {
  const daNumber = this.route?.snapshot?.parent?.parent?.parent?.parent?.parent?.params['daNumber'];
  if (!daNumber) {
       const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
       return (caseInfo) ? caseInfo.da_number : null;
  }
  return daNumber;
}

getFormattedDate(dateValue: any) {
  if (dateValue && moment(new Date(dateValue), 'MM/DD/YYYY HH:mm:ss', true).isValid()) {
      return moment(new Date(dateValue)).format('MM/DD/YYYY HH:mm:ss A');
  } else {
      return '';
  }
}

onSorted(event: any, sortType: boolean) {
  this.paginationInfo.sortBy = event.sortDirection;
  this.paginationInfo.sortColumn = event.sortColumn;
  this.searchAudit();
}

onChangeModule() {
  const moduleCategory = this.caseAuditTrail.get('moduleCategory')?.value;
  this.headerConfig = CaseAuditTrailConstant.HEADERS[moduleCategory];
  this.selectedFilter = CaseAuditTrailConstant.FILTERS[moduleCategory];
}


getValue(item: any, config: any){
  if(item[config.value]){
    if(config.value === 'actiontime'){
      return this.getFormattedDate(item.actiontime)
    }
    return item[config.value]
  } else if(item.progressnotedetails){
    if(config.value === 'contactdate'){
      return this.getFormattedDate(item.progressnotedetails[0][config.value]);
    }
    return item.progressnotedetails[0][config.value];
  } else {
    return null
  }
}
searchAudit(){
const a = this.caseAuditTrail.getRawValue();
let objecttype = this.caseType;
this.caseAuditFormat = null;
if(a.moduleCategory == 'Health_Conditions') {
  objecttype = 'Person-profile';
  this.caseAuditFormat = 'Health_Conditions';
}
if(a.moduleCategory == 'Medication_Psychotropic') {
  objecttype = 'Medication-Psychotropic';
  this.caseAuditFormat = 'Medication_Psychotropic';
}
if(a.moduleCategory == 'Health_Conditions' || a.moduleCategory == 'Medication_Psychotropic' || a.moduleCategory == 'Person Health Summary') {
  this.filterBasedonUser = true;
}
this._commonHttpService.getArrayList(
     {
       method: 'post',
       page: this.paginationInfo.pageNumber,
       limit: 50,
       where: {
          module: a.moduleCategory,
          fromDate: moment(a.fromDate).format('YYYY-MM-DD'),
          toDate: moment(a.toDate).format('YYYY-MM-DD'),
          objecttype: objecttype,
          objectKey: this.daNumber,
          selecteduser: this.filterBasedonUser && a.assigneduser ? a.assigneduser : null,
          clientid:  this.filterBasedonUser && a.clientid ? a.clientid : null,
          sortcolumn: this.paginationInfo.sortColumn,
          sorting: this.paginationInfo.sortBy,
      }
      },'caseaudittrail/list').subscribe(response => {
        if(response && response.length) {
            this.searchResults = response;
            this.searchCount = response[0].totalcount;
        } else {
          this.searchResults = null;
          this.searchCount = null;
        }
});
}

getAssignmentsList() {
  this._commonHttpService.getArrayList(
      {
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
          method: 'get'
      },
      'Caseassignments/getworkload?filter'
  ).subscribe(data => {
      if (data && data.length) {
           for (const element of data) {
                if ((element.responsibilitytypekey === "child" || element.responsibilitytypekey === "family" || element.responsibilitytypekey === "administrative") && (element.enddate === null || moment(element.enddate) >= moment(new Date())) && element.toworkerdetails && element.toworkerdetails.length) {
                    this.assigneduserslist.push(element.toworkerdetails[0]);
                }
            }
      }
  });
}


getInvolvedPerson() {
  this.childList = [];
  let personDetail = {};
      personDetail = {
          objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID),
          objecttypekey: 'servicecase'
      };
      this._commonHttpService.getPagedArrayList(
        {
            where: personDetail,
            method: 'get'
        },
        'People/getpersondetail?filter'
    ).subscribe(response => {
          if (response && response.data && response.data.length) {
            for (const element of response.data) {
                if (element.roles) {
                    this.childList.push(element);
                }
            }
        }
    });
}


toDateChange() {
  
  this.caseAuditTrail.patchValue({ toDate: ''});
}


pageChanged(pageNumber: any) {
  this.paginationInfo.pageNumber = pageNumber.page;
  this.searchAudit();
}



}