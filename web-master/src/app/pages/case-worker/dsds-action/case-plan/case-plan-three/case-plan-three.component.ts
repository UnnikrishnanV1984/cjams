import { Component, OnInit } from '@angular/core';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CommonHttpService, DataStoreService, AuthService, AlertService, SessionStorageService } from '../../../../../@core/services';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { FormGroup } from '@angular/forms';
import { ServicePlanService } from '../../../_entities/caseworker.data.model';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { AppConstants } from '../../../../../@core/common/constants';
import { CasePlanService } from '../case-plan.service';

@Component({
    selector: 'case-plan-three',
    templateUrl: './case-plan-three.component.html',
    styleUrls: ['./case-plan-three.component.scss'],
    standalone: false
})
export class CasePlanThreeComponent implements OnInit {
  store: any;
  personList: any[] = [];
  versionList: any[] = [];
  caseplan3data:any;
  personListName: any;
  personDataList: any[] = [];
  visitationplans: any[] = [];
  id = '';
  daNumber = '';
  isSupervisor = false;

  //Routing and approval
  selectedPerson: any;
  getUsersList: any[] = [];


  approvalProcess!: string;
  user!: AppUser;
  reviewComments: any;
  reviewFormGroup!: FormGroup;


  periodList: any[] = [];
  serviceplanslist: ServicePlanService[] = [];

  //Snapshot versions for the selected service plan
  snapshotVersions: any[] = [];
  snapshotFilterFormGroup!: FormGroup;
  selectedSnapshotVersion: any;

  //Filtering
  selectedFilterType!: string;
  selectedPeriod: any;

  count: any;
  countobj!: number;

  //Child data
  selectedChildData: any;
  selectedCasePlanVersion: any;
  selectedChildRemovalDate!: Date;
  isClosed = false;

