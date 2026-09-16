
import {mergeMap, startWith, map, debounceTime} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Subject,merge } from 'rxjs';
import moment from 'moment';
import { DynamicObject, PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { AuthService } from '../../../@core/services/auth.service';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { MyIntakeDetails } from '../my-newintake/_entities/newintakeModel';
import { BroadCostMessage, SearchCase } from '../my-newintake/_entities/newintakeSaveModel';
import { NewUrlConfig } from '../newintake-url.config';
import { IntakeConfigService } from '../my-newintake/intake-config.service';
import { ActivatedRoute } from '@angular/router';
import { AppUser } from '../../../@core/entities/authDataModel';
import { hasMatch } from '../../../@core/common/initializer';
import { PurposeResolverService } from '../my-newintake/purpose-resolver.service';
import { DataStoreService } from '../../../@core/services';

declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'new-saveintake',
    templateUrl: './new-saveintake.component.html',
    styleUrls: ['./new-saveintake.component.scss'],
    standalone: false
})
export class NewSaveintakeComponent implements OnInit {
    showHistory!: boolean;
    searchHistory: any = [];
    searchIntakeForm!: FormGroup;
    assignedCaseForm!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    intakes!: MyIntakeDetails[];
    totalRecords!: number;
    dynamicObject: DynamicObject = {};
    showBroadCostMessage!: BroadCostMessage;
    roleName!: string;
    isPreIntake = false;
    previousPage!: number;
    narrative =  '';
    searchCriteria!: SearchCase;
    private searchTermStream$ = new Subject<DynamicObject>();
    private pageStream$ = new Subject<number>();
    isDjs = false;
    status!: string;
    agency!: string;
    isCW!: boolean;
    workerList: any[] = [];
    role!: AppUser;
    showWorkerList =false;
    narrative_dialog = '#narrative-dialog';
    activeTab :string ='pending'
    
    constructor(
        private formBuilder: FormBuilder,
        private _authService: AuthService,
        private _service: GenericService<MyIntakeDetails>,
        private _commonHttpService: CommonHttpService,
        private _intakeUtils: IntakeUtils,
        private _intakeConfig: IntakeConfigService,
        private route: ActivatedRoute,
        private purposeResolverService: PurposeResolverService,
        private _dataStoreService: DataStoreService
    ) {
        // this._intakeConfig.setPurposeList(this.route.snapshot.data.purposeList);
    }

    ngOnInit() {
        this.purposeResolverService.getPurpose().subscribe({
            next: (data: any) => {
                this._intakeConfig.setPurposeList(data);
            }
        })
        this.formInitilize();
        this.paginationInfo.sortBy = 'desc';
        this.paginationInfo.sortColumn = 'updateddate';
        this.role = this._authService.getCurrentUser();
        this.agency = this._authService.getAgencyName();
        this.isDjs = this.role.role.teamtypekey === 'DJS';
        this.isCW = this.role.role.teamtypekey === 'CW';
        this.loadWorkers();
        if (this.role.role.name === 'superuser' || this.role.role.name === 'cru' || this.role.role.name === 'ASCW') {
            this.getBroadCostMessage();
        }
        this.roleName = this.role.role.name;
        if (this.roleName === 'SCRNW') {
            this.isPreIntake = true;
        }
        this.showHistory = false;
        this.status = 'pending';
        setTimeout(() => {
            this.getPage(1, 'pending');
          }, 1000);
        
        this.showWorkerList = this.hasModuleAccess('Approval Inbox');
    }

    formInitilize() {
        this.searchIntakeForm = this.formBuilder.group({
            intakenumber: ['']
        });
        this.assignedCaseForm = this.formBuilder.group({
            serreqno: [''],
            securityusersid: [''],
            dateFrom: [''],
            dateTo: ['']
        });
    }

