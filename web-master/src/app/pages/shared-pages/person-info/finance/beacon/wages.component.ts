import { Component, OnInit } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { parseISO } from "date-fns";
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../@core/services';
import { CreateBeaconAuditService } from './../shared/audit.service';
import moment from 'moment';
import { AlertService } from "../../../../../@core/services/alert.service";
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';

@Component({
    selector: 'wages',
    templateUrl: './wages.component.html',
    styleUrls: ['./wages.component.scss'],
    standalone: false
})
export class WagesComponent implements OnInit {
    isOpenDialog: boolean = false;
    selectedTab: string = 'WAGES';
    auditUrl: string = '';
    personId!: string;
    totalWagesSearchList: any;
    currentPageNumber: number = 1;
    selectedClaimant: any;
    historyResponseStatus: string = '';
    wagesPageNumber: number = 0;
    quarterlyWages: any[] = [];
    requestColumns: string[] = [
        'SSN',
        'FIRST NAME',
        'LAST NAME',
        'EMPLOYER ID',
        'EMPLOYER NAME',
        'WAGE AMOUNT',
        'YEAR-QUARTER',
    ]
    wagesSearchList: any = [];
    wagesUnsortablecolumnsList: string[] = [
        'SSN',
        'FIRST NAME',
        'LAST NAME',
        'EMPLOYER ID',
        'EMPLOYER NAME',
        'WAGE AMOUNT',
        'YEAR-QUARTER',
    ];
    wagesSearchKeys: string[] = [
        'maskedSSN',
        'first_name',
        'last_name',
        'employer_id',
        'employer_name',
        'wage_amount',
        'year_and_quarter',
    ];
    totalcount = 0;
    paginationInfo: PaginationInfo = new PaginationInfo();
    styles: any = {
        'SSN': { 'thStyleClassName': 'width-150', 'tdStyleClassName': '', 'filterIconClassName': '', },
        'FIRST NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'LAST NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'EMPLOYER ID': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'EMPLOYER NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'WAGE AMOUNT': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'YEAR-QUARTER': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    claimantRequestColumns: string[] = [
        'CLAIM ID',
        'NAME',
        'CLAIM STATUS',
        'EFFECTIVE DATE',
        'SSN',
        'ACTION'
    ]
    claimantUnsortablecolumnsList: string[] = [
        'CLAIM ID',
        'NAME',
        'CLAIM STATUS',
        'EFFECTIVE DATE',
        'SSN',
        'ACTION'
    ]
    claimants: any = [];
    claimantSearchList: any = [];
    totalClaimantSearchList: any = [];
    claimantTotalcount: number = 0;
    claimantSearchKeys: string[] = [
        'claim_id',
        'claimant_name',
        'claim_status',
        'effectivedatefrom',
        'maskedSSN',
        'View',
    ];
    dateFrom: any;
    dateTo: any;
    claimantPaginationInfo: PaginationInfo = new PaginationInfo();
    claimantAdditionalInfo: any = {};
    claimantStyles: any = {
        'CLAIM ID': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'CLAIM STATUS': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'EFFECTIVE DATE': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'SSN': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'ACTION': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    };

    selectedMenu: string = 'DATA_DIV';
    selectedData: string = 'Historical';
    beaconrequestdetailsid: any;
    ssn: any;
    sourcetrackingid: any;

    constructor(
        private _dataStoreService: DataStoreService,
        private commonHttpService: CommonHttpService,
        private auditService: CreateBeaconAuditService,
        public _authService: AuthService,
        public _alertService: AlertService,
    ) { }
    ngOnInit() {

        this.beaconrequestdetailsid = this._dataStoreService.getData('beaconrequestdetailsid');
        this.ssn = this._dataStoreService.getData('ssn');
        this.sourcetrackingid = this._dataStoreService.getData('sourcetrackingid');
        this.personId = this._dataStoreService.getData('personId');
        this.getPerson();
    }

