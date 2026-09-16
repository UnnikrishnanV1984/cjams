
import {pluck, share} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable, Subject } from 'rxjs';
import { ActivatedRoute, Router } from '@angular/router';


import { PaginationInfo, PaginationRequest } from '../../@core/entities/common.entities';
import { CommonHttpService, GenericService, DataStoreService, SessionStorageService, AlertService } from '../../@core/services';
import { NotificationResult, NotificationSearch } from './_entities/notification-entity.module';
import { NotificationUrlConfig } from './notification.url.config';
import { AuthService } from '../../@core/services/auth.service';
import { AppUser } from '../../@core/entities/authDataModel';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../case-worker/_entities/caseworker.data.constants';
import { IntakeStore } from '../_utils/intake-utils.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notification',
    templateUrl: './notification.component.html',
    styleUrls: ['./notification.component.scss'],
    standalone: false
})
export class NotificationComponent implements OnInit {
    @Input()
    notify!: Subject<string>;
    notificationsTableData: any = [];
    isDeleteAll: boolean = false;
    deleteBtn!: boolean;
    notificationsToBeDeleted: number = 0;
    paginationInfo: PaginationInfo = new PaginationInfo();
    notificationResultData$!: Observable<NotificationResult[]>;
    totalResulRecords$!: Observable<number>;
    notificationSearch: NotificationSearch;
    selectedRecord: NotificationResult;
    selectedDeleteRow!: NotificationResult;
    isBroadCastMessage!: boolean;
    private token: AppUser;
    caseworkerpageurl = '/pages/case-worker/';
    reportsummaryurl = '/dsds-action/report-summary';
    constructor(
        private _dataStoreService: DataStoreService,
        private _router: Router,
        private _service: GenericService<NotificationResult>,
        private _commonService: CommonHttpService,
        private _sessionStorage: SessionStorageService,
        private _authService: AuthService,
        private route: ActivatedRoute,        
        private _alertService: AlertService
    ) {
        this._service.endpointUrl = NotificationUrlConfig.EndPoint.notification.notificationResult;
        this.notificationSearch = new NotificationSearch();
        this.selectedRecord = new NotificationResult();
        this.token = this._authService.getCurrentUser();
    }
    ngOnInit() {
        this.route.fragment.subscribe((fragment) => {
            if(fragment) {
                this.activateTab(fragment);
            }
        })
        const role = this._authService.getCurrentUser();
        if (role.role.name === 'superuser') {
            this.isBroadCastMessage = true;
        }
        this.getNotificationData(1);
        this.deleteBtn = false;
    }

    activateTab(tabId: string) {
        const tabs = document.querySelectorAll('.nav-tabs > li');
        const panes = document.querySelectorAll('.tab-pane');

        tabs.forEach(tab => { 
            tab.classList.remove('active');
            const link = tab.querySelector('a');
            if (link) {
                link.classList.remove('active');
            }
        });
        panes.forEach(tab => tab.classList.remove('active'));

        const targetLink = document.querySelector(`.nav-tabs a[href="#${tabId}`) 
        const targetPane = document.getElementById(`${tabId}`);
        if (targetLink) {
            const parentLi = targetLink.closest('li');
            if (parentLi) {
                parentLi.classList.add('active');
            }
            targetLink.classList.add('active');
        }
        if(targetPane) {
            targetPane.classList.add('active');
        }
    }

    transChanged() {
        setTimeout(() => {
            this.deleteBtn = this.notificationsTableData.findIndex((e: any) => e.isDelete === true) > -1;
         }, 0);
    }

    getNotificationData(pageNo: number) {
        const body: PaginationRequest = {
            limit: 10,
            page: pageNo,
            where: {},
            method: 'post'
        };
        const source = this._service.getPagedArrayList(body).pipe(share());
        this.notificationResultData$ = source.pipe(pluck('data'));
        if (pageNo === 1) {
            this.totalResulRecords$ = source.pipe(pluck('count'));
        }

        this.notificationResultData$.subscribe((data) => {
            this.notificationsTableData = [];
            data.forEach((res: any) => {
                res.deleteBtn = true;
                res.isDelete = false;
                if (res.subject?.includes('Active Substance Exposed New Born')) {
                    res.fromname = 'CJAMS';
                }else if((String(res.subject).endsWith('see attached.') && res.objecttype === 'incidentreport')){
                    let subject = String(res.subject);
                    subject = subject.substring(subject.indexOf('#'));
                    res.objecttype = 'TicketNo';
                    res.type = 'UIR';
                    res.servicerequestnumber = subject.substring(1, subject.indexOf(' '));                   
                }
                this.notificationsTableData.push(res);
            });

        });
    }

