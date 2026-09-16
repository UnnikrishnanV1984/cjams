
import {forkJoin as observableForkJoin } from 'rxjs';

import {map} from 'rxjs/operators';
import { ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, AlertService, SessionStorageService, DataStoreService } from '../../../@core/services';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { PlacementValidationUrlConfig } from './../_constants/placement-validation-url.config';
import { UserProfile, AppUser } from '../../../@core/entities/authDataModel';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import moment from 'moment';

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'pending-placement',
    templateUrl: './pending-placement.component.html',
    styleUrls: ['./pending-placement.component.scss'],
    standalone: false
})
export class PendingPlacementComponent implements OnInit {
  placementList :any= [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  pickList: any[]=[];
  selectedPlacement: any;
  placementForm!: FormGroup;
  loggedInUser!: UserProfile;
  totalcount!: number;
  savePlacement: any[]=[];
  saveBulkItems: any[]=[];
  caseWorkerList:any[]=[];
  bulkReceipt: any[] = [];
  sendBulkList: any[] = [];
  enableBulk: boolean = false;
  selectTransBulk: boolean = false;
  dupResponse: any;
  id: any;
  daNumber: any;
  enableSave!: boolean;
  placementDis!: boolean;
  clientSearch: any;
  caseWorkerSelected: string='';
  userProfile!: AppUser;
  isSupervisor: boolean=false;
  activeModule: any;
  roletype: string='';
  // validateChecked: number;
  placementCheck: any[]=[];
  subscription: any;
  caseworkerform!: FormGroup;
  caseworkerformfirst: string='';
  placementview = '#placement-view';
  filterCase: string='';
  KRD_enddate: any;
  KRD_startdate: any;
  private _commonService: CommonHttpService;
  private formBuilder: FormBuilder;
  private _router: Router;
  private _authService: AuthService;
  private _sessionStorage: SessionStorageService;
  private _dataStoreService: DataStoreService;
  private _alertService: AlertService;

  constructor(private injector : Injector, private cdr: ChangeDetectorRef) { 
    this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);	
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
	  this._router = this.injector.get<Router>(Router);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._alertService = this.injector.get<AlertService>(AlertService);
  }

  ngOnInit() {
    this.formcaseworkerform();
    this.caseworkerformfirst = '';
    this.getCaseWorkerList();
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
    this.getDates();
  }

