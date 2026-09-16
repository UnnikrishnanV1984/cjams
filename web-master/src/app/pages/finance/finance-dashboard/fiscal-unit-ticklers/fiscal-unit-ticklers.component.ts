import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService, AuthService, SessionStorageService } from '../../../../@core/services';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { FinanceUrlConfig } from '../../finance.url.config';

declare let $: any;
@Component({
    selector: 'fiscal-unit-ticklers',
    templateUrl: './fiscal-unit-ticklers.component.html',
    styleUrls: ['./fiscal-unit-ticklers.component.scss'],
    standalone: false
})
export class FiscalUnitTicklersComponent implements OnInit {

  totalcount!: number;
  overduecount!: number;
  currentduecount!: number;
  upcomingcount!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fiscalunitticklersList: any[] = [];
  statusDropDownList = [
    {
      'text': 'All',
      'value': 'All'
    },
    {
      'text': 'Unread',
      'value': 'Unread'
    }
  ];
  typeDropDown = [
    {
      'text': 'All',
      'value': 'All'
    },
    /* {
      'text': 'Ancillary Adjustment',
      'value': 'AA'
    },
    {
      'text': 'Ancillary payment',
      'value': 'AP'
    }, */
    {
      'text': 'Account receivable',
      'value': 'AR'
    },
    {
      'text': 'Conserved balance',
      'value': 'CB'
    },
    {
      'text': 'Child leaves from care',
      'value': 'PEV'
    },
    {
      'text': 'Placement voided',
      'value': 'PV'
    }
    
  ];
  fiscalStatus: any;
  userProfile!: AppUser;
  isLastPage: boolean = false;
  ticklerType: any;
  duevalue: any = '';
  activeModule: any;
  roletype!: string;
  provtype!: string;
  userCounty!: void;
  isVissbleButton!: boolean;
  description = '';
  constructor(
    private _commonHttpService: CommonHttpService,
    private _authService: AuthService,
    private _sessionStorage: SessionStorageService
  ) { }

  ngOnInit() {
    this.isVissbleButton = this._authService.isVissbleButton('read_only_access', '');
    this.loadDashboard();
    this._authService.dashboardConfig$.subscribe(_ => {
      this.loadDashboard();
    });
  }

  loadDashboard() {
    this.paginationInfo.pageNumber = 1;
    this.fiscalStatus = 'All';
    this.userProfile = this._authService.getCurrentUser();
    this.activeModule = this._sessionStorage.getItem('activeModuleNav');
    if (this.activeModule === 'Finance') {
      if (this.userProfile.role.description.trim().toLowerCase().includes('central office fiscal staff')) {
        this.typeDropDown = this.typeDropDown.filter(item => item.value === 'AR');
        this.ticklerType = 'AR';
        this.roletype = 'FNSCOFW';
        this.provtype = 'central';
      } else {
        this.ticklerType = 'All';
        this.roletype = 'FNSFW';
        this.provtype = 'others';
      }

    } else if (this.activeModule === 'Finance Approval') {
      this.isVissbleButton = true;
      if (this.userProfile.role.description.trim().toLowerCase().includes('central office fiscal supervisor')) {
        this.typeDropDown = this.typeDropDown.filter(item => item.value === 'AR');
        this.ticklerType = 'AR';
        this.roletype = 'FNSCOSP';
        this.provtype = 'central';
      } else {
        this.ticklerType = 'All';
        this.roletype = 'FNSFS';
        this.provtype = 'others';
      }
    }
    this.paginationInfo.pageNumber = 1;
    this.fiscalStatus = 'All';
    this.getCounty();
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo;
    this.loadList();
  }

  getCounty() {
    this._commonHttpService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result) => {
      if (result !== null) {
        this.userCounty = result[0].statecountycode;
        this.loadList();
      }
    });
  }

  loadList() {
    this.userProfile = this._authService.getCurrentUser();
    this._commonHttpService.endpointUrl = 'tb_receivable_detail/listFiscalunitTicklersDashboard';
    const modal = {
      page : this.paginationInfo.pageNumber,
      limit : this.paginationInfo.pageSize,
      statusval: this.fiscalStatus,
      typeval: this.ticklerType,
      dueval : this.duevalue,
      roletypekey: this.roletype,
      provtype: this.provtype,
      v_county_cd: this.userCounty
    };
    this._commonHttpService.create(modal).subscribe(
      (response) => {
        if (response && response.data && response.data.length > 0) {
          this.listFiscalunitTicklersDashboardApiResponseFn(response);
        } else {
          if (this.isLastPage && this.paginationInfo && this.paginationInfo.pageNumber > 1) {
              this.paginationInfo.pageNumber =  this.paginationInfo.pageNumber -1;
              this.loadList();
          } else {
            this.fiscalunitticklersList = response.data;
          }
        }
      });
  }

  private listFiscalunitTicklersDashboardApiResponseFn(response: any) {
    this.fiscalunitticklersList = response.data;
    this.totalcount = (this.fiscalunitticklersList && this.fiscalunitticklersList.length > 0) ? this.fiscalunitticklersList[0].totalcount : 0;
    this.overduecount = (this.fiscalunitticklersList && this.fiscalunitticklersList.length > 0) ? this.fiscalunitticklersList[0].overduecount : 0;
    this.currentduecount = (this.fiscalunitticklersList && this.fiscalunitticklersList.length > 0) ? this.fiscalunitticklersList[0].currentduecount : 0;
    this.upcomingcount = (this.fiscalunitticklersList && this.fiscalunitticklersList.length > 0) ? this.fiscalunitticklersList[0].upcomingcount : 0;
  }

  statusManualDropDown(status: any) {
    this.isLastPage = false;
    this.fiscalStatus = status;
    this.paginationInfo.pageNumber = 1;
    this.loadList();
  }

  typeManualDropDown(type: any) {
    this.isLastPage = false;
    this.ticklerType = type;
    this.paginationInfo.pageNumber = 1;
    this.loadList();
  }

  updatefiscalticklers(selectedtickler: any, value: string) {
    if (value === 'markasread') {
      selectedtickler.data_valid_sw = 'Y';
    } else if (value === 'markasdone') {
      selectedtickler.action_sw = 'Y';
      selectedtickler.data_valid_sw = 'Y';
    } else {
      selectedtickler.delete_sw = 'Y';
    }
    this.isLastPage = true;

    this._commonHttpService.create(selectedtickler, 'tb_receivable_detail/fiscalunitticklersupdate')
    .subscribe(
      (response) => {
        if (response) {
          this.loadList();
        }
      });    
  }

  dueChange (value: string) {
    this.duevalue = value;
    this.paginationInfo.pageNumber = 1;
    this.loadList();
  }

  resetFilter() {
    this.paginationInfo.pageNumber = 1;
    this.fiscalStatus = 'All';
    this.ticklerType = 'All';
    this.duevalue = '';
    this.loadList();
  }

  openDescriptionDialog(provider: any): void {
    this.description = provider.tickler_tx;
    this.description = this.description.replace(/''/g, `'`);
    $('#description-dialog').modal('show');
    $('div.modal-backdrop.show').hide();
  }

}
