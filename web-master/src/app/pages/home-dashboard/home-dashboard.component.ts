import { Component, OnInit } from '@angular/core';
import { CompactType, DisplayGrid, GridsterConfig, GridsterItem, GridType } from 'angular-gridster2';
import { Subject } from 'rxjs';

import { BroadCostMessage } from './_entities/home-dash-entities';
import { DashboardTeamperformanceComponent } from './dashboard-teamperformance/dashboard-teamperformance.component';
import { AuthService } from '../../@core/services/auth.service';
import { AppUser } from '../../@core/entities/authDataModel';
import { CommonHttpService } from '../../@core/services/common-http.service';
import { ObjectUtils } from '../../@core/common/initializer';
import { HomeDashboardWidgetConfig } from './home-dashboard.widget.config';
import { SessionStorageService } from '../../@core/services/storage.service';
import { CASE_STORE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';
import { HomeDashboardService } from './home-dashboard.service';
import { AlertService, DataStoreService } from '../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { AppConstants } from '../../@core/common/constants';
declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'home-dashboard',
    templateUrl: './home-dashboard.component.html',
    styleUrls: ['./home-dashboard.component.scss'],
    standalone: false
})
export class HomeDashboardComponent implements OnInit {
    options!: GridsterConfig;
    dashboardMain: GridsterItem[] = [];
    remove: boolean = false;
    dashboardWidget: Array<GridsterItem> = [];
    tempName = DashboardTeamperformanceComponent;
    showtempName = true;
    component = DashboardTeamperformanceComponent;
    showBroadCostMessage!: BroadCostMessage;
    activeModule!: string;
    private token: AppUser;
    assignUsersList: any;
    selectedPerson: any;
    reassignUsersList: any;
    selectedReAssignPerson: any;
    commentInfo: any;
    constructor(
        private _authService: AuthService,
        private _commonHttpService: CommonHttpService,
        private _session: SessionStorageService,
        private _service: HomeDashboardService,
        private _alertService: AlertService,
        private dataStore: DataStoreService,
        private route: ActivatedRoute,
       ) {
        this.token = this._authService.getCurrentUser();
    }

    static itemChange(_item: any, _itemComponent: any) {
        // No content to add or call
    }

    static itemResize(_item: any, _itemComponent: any) {
        // No content to add or call
    }

    ngOnInit() {
        this.dataStore.setData(CASE_STORE_CONSTANTS.ALL_DASHBOARD_DTA_LIST, this.route.snapshot.data.recordData);
        this._session.removeItem('isServiceCase');
        this.activeModule = this._session.getItem('activeModuleNav');
        this.listenForAssignment();
        this.listenForReAssign();
        this.listenForComment();
        this.options = {
            gridType: GridType.VerticalFixed,
            compactType: CompactType.CompactLeftAndUp,
            margin: 10,
            outerMargin: true,
            outerMarginTop: null,
            outerMarginRight: null,
            outerMarginBottom: null,
            outerMarginLeft: null,
            mobileBreakpoint: 1025,
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
            itemChangeCallback: HomeDashboardComponent.itemChange,
            itemResizeCallback: HomeDashboardComponent.itemResize,
        };
        this.options.maxRows = (this._authService.isCW()) ? 6 : 4;
        this._authService.currentUser.subscribe((x) => {
            let roleName = ObjectUtils.getNestedObject(x, ['role', 'name']);
            this.changeTab(roleName, x);
            this._authService.navgationChanged.subscribe(newRole => {
                if (newRole &&  newRole.rolename) {
                   roleName = newRole.rolename;
                   this.activeModule = newRole.modulename;
                   this.changeTab(roleName, x);
                }
             });

        });
        this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
        this._authService.hasSupervisor();
    }
    changeTab(roleName: any,x: any){
        if (roleName !== 'superuser') {
            this.getBroadCostMessage();
        }
        if (this.activeModule === 'Case Work') {
            this.dashboardMain = HomeDashboardWidgetConfig.master.CW;
        }
        if (this.activeModule === 'Provider' || this.activeModule === 'Resource Home' || this.activeModule === 'Home Study' || this.activeModule === 'Recruiter Trainer') {
            this.dashboardMain = HomeDashboardWidgetConfig.master.LDSS;
        }
        if (roleName === AppConstants.ROLES.APPEAL_USER) {
            this.dashboardMain = HomeDashboardWidgetConfig.master.APPEAL;
        }
        if(roleName === AppConstants.ROLES.CJAMS_SSA_FTDM_FACILITATOR) {
            this.dashboardMain = HomeDashboardWidgetConfig.master.FTDM;
            this._session.setItem('selectedModuleRole', 'CJAMS_SSA_FTDM_FACILITATOR' );
        }
        if(roleName === AppConstants.ROLES.CJAMS_SSA_QUALIFIED_INDIVIDUAL) {
            this.dashboardMain = HomeDashboardWidgetConfig.master.QIS;
            this._session.setItem('selectedModuleRole', 'CJAMS_SSA_QUALIFIED_INDIVIDUAL' );
        }
        if (roleName === AppConstants.ROLES.CJAMS_SSA_FTDM_QI_SUPERVISOR) {
            this.dashboardMain = HomeDashboardWidgetConfig.master.FTDMQIS;
            this._session.setItem('selectedModuleRole', 'CJAMS_SSA_FTDM_QI_SUPERVISOR' );
        }
        this.dashboardWidget = this.dashboardMain;
    }
    changedOptions() {
        if (this.options.api && this.options.api.optionsChanged) {
            this.options.api.optionsChanged();
        }
    }
    destroy() {
        this.remove = !this.remove;
    }

