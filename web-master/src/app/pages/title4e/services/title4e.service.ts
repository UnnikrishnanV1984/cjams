import { Injectable } from '@angular/core';
import { CommonHttpService } from '../../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { BehaviorSubject, forkJoin } from 'rxjs';

@Injectable()
export class Title4eService {

  citizenData: any;
  SectionAData: any;
  SectionBData: any;
  SectionCData: any;
  clientIdData: any;
  removalIdData: any;
  gridConfigs: any;
  paginationInfo: PaginationInfo = new PaginationInfo();

  constructor(private _commonHttpService: CommonHttpService) { 
    this.gridConfigs = {
      FosterCare: {
        columns: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Removal Date', 'Date Of Birth', 'Removal Age', 'Assigned To', 'Assignment Status', 'Eligible Status', 'Review Period', 'Action'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Removal Age', 'Assigned To', 'Assignment Status', 'Eligible Status', 'Review Period', 'Action'],
        keys: ['childname', 'clientid', 'casenumber', 'childagency', 'childjurisdiction', 'removaldate', 'dateofbirth', 'removalage','assignedtouser','assignmentstatus', 'fostercareeligibilitystatus', 'sqnm_sw', 'action'],
        htmlColumns: [],
        data: []
      },
      Guardianship: {
        columns: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Subsidy Start Date',  'Assigned To', 'Assignment Status', 'Eligible Status', 'Review Period', 'Action'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Assigned To', 'Assignment Status',  'Eligible Status', 'Review Period', 'Action'],
        keys: ['childname', 'clientid', 'casenumber', 'childagency', 'childjurisdiction', 'dateofbirth', 'startdate', 'assignedtouser', 'assignmentstatus', 'fostercareeligibilitystatus', 'sqnm_sw', 'action'],
        htmlColumns: [],
        data: []
      },
      Adoption: {
        columns: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Subsidy Start Date', 'Assigned To', 'Assignment Status', 'Eligible Status', 'Review Period', 'Action'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Assigned To', 'Assignment Status',  'Eligible Status', 'Review Period', 'Action'],
        keys: ['childname', 'clientid', 'casenumber', 'childagency', 'childjurisdiction', 'dateofbirth', 'startdate', 'assignedtouser', 'assignmentstatus', 'fostercareeligibilitystatus', 'sqnm_sw', 'action'],
        htmlColumns: [],
        data: []
      },
      AdoptionApplicability: {
        columns: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Submission Date' , 'Assigned To', 'Assignment Status', 'Action'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Case Number', 'Agency', 'Jurisdiction', 'Date Of Birth', 'Submission Date' , 'Assigned To', 'Assignment Status', 'Action'],
        keys: ['childname', 'clientid', 'casenumber', 'childagency', 'childjurisdiction', 'dateofbirth', 'startdate', 'assignedtouser', 'assignmentstatus', 'action'],
        htmlColumns: [],
        data: []
      },
      CaseClosureReview: {
        columns: ['Case Number', 'Head of household', 'Client Jurisdiction', 'Requested by (Service Case Worker)', 'Nested Client', 'Time frame (5 Business Days limit)',  'Assigned To', 'Assignment Status', 'Action', 'Status', 'Actions'],
        unsortablecolumn: ['Case Number', 'Head of household', 'Client Jurisdiction', 'Requested by (Service Case Worker)', 'Nested Client', 'Time frame (5 Business Days limit)', 'Assigned To', 'Assignment Status', 'Action', 'Status', 'Actions'],
        keys: ['casenumber', 'headofhousehold', 'jurisdiction', 'caseworker', 'nestedclient', 'timeframe','assignedto', 'assignmentstatus', 'action', 'status', 'actions'],
        htmlColumns: [],
        data: [],
        nestedTableDataColumns : ['clientid', 'clientname', 'programs']
      },
      CaseClosureApproval: {
        columns: ['Case Number', 'Head of household', 'Client Jurisdiction', 'Requested by (Service Case Worker)', 'Nested Client', 'Time frame (5 Business Days limit)',  'Assigned To', 'Status', 'Action'],
        unsortablecolumn: ['Case Number', 'Head of household', 'Client Jurisdiction', 'Requested by (Service Case Worker)', 'Nested Client', 'Time frame (5 Business Days limit)', 'Assigned To', 'Status', 'Action'],
        keys: ['casenumber', 'headofhousehold', 'jurisdiction', 'caseworker', 'nestedclient', 'timeframe', 'assignedto',  'status', 'action'],
        htmlColumns: [],
        data: [],
        nestedTableDataColumns : ['clientid', 'clientname', 'programs']
      },
      Approvals: {
        columns: ['Child Name', 'Client ID', 'Requested From', 'Requested On', 'Requested To', 'Approval Status', 'Approved By', 'Approved Date', 'Rejected By', 'Rejected Date', 'Program Type', 'Review Period'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Requested From', 'Requested On', 'Requested To', 'Approval Status', 'Approved By', 'Approved Date', 'Rejected By', 'Rejected Date', 'Program Type', 'Review Period'],
        keys: ['client_name', 'clientid', 'requestedfrom', 'requestedon', 'requestedto', 'approval_status', 'approvedby', 'approveddate', 'rejectedby', 'rejecteddate', 'placement_type', 'sqnm_sw'],
        htmlColumns: [],
        data: []
      },
      MyAlerts: {
        columns: ['Child Name', 'Client ID', 'Date Of Birth', 'Case Number', 'Child Jurisdiction','Review Period Start Date','Review Period End Date', 'Review Period', 'Assigned by', 'Assigned To', 'Due Date', 'Program Type', 'Action'],
        unsortablecolumn: ['Child Name', 'Client ID', 'Date Of Birth', 'Case Number','Assigned by', 'Program Type', 'Action'],
        keys: ['client_name', 'clientid', 'client_dob', 'casenumber', 'countyname', 'redet_start_dt', 'redet_end_dt','review_period', 'assigned_supervisor_name', 'assigned_specialist_name', 'due_date', 'program_type','action'],
        htmlColumns: [],
        data: []
      }
    };


  }
 private activeprogresselected =new BehaviorSubject<string |null>(null);
 private activeeligibiltyselected = new BehaviorSubject<string |null>(null);
 activevalue$ =this.activeprogresselected.asObservable();
 activeeligibility$ =this.activeeligibiltyselected.asObservable();
 seteligibilityselectedactive(value:any){
  this.activeeligibiltyselected.next(value);
   }
 setprogressselectedactive(value:string){
this.activeprogresselected.next(value);
 }



  getGridConfig(gridKey: string, userRole: string, selectedApprovalStatus?: string) {
    const gridCon = this.gridConfigs[gridKey];
    const gridConfig = { ...gridCon };

    if(gridKey === 'FosterCare' || gridKey === 'Guardianship' || gridKey === 'Adoption' || gridKey === 'AdoptionApplicability'){
      return this.fosterCareGridConfig(gridConfig,userRole,gridKey);
    } else if(gridKey === 'CaseClosureReview' ) {
      return this.caseClosureReviewGridConfig(gridConfig,userRole,gridKey);
    } else if(gridKey === 'Approvals' ) {
      return this.approvalGridConfig(gridConfig,gridKey,selectedApprovalStatus);
    } else if(gridKey === 'MyAlerts' ) {
      return this.myAlertsGridConfig(gridConfig,gridKey, userRole,selectedApprovalStatus);
    } else {
      return gridConfig;
    }
  }

  myAlertsGridConfig(gridConfig : any, gridKey:any,userRole: string, selectedApprovalStatus : any) {
    if(selectedApprovalStatus !== 'Fostercare') {
        // gridConfig.columns = this.gridConfigs[gridKey].columns.filter(col => !['Review Period Start Date','Review Period End Date',].includes(col));
        // gridConfig.keys = this.gridConfigs[gridKey].keys.filter(key => !['redet_start_dt', 'redet_end_dt'].includes(key));
        if (userRole === 'ive-specialist') {
          gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Action','Assigned To'].includes(col));
          gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['action','assigned_specialist_name'].includes(key));
          return gridConfig;
        } 
      return gridConfig;
    }  else {
      if (userRole === 'ive-specialist') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Action', 'Assigned To'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['action', 'assigned_specialist_name'].includes(key));
        return gridConfig;
      } 
      return gridConfig;
    }
     
  }

  approvalGridConfig(gridConfig : any, gridKey:any, selectedApprovalStatus : any) {
    selectedApprovalStatus = selectedApprovalStatus === null ? 'PENDING' : selectedApprovalStatus;
    if(selectedApprovalStatus === 'PENDING') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Approved By', 'Approved Date', 'Rejected By', 'Rejected Date'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => ![ 'approvedby', 'approveddate', 'rejectedby', 'rejecteddate'].includes(key));
    } else if(selectedApprovalStatus === 'REJECTED') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Approved By', 'Approved Date' ].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['approvedby', 'approveddate'].includes(key));
    } else if(selectedApprovalStatus === 'APPROVED') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Rejected By', 'Rejected Date'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['rejectedby', 'rejecteddate'].includes(key));
    }
    return gridConfig;  
  }

  fosterCareGridConfig(gridConfig : any, userRole : any, gridKey:any) {
    if (userRole === 'ive-specialist') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Assigned To', 'Assignment Status', 'Action'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['assignedtouser','assignmentstatus','action'].includes(key));
        return gridConfig;
    } else if (userRole === 'ive-supervisor') {
      if(gridKey === 'CaseClosureReview'){
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Status', 'Actions'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['status', 'actions'].includes(key));
        return gridConfig;
      } else {
        return gridConfig;
      }
    }
  }

  caseClosureReviewGridConfig(gridConfig : any, userRole : any, gridKey:any) {
    if (userRole === 'ive-specialist') {
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Assigned To', 'Assignment Status', 'Action'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['assignedto','assignmentstatus','action'].includes(key));
        return gridConfig;
    } else if (userRole === 'ive-supervisor') {
      if(gridKey === 'CaseClosureReview'){
        gridConfig.columns = this.gridConfigs[gridKey].columns.filter((col: string) => !['Status', 'Actions'].includes(col));
        gridConfig.keys = this.gridConfigs[gridKey].keys.filter((key: string) => !['status', 'actions'].includes(key));
        return gridConfig;
      } else {
        return gridConfig;
      }
    }
  }

  gapCitizenData(data:any) {
    this.citizenData = data;
  }
  gepSectionA(data:any) {
    this.SectionAData = data;
  }
  gepSectionB(data:any) {
    this.SectionBData = data;
  }
  gepSectionC(data:any) {
    this.SectionCData = data;
  }
  getClientId(data:any) {
    this.clientIdData = data;
  }
  getRemovalId(id:any) {
    this.removalIdData = id;
  }

  getInvolvedPersonList(caseUUID:any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          where: { objecttypekey: 'servicecase', objectid: caseUUID }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.PersonList + '?filter'
      );
  }

  getDashboardData(requestParam: any, pagination = {
    page: this.paginationInfo.pageNumber,
    limit: this.paginationInfo.pageSize,
  }) {
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: pagination.page,
        limit: pagination.limit,
        method: 'post',
        where: requestParam
      }),
      'titleive/ive/routing?filter'
    );
  }


    getDashboardDataCountDetails(requestParam: any, pagination = {
    page: this.paginationInfo.pageNumber,
    limit: this.paginationInfo.pageSize,
  }) {
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: pagination.page,
        limit: null,
        method: 'post',
        where: requestParam
      }),
      'titleive/ive/mytaskcount?filter'
    );
  }

  getClosureDashboardData(requestParam: any, pagination = {
    page: this.paginationInfo.pageNumber,
    limit: this.paginationInfo.pageSize,
  }) {
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: pagination.page,
        limit: pagination.limit,
        method: 'post',
        where: requestParam
      }),
      'titleive/ive/closureRouting?filter'
    );
  }


  getDashboardApprovalData(requestParam: any, pagination = {
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
  }) {
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: pagination.page,
        limit: pagination.limit,
        method: 'post',
        where: requestParam
      }),
      'titleive/ive/routingsv?filter'
    );
  }

  getMyTaskDashboard(requestParam: any, pagination = {
    page: this.paginationInfo.pageNumber,
    limit: this.paginationInfo.pageSize,
}) {
  return this._commonHttpService
  .getPagedArrayList(
    new PaginationRequest({
      page: pagination.page,
      limit: pagination.limit,
      method: 'post',
      where: requestParam
    }),
    CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.mytaskdashboard + '?filter'
  );
}


  getUsersList() {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'IVEADOP' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      );
  }

  routingUpdate(data:any) {
    return this._commonHttpService.create(data, 'titleive/ive/routingUpdate');
  }


  getwidgetcount(requestParam: any){
   return this._commonHttpService.create({
      where: requestParam,      
      method: 'post',
      nolimit: true
  }, 'titleive/ive/fostercarecountdetails?filter'
  )
  // .subscribe(response => {
      // Filtering DHS Central and Central office from county list on IVE dashboard
      // const removeCounties = ['DHS Central', 'Central Office', 'DHRIS', 'SSC', 'OIG'];
      // this.countylistdropdown = response.filter(a => !removeCounties.includes(a.countyname));
  // });

}
getDashboarddataandcount(requestParam:any,pagination:any){
  return forkJoin({
    data:this.getDashboardData(requestParam,pagination),
    widgetcount:this.getwidgetcount(requestParam)
  });
  

}
getClosurewidgetDashboardData(requestParam:any,pagination:any){

  return forkJoin({
    data:this.getClosureDashboardData(requestParam,pagination),
    widgetcount:this.getwidgetcount(requestParam)
  });
  
}
getMyTaskandwidgetDashboard(requestParam:any, pagination: any){
  
  return forkJoin({
    data:this.getMyTaskDashboard(requestParam,pagination),
    widgetcount:this.getwidgetcount(requestParam)
  });

}
getdashboardClosureDashboardData(requestParam:any,pagination:any){
  return forkJoin({
 data: this.getClosureDashboardData(requestParam,pagination),
 widgetcount:this.getwidgetcount(requestParam)
})
}
getWidgetMytaskdashboard(requestParam:any, pagination:any){
  return forkJoin({
    data: this.getMyTaskDashboard(requestParam,pagination),
    widgetcount:this.getwidgetcount(requestParam)
   })
}

getDashboardWidgetApprovalData(requestParam:any,pagination:any){
  // var param = {...requestParam,'filtertype':'Approvals'}
  return forkJoin({
    data: this.getDashboardApprovalData(requestParam,pagination),
    widgetcount:this.getwidgetcount(requestParam)
   })
}
getIneligiblegraphdata(requestParam:any,pagination:any){
  
  {
    return this._commonHttpService.create({
       where: requestParam,      
       method: 'post',
       nolimit: true
   }, 'titleive/ive/fostercareineligibledetails?filter'
   )
  
 
 }

}
}
