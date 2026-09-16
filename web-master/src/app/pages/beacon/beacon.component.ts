import { GLOBAL_MESSAGES } from './../..//@core/entities/constants';
import { Component, OnInit } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { PaginationInfo } from "../../@core/entities/common.entities";
import { AlertService } from "../../@core/services/alert.service";
import { CommonHttpService, AuthService } from "../../@core/services";
import { AppConfig } from "../../../../src/app/app.config";
import { PersonInfoService } from '../shared-pages/person-info/person-info.service';
import { NavigationUtils } from '../_utils/navigation-utils.service';
import { ActivatedRoute } from "@angular/router";
import moment from 'moment';
import { CaseWorkerUrlConfig } from '../case-worker/case-worker-url.config';

@Component({
    selector: 'beacon',
    templateUrl: './beacon.component.html',
    styleUrls: ['./beacon.component.scss'],
    standalone: false
})
export class BeaconComponent implements OnInit {
    selectedTab: string = 'New Request';
    ssnNumbers!: string;
    personid: string = '';
    ssnIndex = 0;
    totalWagesSearchList: any;
    isOpenHistoryDialog: boolean = false;
    isSearched: boolean = false;
    case: string = "";
    endpointUrl!: string;
    ssnValues: any = [];
    selectedRecords: any = [];
    isAllchecked: boolean = false;
    sameDaySubmittedSSNs: any[] = [];
    selectedSsnNumbers: any = [];
    currentPageNumber: number = 1;
    requestColumns: string[] = [
        "Search",
        "CJAMS ID",
        "FIRST NAME",
        "MIDDLE NAME",
        "LAST NAME",
        "GENDER",
        "DOB",
        "SSN",
        'ACTION'
    ];
    wagesSearchList: any = [];
    wagesSearchKeys = [
        "search",
        "cjamspid",
        "firstname",
        "middlename",
        "lastname",
        "gendertypekey",
        "dob",
        "maskedSSN"
    ];
    requestColumnsview: string[] = [
        'CJAMS ID',
        'FIRST NAME',
        'MIDDLE NAME',
        'LAST NAME',
        'GENDER',
        'DOB',
        'SSN',
        'REQUESTED BY',
        'REQUESTED ON',
        'ACTION'
    ];
    wagesSearchListview: any = [];
    wagesSearchKeysview = [
        'cjamspid',
        'firstname',
        'middlename',
        'lastname',
        'gendertypekey',
        'dob',
        'maskedSSN',
        'requestedby',
        'insertedon',
        'Hourglass',
    ];
    totalcount = 0;
    paginationInfo: PaginationInfo = new PaginationInfo();
    viewPaginationInfo: PaginationInfo = new PaginationInfo();