  loadInfo() {
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Case Work') {
      this.isSupervisor = false;
      this.roletype = 'CWCW';
    } else if (this.activeModule === 'Approve') {
      this.isSupervisor = true;
      this.roletype = 'CWSP';
    }
    this.userProfile = this._authService.getCurrentUser();
    if (this.userProfile) {
      this.isSupervisor = this.userProfile.role.name === 'apcs' ? true : false;
    }
    this.initPlacementForm();
    this.getPlacementList();
    this.getPlacementValidationType();
    this.paginationInfo.sortColumn = 'validation_start_dt';
    this.paginationInfo.sortBy = 'desc'
  }

  onCaseWorkerSelect(){
    this.paginationInfo.pageNumber = 1;
    this.getPlacementList();
  }

  initPlacementForm() {
    this.placementForm = this.formBuilder.group({
      client_id: [null],
      clientname: [null],
      entry_dt: [null],
      exit_dt: [null],
      placement_entry_dt: [null],
      placement_exit_dt: [null],
      placement_id: [null],
      contract_program_nm: [null],
      provider_nm: [null],
      service_nm: [null],
      servicerequestnumber: [null],
      totalcount: [null],
      validation_end_dt: [null],
      validation_start_dt: [null],
      placement_structure_nm: [null],
      validation_month: [null],
      comment_tx: [null],
      cis_id: [null],
      validation_status_cd: [null],
      address: [null]
    });
    this.placementForm.disable();
    this.placementForm.get('comment_tx')?.enable();
    this.placementForm.get('validation_status_cd')?.enable();
    this.placementForm.get('validation_status_cd')?.setValidators(Validators.required);
    this.placementForm.get('validation_status_cd')?.updateValueAndValidity();
  }
  
  onSearchClient() {
    this.paginationInfo.pageNumber = 1;
    if (!this.clientSearch) {
      this.clientSearch = null;
    }
    this.getPlacementList();
  }

  getPlacementList() {
    if (this.caseworkerformfirst !== '') {
      this.caseWorkerSelected = this.caseworkerformfirst;
      this.caseworkerformfirst = '';
    }
    if (this.roletype === 'CWCW') {
      this.caseWorkerSelected = '';
    }
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            'validationstatus': 'Pending',
            roletypekey: this.roletype,
            client_id: this.clientSearch ? this.clientSearch : null,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy,
            cwid: this.caseWorkerSelected
          },
          method: 'get'
        }),
        PlacementValidationUrlConfig.EndPoint.placement.FcReferalListURL + '?filter'
      ).subscribe(res => {
        if (res) {
          this.placementList = res.data;
          this.dupResponse = res.data;
          this.totalcount = res.count;
          this.placementDis = !res?.data?.length;
        }
      });
  }

  pageChanged(pageNumber: number) {
    this.paginationInfo.pageNumber = pageNumber;
    this.getPlacementList();
  }

  getPlacementValidationType() {
    this._commonService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '146'
      },
      nolimit: true,
      method: 'get'
    }), PlacementValidationUrlConfig.EndPoint.placement.PlacementValidationTypeUrl + '?filter').subscribe(result => {
      this.pickList = result;
    });
  }

  saveValidation() {
    this.savePlacement = [];
    this.placementCheck = [];

    const placement = this.placementForm.getRawValue();

    this._commonService.endpointUrl = 'placement/placementAutoValidation';
    const model = {
      placementid: placement.placement_id,
      startdate: placement.validation_start_dt ? placement.validation_start_dt : null,
      enddate: placement.validation_end_dt ? placement.validation_end_dt : null,
      update_sw: 'N',
      isbefore: true,
      fromscreen: 'pv', // pv-- From placement validation screen
      servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
    };
    this._commonService.create(model).subscribe(
    (response) => {
      if (response && response.length > 0) {
        this.placementCheck = response;
        (<any>$(this.placementview)).modal('hide');
        (<any>$('#placement-approval-check')).modal('show');
      } else {
        this._commonService.endpointUrl = PlacementValidationUrlConfig.EndPoint.placement.UpdatePlacementValidation;
        this.savePlacement.push({
          validation_status_cd: placement.validation_status_cd ? 1750 : 1749,
          update_ts: new Date(),
          update_user_id: this.loggedInUser.securityusersid,
          placement_validation_id: this.selectedPlacement.placement_validation_id
        });
        this._commonService.create({ placement: this.savePlacement }).subscribe(result => {
          this._alertService.success('Placement Updated Successfully.');
          this.getPlacementList();
          (<any>$(this.placementview)).modal('hide');
        });
      }
    });  
  }

  confirmUpdate() {
    ($('#maintenance-payment-check-dialog-h') as any).modal('show');
  }

  getDates() {
    this._commonService.getSettings(['KRD_startdate','KRD_enddate']).subscribe(
      (res: any) => {
        this.KRD_startdate = res.settings?.find((e:any) => e.settingname === 'KRD_startdate')?.settingvalue;
        this.KRD_enddate = res.settings?.find((e:any) => e.settingname === 'KRD_enddate')?.settingvalue;
        return res;
      },
      (error: any) => {
        console.error('Error fetching setting:', error);
      }
    );
  }

  editPlacement(item: any) {
    this.id = item.servicecaseid;
    this.daNumber = item.case_id;
    this.selectedPlacement = item;
    this.placementForm.reset();
    item.validation_status_cd = (item.validation_status_cd === 1750);
    const endDateLimit :any= this.KRD_enddate ? new Date(this.KRD_enddate) : null;
    const startDateLimit :any= this.KRD_startdate ? new Date(this.KRD_startdate) : null;


    this.placementForm.patchValue(item);
    this.placementForm.patchValue({
      clientname: item.client_first_nm + ' ' + item.client_last_nm
    });
    (<any>$(this.placementview)).modal('show');
    if (item.placement_structure_nm === "Restricted (Relative) Foster Care" && item.validation_end_dt > endDateLimit) {
      this.filterCase = 'Restricted Relative placements are not valid later than '  +  moment(this.KRD_enddate).format('MM-DD-YYYY') + ' Please enter a valid placement exit date. A Kinship Home placement must be opened for the child for any dates on or after '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + ' in order for the kinship caregiver to continue to receive payment.'
      this.confirmUpdate();
      return;
    }

    if ((item.placement_structure_nm === 'Kinship' || item.placement_structure_nm === 'Non-Kinship') && item.validation_start_dt < startDateLimit) {
      this.filterCase = 'This placement structure is only valid starting on '  +  moment(this.KRD_startdate).format('MM-DD-YYYY') + '. A different placement or living arrangement must be used for any time prior to this date.'
      this.confirmUpdate();
    }
  }

  viewPlacementReDirect() {
    (<any>$(this.placementview)).modal('hide');
    this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
    if (this.id && this.daNumber) {
      this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, 'servicecase');
    }
    const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + this.id + '/casetype';
    this._commonService.getAll(url).subscribe((response) => {
      const dsdsActionsSummary = response[0];
      if (dsdsActionsSummary) {
        this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
        this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
        const currentUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/sc-placements/list';
        this._router.navigate([currentUrl]);
      }
    });
    
  }

  getBulk(event:any) {
    this.bulkReceipt = [];
    if (event) {
      this.enableBulk = true;
      if (this.dupResponse && this.dupResponse.length) {
        for (let i = 0; i < this.dupResponse.length; i++) {
          this.transChanged(event,this.dupResponse[i], false);
          (<any>$('#trans-id-' + i)).prop('checked', true);
          this.selectTransBulk = true;
        }
      }
    } else {
      this.dupResponse.forEach((dr:any )=> {
        this.transChanged(event,dr, false);
      });
      this.enableBulk = false;
      this.selectTransBulk = false;
      (<any>$('.trans')).prop('checked', false);
    }
    this.cdr.detectChanges();
  }

  formcaseworkerform() {
    this.caseworkerform = this.formBuilder.group({
      securityusersid: ['']
    });
  }

  getCaseWorkerList() {
    const appEvent = 'ALLCW';
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: appEvent , teamid: null},
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe((result) => {
        const data = result.data;
        this.caseWorkerList = data.filter(item => item.username);
        this.caseworkerform.controls['securityusersid'].patchValue(this.caseWorkerList[0].userid);
        this.caseworkerformfirst = this.caseWorkerList[0].userid;
        this.getPlacementList();
      });
  }

  transChanged(event:any, placementdata:any, flag: any) {
    const checked:any =flag ? event?.target?.checked : event;
    const receipt = JSON.parse(JSON.stringify(placementdata));
    const selectedReceipt = (this.bulkReceipt && this.bulkReceipt.length > 0) ? this.bulkReceipt.find(rec => rec.placement_validation_id === receipt.placement_validation_id) : null;
    // receipt.validation_status_cd = placement.validation_status_cd ?  1750 : 1749,
    receipt.update_ts = new Date();
    if (checked) {
      this.sendBulkList.push(this.placementList.find((rec:any) => rec.placement_validation_id === placementdata.placement_validation_id));
      if (!selectedReceipt) {
        this.bulkReceipt.push({
          validation_status_cd: 1750,
          update_ts: new Date(),
          placement_validation_id: placementdata.placement_validation_id ? placementdata.placement_validation_id : null
        });
      }
    } else {
      this.sendBulkList = this.sendBulkList.filter(rec => rec.placement_validation_id !== placementdata.placement_validation_id);
      this.selectTransBulk = false;
      this.bulkReceipt = this.bulkReceipt.filter(rec => rec.placement_validation_id !== receipt.placement_validation_id);
      // }
    }
    this.enableBulk = !!this.bulkReceipt.length;
    const receptlist = this.placementList;
    if (this.bulkReceipt.length !== 0) {
      const bulkcheckboxselect = (receptlist.length === this.bulkReceipt.length);
      if (bulkcheckboxselect) {
        this.selectTransBulk = true;
      } else {
        this.selectTransBulk = false;
      }
    } else {
      this.selectTransBulk = false;
    }
  }

  saveBulkValidation() {
    this.placementCheck = [];
    const all_obs :any= [];
    let i = 0;
    const length = this.sendBulkList.length;
    this.sendBulkList.forEach(dupItem => {
      this._commonService.endpointUrl = 'placement/placementAutoValidation';
      all_obs.push(
        this._commonService.create(
          {
            placementid: dupItem.placement_id,
            startdate: dupItem.validation_start_dt ? dupItem.validation_start_dt : null,
            enddate: dupItem.validation_end_dt ? dupItem.validation_end_dt : null,
            update_sw: 'N',
            isbefore: true,
            fromscreen: 'pv', // pv-- From placement validation screen
            servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)
          }
        ).pipe(map(
        (response) => {
          if (response && response.length > 0) {
            this.placementCheck = response;
          } else {
            this._commonService.endpointUrl = PlacementValidationUrlConfig.EndPoint.placement.UpdatePlacementValidation;
            this.saveBulkItems = [];
            this.saveBulkItems.push({
              validation_status_cd: dupItem.validation_status_cd ? 1750 : 1749,
              update_ts: new Date(),
              update_user_id: this.loggedInUser.securityusersid,
              placement_validation_id: dupItem.placement_validation_id
            });
            this._commonService.create({ placement: this.saveBulkItems }).subscribe(
              () => {
                i++;
                (<any>$(this.placementview)).modal('hide');
                if (length === i) {
                  this.getPlacementList();
                }
              },
              (error) => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
            );
          }
        }))
      );//end obs push
    });  

    observableForkJoin(all_obs).subscribe(() => {
      this.saveBulkItems = [];
      if (this.placementCheck.length > 0) {
        this.placementCheck.sort((a,b) => new Date(a.validation_start_dt) >= new Date(b.validation_start_dt) ? -1 : 1 );
        (<any>$(this.placementview)).modal('hide');
        (<any>$('#placement-approval-check')).modal('show');
        this.selectTransBulk = false;
        this.sendBulkList = [];
        this.getPlacementList();
      } else {
        this._alertService.success('Selected Placement Validation Saved Successfully');
        this.selectTransBulk = false;
        this.sendBulkList = [];
        this.getPlacementList();
      }
    });
  }

  validateCheck(checked:boolean) {
    if (checked === true) {
      this.enableSave = true;
    } else {
      this.enableSave = false;
    }
  }

  onChildListSort($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getPlacementList();
  }
}
