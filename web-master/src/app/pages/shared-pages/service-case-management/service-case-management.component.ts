import { Component, OnInit } from '@angular/core';
import { AlertService, AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { AppConstants } from '../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { DSDSActionSummary, ServiceCaseResponsbility } from '../../case-worker/_entities/caseworker.data.model';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { PaginationRequest } from '../../../@core/entities/common.entities';
import { take } from 'rxjs/internal/operators/take';

@Component({
    selector: 'service-case-management',
    templateUrl: './service-case-management.component.html',
    styleUrls: ['./service-case-management.component.scss'],
    standalone: false
})
export class ServiceCaseManagementComponent implements OnInit {
  dsdsActionsSummary = new DSDSActionSummary();
  isServiceCase = false;
  isCW = false;
  isCaseWorker = false;
  isSupervisor = false;
  selectedServiceCaseId: string | null = null;
  daNumber!: string;
  id!: string;
  serviceCaseNumber: any;
  exitingServiceCaseList: Array<any> = [];
  reporterName!: string;
  serviceprogramkey: any[] = [];
  familyworker!: ServiceCaseResponsbility | undefined;
  childworker!: ServiceCaseResponsbility | undefined;
  getUsersList = [];
  selectedPerson : any;
  isClosed: boolean = false;
  routingupdateurl = 'routing/routingupdate';
  confirmrequestcasepopupid = '#confirm-request-case';
  servicecasehistorynew = '#serviceCaseHistoryNew';
  searchString: any;
  isProcessingRoute:boolean = false;
  
  constructor(
        private _alertService: AlertService,
        private _authService: AuthService,
        private _dsdsActionService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        private storage: SessionStorageService,
        private _commonHttpService: CommonHttpService
  ) { }

  ngOnInit() {
    this.isServiceCase = this.storage.getItem('ISSERVICECASE');
    this.dsdsActionsSummary= this._dataStoreService.getData('dsdsActionsSummary');
    this.isCW = this._authService.isCW();
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
    this.id =  this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    const statusobj = this._dataStoreService.getData('object');
    if (statusobj) {
      if(statusobj.da_status === 'Closed' || statusobj.da_status === 'Completed') {
          this.isClosed = true;
      } else {
          this.isClosed = false;
      }
    }
  }

  selectCase(selectedcase: any) {
    if (selectedcase === 'NEW_CASE') {
        this.selectedServiceCaseId = 'NEW_CASE';
    } else {
        this.selectedServiceCaseId = selectedcase.servicecaseid;

        this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this.isProcessingRoute = true;
        this.routToServiceCase(selectedcase);

    }
}
routToServiceCase(selectedcase: any) {
    if (selectedcase) {
        this.storage.setItemKey(selectedcase.servicecasenumber + '.' + CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, selectedcase.objecttypekey);
    }
    const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + selectedcase.servicecaseid + '/casetype';
    
    this._dsdsActionService.getAll(url)
        .pipe(take(1)) 
        .subscribe({
            next: (response) => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                    this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                    this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                    const currentUrl = '#/pages/case-worker/' + selectedcase.servicecaseid + '/' + selectedcase.servicecasenumber + '/dsds-action/person-cw';
                    window.open(currentUrl);
                    this.storage.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
                }
                this.isProcessingRoute = false; 
            },
            error: (err) => {
                this.isProcessingRoute = false;
            }
        });
}


createOrMergeServiceCase() {
    const serviceCaseData = {
        servicecaseid: this.selectedServiceCaseId === 'NEW_CASE' ? null :  this.selectedServiceCaseId ,
        intakeserviceid: this.id,
        isnewcase: this.selectedServiceCaseId === 'NEW_CASE' ? 1 : 0,
        subtypekey: 'IHM', // INHOME SERVICES,
        source: 'intake'
    };
    this._dsdsActionService
        .create(serviceCaseData, 'servicecase/createservicecase')
        .subscribe(response => {
            this.serviceCaseNumber = response[0].servicecaseno;
            const routingObject = {
                objectid: this.id,
                eventcode: 'SCCR',
                status: 'Accepted',
                intakeserviceid: this.id
            };


            this._dsdsActionService.create(routingObject, this.routingupdateurl).subscribe((res) => {
                this._alertService.success('Service case created: ' + this.serviceCaseNumber);
                if (this.selectedServiceCaseId === 'NEW_CASE') {
                    (<any>$('#confirm-navigation-assign-service-case')).modal('show');
                }
            });
            this.hideHistoryOfFmailyCase();
        });

}

