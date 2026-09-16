
import {share, pluck} from 'rxjs/operators';
import { Component, Input } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services';
import { TeamMemberCountyDetails, TeamZipCodeDetails, UsersSearchResult } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';
import { map } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'staff-and-team-result',
    templateUrl: './staff-and-team-result.component.html',
    styleUrls: ['./staff-and-team-result.component.scss'],
    standalone: false
})
export class StaffAndTeamResultComponent {

    @Input()
    pageNumberSubject$!: Subject<number>;
    @Input()
    searchList$!: Observable<UsersSearchResult[]>;
    @Input()
    totalRecords$!: Observable<number>;
    @Input()
    userIDSubject$!: Subject<UsersSearchResult>;

    teamMemberZipCodes$!: Observable<TeamMemberCountyDetails[] | null | undefined>;
    teamZipCodes$!: Observable<TeamZipCodeDetails[]>;
    totalTeammemberRecords$!: Observable<number>;
    totalTeamRecords$!: Observable<number>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    teamMermberpagination: PaginationInfo = new PaginationInfo();
    teampagination: PaginationInfo = new PaginationInfo();
    selectedTeam!: UsersSearchResult | null | undefined;
    selectedTeamMember!: UsersSearchResult;

    selectedUser!: UsersSearchResult;

    constructor(private _commonservice: CommonHttpService) { }

    selectUser(id: UsersSearchResult) {
        this.selectedUser = id;
        this.userIDSubject$.next(this.selectedUser);
    }

    viewTeamMemberZipCodes(item: UsersSearchResult, pageNo: number) {
        this.selectedTeamMember = item;
        this._commonservice.endpointUrl =
            `${FindUrlConfig.EndPoint.staffnteam.teamMemberZipCode}/${item.teammemberid}?filter={"limit": 10,"page": ${pageNo}}`;
        const source = this._commonservice.getPagedArrayList({}).pipe(share());
        this.teamMemberZipCodes$ = source.pipe(
            pluck('data'),
            pluck('countyareateammember'),
            map((data:any) => data as TeamMemberCountyDetails[])
          );
        this.totalTeammemberRecords$ = source.pipe(pluck('count'));
    }

    viewTeamZipCodes(item: UsersSearchResult, _pageNo: number) {
        // Pagination is not in service. Waiting for pagination.
        this.selectedTeam = item;
        this._commonservice.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.teamZipCode + '/' + '?filter={"order": "countyname asc","where": {"activeflag": 1}}';
        this.teamZipCodes$ = this._commonservice.getArrayList({}).pipe(share());
    }

    pageChanged(pageNo: number) {
        this.pageNumberSubject$.next(pageNo);
    }

    teamPageChanged(pageNo: number) {
         // Pagination is not in service. Waiting for pagination.
        // this.pageNumberSubject$.next(pageNo);
    }

    teamMemberPageChanged(pageNo: number) {
        this.viewTeamMemberZipCodes(this.selectedTeamMember, pageNo);
    }

}
