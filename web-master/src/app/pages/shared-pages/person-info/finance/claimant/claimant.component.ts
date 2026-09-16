import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CreateBeaconAuditService } from './../shared/audit.service';
import { AlertService } from "../../../../../@core/services/alert.service";
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';

@Component({
    selector: 'claimant',
    templateUrl: './claimant.component.html',
    styleUrls: ['./claimant.component.scss'],
    standalone: false
})
export class ClaimantComponent implements OnInit {
    @Input() claimant: any = {};
    @Input() ssnNumber: string = '';
    @Input() personId: string = '';
    @Output() backToClaimant: EventEmitter<any> = new EventEmitter();
    isCollapse = false;
    employeeDetails: any = {};
    selectedSideBar: string = 'Account Profile';
    topBar: string = 'Contact Information'
    totalcount = 0;
    totalEmploymentInformationList: any = [];
    currentPageNumber: number = 1;
    employmentInformationList: any = [];
    employmentColumns: string[] = [
        // 'EMPLOYER ID',
        'EMPLOYER NAME',
        'STATE',
        'LAST DAY OF WORK',
    ];
    unsortablecolumnsList: string[] = [
        // 'EMPLOYER ID',
        'EMPLOYER NAME',
        'STATE',
        'LAST DAY OF WORK',
    ];
    employmentSearchKeys = [
        // 'employer_id',
        'employer_name',
        'state',
        'last_day_of_work',
    ];

    paginationInfo: PaginationInfo = new PaginationInfo();
    styles: any = {
        // 'EMPLOYER ID': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'EMPLOYER NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'STATE': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'LAST DAY OF WORK': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    constructor(
        private auditService: CreateBeaconAuditService,
        private commonHttpService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        public _authService: AuthService,
        public _alertService: AlertService,
    ) { }

    ngOnInit() {
        this.auditService.createAudit('View', 'Account Profile', this.claimant.claim_id, this.ssnNumber,this.personId);
        let result = this.claimant?.employeeDetails?.data;
        result = result.map((item: any) => {
            let quarterlyWageSegments = item?.quarterlyWageSegments.length ? item?.quarterlyWageSegments : [];
            quarterlyWageSegments = quarterlyWageSegments.sort((f: any = {}, s: any = {}) => {
                f.wageYear = f?.wageYear || 0;
                s.wageYear = s?.wageYear || 0;
                f.wageQuarter = f?.wageQuarter || 0;
                s.wageQuarter = s?.wageQuarter || 0;
                if (Number(f?.wageYear) !== Number(s?.wageYear)) {
                    return Number(f?.wageYear) - Number(s?.wageYear);
                }
                return Number(f?.wageQuarter) - Number(s?.wageQuarter);
            });
            quarterlyWageSegments = quarterlyWageSegments[quarterlyWageSegments.length - 1];
            item.employer_id = item.employerSegmentId
            item.employer_name = item.employerName;
            item.last_day_of_work = item?.last_day_of_work ? this.formatDate(new Date(item?.last_day_of_work)) : `${quarterlyWageSegments.wageYear}-${quarterlyWageSegments.wageQuarter}`;

            return item;
        });

        result.sort((f: any, s: any) => {
            const fWageYear = f.last_day_of_work.split('-')[0];
            const sWageYear = s.last_day_of_work.split('-')[0];
            const fwageQuarter = f.last_day_of_work.split('-')[1];
            const swageQuarter = s.last_day_of_work.split('-')[1];
            if (Number(sWageYear) !== Number(fWageYear)) {
                return Number(sWageYear) - Number(fWageYear);
            }
            return Number(swageQuarter) - Number(fwageQuarter);
       })
        this.totalEmploymentInformationList = Object.create(result);
        let startIndex = (this.currentPageNumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.employmentInformationList = result.slice(startIndex, endIndex);
        this.totalcount = this.claimant?.employeeDetails?.total;
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

    onCollapse() {
        this.isCollapse = !this.isCollapse;
    }

    async pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        let newPagenumber = pageInfo.page;

        let employerDetails = Object.create(this.totalEmploymentInformationList);
        if(newPagenumber < this.currentPageNumber) {
            let result: any = await this.onPersionSearch('employer');
            let data = result['employerName'] || [];
            let total = result['totalEmployers'] || [];
            employerDetails = [...employerDetails, ...data];
            this.totalcount = total;
        }

        this.totalEmploymentInformationList = Object.create(employerDetails);
        let startIndex = (newPagenumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.employmentInformationList = employerDetails.slice(startIndex, endIndex);
        this.currentPageNumber = newPagenumber;
    }

    formatDate(date: Date) {
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        return `${month}-${day}-${year}`;
    }

    onSelect(value: string) {
        this.selectedSideBar = value;

        if (value === 'View Cases') {
            this.topBar = 'Payments';
        }
    }

    onSelectTopBar(value: string) {
        this.topBar = value;
    }

    onBackToClaimant() {
        this.backToClaimant.emit('Back');
    }
}
