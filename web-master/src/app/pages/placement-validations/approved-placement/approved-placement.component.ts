import { Component, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, AlertService, SessionStorageService } from '../../../@core/services';
import { FormBuilder, FormGroup} from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { PaginationRequest, PaginationInfo } from '../../../@core/entities/common.entities';
import { PlacementValidationUrlConfig } from './../_constants/placement-validation-url.config';
import { UserProfile } from '../../../@core/entities/authDataModel';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'approved-placement',
    templateUrl: './approved-placement.component.html',
    styleUrls: ['./approved-placement.component.scss'],
    standalone: false
})
export class ApprovedPlacementComponent implements OnInit {
  placementList :any= [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  pickList: any[]=[];
  selectedPlacement: any;
  placementForm!: FormGroup;
  loggedInUser!: UserProfile;
  totalcount!: number;
  clientSearch: any;
  activeModule: string='';
  isSupervisor!: boolean;
  roletype: string='';

  constructor(private _commonService: CommonHttpService, private formBuilder: FormBuilder,
    private route: ActivatedRoute, private _alertService: AlertService, private _authService: AuthService,
    private _sessionStorage: SessionStorageService) { }

  ngOnInit() {
    this.loadInfo();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadInfo();
    });
  }

  loadInfo() {
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile;
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    this.paginationInfo.sortColumn = 'validation_start_dt';
    this.paginationInfo.sortBy = 'desc';
    if (this.activeModule === 'Case Work') {
      this.isSupervisor = false;
      this.roletype = 'CWCW';
    } else if (this.activeModule === 'Approve') {
      this.isSupervisor = true;
      this.roletype = 'CWSP';
    }
    this.initPlacementForm();
    this.getPlacementList();
    this.initPlacementForm();
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
      address: [null]
    });
    this.placementForm.disable();
  }

  onSearchClient() {
    this.paginationInfo.pageNumber = 1;
    if (!this.clientSearch) {
      this.clientSearch = null;
    }
    this.getPlacementList();
  }

  getPlacementList() {
   this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          page: this.paginationInfo.pageNumber,
          limit: this.paginationInfo.pageSize,
          where: {
            'validationstatus': 'Approved',
            roletypekey: this.roletype,
            client_id: this.clientSearch ? this.clientSearch : null,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy
          },
          method: 'get'
        }),
        PlacementValidationUrlConfig.EndPoint.placement.FcReferalListURL + '?filter'
      ).subscribe(res => {
        this.placementList = res.data;
        this.totalcount = res.count;
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

  editPlacement(item: any) {
    this.selectedPlacement = item;
    this.placementForm.reset();
    this.placementForm.patchValue(item);
    this.placementForm.patchValue({
      clientname: item.client_first_nm + ' ' + item.client_last_nm
    });
    (<any>$('#approved-placement-details')).modal('show');
  }

  onChildListSort($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getPlacementList();
}

}