  //visitation plan reference values
  childandvisitortransportation: any[] = [];
  frequencyofplannedvisits: any[] = [];
  lengthofplannedvisit: any[] = [];

  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];

  constructor(
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _authService: AuthService,
    private _alertservice: AlertService,
    private _caseplanService: CasePlanService,
    private storage: SessionStorageService
  ) { 
    this.store = this._dataStoreService.getCurrentStore();
    this.selectedChildData = this.store['SELECTED_CHILD_DATA'];

  }

  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);

    this.selectedCasePlanVersion = this.store['SELECTED_VERSION'];
    
    this.setSelectedVersion(this.selectedCasePlanVersion);
    this.getInvolvedPerson();
    this.getServicePlans();
    this.getChildRemovalDate();

    const da_status = this.storage.getItem('da_status');
           if (da_status) {
            if (da_status === 'Closed' || da_status === 'Completed') {
                this.isClosed = true;
            } else {
                this.isClosed = false;
            }
        }
  }

  ngAfterViewInit() {
    this.scroll('versions-table');
  }

  scroll(id: any) {
    const el: any = document.getElementById(id);
    el.scrollIntoView({behavior: 'smooth', block: 'start', inline: 'nearest'});
  }

  getChildRemovalDate() {
    this.selectedChildRemovalDate = new Date(this.selectedChildData?.removalInfo?.removaldate);
  }

  getPersonName(id: any) {
    if (this.personList && Array.isArray(this.personList)) {
      const person = this.personList.find(item => item.personid === id);
      return (person) ? (person.firstname + ' ' + person.lastname) : '';
    }
    return '';
  }

  getServicePlans() {
    const payload = {
      method: 'get',
      where: {
        caseid : this.id
      }
    };
    this._commonHttpService.getArrayList(payload, 'serviceplan/listbyallrelation?filter').subscribe(
      response => {
        if (this.user.role.name !== 'field') {
          this.serviceplanslist = response.filter((item) =>  item.approvalstatustypekey !== null && item.approvalstatustypekey !== '');
        } else {
          this.serviceplanslist = response;
        }
        if(this.serviceplanslist && this.serviceplanslist.length>0){
          this.serviceplanslist.forEach(plan=>{        this.getHist(plan.serviceplanid);          })
        }
    });
  }

  setSelectedVersion(item: any){
    this.versionList = [];
    if (item && (Array.isArray(item.snapshotdata) && item.snapshotdata.length)) {
      this.caseplan3data = item.snapshotdata[0];
      this.versionList = this.caseplan3data &&  this.caseplan3data['versionList'] ? this.caseplan3data['versionList']  : [];
    }
  }
  
  getPatchDataPayload() {
    const data: any = []
    this.caseplan3data['versionList'] = this.versionList;
    data[0] = this.caseplan3data;
    return data;

  }

   // Save as draft and update once the assessment record is created
  saveSnapshotData() {
    const payload: any = {};
    payload['id'] = this.selectedCasePlanVersion.id;
    payload['snapshotdata'] = this.getPatchDataPayload();
    payload['updatedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    payload['insertedby'] = this._authService?.getCurrentUser()?.user?.securityusersid;
    this._commonHttpService.patch(
      this.selectedCasePlanVersion.id,
      payload,
      'snapshothist'
    ).subscribe((response) => {
        this._alertservice.success('Data saved successfully');
        this.getServicePlans();
      },
      error => {
        this._alertservice.error('Error in saving data');
      }
    );
  }

  //Get list of persons involved -- don't think we need this here
  getInvolvedPerson() {
    let inputRequest = {};
    const isServiceCase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase) {
      inputRequest = {
        objectid: this.id,
        objecttypekey: 'servicecase'
      };
    } else {
      inputRequest = {
        intakeserviceid: this.id
      };
    }
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 20,
      where: inputRequest
    };
    this._commonHttpService.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
      response => {
        this.personList = response.data;

        if (response.data && response.data.length) {
          response.data.forEach(person => {
            this.personDataList.push({'name': person.firstname + ' ' + person.lastname});
          });
          this.personDataList.push({'name': this.user.user.userprofile.displayname});
          if (this.personDataList && this.personDataList.length) {
          this.personListName = this.personDataList[0].name;
          }
        }
      });
  }
    
  selectVersion($event: any, servicePlanVersion: any, servicePlan: any) {
    if($event.checked){
      this.versionList.push({
        serviceplanid: servicePlan.serviceplanid,
        id: servicePlanVersion.id
        // snapshotdata: servicePlanVersion.snapshotdata
      });
    }
    else{
      this.versionList = this.versionList.filter(version => version.id != servicePlanVersion.id);
    }
  }

  getHist(serviceplanid: any) {
    this._commonHttpService
    .getArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        order: 'insertedon desc',
        where: {
         objectid: serviceplanid,
         objecttype: 'SPLAN'
         }
      }),
      'snapshothist' + '?filter'
    ).subscribe(
      response => {
        if(response && Array.isArray(response) && response.length > 0){
        response = response.filter(version => version.approvalstatus === 'Approved');
          this.serviceplanslist.forEach(plan => {
            if (plan.serviceplanid === response[0].objectid) {
              plan.serviceplanversions = response;
            }
          });
          this.populateVersions(response[0].objectid);
        }
     });
  }

  populateVersions(serviceplanid: any){
    const serviceplan: any = this.serviceplanslist.find(plan => plan.serviceplanid == serviceplanid);
    const serviceplanversions: any = serviceplan.serviceplanversions;
    if(this.versionList && this.versionList.length > 0 && serviceplanversions && serviceplanversions.length>0){
      this.versionList.forEach(checkedversion => {
        serviceplanversions.forEach((planversion: any)=>{
          if(planversion.id == checkedversion.id){
            planversion['checked'] = true;
          }
        });
      });
    }
  }


  //Get pdfs
  servicePlanIhmPrint(item: any) {
    const inputRequest = {
         'intakeserviceid': this.id,
         'id': item.serviceplanid,
         'type': 'IHSFP',
         'snapshotid': item.id,
         'documenttemplatekey': [
             'inhome'
         ],
         'isheaderrequired': false,
        //  personinvolved: this.personlistforsnapshot[index]
     };
     const payload = {
       method: 'post',
       count: -1,
       page: 1,
       limit: 20,
       where: inputRequest,
       documntkey: [
         'inhome'
     ],
     };
     this._commonHttpService.create(payload, 'serviceplan/getreportserviceplan').subscribe(
       response => {
         setTimeout(() => window.open(response.data.documentpath), 2000);
      });
     // this.backupService = this.selectedService ? this.selectedService : null;
     // this.selectedService = item;
     // (<any>$('#servicePlanIhmPrint')).modal('show');
   }

   servicePlanOohPrint(item: any) {
    const inputRequest = {
      'intakeserviceid': this.id,
      'id': item.serviceplanid,
      'type': 'OOH',
      'snapshotid': item.id,
      'documenttemplatekey': [
          'inhome'
      ],
      'isheaderrequired': false,
      // personinvolved: this.personlistforsnapshot[index]
  };
  const payload = {
    method: 'post',
    count: -1,
    page: 1,
    limit: 20,
    where: inputRequest,
    documntkey: [
      'oohome'
  ],
  };
  this._commonHttpService.create(payload, 'serviceplan/getreportserviceplan').subscribe(
    response => {
      setTimeout(() => window.open(response.data.documentpath), 2000);
   });
    // this.backupService = this.selectedService ? this.selectedService : null;
    // this.selectedService = item;
    // (<any>$('#servicePlanOohPrint')).modal('show');
  }

  showReviewComments(_item: any) {
    // No function or data to call
  }

  setSelectedSnapshotVersion(_item: any) {
    // No function or data to call
  }

  getRoutingUser(_data: any) {
    // No function or data to call
  }


}
