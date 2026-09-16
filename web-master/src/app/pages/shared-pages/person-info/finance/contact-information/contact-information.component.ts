import { Component, OnInit, Input } from '@angular/core';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { CreateBeaconAuditService } from './../shared/audit.service';
import { AlertService } from "../../../../../@core/services/alert.service";
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';

@Component({
    selector: 'contact-information',
    templateUrl: './contact-information.component.html',
    styleUrls: ['./contact-information.component.scss'],
    standalone: false
})
export class ContactInformation implements OnInit {
    @Input() claimant: any = {};
    @Input() ssn: string = '';
    @Input() personId: string = '';
    totalcount = 0;
    currentPageNumber: number = 1;
    totalContactList: any = [];
    contactList: any = [];
    contactColumns: string[] = [
        'EMPLOYER NAME',
        'ADDRESS LINE1',
        'ADDRESS LINE2',
        'CITY',
        'STATE',
        'ZIP'
    ];
    unsortablecolumnsList: string[] = [
        'EMPLOYER NAME',
        'ADDRESS LINE1',
        'ADDRESS LINE2',
        'CITY',
        'STATE',
        'ZIP'
    ];
    contactSearchKeys = [
        'employerName',
        'adress_line_1',
        'adress_line_2',
        'city',
        'state',
        'zip',
    ];

    paginationInfo: PaginationInfo = new PaginationInfo();
    styles: any = {
        'EMPLOYER NAME': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'ADDRESS LINE1': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'ADDRESS LINE2': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'CITY': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'STATE': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'ZIP': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    constructor(
        private auditService: CreateBeaconAuditService,
        private commonHttpService: CommonHttpService,
        private _dataStoreService: DataStoreService,
        public _authService: AuthService,
        public _alertService: AlertService,
    ) { }
    ngOnInit() {
        this.auditService.createAudit('View', 'Contact Information', this.claimant.claim_id, this.ssn,this.personId);
        this.getContactInformation();
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


    private getContactInformation() {
        this.totalContactList = this.claimant?.employeeDetails?.data.map((item: any) => {
            return {
                employerName: item.employerName,
                adress_line_1: item.address1,
                adress_line_2: item.address2,
                city: item.city,
                state: item.state,
                zip: item.postalCode,
            }
        });
        this.contactList = Object.create(this.totalContactList);
        this.totalcount = this.claimant?.employeeDetails?.total;
    }

    async pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        let newPagenumber = pageInfo.page;

        let employerDetails = Object.create(this.totalContactList);
        if (newPagenumber < this.currentPageNumber) {
            let result: any = await this.onPersionSearch('employer');
            let data = result['employerName'] || [];
            let total = result['totalEmployers'] || [];

            data = data.map((employer: any) => {
                return {
                    employerName: employer.employerName,
                    adress_line_1: employer.address1,
                    adress_line_2: employer.address2,
                    city: employer.city,
                    state: employer.state,
                    zip: employer.postalCode,
                }
            });

            employerDetails = [...employerDetails, ...data];
            this.totalcount = total;
        }

        this.totalContactList = Object.create(employerDetails);
        let startIndex = (newPagenumber - 1) * 10;
        let endIndex = startIndex + 10;
        this.contactList = employerDetails.slice(startIndex, endIndex);
        this.currentPageNumber = newPagenumber;
    }
}
