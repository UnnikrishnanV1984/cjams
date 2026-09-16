
import {share, pluck} from 'rxjs/operators';
import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services';
import { TeamMemberDetails, TreeView } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';
import { map } from 'rxjs';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'staff-and-team-reasign',
    templateUrl: './staff-and-team-reasign.component.html',
    styleUrls: ['./staff-and-team-reasign.component.scss'],
    standalone: false
})
export class StaffAndTeamReasignComponent implements OnInit {

    id!: string | null;
    teamTreeview$!: Observable<TreeView[]>;
    teamMemberDetailsList$!: Observable<TeamMemberDetails[]>;
    totalteamMemberListCount$!: Observable<number>;
    treeComponentId!: string | null;
    paginationInfo: PaginationInfo = new PaginationInfo();
    userinStack!: TeamMemberDetails;
    selectedUserProfile!: TeamMemberDetails;

    constructor(
        private _commonservice: CommonHttpService,
        private route: ActivatedRoute, private datePipe: DatePipe) { }

    ngOnInit() {
        this.id = this.route.snapshot.params['id'];
        this.getTeamTree();
        this.showReassignModel();
    }

    showReassignModel() {
        $('#reassign-equipment').modal('show');
    }

    getTeamTree() {
        this.teamTreeview$ = this._commonservice.getArrayList(FindUrlConfig.EndPoint.staffnteam.teamtreelist).pipe(share());
    }

    teamTreeSubComp(model: any) {
        this.treeComponentId = model.node.id;
        this.teamMembersDetails(1);
    }

    teamMembersDetails(pageNo: number) {

        this._commonservice.endpointUrl = `${FindUrlConfig.EndPoint.staffnteam.teamMemberDetails}/f7b2732f-3ded-4877-bdc2-860462f6d689?filter={"limit": 5,"page": ${pageNo}}`;
        const source = this._commonservice.getPagedArrayList({}).pipe(share());
        this.teamMemberDetailsList$ = source.pipe(
            pluck('data'),
            pluck('teammembers'),
            map((data:any) => data as TeamMemberDetails[])
          );
        this.totalteamMemberListCount$ = source.pipe(pluck('count'));
    }

    pageChanged(pageNo: number) {
        this.teamMembersDetails(pageNo);
    }

    selectUserProfile(member: TeamMemberDetails) {
        this.userinStack = member;
    }

    loadUserSelection() {
        this.selectedUserProfile = this.userinStack;
    }

    reassignUser() {
        if (this.selectedUserProfile) {
            const date = this.datePipe.transform(new Date(), 'yyyy-MM-dd h:mm:ss');
            const params = {
                positioncode: this.selectedUserProfile.positioncode,
                equipmentid: this.id,
                activeflag: 1,
                insertedby: 'Conversion',
                updatedby: 'Conversion',
                effectivedate: date
            };

            this._commonservice.endpointUrl =
                FindUrlConfig.EndPoint.staffnteam.assignEquipment;
            this._commonservice.create(params).subscribe(data => {
                // need to handle the error
            });
        } else {
            //No operation needed here
        }
    }
}
