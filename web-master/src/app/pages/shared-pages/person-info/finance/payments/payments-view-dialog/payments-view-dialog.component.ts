import { Component, OnInit, Input } from '@angular/core';
import { PaginationInfo } from '../../../../../../@core/entities/common.entities';
import moment from 'moment';
import { AlertService } from "../../../../../../@core/services/alert.service";
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../../case-worker/case-worker-url.config';

@Component({
    selector: 'payments-view-dialog',
    templateUrl: './payments-view-dialog.component.html',
    standalone: false
})
export class PaymentsViewDialogComponent implements OnInit {
    @Input() overPayments: any;
    @Input() adjustedPaymentHistoryDetailsSegment: any;
    @Input() screen!: string;
    overPaymentsList: any = [];
    totalOverPaymentsList: any = [];
    currentDialogPageNumber: number = 1;
    totalDialogCount = 0;
    dialogPaginationInfo: PaginationInfo = new PaginationInfo();
    requestDialogColumns: string[] = [];
    overPaymetKeys: string[] = [];
    unsortablecolumnsList: string[] = [];
    styles: any = {
        'DATE OF DISCOVERY': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'DATE PAYMENT RECEIVED': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'WEEK ENDING': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PROGRAM NAME': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'DATE PAYMENT ISSUED': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'BENEFIT AMOUNT': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PAYMENT AMOUNT': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PROCESS STATUS': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PROCESS ADJUSTMENT DATE': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    constructor(
        private commonHttpService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        public _authService: AuthService,
        public _alertService: AlertService,
    ) { }

    ngOnInit() {
        if (this.screen === 'Adjusted Payments') {
            this.requestDialogColumns = [
                'WEEK ENDING',
                'PROGRAM NAME',
                'DATE PAYMENT ISSUED',
                'BENEFIT AMOUNT',
                'PAYMENT AMOUNT',
                'PROCESS STATUS',
                'PROCESS ADJUSTMENT DATE'
            ];
            this.unsortablecolumnsList = [
                'WEEK ENDING',
                'PROGRAM NAME',
                'DATE PAYMENT ISSUED',
                'BENEFIT AMOUNT',
                'PAYMENT AMOUNT',
                'PROCESS STATUS',
                'PROCESS ADJUSTMENT DATE'
            ];
            this.overPaymetKeys = [
                'weekEnding',
                'programName',
                'datePaymentIssued',
                'benefitAmount',
                'paymentAmount',
                'processStatus',
                'processAdjustmentDate',
            ];
        } else {
            this.requestDialogColumns = [
                'DATE OF DISCOVERY',
                'AMOUNT OF OVERPAYMENT',
            ];
            this.unsortablecolumnsList = [
                'DATE OF DISCOVERY',
                'AMOUNT OF OVERPAYMENT',
            ];
            this.overPaymetKeys = [
                'dateOfDiscovery',
                'amountOfOverpayment',
            ];
        }
        this.openDialog();
    }

    amountFormater(value: string = '0') {
        if (typeof value === 'string' && value.indexOf('$') > -1) {
            return value;
        }

        return `$${Number(value).toLocaleString('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        })}`
    }

    async onPersionSearch(segment: string, pageNumber = 0) {
        let beaconrequestdetailsid = this._dataStoreService.getData('beaconrequestdetailsid');
        let ssn = this._dataStoreService.getData('ssn');
        let sourcetrackingid = this._dataStoreService.getData('sourcetrackingid');
        return new Promise((resolve, reject) => {
            let user: any = {};
            const currentUser = this._authService.getCurrentUser();
            if (currentUser) {
                const loggedInUserProfile = currentUser.user ? currentUser.user.userprofile : null;
                if (loggedInUserProfile) {
                    user = {
                        securityuserid: loggedInUserProfile.securityusersid,
                        username: loggedInUserProfile.fullname
                    };
                }
            }
            this.commonHttpService.getArrayList(
                {
                    nolimit: true,
                    where: {
                        beaconrequestdetailsid: beaconrequestdetailsid,
                        ssn: ssn,
                        sourcetrackingid: sourcetrackingid,
                    },
                    pageNum: pageNumber,
                    securityuserid: user?.securityuserid,
                    username: user?.username,
                    segment: segment,
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Getbeaconrealtimedata
            ).subscribe((response: any) => {
                if ((typeof response === 'string' && response.toLowerCase().indexOf('exception') > -1) || response instanceof Error) {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    return;
                }

                resolve(response);

            },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
        });
    }

    openDialog() {
        let result;
        let total = 0;
        if (this.screen === 'Adjusted Payments') {
            result = Object.create(this.adjustedPaymentHistoryDetailsSegment);
            total = result.length;
            result = result.map((item: any) => {
                item.benefitAmount = this.amountFormater(item.benefitAmount);
                item.paymentAmount = this.amountFormater(item.paymentAmount);
                item.weekEnding = this.fmtDate(item.weekEnding);
                item.datePaymentIssued = this.fmtDate(item.datePaymentIssued);
                item.processAdjustmentDate = this.fmtDate(item.processAdjustmentDate);
                return item;
            });
        } else {
            result = Object.create(this.overPayments?.data || []);
            total = this.overPayments?.total || 0;
            result = result.map((item: any) => {
                item.amountOfOverpayment = this.amountFormater(item.amountOfOverpayment);
                item.dateOfDiscovery = this.fmtDate(item.dateOfDiscovery);
                return item;
            });
        }

        this.currentDialogPageNumber = 1;
        let startIndex = (this.currentDialogPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.totalOverPaymentsList = Object.create(result);
        this.overPaymentsList = result.slice(startIndex, endIndex);
        this.totalDialogCount = total || 0;
    }

    fmtDate(value: any){
        return value ? moment(value).format('MM-DD-YYYY') : '';
    }

    async dialogPageChanged(pageInfo: any) {
        this.dialogPaginationInfo.pageNumber = pageInfo.page;
        let newPageNumber = pageInfo.page;
        let total = 0;
        let payments = Object.create(this.totalOverPaymentsList);
        if (newPageNumber < this.currentDialogPageNumber && this.screen != 'Adjusted Payments') {
            let result: any = await this.onPersionSearch('overpaymentInquiry', newPageNumber - 1);
            result = result['historyResponse'];
            result = result['overpaymentInquiry']?.results || [];
            total = result['overpaymentInquiry']?.total || 0;
            payments = [...payments, ...result];
        } else {
            total = payments.length || 0;
        }

        let startIndex = (newPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.totalOverPaymentsList = Object.create(payments);
        this.overPaymentsList = payments.slice(startIndex, endIndex);
        this.totalDialogCount = total || 0;
        this.currentDialogPageNumber = newPageNumber;
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }
}