confirmRequestCase() {
  const routingObject = {
      objectid: this.id,
      eventcode: 'SCCR',
      status: 'Review',
      intakeserviceid: this.id,
      tosecurityusersid: this.selectedPerson ? this.selectedPerson.userid : ''
  };

  /*
  comments: "Case worker has requested to open a in-home service case.",
  notifymsg: 'Notify message',
  routeddescription: 'routing description'
  */
  this._dsdsActionService.create(routingObject, this.routingupdateurl).subscribe((res) => {
      this._alertService.success('Successfully Requested to Open a Service Case.');
      this.routeIntakeServiceRequestToCaseWorker1(this.daNumber);
  });


  (<any>$(this.confirmrequestcasepopupid)).modal('hide');
  this.hideHistoryOfFmailyCase();
}

routeIntakeServiceRequestToCaseWorker1(item: any) {
  (<any>$(this.confirmrequestcasepopupid)).modal('hide');
  this._dsdsActionService.getById(item, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
          this.dsdsActionsSummary.caseconnectsent = dsdsActionsSummary.caseconnectsent;
      }
  });
}

hideHistoryOfFmailyCase() {
    (<any>$(this.servicecasehistorynew)).modal('hide');
}
openHistoryOfFamilyCase(caseList: any) {
  this.exitingServiceCaseList = caseList;
  (<any>$(this.servicecasehistorynew)).modal('show');
}
linkToServiceCase() {
  this._dsdsActionService
      .getArrayList(
          {
              where: { intakeserviceid: this.id, source: 'cps' },
              method: 'get'
          },
          'intakeservreqchildremoval/servicecasevalidation?filter'
      ).subscribe((result: any) => {
          if (result.isavailable === 1) {
              this.openHistoryOfFamilyCase(result.data);

          } else {
              this.getActionSummary();
              this._alertService.success('Successfully Linked to Service Case');
              const routingObject = {
                  objectid: this.id,
                  eventcode: 'SCCR',
                  status: 'Accepted',
                  intakeserviceid: this.id

              };

              this._dsdsActionService.create(routingObject, this.routingupdateurl).subscribe((res) => {
                  this._alertService.success('Service case created: ' + (this.serviceCaseNumber || this.dsdsActionsSummary.servicecasenumber));
                  (<any>$('#confirm-navigation-assign-service-case')).modal('show');
              });
          }
      });
}

