import { Component, Injector, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { AppUser } from '../../../@core/entities/authDataModel';
import { GridType, CompactType, DisplayGrid, GridsterConfig, GridsterItem } from 'angular-gridster2';
import { FinanceDashboardWidgetConfig } from './finance-dashborad.widget.config';
import { UserCounty } from '../finance.constants';
import { FinanceUrlConfig } from '../finance.url.config';
import { RoleGuard } from '../../../@core/guard';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'finance-dashboard',
    templateUrl: './finance-dashboard.component.html',
    styleUrls: ['./finance-dashboard.component.scss'],
    standalone: false
})
export class FinanceDashboardComponent implements OnInit {
  user!: AppUser;
  financeDirector!: boolean;
  financeSupervisor!: boolean;
  programManager!: boolean;
  options!: GridsterConfig;
  dashboardMain!: GridsterItem[];
  dashboardWidget!: Array<GridsterItem>;
  userCounty: any;
  activeModule: any;
  financeapproval = 'Finance Approval';
  
  private _roleGuard: RoleGuard;
  private _authService: AuthService;
  private _commonService: CommonHttpService;
  private _dataStore: DataStoreService;
  private _sessionStorage: SessionStorageService;

  constructor(private injector : Injector) {
      this._roleGuard = this.injector.get<RoleGuard>(RoleGuard);
      this._authService = this.injector.get<AuthService>(AuthService);
      this._commonService = this.injector.get<CommonHttpService>(CommonHttpService);
      this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
      this._sessionStorage = this.injector.get<SessionStorageService>(SessionStorageService);
    }

  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    this.getCounty();
    this.loadDashboardInfo();
    this._authService.dashboardConfig$.subscribe(data => {
      this.loadDashboardInfo();
    });
}