    removeItem(item: GridsterItem) {
        this.dashboardMain.forEach((element: GridsterItem) => {
            if (element.number === item.number) {
                element.show = false;
            }
        });
        this.dashboardWidget.splice(this.dashboardWidget.indexOf(item), 1);
    }

    refreshItem(item: GridsterItem) {
        item.input.eventSubject$.next('refresh');
    }
    
    restoreWidgets() {
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
    getBroadCostMessage() {
        const userid = this._authService.getCurrentUser().userId;
        this._commonHttpService.getSingle({
            method: 'get',
            where: { userid: userid }
            }, 'announcement/getuserannouncement?filter').subscribe((result) => {
            if (result !== null) {
                (<any>$('#broadcoastmessage')).modal('show'); //NOSONAR
                this.showBroadCostMessage = result;
            }
        });
    }
    acceptAnnouncement() {
        this._commonHttpService.endpointUrl = 'announcement/acceptannouncement';
        (<any>$('#broadcoastmessage')).modal('hide'); // NOSONAR
        this._commonHttpService
            .patch(this.showBroadCostMessage.userannouncementid, {
                id: this.showBroadCostMessage.userannouncementid
            })
            .subscribe();
    }

    listenForAssignment() {
        this._service.assignUserListener$.subscribe(data => {
            if (data.event === 'LIST_USERS') {
                this.assignUsersList = data.users;
            }
        });
    }

    selectPerson(row: any) {
        this.selectedPerson = row;
    }
    assignNewUser() {

        if (this.selectedPerson) {
            const data: any = {};
            data['event'] = 'ASSIGNMENT';
            data['selectedUser'] = this.selectedPerson;
            this._service.assignUserListener$.next(data);
        } else {
            this._alertService.error('Please Select the user');
        }
    }

    closeAssignment() {
        this.selectedPerson = null;
    }

    listenForReAssign() {
        this._service.assignSupervisorListener$.subscribe(data => {
            if (data.event === 'LIST_USERS') {
                this.reassignUsersList = data.users;
            }
        });
    }

    listenForComment() {
        this._service.assignCommentListener$.subscribe(data => {
            if (data) {
                this.commentInfo = data;
            }
        });
    }

    selectSupervisor(row: any) {
        this.selectedReAssignPerson = row;
    }
    assignToSupervisor() {
        if (this.selectedReAssignPerson) {
            const data: any = {};
            data['event'] = 'ASSIGNMENT';
            data['selectedUser'] = this.selectedReAssignPerson;
            this._service.assignSupervisorListener$.next(data);
        } else {
            this._alertService.error('Please Select the user');
        }
    }

    closeReAssignment() {
        this.selectedReAssignPerson = null;
    }
    resetComment() {
        this.commentInfo = null;
    }
}