    getPerson() {
        if (this.beaconrequestdetailsid && this.sourcetrackingid && this.ssn) {
            this.onSelect('WAGES');
        } else {
            let person = this._dataStoreService.getObj('PERSON_NAVIGATION_INFO')
            let personId = this.personId || person.personId;
            this.commonHttpService.getArrayList({
                nolimit: true,
                personid: personId,
                method: 'get'
            },
                'beacon/getbeaconvalidation' + '?filter'
            ).subscribe(response => {
                this.ssn = response[0]?.ssn || 0;
                this.sourcetrackingid = response[0]?.sourcetrackingid || 0;
                if (!response?.length && !this.beaconrequestdetailsid) {
                    this.isOpenDialog = true;
                } else {
                    this.onSelect('WAGES');
                }

            },
                error => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                });
        }
    }

    async onWagesSearch(pageNumber: number = 0) {
        let response = await this.onPersionSearch('employer', pageNumber);
        if (response instanceof Error) {
            return '';
        } else {
            return this.processWages(response);
        }
    }

    async onClaimantSearch() {
        let response = await this.onPersionSearch('claimHistory');
        this.processClaimants(response);
    }

    async onPersionSearch(segment: string, pageNumber = 0) {
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
                        beaconrequestdetailsid: this.beaconrequestdetailsid,
                        ssn: this.ssn,
                        sourcetrackingid: this.sourcetrackingid,
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

    async processClaimants(response: any) {
        let historyResponse = response['historyResponse'];
        let claimantHistory = historyResponse['claimHistorySegment']?.results || [];
        let claimantHistoryTotal = historyResponse['claimHistorySegment']?.total || 0;
        let claimants = response['claimant'];
        claimants = this.bindPayments(claimants);
        this.claimantAdditionalInfo = {
            historyEmployees: { total: 0, data: [] },
            historyOverPayments: { total: 0, data: [] },
        }

        let historyData: any;

        historyData = await this.onPersionSearch('employer');
        historyData = historyData['historyResponse'];
        this.claimantAdditionalInfo.historyEmployees.data = historyData['employerName'] || [];
        this.claimantAdditionalInfo.historyEmployees.total = historyData['totalEmployers'] || [];

        historyData = await this.onPersionSearch('overpaymentInquiry');
        historyData = historyData['historyResponse'];
        this.claimantAdditionalInfo.historyOverPayments.data = historyData['overpaymentInquiry']?.results || [];
        this.claimantAdditionalInfo.historyOverPayments.total = historyData['overpaymentInquiry']?.total || 0;
        if (claimants.payments.length || claimants.claim_id || claimants.first_name || claimants.last_name || claimants.claim_status || claimants.effectivedatefrom) {
            claimants.from = 'Realtime';
            claimants.overPayments = { total: 0, data: [] }; 
            claimants.adjustedPaymentHistoryDetailsSegment = [];
            claimants = [claimants];
        } else {
            claimants = [];
        }


        for (let item of claimantHistory) {
            let details: any = {};
            details.ssn = this.ssn;
            details.first_name = claimants[0]?.first_name
            details.last_name = claimants[0]?.last_name
            details.maskedSSN = this.maskSSN(this.ssn);
            details.claim_status = item.claim_status || '';
            details.effective_date = this.fmtDate(item.effective_date);
            details.benefit_year_begin_date = this.emptyStr(item.benefit_year_begin_date);
            details.benefit_year_end_date = this.emptyStr(item.benefit_year_end_date);
            details.claim_id = this.emptyStr(item.claim_id);
            details.adress_line_1 = this.emptyStr(historyResponse.adress_line_1);
            details.adress_line_2 = this.emptyStr(historyResponse.adress_line_2);
            details.city = this.emptyStr(historyResponse.city);
            details.state = this.emptyStr(historyResponse.state);
            details.zip = this.emptyStr(historyResponse.zip);
            details.payments = item.paymentHistorySegment || [];
            details.employeeDetails = this.claimantAdditionalInfo.historyEmployees;
            details.overPayments = this.claimantAdditionalInfo.historyOverPayments;
            details.adjustedPaymentHistoryDetailsSegment = item.adjustedPaymentHistoryDetailsSegment || [];
            details.from = 'Historical';
            claimants.push(details);
        }

        claimants = claimants.map((item: any) => {
            item.ssn = item.ssn ? item.ssn + '' : '';
            item.effectivedatefrom = this.fmtDate(item.effective_date);
            item.benefit_year_begin_date = this.fmtDate(item.benefit_year_begin_date);
            item.benefit_year_end_date = this.fmtDate(item.benefit_year_end_date);
            item.maskedSSN = this.maskSSN(item.ssn);
            item.claimant_name = this.getName(item.first_name, item.last_name);
            return item;
        });
        claimants = claimants.filter((item: any) => item.claim_id);
        this.claimants = Object.create(claimants);
        this.totalClaimantSearchList = Object.create(claimants);
        this.currentPageNumber = 1;
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        claimants = claimants.filter((item: any) => item.from === this.selectedData);
        this.claimantSearchList = claimants.slice(startIndex, endIndex);
        this.claimantTotalcount = claimantHistoryTotal + 1;
    }

    async claimantPageChanged(pageInfo: any) {
        this.claimantPaginationInfo.pageNumber = pageInfo.page;
        let newPageNumber = pageInfo.page;
        let claimants = Object.create(this.claimants);
        if (newPageNumber < this.currentPageNumber) {
            let response: any = await this.onPersionSearch('claimHistory', newPageNumber - 1);
            let historyResponse = response['historyResponse'];
            let claimantHistory = historyResponse['claimHistorySegment']?.results || [];
            let claimantHistoryTotal = historyResponse['claimHistorySegment']?.total || 0;

            for (let item of claimantHistory) {
                let details: any = {};
                details.ssn = this.ssn;
                details.first_name = claimants[0]?.first_name
                details.last_name = claimants[0]?.last_name
                details.maskedSSN = this.maskSSN(this.ssn);
                details.claim_status = this.emptyStr(item.claim_status);
                details.effective_date = this.fmtDate(item.effective_date);
                details.benefit_year_begin_date = this.emptyStr(item.benefit_year_begin_date);
                details.benefit_year_end_date = this.emptyStr(item.benefit_year_end_date);
                details.claim_id = this.emptyStr(item.claim_id);
                details.adress_line_1 = this.emptyStr(historyResponse.adress_line_1);
                details.adress_line_2 = this.emptyStr(historyResponse.adress_line_2);
                details.city = this.emptyStr(historyResponse.city);
                details.state = this.emptyStr(historyResponse.state);
                details.zip = this.emptyStr(historyResponse.zip);
                details.payments = item.paymentHistorySegment || [];
                details.employeeDetails = this.claimantAdditionalInfo.historyEmployees;
                details.overPayments = this.claimantAdditionalInfo.historyOverPayments;
                details.adjustedPaymentHistoryDetailsSegment = item.adjustedPaymentHistoryDetailsSegment || [];
                details.from = 'Historical';
                claimants.push(details);
            }

            claimants = claimants.map((claimant: any) => {
                claimant.ssn = claimant.ssn ? claimant.ssn + '' : '';
                claimant.effectivedatefrom = this.fmtDate(claimant.effective_date);
                claimant.benefit_year_begin_date = this.fmtDate(claimant.benefit_year_begin_date);
                claimant.benefit_year_end_date = this.fmtDate(claimant.benefit_year_end_date);
                claimant.maskedSSN = this.maskSSN(claimant.ssn);
                claimant.claimant_name = this.getName(claimant.first_name, claimant.last_name);
                return claimant;
            });
            this.claimantTotalcount = claimantHistoryTotal + 1;
            this.claimants = Object.create(claimants);
            this.totalClaimantSearchList = Object.create(claimants);
        }


        let startIndex = (newPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        if (this.selectedData != 'All') {
            claimants = claimants.filter((item: any) => item.from === this.selectedData);
        }
        this.claimantSearchList = claimants.slice(startIndex, endIndex);
        this.currentPageNumber = newPageNumber;
    }

    emptyStr(value: any){
        return value || '';
    }

    fmtDate(value: any){
        return value ? moment(value).format('MM-DD-YYYY') : '';
    }

    bindPayments(claimants: any) {
        claimants.payments = [];
        if (claimants?.paidDateWeek1 || claimants?.netPayWeek1 || claimants?.grossPayWeek1) {
            claimants.payments.push({
                "week_ending": claimants.week_ending,
                "date_certification_received": claimants.date_certification_received,
                "program": claimants.program,
                "over_payment": claimants.over_payment,
                "process_status": claimants.process_status,
                "process_adjusted_date": claimants.process_adjusted_date,
                "date_payment_issued": claimants.paidDateWeek1,
                "benfit_amount": claimants.netPayWeek1,
                "payment_amount": claimants.grossPayWeek1,
            })
        }

        if (claimants?.paidDateWeek2 || claimants?.netPayWeek2 || claimants?.grossPayWeek2) {
            claimants.payments.push({
                "week_ending": claimants.week_ending,
                "date_certification_received": claimants.date_certification_received,
                "program": claimants.program,
                "over_payment": claimants.over_payment,
                "process_status": claimants.process_status,
                "process_adjusted_date": claimants.process_adjusted_date,
                "date_payment_issued": claimants.paidDateWeek2,
                "benfit_amount": claimants.netPayWeek2,
                "payment_amount": claimants.grossPayWeek2,
            })
        }

        if (claimants?.paidDateWeek3 || claimants?.netPayWeek3 || claimants?.grossPayWeek3) {
            claimants.payments.push({
                "week_ending": claimants.week_ending,
                "date_certification_received": claimants.date_certification_received,
                "program": claimants.program,
                "over_payment": claimants.over_payment,
                "process_status": claimants.process_status,
                "process_adjusted_date": claimants.process_adjusted_date,
                "date_payment_issued": claimants.paidDateWeek3,
                "benfit_amount": claimants.netPayWeek3,
                "payment_amount": claimants.grossPayWeek3,
            })
        }

        if (claimants?.paidDateWeek4 || claimants?.netPayWeek4 || claimants?.grossPayWeek4) {
            claimants.payments.push({
                "week_ending": claimants.week_ending,
                "date_certification_received": claimants.date_certification_received,
                "program": claimants.program,
                "over_payment": claimants.over_payment,
                "process_status": claimants.process_status,
                "process_adjusted_date": claimants.process_adjusted_date,
                "date_payment_issued": claimants.paidDateWeek4,
                "benfit_amount": claimants.netPayWeek4,
                "payment_amount": claimants.grossPayWeek4,
            })
        }

        claimants.employeeDetails = { total: 0, data: [] };

        return claimants;
    }

    async processWages(response: any): Promise<string | undefined> {
        let historyResponse = response['historyResponse'];
        historyResponse['employerName']?.forEach((item: any) => {
            item.quarterlyWageSegments = item.quarterlyWageSegments.map((value: any) => {
                value.employer_name = item.employerName;
                return value;
            });
            this.quarterlyWages = [...this.quarterlyWages, ...item.quarterlyWageSegments];
        });
        if (historyResponse['employerName']?.total > 10) {
            this.wagesPageNumber++;
            const wageSearch = await this.onWagesSearch(this.wagesPageNumber);
            console.log(this.wagesPageNumber);
            return wageSearch;
        }
        this.historyResponseStatus = historyResponse.processedDate ? `Available (Received On: ${moment(historyResponse.processedDate).format('MM-DD-YYYY')})` : 'Awaiting Info';
        let wages = response['wages'];
        wages = wages.map((item: any) => {
            item.ssn = item.ssn ? item.ssn + '' : '';
            item.maskedSSN = this.maskSSN(item.ssn);
            item.year_and_quarter = `${item.year}-${item.year_quarter}`;
            item.wage_amount = item.wage_amount ? `$${Number(item.wage_amount).toLocaleString('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            })}` : '';
            item.from = 'Realtime';
            return item;
        });

        for (let item of this.quarterlyWages) {
            let details: any = {};
            details.ssn = this.ssn;
            details.first_name = item.first_name || wages[0]?.first_name;
            details.last_name = item.last_name || wages[0]?.last_name;
            details.maskedSSN = this.maskSSN(this.ssn);
            details.employer_id = item.employerMarylandAccountNumber;
            details.employer_name = item.employer_name;
            details.wage_amount = item.incomeAmount ? `$${Number(item.incomeAmount).toLocaleString('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            })}` : '';
            details.year_and_quarter = `${item.wageYear}-${item.wageQuarter}`;
            details.from = 'Historical';
            wages.push(details);
        }

        wages.sort((f: any, s: any) => {
            const fWageYear = f.year_and_quarter.split('-')[0];
            const sWageYear = s.year_and_quarter.split('-')[0];
            const fwageQuarter = f.year_and_quarter.split('-')[1];
            const swageQuarter = s.year_and_quarter.split('-')[1];
            if (Number(sWageYear) !== Number(fWageYear)) {
                return Number(sWageYear) - Number(fWageYear);
            }
            return Number(swageQuarter) - Number(fwageQuarter);
        });

        this.totalWagesSearchList = Object.create(wages);
        this.currentPageNumber = 1;
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        wages = wages.filter((item: any) => item.from === this.selectedData);
        this.wagesSearchList = wages.slice(startIndex, endIndex);
        this.totalcount = wages?.length;
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        let newPageNumber = pageInfo.page;
        let wages = Object.create(this.totalWagesSearchList);
        this.totalWagesSearchList = Object.create(wages);
        let startIndex = (newPageNumber - 1) * 10;
        let endIndex = startIndex + 10;

        if (this.selectedData != 'All') {
            wages = wages.filter((item: any) => item.from === this.selectedData);
        }

        if (this.selectedData === 'All') {
            wages = this.unifyWages(wages);
        }

        this.wagesSearchList = wages.slice(startIndex, endIndex);
        this.currentPageNumber = newPageNumber;
        this.totalcount = wages?.length;
    }

    unifyWages(wages: any) {
        const wagesSet = new Set();
        return wages.filter((item: any) => {
            const key = `${item.employer_id}-${item.wage_amount}-${item.year_and_quarter}`;

            if (wagesSet.has(key)) {
                return false;
            }

            wagesSet.add(key);
            return true;
        });
    }

    async onSelected(value: string) {
        this.selectedData = value;
        this.paginationInfo.pageNumber = 1;
        this.claimantPaginationInfo.pageNumber = 1;
        this.wagesSearchList = [];
        this.totalcount = 0;
        this.claimantSearchList = [];
        await new Promise((res, rej) => {
            setTimeout(() => res(true), 10);
        });
        if (this.selectedTab == 'WAGES') {
            let wages = Object.create(this.totalWagesSearchList);
            if (this.selectedData != 'All') {
                wages = wages.filter((item: any) => item.from === this.selectedData);
            }

            if (this.selectedData === 'All') {
                wages = this.unifyWages(wages);
            }

            this.currentPageNumber = 1;
            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;
            this.wagesSearchList = wages.slice(startIndex, endIndex);
            this.totalcount = wages?.length;
        } else if (this.selectedTab == 'CLAIMANT') {
            let claimants = Object.create(this.totalClaimantSearchList);
            if (this.selectedData != 'All') {
                claimants = claimants.filter((item: any) => item.from === this.selectedData);
            }

            this.currentPageNumber = 1;
            let startIndex = (this.currentPageNumber - 1) * 10;
            let endIndex = startIndex + 10;
            this.claimantSearchList = claimants.slice(startIndex, endIndex);
            this.totalcount = claimants?.length || 0;
        }
    }

    async onSelect(value: string) {
        this.selectedData = 'Historical';
        this.paginationInfo.pageNumber = 1;
        this.claimantPaginationInfo.pageNumber = 1;
        this.wagesSearchList = [];
        this.totalcount = 0;
        this.claimantSearchList = [];
        await new Promise((res, rej) => {
            setTimeout(() => res(true), 10);
        });
        if (value === 'WAGES') {
            this.wagesPageNumber = 0;
            this.quarterlyWages = [];
            this.onWagesSearch(this.wagesPageNumber);
            this.auditService.createAudit('View', 'Wages', '', this.ssn,this.personId);
        } else if (value === 'CLAIMANT') {
            this.onClaimantSearch();
            this.auditService.createAudit('View', 'Claimant', '', this.ssn,this.personId);
            this.selectedMenu = 'DATA_DIV';
        } else if (value === 'AUDIT TRAIL') {
            this.auditUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Beacon.Getbeaconaudit
        }
        this.selectedTab = value;

    }

    onValidateSearch() {
        if(this.dateFrom && this.dateTo) {
            this.onSearch();
        } else if(!this.dateFrom && this.dateTo) {
            this._alertService.error('Please Enter Effective Date From');
        } else if(this.dateFrom && !this.dateTo){
            this._alertService.error('Please Enter Effective Date To');
        } else {
            this._alertService.error('Please Enter Effective Date From and Effective Date To');
        }
    }

    maskSSN(ssn: any) {
        ssn = ssn || '';
        ssn = ssn + '';
        if (ssn?.length === 9) {
            const maskedSSN = '*'.repeat(ssn.length - 4);
            const lastFoutDigits = ssn.slice(-4);
            let output = `${maskedSSN}${lastFoutDigits}`;
            return output.replace(/^\*+(\d{4})$/, '***-**-$1')
        }
        return ssn;
    }

    claimantCallReDirect(event: any) {
        const data = JSON.parse(event);
        data.fullName = this.getName(data.first_name, data.last_name);
        data.employeeDetails = data.employeeDetails ? data.employeeDetails : [];
        this.selectedClaimant = data;
        this.selectedMenu = 'VIEW_DIV';
    }

    getName(firstName: string, lastName: string) {
        let fullName = firstName || '';
        if (firstName) {
            fullName = fullName + ', '
        }
        fullName = fullName + (lastName || '');
        return fullName;
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }

    onSearch() {
        let data = Object.create(this.claimants);
        let startDate = parseISO(this.dateFrom)
        let endDate = parseISO(this.dateTo);
        data = data.filter((item: any) => {
            const itemDate = new Date(item.effective_date);
            return itemDate >= startDate && itemDate <= endDate;
        });
        this.currentPageNumber = 1;
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.totalClaimantSearchList = Object.create(data);

        if (this.selectedData != 'All') {
            data = data.filter((item: any) => item.from === this.selectedData);
        }
        this.claimantSearchList = data.slice(startIndex, endIndex);
        this.claimantPaginationInfo.pageNumber = 1;
        this.claimantTotalcount = this.totalClaimantSearchList?.length || 0;
    }

    onClear() {
        this.dateFrom = '';
        this.dateTo = '';
        let data = Object.create(this.claimants);
        this.currentPageNumber = 1;
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.totalClaimantSearchList = Object.create(data);
        if (this.selectedData != 'All') {
            data = data.filter((item: any) => item.from === this.selectedData);
        }
        this.claimantSearchList = data.slice(startIndex, endIndex);
        this.claimantPaginationInfo.pageNumber = 1;
        this.claimantTotalcount = this.totalClaimantSearchList?.length || 0;
    }

    backToClaimant() {
        this.selectedMenu = 'DATA_DIV';
    }

    closeAlert() {
        this.isOpenDialog = false;
    }
}