loadDashboardInfo() {
  this.options = {
    gridType: GridType.VerticalFixed,
    compactType: CompactType.CompactLeftAndUp,
    margin: 10,
    outerMargin: true,
    outerMarginTop: null,
    outerMarginRight: null,
    outerMarginBottom: null,
    outerMarginLeft: null,
    mobileBreakpoint: 640,
    minCols: 12,
    maxCols: 12,
    minRows: 1,
    maxRows: 4,
    maxItemCols: 100,
    minItemCols: 1,
    maxItemRows: 100,
    minItemRows: 1,
    maxItemArea: 2500,
    minItemArea: 1,
    defaultItemCols: 1,
    defaultItemRows: 1,
    fixedColWidth: 46,
    fixedRowHeight: 450,
    keepFixedHeightInMobile: false,
    keepFixedWidthInMobile: false,
    scrollSensitivity: 10,
    scrollSpeed: 20,
    enableEmptyCellClick: false,
    enableEmptyCellContextMenu: false,
    enableEmptyCellDrop: false,
    enableEmptyCellDrag: false,
    emptyCellDragMaxCols: 50,
    emptyCellDragMaxRows: 50,
    ignoreMarginInRow: true,
    draggable: {
        delayStart: 0,
        enabled: true,
        ignoreContentClass: 'gridster-item-content',
        ignoreContent: false,
        dragHandleClass: 'drag-handler'
    },
    resizable: {
        delayStart: 0,
        enabled: true,
        handles: {
            s: true,
            e: true,
            n: true,
            w: true,
            se: true,
            ne: true,
            sw: true,
            nw: true
        }
    },
    swap: true,
    pushItems: true,
    disablePushOnDrag: false,
    disablePushOnResize: false,
    pushDirections: {
        north: true,
        east: true,
        south: true,
        west: true
    },
    pushResizeItems: false,
    displayGrid: DisplayGrid.Always,
    disableWindowResize: false,
    disableWarnings: false,
    scrollToNewItems: false,
};
let fundingApproval!: boolean;
let paymentApproval!: boolean;
let directorApproval!: boolean;
let programManagerApproval!: boolean;
const resourcePermission: any[] = this._roleGuard.getPermissionsList();
if (resourcePermission) {
  fundingApproval = (resourcePermission.filter(data => data.name === 'manage_funding_approval').length > 0);
  paymentApproval = (resourcePermission.filter(data => data.name === 'manage_payment_approval').length > 0);
  directorApproval = (resourcePermission.filter(data => data.name === 'manage_over1000_approval').length > 0);
  programManagerApproval = (resourcePermission.filter(data => data.name === 'bc_approval_manage_over1000').length > 0);
}
this.activeModule = this._sessionStorage.getItem('activeModuleNav');
if ((this.user.role.name === 'DF' || directorApproval) && (programManagerApproval)) {
  this.ifProgramManagerApprovalFn();
} else {
  this.ElseProgramManagerApprovalFn(directorApproval, programManagerApproval, fundingApproval, paymentApproval);
}
 this.restoreWidgets();
}
  // Associated with loadDashboardInfo function
  private ElseProgramManagerApprovalFn(directorApproval: boolean, programManagerApproval: boolean, fundingApproval: boolean, paymentApproval: boolean) {
    if (this.user.role.name === 'DF' || directorApproval) {
      if (this.activeModule === this.financeapproval) {
        this.financeSupervisor = true;
        this.financeDirector = false;
        this.programManager = false;
        this.dashboardMain = FinanceDashboardWidgetConfig.master.FS;
        this.options.maxRows = 9;
      } else {
        this.financeDirector = true;
        this.financeSupervisor = false;
        this.programManager = false;
        this.dashboardMain = FinanceDashboardWidgetConfig.master.DF;
        this.options.maxRows = 1;
      }
    } else if (programManagerApproval) {
      if (this.activeModule === this.financeapproval) {
        this.financeSupervisor = true;
        this.financeDirector = false;
        this.programManager = false;
        this.dashboardMain = FinanceDashboardWidgetConfig.master.FS;
        this.options.maxRows = 9;
      } else {
        this.programManager = true;
        this.financeDirector = false;
        this.financeSupervisor = false;
        this.dashboardMain = FinanceDashboardWidgetConfig.master.PM;
        this.options.maxRows = 1;
      }
    } else if (this.activeModule === this.financeapproval || (fundingApproval && paymentApproval)) {
      this.financeSupervisor = true;
      this.financeDirector = false;
      this.programManager = false;
      this.dashboardMain = FinanceDashboardWidgetConfig.master.FS;
      this.options.maxRows = 9;
    } else if (this.activeModule === 'Finance') {
      this.financeDirector = false;
      this.financeSupervisor = false;
      this.programManager = false;
      this.dashboardMain = FinanceDashboardWidgetConfig.master.FW;
      this.options.maxRows = 10;
    }
  }
  // Associated with loadDashboardInfo function
  private ifProgramManagerApprovalFn() {
    if (this.activeModule === this.financeapproval) {
      this.financeSupervisor = true;
      this.financeDirector = false;
      this.programManager = false;
      this.dashboardMain = FinanceDashboardWidgetConfig.master.FS;
      this.options.maxRows = 9;
    } else {
      this.financeDirector = true;
      this.financeSupervisor = false;
      this.programManager = true;
      this.dashboardMain = FinanceDashboardWidgetConfig.master.PMDF;
      this.options.maxRows = 2;
    }
  }

restoreWidgets() {
  const resources: any[] = this._roleGuard.getPermissionsList();
  if (resources) {
    const filterS = resources.filter((item: any) => !item.isvisible && item.modulekey === 'finance-module').map((item) => {
      return item.description;
    });
    filterS.forEach((item: any) => {
      this.dashboardMain.forEach((res, index) => {
        if (res.title === item) {
          this.dashboardMain.splice(index, 1);
        }
      });
    });
  }
  this.dashboardMain.forEach((element: GridsterItem) => {
      element.show = true;
  });
  this.dashboardWidget = Object.assign([], this.dashboardMain);
}

showWidget(selection: boolean, item: GridsterItem) {
  if (!selection) {
      item.show = false;
      for (let i = 0; i < this.dashboardWidget.length; i++) {
          if (item.number === this.dashboardWidget[i].number) {
              this.dashboardWidget.splice(i, 1);
              break;
          }
      }
  } else {
      item.show = true;
      this.dashboardWidget.push(item);
  }
}

getCounty() {
  this._commonService.getArrayList({ method: 'get', where : {}}, FinanceUrlConfig.EndPoint.general.userCounty + '?filter').subscribe((result) => {
    if (result !== null) {
        this.userCounty = result;
        this._dataStore.setData(UserCounty.CountyData, result);
        if (result && result.length > 0) {
          this._dataStore.setData('selectedFinanceDept', result[0].statecountycode);
        }
    }
  });
}
removeItem(item:any){
  //function was not defined initially - added as part of angular upgraed issue fix
}
refreshItem(item:any){
   //function was not defined initially - added as part of angular upgraed issue fix
}
}
