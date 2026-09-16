import { Component, OnInit, Input } from '@angular/core';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import moment from 'moment';
import { GLOBAL_MESSAGES } from '../../..//@core/entities/constants';
import { AlertService } from "../../../@core/services/alert.service";
import { CommonHttpService } from "../../../@core/services";

@Component({
    selector: 'audit-access-logs',
    templateUrl: './audit-access-logs.component.html',
    styleUrls: ['./audit-access-logs.component.scss'],
    standalone: false
})
export class AuditAccessLogsComponent implements OnInit {
    @Input() url: string = '';
    @Input() ssnNumber: string = '';
    @Input() personId: string = '';
    currentPageNumber: number = 1;
    dateFrom: any;
    dateTo: any;
    auditTrailList: any[] = [];
    totalAuditTrailList: any[] = [];
    auditTrailTotalcount: number = 0;
    auditTrailRequestColumns: string[] = [
        'VIEWED BY',
        'VIEWED ON',
        'SCREEN/INFO ACCESSED',
    ];
    auditTrailSearchKeys = [
        'viewby',
        'insertedon',
        'info',
    ];
    auditStyles: any = {
        'VIEWED BY': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'VIEWED ON': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'SCREEN/INFO ACCESSED': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    };
    paginationInfo: PaginationInfo = new PaginationInfo();

    constructor(
        private readonly _alertService: AlertService,
        private commonHttpService: CommonHttpService,
    ) { }
    ngOnInit() {
        this.loadAudts();
    }

    async processRequest(request: any, url: string, method = 'get') {
        return new Promise((resolve, rejuct) => {
            this.commonHttpService.getArrayList({
                ...request,
                method: method
            },
                url
            ).subscribe(response => {
                resolve(response);
            },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    rejuct();
                });
        })
    }

    onValidateSearch() {
        if(this.dateFrom && this.dateTo) {
            this.loadAudts();
        } else if(!this.dateFrom && this.dateTo) {
            this._alertService.error('Please Enter Start Date');
        } else if(this.dateFrom && !this.dateTo){
            this._alertService.error('Please Enter End Date');
        } else {
            this._alertService.error('Please Enter Start Date and End Date');
        }
    }

    async loadAudts() {
        this.currentPageNumber = 1;
        this.commonHttpService.getArrayList({
            startdate: this.dateFrom,
            enddate: this.dateTo,
            ssn: this.ssnNumber,
            personid: this.personId,
            method: 'get'
        },
            this.url + '?filter'
        ).subscribe(response => {
            let result = response[0].getbeaconaudit || [];
            result = result.map((item: any) => {
                item.info = `${item.eventpage}${item.eventid ? '/' + item.eventid : ''}`;
                item.insertedon = moment(item.insertedon).format('MM-DD-YYYY h:mm A');
                return item;
            });
            this.totalAuditTrailList = result;
            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;
            this.auditTrailList = result.slice(startIndex, endIndex);
            this.auditTrailTotalcount = result?.length || 0;
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    onClear() {
        this.dateFrom = '';
        this.dateTo = '';
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
        if (from != 'page_change') {
            event = JSON.parse(event);
        }

        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = event.sortColumn;
        this.auditTrailList = Object.create(this.totalAuditTrailList);
        if (event.sortDirection === 'asc') {
            this.auditTrailList.sort((first: any, next: any) => first[event.sortColumn].localeCompare(next[event.sortColumn]));
        } else {
            this.auditTrailList.sort((first: any, next: any) => next[event.sortColumn].localeCompare(first[event.sortColumn]));
        }
        this.callApi(event, 'sort');
    }

    callApi(query: any, from: any = '') {
        let data: any;
        let result: any;
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
        if (filters.length) {
            let searchList: any;
            searchList = this.getAuitTrialList(from);

            result = searchList.filter((item: any) => filters.every(filter => String(item[filter.key]).toLowerCase().indexOf(filter.value) > -1));

        } else {
            result = this.getAuitTrialList(from);
        }
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.auditTrailList = result.slice(startIndex,endIndex);
        this.auditTrailTotalcount = result.length;
    }

    getAuitTrialList(from: any){
        return from == 'sort' ? this.auditTrailList : Object.create(this.totalAuditTrailList);
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }
}
