import { Component, OnInit, Input } from '@angular/core';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import moment from 'moment';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AlertService } from "../../../@core/services/alert.service";
import { CommonHttpService } from "../../../@core/services";
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';

@Component({
    selector: 'beacon-view-dialog',
    templateUrl: './beacon-view-dialog.component.html',
    standalone: false
})
export class BeaconViewDialogComponent implements OnInit {
    @Input() personId!: string;
    totalWagesSearchList: any = [];
    totalWagesDialogSearchList: any;
    currentDialogPageNumber: number = 1;
    requestDialogColumns: string[] = [
        'CJAMS ID',
        'FIRST NAME',
        'MIDDLE NAME',
        'LAST NAME',
        'GENDER',
        'DOB',
        'SSN',
        'REQUESTED BY',
        'REQUESTED ON'
    ];
    wagesDialogSearchKeys = [
        'cjamspid',
        'firstname',
        'middlename',
        'lastname',
        'gendertypekey',
        'dob',
        'dialogMaskedSSN',
        'requestedby',
        'insertedon'
    ];
    wagesDialogSearchList: any = [];
    totalDialogCount = 0;
    dialogPaginationInfo: PaginationInfo = new PaginationInfo();
    styles: any = {
        'CJAMS ID': { 'thStyleClassName': 'width-250', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'First NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'MIDDLE NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'lAST NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'GENDER': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'DOB': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'SSN': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'REQUESTED BY': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'REQUESTED ON': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    constructor(
        private readonly _alertService: AlertService,
        private commonHttpService: CommonHttpService,
    ) { }

    ngOnInit() {
        this.bindHistory();
    }

    async bindHistory() {
        this.commonHttpService.getArrayList({
            personid: this.personId,
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Getbeaconrequesthistory
        ).subscribe(response => {
            this.totalWagesSearchList = response[0].getbeaconrequesthistory || [];
            this.totalWagesSearchList = this.totalWagesSearchList.map((item: any, index: any) => {
                item.dob = this.formatDate(new Date(item.dob));
                item.insertedon = moment(item.insertedon).format('MM-DD-YYYY h:mm A');
                item.dialogMaskedSSN = this.maskSSN(item.ssn);
                item.beaconrequestdetailsid = item.beaconrequestdetailsid || index;
                return item;
            });
            this.openDialog();
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    openDialog() {

        let result = Object.create(this.totalWagesSearchList);
        let startIndex = (this.currentDialogPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.totalWagesDialogSearchList = Object.create(result);
        this.wagesDialogSearchList = result.slice(startIndex, endIndex);
        this.totalDialogCount = result.length || 0;
    }

    dialogPageChanged(pageInfo: any) {
        this.dialogPaginationInfo.pageNumber = pageInfo.page;
        this.dialogPaginationInfo.sortColumn = pageInfo.query.sortColumn;
        this.dialogPaginationInfo.sortBy = pageInfo.query.sortDirection;
        this.currentDialogPageNumber = pageInfo.page;
        if (pageInfo.query.sortColumn) {
            this.onDialogSort(pageInfo.query, 'page_change');
        } else {
            this.callDialogApi(pageInfo.query, 'page_change');
        }
    }

    onDialogSort(event: any, from = '') {
        if (from != 'page_change') {
            event = JSON.parse(event);
        }

        this.dialogPaginationInfo.sortBy = event.sortDirection;
        this.dialogPaginationInfo.sortColumn = event.sortColumn;
        this.wagesDialogSearchList = Object.create(this.totalWagesDialogSearchList);
        if (event.sortDirection === 'asc') {
            if (event.sortColumn === 'cjamspid') {
                this.wagesDialogSearchList.sort((first: any, next: any) => first[event.sortColumn] - next[event.sortColumn]);
            } else {
                this.wagesDialogSearchList.sort((first: any, next: any) => first[event.sortColumn].localeCompare(next[event.sortColumn]));
            }
        } else {
            if (event.sortColumn === 'cjamspid') {
                this.wagesDialogSearchList.sort((first: any, next: any) => next[event.sortColumn] - first[event.sortColumn]);
            } else {
                this.wagesDialogSearchList.sort((first: any, next: any) => next[event.sortColumn].localeCompare(first[event.sortColumn]));
            }
        }
        this.callDialogApi(event, 'sort');
    }

    callDialogApi(query: any, from: any = '') {
        let data: any;
        if (from === 'page_change' || from === 'sort') {
            data = query;
        } else {
            data = JSON.parse(query);
        }
        if(data['dialogMaskedSSN']) {
            data['dialogMaskedSSN'] = data['dialogMaskedSSN'].replace(/-/g, '');
        }

        data['ssn'] = data['dialogMaskedSSN'];
        delete data['dialogMaskedSSN'];
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

        this.filterWages(filters, from);
    }

    filterWages(filters: any, from = '') {
        let result: any;
        if (filters.length) {
            let searchList: any;
            if (from === 'sort') {
                searchList = this.wagesDialogSearchList;
            } else {
                searchList = Object.create(this.totalWagesDialogSearchList);
            }

            result = searchList.filter((item: any) => filters.every((filter: any) => String(item[filter.key]).toLowerCase().indexOf(filter.value) > -1));
            this.totalDialogCount = result.length;
        } else {
            if (from == 'sort') {
                result = this.wagesDialogSearchList;
            } else {
                result = Object.create(this.totalWagesDialogSearchList);
            }
        }
        let startIndex = (this.currentDialogPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.wagesDialogSearchList = result.slice(startIndex, endIndex);
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }
    maskSSN(ssn: any) {

        if (ssn.length === 9) {
            const maskedSSN = '*'.repeat(ssn.length - 4);
            const lastFoutDigits = ssn.slice(-4);
            let output = `${maskedSSN}${lastFoutDigits}`;
            return output.replace(/^\*+(\d{4})$/, '***-**-$1')
        }
        return ssn || '';
    }

    formatToSSN(ssn: string) {
        return `${ssn.slice(0, 3)}-${ssn.slice(3, 5)}-${ssn.slice(5)}`
    }
}