    styles: any = {
        "CJAMS ID": {
            thStyleClassName: "width-150",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        "FIRST NAME": {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        "MIDDLE NAME": {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        "LAST NAME": {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        GENDER: {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        DOB: {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
        SSN: {
            thStyleClassName: "inherit",
            tdStyleClassName: "",
            filterIconClassName: "",
        },
    };
    totalWagesSearchListview: any;
    requestedBy: string = '1';
    usersList: any;
    totalcountview: any;
    ssnNumLimit = 10;

    constructor(
        private readonly _navigationUtils: NavigationUtils,
        private readonly _alertService: AlertService,
        private http: HttpClient,
        public _personInfoService: PersonInfoService,
        public _authService: AuthService,
        private route: ActivatedRoute,
        private commonHttpService: CommonHttpService,
    ) { }

    ngOnInit() {
        this.ssnValues.push({ value: "" });
        this.bindUsers();
        this.route.queryParams.subscribe(params => {
            this.changeTab(params.to || 'New Request');
        });
    }

    onAddSSN() {
        if (this.ssnValues.length >= this.ssnNumLimit) {
            return;
        }

        let existingSSN = this.ssnValues.filter((item: any) => !item.value);

        if (existingSSN.length) {
            return this._alertService.error('Please Enter SSN');
        }

        this.ssnValues.push({ value: "" });
    }

    onRemoveSSN(index: number) {
        if (this.ssnValues.length == 1) {
            return;
        }

        this.ssnValues.splice(index, 1);
    }

    async onSSNChange(event: any, i: any, previousValue: any) {
        this.case = "";
        this.ssnIndex = i;
        let $input = $('#' + event.currentTarget.id);
        let value: any = $input.val();

        value = this.filterSSNValue(value, i);
        
        this.ssnValues = this.ssnValues.map((item: any) => {
            if (item.value === previousValue && !value) {
                return { value: '', maskedSSN: '' };
            }

            return item;
        });

        if (value.indexOf('*') === -1 && value.length === 9) {
            let existingSSN = this.ssnValues.find((item: any) => item.value === value);
            if (existingSSN && previousValue != existingSSN.value && existingSSN.value.length === 9) {
                this._alertService.error("Given SSN already exists, Please enter other SSN");
                $(`#viewSSN${i}`).hide();
                $input.val(value);
                return;
            }

            let maskedVal = this.maskSSN(value);
            this.ssnValues[i] = { value: value, maskedSSN: maskedVal };
            await this.validateSSN(i);
            return;
        } else if (value.indexOf('*') > -1 && value.length != 11) {
            value = value.replace(/-/g, '');
            value = previousValue.substring(0, value.length);
            this.ssnValues[i] = { value: value, maskedSSN: '' };
            return;
        }

        if (value.indexOf('*') > -1 && value.length === 11) {
            return;
        } else if (value.indexOf('*') > -1) {
            (<any>$('#dilog-container')).modal('show');
            $input.focus();
            return;
        }

        if (value.indexOf('*') === -1 && value.length > 9) {
            (<any>$('#dilog-container')).modal('show');
            this.ssnValues[i] = { value: '', maskedSSN: '' };
            $input.focus();
            return;
        }

        value = value.replace(/\D/g, '');
        $input.val(value);
        this.isAllchecked = false;
        this.wagesSearchList = [];
        this.wagesSearchListview = [];
        this.totalWagesSearchList = [];
        this.totalWagesSearchListview = [];
        this.totalcountview = 0;
        this.totalcount = 0;
        this.currentPageNumber = 1;
    }

    private filterSSNValue(value: any, i: any){
        if (value.indexOf('*') === -1) {
            value = value.replace(/-/g, '');

            if (value.length > 9) {
                value = value.substring(0, 9)
            }
        }



        if (value.length) {
            $(`#viewSSN${i}`).show();
        } else {
            $(`#viewSSN${i}`).hide();
        }

        if (value.length == 11 && value.indexOf('*') === -1) {
            value = value.replace(/-/g, '');
        }
        return value;
    }

    onClear() {
        this.ssnValues = [{ value: "" }];
        this.case = '';
        this.requestedBy = '';
        this.wagesSearchList = [];
        this.wagesSearchListview = [];
        this.totalWagesSearchList = [];
        this.totalWagesSearchListview = [];
        this.totalcountview = 0;
        this.totalcount = 0;
        this.isSearched = false;
        this.currentPageNumber = 1;
    }

    maskSSN(ssn: any) {
        ssn = ssn || '';
        if (ssn?.length === 9) {
            const maskedSSN = '*'.repeat(ssn.length - 4);
            const lastFoutDigits = ssn.slice(-4);
            let output = `${maskedSSN}${lastFoutDigits}`;
            return output.replace(/^\*+(\d{4})$/, '***-**-$1')
        }
        return ssn;
    }

    formatToSSN(ssn: string) {
        return `${ssn.slice(0, 3)}-${ssn.slice(3, 5)}-${ssn.slice(5)}`
    }

    viewSSN(ssn: string, maskedSSN: string, index: number) {
        let value: any = $(`#SSN${index}`).val();

        if (value.indexOf('**') > -1) {
            $(`#viewSSN${index}`).removeClass('fa-eye-slash').addClass('fa-eye');
            $(`#SSN${index}`).val(this.formatToSSN(ssn));
        } else {
            $(`#viewSSN${index}`).removeClass('fa-eye').addClass('fa-eye-slash');
            $(`#SSN${index}`).val(maskedSSN);
        }

    }

    async validateSSN(index: any, event?: any) {
        if (event) {
            let $input = $('#' + event.currentTarget.id);
            let value: any = $input.val();
            if (!value.length) {
                return;
            }

            if (value.indexOf('*') === -1 && value.length < 9) {
                (<any>$('#dilog-container')).modal('show');
                return;
            }
        } else {
            let ssn = this.ssnValues[index];

            if (!ssn?.value) {
                (<any>$('#dilog-container')).modal('hide');
                return false;
            }

            return new Promise((resolve) => {
                this._personInfoService.searchPersonWithSsnCritera({
                    'ssn': ssn.value,
                }).subscribe(presonSearchResult => {
                    if (!presonSearchResult?.count) {
                        this._alertService.error("The SSN you have entered is not saved in the system, Please try again with a different SSN");
                        this.ssnValues[index] = { value: '', maskedSSN: '' };
                    } else {
                        $(`#viewSSN${index}`).removeClass('fa-eye').addClass('fa-eye-slash');
                    }
                    resolve(true);
                });
            });
        }
    }

    pageChanged(pageInfo: any) {
        if (this.selectedTab === 'New Request') {
            this.isAllchecked = false;
            this.selectedRecords = [];
            this.wagesSearchList = this.wagesSearchList.map((item: any) => {
                item.isChecked = false;
                return item;
            })
            this.paginationInfo.pageNumber = pageInfo.page;
            this.paginationInfo.sortColumn = pageInfo.query.sortColumn;
            this.paginationInfo.sortBy = pageInfo.query.sortDirection;
            this.currentPageNumber = pageInfo.page;
        } else if (this.selectedTab === 'View Requested') {
            this.viewPaginationInfo.pageNumber = pageInfo.page;
            this.viewPaginationInfo.sortColumn = pageInfo.query.sortColumn;
            this.viewPaginationInfo.sortBy = pageInfo.query.sortDirection;
            this.currentPageNumber = pageInfo.page;
        }

        if (pageInfo?.query?.sortColumn) {
            this.onSort(pageInfo.query, 'page_change');
        } else {
            this.callApi(pageInfo.query, 'page_change');
        }
    }

    onSort(event: any, from = '') {
        if (this.isOpenHistoryDialog) {
            return
        }

        if (from != 'page_change') {
            event = JSON.parse(event);
        }

        if (this.selectedTab === 'New Request') {
            this.sortNewRequestTable(event);
        } else if (this.selectedTab === 'View Requested') {
            this.sortViewRequestTable(event);
        }

        this.callApi(event, 'sort');
    }

    sortNewRequestTable(event: any) {
        this.paginationInfo.sortBy = event.sortDirection;
        this.paginationInfo.sortColumn = event.sortColumn;
        this.wagesSearchList = Object.create(this.totalWagesSearchList);
        this.wagesSearchList = this.wagesSearchList.map((item: any) => {
            item[event.sortColumn] = item[event.sortColumn] || '';
            return item;
        });
        if (event?.sortDirection === 'asc') {
            if (event?.sortColumn === 'cjamspid') {
                this.wagesSearchList.sort((first: any, next: any) => first[event.sortColumn] - next[event.sortColumn]);
            } else {
                this.wagesSearchList.sort((first: any, next: any) => first[event.sortColumn].localeCompare(next[event.sortColumn] || ''));
            }
        } else {
            if (event?.sortColumn === 'cjamspid') {
                this.wagesSearchList.sort((first: any, next: any) => next[event.sortColumn] - first[event.sortColumn]);
            } else {
                this.wagesSearchList.sort((first: any, next: any) => next[event.sortColumn].localeCompare(first[event.sortColumn] || ''));
            }
        }
    }

    sortViewRequestTable(event: any) {
        this.viewPaginationInfo.sortBy = event.sortDirection;
        this.viewPaginationInfo.sortColumn = event.sortColumn;
        this.wagesSearchListview = Object.create(this.totalWagesSearchListview);
        this.wagesSearchListview = this.wagesSearchListview.map((item: any) => {
            item[event.sortColumn] = item[event.sortColumn] || '';
            return item;
        });
        if (event.sortDirection === 'asc') {
            if (event.sortColumn === 'cjamspid') {
                this.wagesSearchListview.sort((first: any, next: any) => first[event.sortColumn] - next[event.sortColumn]);
            } else {
                this.wagesSearchListview.sort((first: any, next: any) => first[event.sortColumn].localeCompare(next[event.sortColumn] || ''));
            }
        } else {
            if (event.sortColumn === 'cjamspid') {
                this.wagesSearchListview.sort((first: any, next: any) => next[event.sortColumn] - first[event.sortColumn]);
            } else {
                this.wagesSearchListview.sort((first: any, next: any) => next[event.sortColumn].localeCompare(first[event.sortColumn] || ''));
            }
        }
    }

    callApi(query: any, from: any = '') {
        let data: any;

        if (from === 'page_change' || from === 'sort') {
            data = query;
        } else {
            data = JSON.parse(query);
        }

        if(data['maskedSSN']) {
            data['maskedSSN'] = data['maskedSSN'].replace(/-/g, '');
        }

        if (this.selectedTab === 'New Request') {
            data['ssnno'] = data['maskedSSN'];
        } else if (this.selectedTab === 'View Requested') {
            data['ssn'] = data['maskedSSN'];
        }

        delete data['maskedSSN'];
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

        if (this.selectedTab === 'New Request') {
            this.filterNewRequestTable(filters, from);
        } else if (this.selectedTab === 'View Requested') {
            this.filterViewRequestTable(filters, from);
        }
    }

    filterNewRequestTable(filters: any, from = '') {
        let result: any;
        if (filters?.length) {
            let searchList: any;
            if (from === 'sort') {
                searchList = this.wagesSearchList;
            } else {
                searchList = Object.create(this.totalWagesSearchList);
            }

            result = searchList.filter((item: any) => filters.every((filter: any) => String(item[filter.key]).toLowerCase().indexOf(filter.value) > -1));
            this.currentPageNumber = 1;
        } else {
            if (from == 'sort') {
                result = this.wagesSearchList;
                this.currentPageNumber = 1;
            } else {
                result = Object.create(this.totalWagesSearchList);
            }
        }
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.totalcount = result.length;
        this.wagesSearchList = result.slice(startIndex, endIndex);
    }

    filterViewRequestTable(filters: any, from = '') {
        let result: any;
        if (filters.length) {
            let searchList: any;
            if (from === 'sort') {
                searchList = this.wagesSearchListview;
            } else {
                searchList = Object.create(this.totalWagesSearchListview);
            }

            result = searchList?.filter((item: any) => filters.every((filter: any) => String(item[filter.key]).toLowerCase().indexOf(filter.value) > -1));
            this.currentPageNumber = 1;
        } else {
            if (from == 'sort') {
                result = this.wagesSearchListview;
                this.currentPageNumber = 1;
            } else {
                result = Object.create(this.totalWagesSearchListview);
            }
        }
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        this.totalcountview = result.length;

        this.wagesSearchListview = result?.slice(startIndex, endIndex);
    }

    callReDirect(event: any) {
        const data = JSON.parse(event);

        if (data.action === 'History') {
            this.personid = data.personid;
            this.isOpenHistoryDialog = true;
        } else {

            data.caseobjecttype = data.caseobjecttype == 'servicerequest' ? 'SERVICE_CASE' : data.caseobjecttype;
            this._navigationUtils.openEditFinance(data.personid, data.cjamspid, null, null, false,
                data.caseobjecttype, data.caseobjectid, data);
        }

    }

    onClose() {
        (<any>$('#request-submitted')).modal('hide');
    }

    onCloseHistory() {
        this.isOpenHistoryDialog = false;
    }

    onCaseChange(event: Event) {
        let element = event.target as HTMLInputElement;
        this.case = element.value.replace(/[^0-9]/g, '');
        this.ssnValues = [{ value: "" }];
        this.wagesSearchList = [];
        this.wagesSearchListview = [];
        this.totalWagesSearchList = [];
        this.totalWagesSearchListview = [];
        this.totalcountview = 0;
        this.totalcount = 0;
        this.currentPageNumber = 1;
    }

    findDuplicates(input: any[]) {
        let temp: any = {};
        let duplicate = [];

        for (let item of input) {
            if (temp[item]) {
                duplicate.push(item);
                break;
            }

            temp[item] = '';
        }

        return duplicate;
    }

    onSearch() {
        this.selectedRecords = [];
        this.isAllchecked = false;
        this.totalWagesSearchList = [];
        this.wagesSearchList = [];
        this.selectedSsnNumbers = this.ssnValues
            .map((e: any) => e.value)
            .filter((e: any) => !!e);

        let duplicates = this.selectedSsnNumbers.filter((value: any, index: any, self: any) => {
            return self.indexOf(value) !== index;
        });

        if (duplicates.length) {
            return this._alertService.error("Duplicate SSN Found, Please remove duplicate SSN");
        }

        if (this.selectedTab == 'New Request' && !this.selectedSsnNumbers.length && !this.case) {
            return this._alertService.error("Please search with SSN or CASE number");
        }

        if (this.selectedTab == 'View Requested' && !this.selectedSsnNumbers.length && !this.case && !this.requestedBy) {
            return this._alertService.error("Please search with SSN or CASE number or Requested by");
        }

        this.isSearched = true;
        if (this.selectedTab == 'New Request') {
            if (this.case) {
                this.caseSearch(1);
            } else {
                this.ssnSearch(1, this.selectedSsnNumbers);
            }
        } else if (this.selectedTab == 'View Requested') {
            if (this.case) {
                this.onBeaconSearch('CASE');
            } else {
                this.selectedSsnNumbers = this.selectedSsnNumbers.filter((item: any, index: number) => this.selectedSsnNumbers.indexOf(item) === index);
                this.ssnNumbers = this.selectedSsnNumbers.toString();
                this.onBeaconSearch('SSN');
            }
        }
    }
    async bindUsers() {
        this.commonHttpService.getArrayList({
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Getbeaconrequestedbylist
        ).subscribe(response => {
            this.usersList = response || [];
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    private async onBeaconSearch(type: string) {
        this.isSearched = true;
        this.currentPageNumber = 1;
        let req = {};
        if (!this.ssnNumbers && !this.case && this.requestedBy) {
            req = {
                requestby: this.requestedBy,
            };
        } else if (type === 'SSN') {
            req = {
                ssn: [this.ssnNumbers],
                requestby: this.requestedBy,
            };
        } else if (type === 'CASE') {
            req = {
                case: this.case,
                requestby: this.requestedBy,
            }
        }

        this.commonHttpService.getArrayList({
            ...req,
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Getbeaconrequestdetails
        ).subscribe(response => {
            let result = response[0].getbeaconrequestdetails || [];
            result = result.map((item: any) => {
                item.dob = this.formatDate(new Date(item.dob));
                item.insertedon = moment(item.insertedon).format('MM-DD-YYYY h:mm A');
                item.maskedSSN = this.maskSSN(item.ssn);
                return item;
            });

            this.totalWagesSearchListview = Object.create(result);

            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;

            this.wagesSearchListview = result.slice(startIndex, endIndex);
            this.totalcountview = response[0].getbeaconrequestdetails?.length || 0;
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    private async caseSearch(pageNumber: number) {
        this.commonHttpService.getArrayList({
            case: this.case,
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Beaconcasesearch
        ).subscribe(response => {
            let result = response[0].beaconcasesearch || [];
            result = result.map((item: any) => {
                item.dob = this.formatDate(new Date(item.dob));
                item.isChecked = false;
                item.maskedSSN = this.maskSSN(item.ssnno || '');
                return item;
            });
            this.totalWagesSearchList = Object.create(result);

            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;

            this.wagesSearchList = result.slice(startIndex, endIndex);

            if (pageNumber === 1) {
                this.totalcount = response[0].beaconcasesearch?.length || 0;
            }
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    private async ssnSearch(pageNumber: number, ssnNumbers: any) {
        ssnNumbers = ssnNumbers.filter((item: any, index: number) => ssnNumbers.indexOf(item) === index);
        this.commonHttpService.getArrayList({
            ssn: ssnNumbers,
            searchtype: "EXM",
            sortorder: this.paginationInfo.sortBy,
            activeflag: 1,
            pagenumber: pageNumber,
            pagesize: this.paginationInfo.pageSize,
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Beaconssnsearch
        ).subscribe(response => {
            let result = response[0].beaconssnsearch || [];
            result = result.map((item: any) => {
                item.dob = this.formatDate(new Date(item.dob));
                item.isChecked = false;
                item.maskedSSN = this.maskSSN(item.ssnno);
                return item;
            });
            this.totalWagesSearchList = Object.create(result);
            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;

            this.wagesSearchList = result.slice(startIndex, endIndex);
            if (pageNumber === 1) {
                this.totalcount = response[0].beaconssnsearch.length;
            }
        },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            });
    }

    onSelect(event: any) {

        if (event.from != 'all') {
            if (event.isChecked) {
                this.selectedRecords.push(event.data);
            } else {
                this.selectedRecords = this.selectedRecords.filter((item: any) => {
                    if (item.personid !== event.data.personid) {
                        return item;
                    }
                });
            }
            this.isAllchecked = this.selectedRecords.length === this.wagesSearchList.length;
            if (this.isAllchecked) {
                this.wagesSearchList = this.wagesSearchList.map((item: any) => {
                    item.isChecked = this.isAllchecked;
                    return item;
                });
                this.selectedRecords = this.wagesSearchList;
            }

        } else {
            this.isAllchecked = event.isAllchecked;
            this.wagesSearchList = this.wagesSearchList.map((item: any) => {
                item.isChecked = event.isAllchecked;
                return item;
            });

            if (event?.isAllchecked) {
                this.selectedRecords = this.wagesSearchList;
            } else {
                this.selectedRecords = [];
            }
        }
    }

    addbeaconrequestdetails() {
        if (!this.selectedRecords.length) {
            return this._alertService.error("Please select atleast one record and submit request");
        }
        let userName = '';
        const currentUser = this._authService.getCurrentUser();
        if (currentUser) {
            const loggedInUserProfile = currentUser.user ? currentUser.user.userprofile : null;
            if (loggedInUserProfile) {
                userName = loggedInUserProfile.fullname;
            }
        }
        let req = this.selectedRecords.map((item: any) => {
            return {
                username: userName,
                caseobjecttype: item.caseobjecttype,
                caseobjectid: item.caseobjectid,
                personid: item.personid,
                ssn: item.ssnno,
            }
        });

        this.http
            .post(`${AppConfig.baseUrl}/beacon/addbeaconrequestdetails`, req)
            .subscribe((response: any) => {
                this.sameDaySubmittedSSNs = response[0]?.addbeaconrequestdetails?.existingdetails;
                (<any>$('#request-submitted')).modal('show');
            });
    }

    getLoggedInUser() {
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
        return user;
    }

    onView() {
        let ssnNumbers = this.selectedRecords.map((item: any) => {
            return item.ssnno;
        });

        ssnNumbers = [...new Set(ssnNumbers)];
        this.ssnNumbers = ssnNumbers.toString();
        this.selectedTab = 'View Requested';
        this.ssnValues = ssnNumbers.map((item: any) => {
            return {
                value : item,
                maskedSSN:  this.maskSSN(item)
            }
        })
        this.case = '';
        this.requestedBy = '';
        (<any>$('#request-submitted')).modal('hide');
        this.currentPageNumber = 1;
        this.onBeaconSearch('SSN');
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }


    closeErrorMessage() {
        (<any>$('#dilog-container')).modal('hide');
        $('#SSN' + this.ssnIndex).focus();
    }

    changeTab(value: string, from: string = '') {
        let user = this.getLoggedInUser();
        if (from !== 'new') {
            this.ssnNumbers = '';
        }
        this.selectedTab = value;
        this.ssnValues = [{ value: "" }];
        this.case = '';
        this.requestedBy = user.securityuserid;
        this.isSearched = false;
        this.currentPageNumber = 1;
        if (this.selectedTab == 'View Requested') {
            this.onBeaconSearch('SSN');
        }

    }

    onEvent(event: any) {
        if (event.from == 'new') {
            this.ssnNumbers = event.ssnNumbers;
            this.changeTab(event.tab, event.from);
        }
    }
}