    getPage(selectPageNumber: number, status: string, def?:boolean | null, securityusersid? :string) {
        this.intakes = [];
        this.status = status;
        this.activeTab =status;
    
        
        if(def){
            this.paginationInfo.pageNumber = 1;}
        const pageSource = this.pageStream$.pipe(map(pageNumber => {
            if (this.paginationInfo.pageNumber !== 1) {
                this.previousPage = pageNumber;
            } else {
                this.previousPage = this.paginationInfo.pageNumber;
            }
            return { search: this.dynamicObject, page: this.previousPage };
        }));
        const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map(searchTerm => {
            this.previousPage = 1;
            this.dynamicObject = searchTerm;
            if (searchTerm && searchTerm.intakenumber) {
                this.searchHistory.push({ intakeNumber: searchTerm.intakenumber.like.replace('%25', '').replace('%25', '') });
            }
            this.showHistory = false;
            return { search: searchTerm, page: this.previousPage };
        }),);
        merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                let intakeNumber = '';
                if (this.searchIntakeForm.value.intakenumber) {
                    intakeNumber = this.searchIntakeForm.value.intakenumber;
                }
                this.searchCriteria = {
                    status: this.status,
                    intakenumber: intakeNumber,
                    ispreintake: this.isPreIntake,
                    sortcolumn: this.paginationInfo.sortColumn,
                    sortorder: this.paginationInfo.sortBy,
                    securityusersid: securityusersid ? securityusersid : null
                };
                if(this.status === 'transfer'){
                    return this.statusIfTransferFn();
                }else{
                    return this.statusElseTransferFn();
                }
            }),)
            .subscribe(result => {
                this.returnMergeMapResponseFn(result);
            });
    }

    private returnMergeMapResponseFn(result: any) {
        this.intakes = result.data;
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords = result.count;
        }

        // D-07003 Start
        let i = 0;
        for (const intake of this.intakes) {
            this.intakes[i].updateddateeststr = moment(intake.updateddate).format('MM/DD/YYYY, h:mm A');

            i = i + 1;
        }
        // D-07003 End
        //@Simar - map the purpose for each intake
        // We are computing this Purpose object on the UI itself based on the jsondata object
        this.intakes = this.intakes.map((item) => {
            item.purpose = {};
            if (item.jsondata) {
                const purposeitem = item.jsondata.General.Purpose;
                const purposeid = purposeitem.split('~')[0];
                item.purpose = this._intakeConfig.getSelectedPurpose(purposeid);
            }
            return item;
        });
    }

    private statusElseTransferFn() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._dataStoreService.getData('iscaseexpunged');
     
        const searchCriteria:any = this.searchCriteria;
        searchCriteria.isExpungementSuperUser = isExpungementSuperUser;
        searchCriteria.iscaseexpunged = iscaseexpunged;
        return this._service.getPagedArrayList(
            new PaginationRequest({
                limit: this.paginationInfo.pageSize,
                page: this.previousPage,
                method: 'post',
                where: searchCriteria
            }),
            NewUrlConfig.EndPoint.Intake.saveIntakeUrl
        );
    }

    private statusIfTransferFn() {
        let securityusersid = this.assignedCaseForm.controls['securityusersid'].value;
        securityusersid = securityusersid ? securityusersid : this.role.user.userprofile.securityusersid;
        return this._commonHttpService.getPagedArrayList(
            new PaginationRequest({
                limit: this.paginationInfo.pageSize,
                page: this.previousPage,
                method: 'post',
                where: {
                    securityusersid: securityusersid, screentype: 'pending',
                }
            }), 'intaketransfers/list'
        );
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortDirection;
        this.paginationInfo.sortColumn = $event.sortColumn;
        this.getPage(this.paginationInfo.pageNumber, this.status);
    }

    pageChanged(pageInfo: any) {
        this.paginationInfo.pageNumber = pageInfo.page;
        this.previousPage = this.paginationInfo.pageNumber;
        this.getPage(this.previousPage, this.status);
    }

    hasModuleAccess(key: string): boolean {
        const user = this._authService.getCurrentUser();
        if (key && user && user.resources && user.resources.length > 0) {
            const resources = user.resources.filter(menu => menu.isallowed === true);
            if (hasMatch([key], resources.map(item => (item ? item.name : '')))) {
                return true;
            }
            return false;
        }
        return false;
    }
    
    private loadWorkers() {
        this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTRW' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.workerList = result['data'];
                this.assignedCaseForm.controls['securityusersid'].patchValue(this.role.user.userprofile.securityusersid);
            });
    }

    workerChange() {
        const securityusersid = this.assignedCaseForm.controls['securityusersid'].value;
        this.getPage(1, this.status, null, securityusersid);
    }

    onSearch(field: string, val: Event | null) {
        let value = val ? (val.target as HTMLInputElement).value : '';
        this.showHistory = true;
        if(this.isCW && value) {
            value = value.replace(' ', '');
        }        
        this.searchIntakeForm.patchValue({ intakenumber: value });
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }

    htmlToPlaintext(text: any) {
        return text ? String(text).replace(/<[^>]+>/gm, '') : '';
    }

    getBroadCostMessage() {
        const userid = this._authService.getCurrentUser().userId;
        this._commonHttpService.getSingle({
            method: 'get',
            where: { userid: userid }
            }, 'announcement/getuserannouncement?filter').subscribe(result => {
            if (result !== null) {
                $('#broadcoastmessage').modal('show');// NOSONAR
                this.showBroadCostMessage = result;
            }
        });
    }

    showHideHistory(value: any) {
        this.showHistory = value;
    }

    acceptAnnouncement() {
        this._commonHttpService.endpointUrl = 'announcement/acceptannouncement';
        $('#broadcoastmessage').modal('hide');// NOSONAR
        this._commonHttpService.patch(this.showBroadCostMessage.userannouncementid, { id: this.showBroadCostMessage.userannouncementid }).subscribe();
    }

    openIntake(intakeNumber: any) {
        if (intakeNumber) {
            this._intakeUtils.redirectIntake(intakeNumber, 'edit');
        } else {
            this._commonHttpService.getArrayList({}, NewUrlConfig.EndPoint.Intake.GetNextNumberUrl).subscribe((result: any) => {
                this._intakeUtils.redirectIntake(result['nextNumber'], 'add');
            });
        }
    }

    openNarrativeDialog(listItem: any): void {
        if (listItem && listItem.jsondata && listItem.jsondata.General && listItem.jsondata.General.Narrative) {
            this.narrative = listItem.jsondata.General.Narrative;
        } else {
            this.narrative = 'No narrative info found!';
        }
        this.narrative = this.fixNarrativeHistoryClearanceText(this.narrative);
        $(this.narrative_dialog).modal('show');
    }

    fixNarrativeHistoryClearanceText(narr: string) {
        let n: string = narr;
        if (n) {
            n = n.replace(/(\\n)/g, '<br>');
            n = n.replace(/(\\r)/g, '');
            n = n.replace(/''/g, `'`);
            n = n.replace(/&nbsp;/g, ' ')
        }
        return n;
    }

    closeNarrativeDialog(): void {
        this.narrative = '';
        $(this.narrative_dialog).modal('hide');
    }

    validate(persons: any) {
        if (persons instanceof Array) {
            if (persons && persons.length) {
            return true;
            } else {
            return false;
            }
        } else {
            return false;
        }
    }
    
    
}