    checkCount() {
        this.notificationsToBeDeleted = 0;
        this.notificationsTableData.map((notification: any) => {
            if (notification.isDelete) {
                this.notificationsToBeDeleted++;
            }
        });
    }

    updateDeleteNotifications(event: Event) {
        const target = event.target as HTMLInputElement;
        if (target && target.checked) {
            this.deleteBtn = true;
        } else {
            this.deleteBtn = false;
        }
        this.notificationsTableData.map((notification: any) => {
            notification.isDelete = this.isDeleteAll;
        });
    }

    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.getNotificationData(page);
    }
    selectNotification(selectedData: NotificationResult) {
        this.selectedRecord = selectedData;
    }
    selectDeleteNotification(selectedRow: NotificationResult) {
        this.selectedDeleteRow = selectedRow;
    }
    updateNotification(notification: NotificationResult) {
        this._commonService.endpointUrl = NotificationUrlConfig.EndPoint.notification.updateNotification;
        const body = {
            usernotificationid: notification.usernotificationid
        };
        if (!notification.isread) {
            this._commonService.create(body).subscribe((data) => {
                if (data === 'Success') {
                    notification.isread = true;
                } else {
                    notification.isread = false;
                }
            });
        }
    }
    deleteSelectedNotification() {
        const usernotificationids: any = [];
        this.notificationsTableData.map((notification: any) => {
            if (notification.isDelete) {
                usernotificationids.push(notification.usernotificationid);
            }
        });

        this._commonService.endpointUrl = NotificationUrlConfig.EndPoint.notification.deleteNotification;
        const body = {
            usernotificationids: usernotificationids
        };

        this._commonService.create(body).subscribe(() => {
            this.isDeleteAll = false;
            this.getNotificationData(this.paginationInfo.pageNumber);
        });
    }
    routToCaseWorker(item: NotificationResult) {
        if (item.objecttype === 'servicecase') {
            this._sessionStorage.setTabKeyKey( item.servicerequestnumber);
            this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
            const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
            this._commonService.getAll(url).subscribe((response) => {
                const dsdsActionsSummary = response[0];
                if (dsdsActionsSummary) {
                    this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                    this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                    // common person for cw
                    let currentUrl = this.caseworkerpageurl + item.intakeserviceid + '/' + item.servicerequestnumber + this.reportsummaryurl;
                    if(item.body.includes('Form 1080')) {
                        this.routeToForm1080(currentUrl,item);
                        return;
                    }
                    this._router.navigate([currentUrl]);
                }
            });
        } else if (item.objecttype === 'intake') {
            const intake = Object.create(IntakeStore);
            intake.number = item.servicerequestnumber;
            intake.action = 'edit';
            this._dataStoreService.setObj('intake', intake);
            this._dataStoreService.clearStore();
            this._dataStoreService.clearStoreWithout();
            let url = '/pages/newintake/my-newintake/' + intake.number + '/edit/' + 'person-cw/list';
            if(item.body.includes('Form 1080')) {
                url = '/pages/newintake/my-newintake/' + intake.number + '/edit/attachment';
            }
            this._router.navigate([url]);
        } else if (item.objecttype === 'adoptioncase') {
            this.routToAdoptionCase(item);
        }else if(item.objecttype === 'psychotropic'){
            this.routTopsychotropic(item);
        }
        else {
          this.routeToCaseWorkerElseCondition(item);
        }
    }

    routeToCaseWorkerElseCondition(item: any) {
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            let currentUrl = '';
            const intakeserviceid = item.intakeserviceid ?? dsdsActionsSummary?.intakeserviceid;
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            if(item.body.includes('Form 1080')) {
                this.routeToForm1080(currentUrl,item);
                return;
            } else {
                currentUrl = this.caseworkerpageurl + intakeserviceid + '/' + item.servicerequestnumber + this.reportsummaryurl;
            }
            this._router.navigate([currentUrl]);
        });
    }

    routeToForm1080(currentUrl: any, item: any) {
        const url = currentUrl || `${this.caseworkerpageurl}${item.intakeserviceid}/${item.servicerequestnumber}/dsds-action/attachment`;
        this._router.navigate([url], {
            queryParams: { openFormsTab: true}
        });
    }

    routToServiceCase(item: NotificationResult) {
        this._sessionStorage.removeItemWithOutTab('ISADOPTION');
        this._sessionStorage.setTabKeyKey( item.servicerequestnumber);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, true);
        if (item) {
          this._dataStoreService.setData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE, item.objecttype);
        }
        const url = CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl + '/' + item.intakeserviceid + '/casetype';
        this._commonService.getAll(url).subscribe((response) => {
            const dsdsActionsSummary = response[0];
            if (dsdsActionsSummary) {
                this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
                this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
                const currentUrl = this.caseworkerpageurl + item.intakeserviceid + '/' + item.servicerequestnumber + this.reportsummaryurl;
                this._router.navigate([currentUrl]);
            }
        });
      }
    
    routToAdoptionCase(item: NotificationResult) {
        this._sessionStorage.setTabKeyKey(item.servicerequestnumber);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.CASE_TYPE, 'ADOPTION');
        this._sessionStorage.setItem('ISADOPTION', true);
        this._sessionStorage.setObj(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        if (item) {
          this._dataStoreService.setData(CASE_STORE_CONSTANTS.CASE_DASHBOARD, item);
        }
        this._commonService.getById(item.servicerequestnumber, CaseWorkerUrlConfig.EndPoint.Dashboard.DsdsActionSummaryUrl).subscribe((response) => {
          const dsdsActionsSummary = response[0];
          if (dsdsActionsSummary) {
            this._dataStoreService.setData('da_status', dsdsActionsSummary.da_status);
            this._dataStoreService.setData('teamtypekey', dsdsActionsSummary.teamtypekey);
            const currentUrl = this.caseworkerpageurl + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/adoption-persons';
            this._router.navigate([currentUrl]);
          }
        });
      }

    downloadFile(documentlocation: any) {
        if (documentlocation) {
            if (documentlocation.includes('attachments/downloadFileFromECMS')) {
               const s3bucketpathname = (documentlocation || '').replace(/,/g, '');        
                const path = s3bucketpathname.trim().split('?')[1].split('&');
                const config: any = {};
                path.forEach((element: string) => {
                    const obj = element.split('=');
                    config[obj[0]] = obj[1];
                });
                const ecmsdocumentid = config['docId'];
                const originalfilename = config['filename'];
                this._commonService
                .downloadXml(
                    CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileFromECMS + '?docId=' + ecmsdocumentid + '&filename=' + originalfilename
                ).subscribe((result: any) => {
                    const blob = new Blob([result]);
                    const link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = originalfilename;
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                });
            } else {
                this.downloadFileFromEDMS(documentlocation);
            }
        } else {
            this._alertService.error('Attachment location not found');
        }
    }

    downloadFileFromEDMS(documentlocation: any) {
        this._commonService.getArrayList(
            {
                method: 'post',
                nolimit: true,
                where: { documentpropertiesid: documentlocation }
            },
            NotificationUrlConfig.EndPoint.notification.getDocDetails
        ).subscribe(
            (response: any) => {
                const records = Array.isArray(response) ? response : (response && response.data ? response.data : []);
                const source = Array.isArray(records) ? records[0] : records;
                if (source && source.ecmsdocumentid) {
                    this.continueDownloadLargeFileAttachment(source);
                } else {
                    this._alertService.error('Attachment details not found');
                }
            }
        );
    }

    continueDownloadLargeFileAttachment(source: any) {
        this._commonService
        .downloadXml(
            CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.downloadFileFromEDMS + '?docId=' + source.ecmsdocumentid + '&filename=' + source.originalfilename
        ).subscribe((result: any) => {
            const blob = new Blob([result]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = source.originalfilename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
    }

    routTopsychotropic(item: NotificationResult){
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.PSYCHOTRPIC_ID, item.intakeserviceid);
        this._sessionStorage.setItem(CASE_STORE_CONSTANTS.FROM_NOTIFICATION, true);
        this._router.navigate(['/pages/psychotropicprescription-review'], { relativeTo: this.route });

    }
}