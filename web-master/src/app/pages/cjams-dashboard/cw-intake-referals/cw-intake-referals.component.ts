
import {mergeMap, startWith, map, debounceTime} from 'rxjs/operators';
import { ChangeDetectorRef, Component, Injector, OnInit } from '@angular/core';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { Subject, Observable, merge } from 'rxjs';
import { PaginationInfo, DynamicObject, PaginationRequest } from '../../../@core/entities/common.entities';
import { FormGroup, FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { IntakeSummary, Prior } from '../_entities/dashBoard-datamodel';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { CaseWorkerUrlConfig } from '../../case-worker/case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../case-worker/_entities/caseworker.data.constants';
import { SessionStorageService, AuthService } from '../../../@core/services';
import { IntakeConfigService } from '../../newintake/my-newintake/intake-config.service';
import { ActivatedRoute } from '@angular/router';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { CommonModule } from '@angular/common';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { SharedPipesModule } from '../../../@core/pipes/shared-pipes.module';
import { MatSelectModule } from '@angular/material/select';
import { MatSortModule } from '@angular/material/sort';
import { PurposeResolverService } from '../../newintake/my-newintake/purpose-resolver.service';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cw-intake-referals',
    templateUrl: './cw-intake-referals.component.html',
    styleUrls: ['./cw-intake-referals.component.scss'],
    imports:[SortTableModule,MatSortModule,CommonModule,PaginationModule,FormsModule,SharedPipesModule,ReactiveFormsModule,MatSelectModule],
    standalone: true
})
export class CwIntakeReferalsComponent implements OnInit {
  paginationInfo: PaginationInfo = new PaginationInfo();
  intakeSummaryForm!: FormGroup;
  dynamicObjectIntakeSummary: DynamicObject = {};
  currentStatus!: string;
  intakesSummary: IntakeSummary[] = [];
  totalRecords!: number;
  intakeSearchCriteria: any;
  private searchTermStreamIntake$ = new Subject<DynamicObject>();
  private pageStreamIntake$ = new Subject<number>();
  priorItem$!: Observable<Prior[]>;
  supervisorList: any = [];
  currentUser!: AppUser;
  transfer!: string;
  isVisible: boolean = false;
  ipaduser: boolean = false;
  private cdr: ChangeDetectorRef;
private _intakeUtils: IntakeUtils;
private _session: SessionStorageService;
private _intakeConfig: IntakeConfigService;
private route: ActivatedRoute;
private _authService: AuthService;

