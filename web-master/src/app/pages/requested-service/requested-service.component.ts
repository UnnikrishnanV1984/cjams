
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, Validators, FormBuilder } from '@angular/forms';
import { Observable } from 'rxjs';

import { PaginationInfo, DropdownModel } from '../../@core/entities/common.entities';
import { AuthService, CommonHttpService, AlertService } from '../../@core/services';
import { ColumnSortedEvent } from '../../shared/modules/sortable-table/sort.service';
import { IntakeUtils } from '../_utils/intake-utils.service';
import { AppUser } from '../../@core/entities/authDataModel';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'requested-service',
    templateUrl: './requested-service.component.html',
    styleUrls: ['./requested-service.component.scss'],
    standalone: false
})
export class RequestedServiceComponent implements OnInit {
    paginationInfo: PaginationInfo = new PaginationInfo();
    dashboard$!: Observable<any[]>;
    decisionForm!: FormGroup;
    intakeDecisionForm!: FormGroup;
    reqforservice = '';
    selectedForRemoval: any;
    userRole!: AppUser;
    totalRecords!: number;
    status = 'datereceived';
    isCaseWorker!: boolean;
    tabName = 'Pending';
    showOther = false;
    resonDetails$!: Observable<DropdownModel[]>;
    constructor(private _commonhttp: CommonHttpService,
      private _router: Router, private _authService: AuthService, private _formbuilder: FormBuilder, private _intakeUtils: IntakeUtils, private _alertservice: AlertService) {}

    ngOnInit() {
        this.userRole = this._authService.getCurrentUser();
        if (this.userRole.role.description === 'Case Worker,AS') {
            this.isCaseWorker = true;
        } else {
            this.isCaseWorker = false;
        }
        this.paginationInfo.sortBy = 'desc';
        this.paginationInfo.sortColumn = 'datereceived';
        this.intializeForm();
        this.getPage(1);
        this.caseResonForRemovel();
    }

    intializeForm() {
      this.intakeDecisionForm = this._formbuilder.group({
        reason: ['']
      });
        this.decisionForm = this._formbuilder.group({
            investigationreqforservconfigid: [''],
            reqforservstatus: 'Remove',
            removalreasontypekey: ['', Validators.required],
            removalreasonother: [''],
            closeddate: ['']
        });
    }

    getPage(page: number) {
        const userSID = this._authService.getCurrentUser().user.securityusersid;
        this.paginationInfo.pageNumber = page;
        if (this.isCaseWorker) {
            this.dashboard$ = this._commonhttp
                .getArrayList(
                    {
                        limit: this.paginationInfo.pageSize,
                        page: page,
                        count: this.paginationInfo.total,
                        userid: userSID,
                        status: this.tabName,
                        method: 'post',
                        where: {
                            Reqforservice: this.reqforservice,
                            sortcolumn: this.paginationInfo.sortColumn,
                            sortorder: this.paginationInfo.sortBy
                        }
                    },
                    'investigationreqforservconfig/listservicestatus'
                ).pipe(
                map((result: any) => {
                    this.totalRecords = result.count;
                    return result.data;
                }));

        } else {
            this.dashboard$ = this._commonhttp
                .getArrayList(
                    {
                        limit: this.paginationInfo.pageSize,
                        page: page,
                        count: this.paginationInfo.total,
                        userid: userSID,
                        method: 'post',
                        where: {
                            Reqforservice: this.reqforservice,
                            sortcolumn: this.paginationInfo.sortColumn,
                            sortorder: this.paginationInfo.sortBy
                        }
                    },
                    'Intakedastagings/listservicestatus?'
                ).pipe(
                map((result: any) => {
                    return result.data;
                }));
        }
    }

    changeTab(status: string) {
        this.tabName = status;
        this.getPage(1);
    }

    removeFromQueue() {
        this._commonhttp
            .create(
                {
                    intakenumber: this.selectedForRemoval.intakenumber,
                    rejectcomments: this.decisionForm.getRawValue().reason
                },
                'Intakedastagings/rejectservicestatus'
            )
            .subscribe(
                (result: any) => {
                    this._alertservice.success('Intake removed from waiting list');
                    (<any>$('#remove-from-wl')).modal('hide');
                    this.getPage(this.paginationInfo.pageSize);
                },
                err => {
                    this._alertservice.error('Error in removing intake from waiting list.');
                }
            );
    }
    caseResonForRemovel() {
        this.resonDetails$ = this._commonhttp
            .getArrayList(
                {
                    method: 'get',
                    where: { tablename: 'removalreason', teamtypekey: 'AS' }
                },
                'referencetype/gettypes?filter'
            ).pipe(
            map(item => {
                return item.map(
                    res =>
                        new DropdownModel({
                            text: res.description,
                            value: res.ref_key
                        })
                );
            }));
    }
    onDecisionChange() {
        //No operation needed here
    }

    filterChange(event: any) {
        this.reqforservice = event.value;
        this.getPage(1);
    }

    selectForRemoval(item: any) {
        this.selectedForRemoval = item;
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getPage(this.paginationInfo.pageNumber);
    }

    getScore(item: any) {
        const scoreList = JSON.parse(item.asstscore);
        let scores = '';
        if (scoreList) {
            scoreList.forEach((element: any) => {
                scores = scores + element.titleheadertext + '' + element.score;
            });
        }
        return scoreList;
    }

    openIntake(intakeNumber: string) {
        if (intakeNumber) {
            this._intakeUtils.redirectIntake(intakeNumber, 'edit');
        }
    }

    navigateToCase(item: any) {

        const routeTo = 'report-summary';
        const currentUrl = '/pages/case-worker/' + item.intakeserviceid + '/' + item.servicerequestnumber + '/dsds-action/' + routeTo;
        this._router.navigate([currentUrl]);

    }

    changeToOther(value: any) {
        if (value === 'Other') {
            this.showOther = true;
        } else {
            this.showOther = false;
            this.decisionForm.patchValue({
                removalreasonother: ''
            });
        }
    }

    clearForm() {
        this.decisionForm.reset();
        this.intializeForm();
        this.showOther = false;
    }

    saveRemovalReason(saveValue: any) {
        if (saveValue) {
            saveValue.investigationreqforservconfigid = this.selectedForRemoval.investigationreqforservconfigid;
            saveValue.closeddate = new Date();
            this._commonhttp.create(saveValue, 'investigationreqforservconfig/removalservicestatus').subscribe(data => {
                if (data) {
                    this._alertservice.success('Removed Successfully');
                    this.clearForm();
                    this.getPage(1);
                } else {
                    this._alertservice.error('Unable to Remove');
                }
            });
        }
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.paginationInfo.pageSize = pageInfo.itemsPerPage;
        this.getPage(this.paginationInfo.pageNumber);
    }
}
