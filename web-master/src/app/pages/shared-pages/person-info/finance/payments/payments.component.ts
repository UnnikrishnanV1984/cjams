import { Component, OnInit, Input } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CreateBeaconAuditService } from './../shared/audit.service';
import moment from 'moment';

@Component({
    selector: 'payments',
    templateUrl: './payments.component.html',
    styleUrls: ['./payments.component.scss'],
    standalone: false
})
export class PaymentComponent implements OnInit {
    @Input() claimant: any = {};
    @Input() ssn: string = '';
    @Input() personId: string = '';
    isOpenOverPaymentsDialog: boolean = false;
    dialogHeader: string = 'Over Payment';
    overPayments: any = [];
    adjustedPaymentHistoryDetailsSegment: any = [];
    totalcount = 0;
    currentPageNumber: number = 1;
    totalPayemtsList: any = [];
    payemtsList: any = [];
    payemtsColumns: string[] = [
        'WEEK ENDING',
        'DATE CERTIFICATION RECEIVED',
        'PROGRAM',
        'DATE PAYMENT ISSUED',
        'BENEFIT AMOUNT',
        'PAYMENT AMOUNT',
        'OVERPAYMENT',
        'PROCESS STATUS',
    ];
    unsortablecolumnsList: string[] = [
        'WEEK ENDING',
        'DATE CERTIFICATION RECEIVED',
        'PROGRAM',
        'DATE PAYMENT ISSUED',
        'BENEFIT AMOUNT',
        'PAYMENT AMOUNT',
        'OVERPAYMENT',
        'PROCESS STATUS',
    ];
    payemtsSearchKeys = [
        'week_ending',
        'date_certification_received',
        'program',
        'date_payment_issued',
        'benefit_amount',
        'payment_amount',
        'over_payment',
        'process_status',
    ];

    paginationInfo: PaginationInfo = new PaginationInfo();
    styles: any = {
        'WEEK ENDING': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'DATE CERTIFICATION RECEIVED': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PROGRAM': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'DATE PAYMENT ISSUED': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'BENEFIT AMOUNT': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PAYMENT AMOUNT': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'OVERPAYMENT': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'PROCESS STATUS': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    constructor(
        private auditService: CreateBeaconAuditService
    ) { }
    ngOnInit() {
        this.getBeaconPayments();
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
    private getBeaconPayments() {
        this.auditService.createAudit('View', 'Payments', this.claimant.claim_id, this.ssn,this.personId);
        this.overPayments = this.claimant.overPayments || { data: [], total: 0 };
        this.adjustedPaymentHistoryDetailsSegment = this.claimant.adjustedPaymentHistoryDetailsSegment || [];
        let payments;
        payments = this.claimant.payments.map((item: any) => {
            item.week_ending = item.week_ending ? item.week_ending : item.weeklyEndingDate;
            item.date_certification_received = item.date_certification_received ? item.date_certification_received : item.dateCertificationReceived;
            item.program = item.program ? item.program : item.programName;
            item.date_payment_issued = item.date_payment_issued ? item.date_payment_issued : item.datePaymentIssued;
            item.benefit_amount = item.benfit_amount ? this.amountFormater(item.benfit_amount) : this.amountFormater(item.benefitAmount);
            item.payment_amount = item.payment_amount ? this.amountFormater(item.payment_amount) : this.amountFormater(item.paymentAmount);
            item.over_payment = item.over_payment ? item.over_payment : item.overpayment;
            item.process_status = item.process_status ? item.process_status : item.processStatus;
            item.adjusted = item.adjusted ? item.adjusted : 'Yes';
            item.process_adjusted_date = item.process_adjusted_date ? item.process_adjusted_date : item.processadjusteddate;

            item.week_ending = item.week_ending ? moment(item.week_ending).format('MM-DD-YYYY') : '';
            item.date_certification_received = item.date_certification_received ? moment(item.date_certification_received).format('MM-DD-YYYY') : '';
            item.date_payment_issued = item.date_payment_issued ? moment(item.date_payment_issued).format('MM-DD-YYYY') : '';
            item.process_adjusted_date = item.process_adjusted_date ? moment(item.process_adjusted_date).format('MM-DD-YYYY') : '';

            return item;
        });


        this.totalPayemtsList = Object.create(payments);
        let result = Object.create(this.totalPayemtsList);
        this.currentPageNumber = 1;
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.payemtsList = result.slice(startIndex, endIndex);
        this.totalcount = result.length;
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.sortColumn = pageInfo.query.sortColumn;
        this.paginationInfo.sortBy = pageInfo.query.sortDirection;
        this.currentPageNumber = pageInfo.page;
        if (pageInfo.query.sortColumn) {
            this.onSort(pageInfo.query, 'page_change');
        } else {
            this.callApi(pageInfo.query, 'page_change');
        }
    }

    onSort(event: any, from = '') {
        if (this.isOpenOverPaymentsDialog) {
            return;
        }

        if (from != 'page_change') {
            event = JSON.parse(event);
        }

        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = event.sortColumn;
        this.payemtsList = Object.create(this.totalPayemtsList);
        if (event.sortDirection === 'asc') {
            this.payemtsList.sort((first: any, next: any) => first[event.sortColumn].localeCompare(next[event.sortColumn]));
        } else {
            this.payemtsList.sort((first: any, next: any) => next[event.sortColumn].localeCompare(first[event.sortColumn]));
        }
        this.callApi(event, 'sort');
    }

    callApi(query: any, from: any = '') {
        let data: any;
        if (from === 'page_change' || from === 'sort') {
            data = query;
        } else {
            data = JSON.parse(query);
        }
        let filters = [];
        for (let value in data) {
            if (data[value]) {
                if (value === 'sortColumn' || value === 'sortDirection') {
                    continue;
                }
                filters.push({
                    key: value,
                    value: data[value].toLowerCase(),
                });
            }
        }
        this.filterPayments(filters, from);
    }

    filterPayments(filters: any, from = '') {
        let result: any;
        if (filters.length) {
            let searchList: any;
            if (from === 'sort') {
                searchList = this.payemtsList;
            } else {
                searchList = Object.create(this.totalPayemtsList);
            }

            result = searchList.filter((item: any) => filters.every((filter: any) => String(item[filter.key]).toLowerCase().indexOf(filter.value) > -1));
            this.totalcount = result.length;
        } else {
            if (from == 'sort') {
                result = this.payemtsList;
            } else {
                result = Object.create(this.totalPayemtsList);
            }
        }
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.payemtsList = result.slice(startIndex, endIndex);
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }

    onSelected(value: string) {

        if (value === 'Adjusted Payments') {
            this.dialogHeader = 'Adjusted Payments';
        } else if (value === 'Over Payment') {
            this.dialogHeader = 'Over Payment';
        }
        this.isOpenOverPaymentsDialog = true;
    }

    onCloseOverPayments() {
        this.isOpenOverPaymentsDialog = false;
    }
}