  constructor(private _commonService: CommonHttpService,
    private formBuilder: FormBuilder,
    private injector: Injector,
    private purposeService: PurposeResolverService
    ) {
        this.cdr = this.injector.get<ChangeDetectorRef>(ChangeDetectorRef);
        this._intakeUtils = this.injector.get<IntakeUtils>(IntakeUtils);
        this._session = this.injector.get<SessionStorageService>(SessionStorageService);
        this._intakeConfig = this.injector.get<IntakeConfigService>(IntakeConfigService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._intakeConfig.setPurposeList(this.route.snapshot.data.purposeList);
    }

  ngOnInit() {
    this.currentUser = this._authService.getCurrentUser();
    this.paginationInfo.sortColumn = 'receiveddate';
    this.paginationInfo.sortBy = 'desc';
    this.loadSupervisor();
    this.formIntakeSummaryInitilize();
    setTimeout(() => {
        this.getIntakeSummary(1, 'pendingreview');
      }, 500);
    this._session.removeItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    this._session.removeItem(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.isVisible = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
    if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
        this.ipaduser = true;
    }

  }
  getPrior(intakenumber: any) {
    this.priorItem$ = this._commonService
    .getArrayList(
        {
            where: {'intakenumber' : intakenumber},
            method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.Dashboard.GetPrior + '?filter'
    );
}
supervisorChange() {
    this.getIntakeSummary(1, this.currentStatus);
}
  getIntakeSummary(selectPage: number, status: string, stage?: string) {
      this.intakesSummary = [];
      if (stage === 'Initial') {
        this.intakeSummaryForm.controls['intakenumber'].patchValue('');
        this.intakeSummaryForm.controls['securityusersid'].patchValue(this.currentUser.user.userprofile.securityusersid);
      }
    this.currentStatus = status;
    this.transfer = (this.currentStatus === 'pending' || this.currentStatus === 'assign')? 'transfer':'';
    const pageSource = this.pageStreamIntake$.pipe(map((pageNumber) => {
        this.paginationInfo.pageNumber = pageNumber;
        return {
            search: this.dynamicObjectIntakeSummary,
            page: pageNumber
        };
    }));

    const searchSource = this.searchTermStreamIntake$.pipe(debounceTime(1000),map((searchTerm) => {
        this.dynamicObjectIntakeSummary = searchTerm;
        return { search: searchTerm, page: 1 };
    }),);
    merge(searchSource,pageSource).pipe(
        startWith({
            search: this.dynamicObjectIntakeSummary,
            page: this.paginationInfo.pageNumber
        }),
        mergeMap((params: { search: DynamicObject; page: number }) => {
            if (this.intakeSummaryForm.value.intakenumber === '') {
                this.intakeSearchCriteria = {
                    intakenumber: '',
                    status: this.currentStatus,
                    sortcolumn: this.paginationInfo.sortColumn,
                    sortorder: this.paginationInfo.sortBy,
                    securityusersid: this.retrunSecurityusersidFn()
                };
            } else {
                this.intakeSearchCriteria = {
                    intakenumber: this.intakeSummaryForm.value.intakenumber,
                    status: this.currentStatus,
                    sortcolumn: this.paginationInfo.sortColumn,
                    sortorder: this.paginationInfo.sortBy,
                    securityusersid: this.retrunSecurityusersidFn()
                };
            }
            if(this.currentStatus === 'pending' || this.currentStatus === 'assign'){
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: {
                            securityusersid: this.returnPaginationSecurityusersidFn(), 
                            screentype: this.currentStatus,
                        }
                    }),'intaketransfers/list'
                );
            }else{
                return this._commonService.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: selectPage,
                        method: 'post',
                        where: this.intakeSearchCriteria
                    }),
                    'Intakedastagings/listdadetails'
                );
            }
        }),)
        .subscribe((result) => {
            this.intakesSummary = result.data;
            if (status === 'pendingreview' && this.intakesSummary && this.intakesSummary.length && this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR)){
                this.intakesSummary = this.intakesSummary.filter(item => item.reviewstatus !== 'Reopen');
            }
            
            this.intakesSummary = this.returnIntakesSummaryFn();

            if (this.paginationInfo.pageNumber === 1) {
                this.totalRecords = result.count;
            }

            this.cdr.markForCheck();
        });


    }
    private returnPaginationSecurityusersidFn() {
        return (this.intakeSearchCriteria.securityusersid) ? this.intakeSearchCriteria.securityusersid : this.currentUser.user.userprofile.securityusersid;
    }

    // Associated with getIntakeSummary method
    private retrunSecurityusersidFn() {
        return (this.intakeSummaryForm.value.securityusersid === '') ? this.currentUser.user.userprofile.securityusersid : this.intakeSummaryForm.value.securityusersid;
    }
    // Associated with getIntakeSummary method)
    private returnIntakesSummaryFn(): IntakeSummary[] {
        return this.intakesSummary.map((item) => {

            const timeleft = item.timeleft;
            if (timeleft) {
                item.timeelapsed = false;
                this.formatTimeleftFn(timeleft, item);
            }

            //@Simar - map the purpose for each intake
            // We are computing this Purpose object on the UI itself based on the jsondata object
            item.purpose = {};

            if (item.jsondata) {
                const purposeitem = item.jsondata.General.Purpose;
                const purposeid = purposeitem.split('~')[0];
                item.purpose = this._intakeConfig.getSelectedPurpose(purposeid);
            }

            return item;
        });
    }
    // Associated with getIntakeSummary method)
    private formatTimeleftFn(timeleft: string, item: IntakeSummary) {
        let _timeleft = timeleft.split(':');
        if (_timeleft.length > 1) {
            if (Number(_timeleft[0]) < 0) {
                item.timeelapsed = true;
                item.timeleft = Math.abs(Number(_timeleft[0])) + ' Hours ' + _timeleft[1] + ' Mins' + ' overdue';
            }
            else {
                item.timeleft = Math.abs(Number(_timeleft[0])) + ' Hours ' + _timeleft[1] + ' Mins';
            }
        } else {
            _timeleft = timeleft.split(' ');
            if (_timeleft.length > 1) {
                if (Number(_timeleft[0]) < 0) {
                    item.timeelapsed = true;
                }
                if (_timeleft[1].startsWith('d')) {
                    item.timeleft = Math.abs(Number(_timeleft[0])) + ' Days';
                } else if (_timeleft[1].startsWith('m')) {
                    item.timeleft = Math.abs(Number(_timeleft[0])) + ' Months';
                }
            }
        }
    }

    private loadSupervisor() {
        this._commonService
            .getPagedArrayList(
                new PaginationRequest({
                    where: { appevent: 'INTRS' },
                    method: 'post'
                }),
                'Intakedastagings/getroutingusers'
            )
            .subscribe(result => {
                this.supervisorList = result['data'];
                if(this.supervisorList && this.supervisorList?.length && this.supervisorList?.length>0){
                    this.supervisorList = this.supervisorList.filter((item: any) => (item?.username !=null && item?.username !== ""));
                }
                this.intakeSummaryForm.controls['securityusersid'].patchValue(this.currentUser.user.userprofile.securityusersid);
            });
    }
    pageChanged(pageInfo: any) {
      this.paginationInfo.pageNumber = pageInfo.page;
      this.paginationInfo.pageSize = pageInfo.itemsPerPage;
      this.getIntakeSummary(this.paginationInfo.pageNumber, this.currentStatus);
    }
    onSorted($event: any) {
      this.paginationInfo.sortBy = $event.sortDirection;
      this.paginationInfo.sortColumn = $event.sortColumn;
      this.getIntakeSummary(this.paginationInfo.pageNumber, this.currentStatus);
    }
    onSearch(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.dynamicObjectIntakeSummary[field] = {
            like: '%25' + value + '%25'
        };
        if (!value) {
            delete this.dynamicObjectIntakeSummary[field];
        }
        this.searchTermStreamIntake$.next(this.dynamicObjectIntakeSummary);
    }
    routToIntake(intakeId: any) {
      this._session.setItem('ISINTAKE', true);
      this._intakeUtils.redirectIntake(intakeId);
    }
    formIntakeSummaryInitilize() {
      this.intakeSummaryForm = this.formBuilder.group({
          intakenumber: [''],
          securityusersid: ['']
      });
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
      routToCase(casenumber: any, intakeserviceid: any) {
          // no data or function to call
      }
}