private getActionSummary() {    
  const isExpungementSuperUser = this._authService.isExpungementSuperUser();
  const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
  this.serviceprogramkey = [];
  let url = '';
  if (this.isServiceCase) {
      url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.id + '/casetype' + `?isExpungementSuperUser=${isExpungementSuperUser}`;
  } else {
      url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.daNumber + `?isExpungementSuperUser=${isExpungementSuperUser}&iscaseexpunged=${iscaseexpunged}`;
  }
  this._dsdsActionService.getAll(url).subscribe(
      (response) => {
          this.dsdsActionsSummary = response[0];
          if (this.dsdsActionsSummary) {
              this.dsdsActionsSummaryResponse();
          } else {
              this._alertService.error('DSDS Action Summary is Empty, Please Check Your Data.');
          }
      },
      error => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
  );
}

    private dsdsActionsSummaryResponse() {
        if (this.dsdsActionsSummary?.intake_jsondata?.narrative?.length > 0) {
            this.reporterName = this.dsdsActionsSummary.intake_jsondata.narrative[0].Firstname + ' ' + this.dsdsActionsSummary.intake_jsondata.narrative[0].Lastname;
            if (!this.reporterName || !this.reporterName.replace(/\s/g, '').length) {
                this.reporterName = '';
            }
        }
        if (this.dsdsActionsSummary?.programarea?.length > 0) {
            this.dsdsActionsSummary.programarea.forEach(element => {
                this.serviceprogramkey.push(element);
            });
        }
        if (this.dsdsActionsSummary.responsibleworkers && Array.isArray(this.dsdsActionsSummary.responsibleworkers)) {
            this.familyworker = this.dsdsActionsSummary.responsibleworkers.find(worker => worker.responsibilitytypekey === 'family');
            this.childworker = this.dsdsActionsSummary.responsibleworkers.find(worker => worker.responsibilitytypekey === 'child');
        }

        this.reusableDataSet();
    }

    private reusableDataSet() {
        this._dataStoreService.setData('object', this.dsdsActionsSummary);
        this._dataStoreService.setData('da_status', this.dsdsActionsSummary.da_status);
        this._dataStoreService.setData('teamtypekey', this.dsdsActionsSummary.teamtypekey);
        this._dataStoreService.setData('teamid', this.dsdsActionsSummary.teamid);
        this._dataStoreService.setData('dsdsActionsSummary', this.dsdsActionsSummary);
        this._dataStoreService.setData('youthFullName', this.dsdsActionsSummary.da_lastname + ' ' + this.dsdsActionsSummary.da_suffix + ', ' + this.dsdsActionsSummary.da_firstname);
        this._dataStoreService.setData('da_legalGuardian', this.dsdsActionsSummary.da_legalGuardian);
        this._dataStoreService.setData('da_focus', this.dsdsActionsSummary.da_focus);
        this._dataStoreService.setData('da_personid', this.dsdsActionsSummary.personid);
        this._dataStoreService.setData('da_persondob', this.dsdsActionsSummary.persondob);
        this._dataStoreService.setData('da_foldertypedecription', this.dsdsActionsSummary.foldertypedescription);
        this._dataStoreService.setData('da_foldertypekey', this.dsdsActionsSummary.foldertypekey);
        this._dataStoreService.setData('da_intakenumber', this.dsdsActionsSummary.intakenumber);
        this._dataStoreService.setData('countyid', this.dsdsActionsSummary.countyid);
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.CPS_CASE_ID, this.dsdsActionsSummary.intakeserviceid);
    }

routeServiceCaseToCaseWorker(servicerequestnumber: any) {
  (<any>$(this.servicecasehistorynew)).modal('hide');
  (<any>$(this.confirmrequestcasepopupid)).modal('hide');
    this.storage.removeItemWithOutTab('ISADOPTION');
    this.storage.setTabKeyKey( servicerequestnumber.servicecasenumber);
    this.storage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    if (servicerequestnumber.servicecasenumber) {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, servicerequestnumber.servicecasenumber.objecttypekey);
    }
    const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + servicerequestnumber.servicecaseid + '/casetype';
    this._commonHttpService.getAll(url).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
        this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
        const currentUrl = '#/pages/case-worker/' + servicerequestnumber.servicecaseid + '/' + servicerequestnumber.servicecasenumber + '/dsds-action/report-summary';
        window.open(currentUrl);
      }
    });
}


  selectPerson(row: any) {
    this.selectedPerson = row;
  }

/**
   * Public provider assignment & Routing
   */
  getRoutingUser() {
     this.getUsersList = [];
     this._commonHttpService
     .getPagedArrayList(
         new PaginationRequest({
             where: { appevent:  'SCCR' },
             method: 'post'
         }),
         'Intakedastagings/getroutingusers'
     )
     .subscribe((result: any) => {
         this.getUsersList = result.data;
         this.getUsersList = this.getUsersList.filter((users: any) => users.userid !== this._authService.getCurrentUser().user.securityusersid
         );
     });



}



}
