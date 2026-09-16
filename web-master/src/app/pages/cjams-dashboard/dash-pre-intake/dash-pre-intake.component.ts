import {mergeMap, map, startWith, debounceTime} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Subject, Observable, merge } from 'rxjs';

import {
  DynamicObject,
  PaginationInfo,
  PaginationRequest,
  DropdownModel
} from '../../../@core/entities/common.entities';
import { CommonHttpService, GenericService } from '../../../@core/services';
import { AlertService } from '../../../@core/services/alert.service';
import { AuthService } from '../../../@core/services/auth.service';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import {
  AssignedCase,
  BroadCostMessage,
  IntakeSummary,
  PreIntakeAssign,
  RoutingUser,
  Appeal
} from '../_entities/dashBoard-datamodel';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dash-pre-intake',
    templateUrl: './dash-pre-intake.component.html',
    styleUrls: ['./dash-pre-intake.component.scss'],
    imports:[SortTableModule,MatSortModule,MatFormFieldModule,MatInputModule,MatSelectModule,MatDatepickerModule,ReactiveFormsModule,PaginationModule,FormsModule,CommonModule],
    standalone: true
})
export class DashPreIntakeComponent implements OnInit {
  intakeSummaryForm!: FormGroup;
  assignedCaseForm!: FormGroup;
  appealForm!: FormGroup;
  preIntakeForm!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  tobeassignedPaginationInfo: PaginationInfo = new PaginationInfo();
  preIntakePaginationInfo: PaginationInfo = new PaginationInfo();
  intakesSummary: IntakeSummary[] = [];
  assingedCaseSummary: AssignedCase[] = [];
  getUsersList: RoutingUser[] = [];
  mergeUsersList: RoutingUser[] = [];
  getIntakeUsers: RoutingUser[] = [];
  originalUserList: RoutingUser[] = [];
  totalRecords!: number;
  totalRecordsAssingedCase!: number;
  totalRecordsPreIntake!: number;
  dynamicObjectIntakeSummary: DynamicObject = {};
  dynamicObjectAssignCase: DynamicObject = {};
  dynamicObjectPreIntake: DynamicObject = {};
  currentStatus!: string;
  previousPage!: number;
  searchCriteria: any;
  assignedStatus: boolean = false;
  preIntakeStatus!: string;
  selectedPerson: any;
  selectIntake: any;
  isSupervisor!: boolean;
  ispreIntake!: boolean;
  getServicereqid!: string;
  getPreIntake!: PreIntakeAssign;
  showBroadCostMessage!: BroadCostMessage;
  preIntakeSummary: AssignedCase[] = [];
  statusDropdownItems$!: Observable<DropdownModel[]>;
  isGroup = false;
  zipCode!: string;
  zipCodeIndex!: number;
  isDjs = false;
  private searchTermStreamIntake$ = new Subject<DynamicObject>();
  private searchTermStreamAssignCase$ = new Subject<DynamicObject>();
  private searchTermStreamPreIntake$ = new Subject<DynamicObject>();
  private pageStreamIntake$ = new Subject<number>();
  private pageStreamAssgine$ = new Subject<number>();
  private pageStreamPreIntake$ = new Subject<number>();
  // appealSaveButton: boolean;
  // appealSaveButton: boolean;
  private appealIntakeReqId!: string;

  constructor(
    private _authService: AuthService,
    private _alertService: AlertService,
    private _commonService: CommonHttpService,
    private _appealService: GenericService<Appeal>,
    private formBuilder: FormBuilder,
    private _intakeUtils: IntakeUtils
  ) {
    this._appealService.endpointUrl = 'intakeservicerequestappeal/add';
  }

  ngOnInit() {
    this.isDjs = this._authService.isDJS();
    this.paginationInfo.sortColumn = 'datesubmitted';
    this.paginationInfo.sortBy = 'desc';
    this.formIntakeSummaryInitilize();
    this.appealFormInitialize();
    this.formAssignInitilize();
    this.formPreIntakeInitilize();
    this.getPreIntakeSummary(1, 'PREINRU', false);
    const role = this._authService.getCurrentUser();
    if (role.role.name === 'apcs' || role.role.name === 'provider') {
      this.getBroadCostMessage();
    }
    this.appealForm .get('dispositioncode')?.valueChanges.subscribe(result => {
        if (result === 'ScreenOUT') {
          this.appealForm.patchValue({ dispositioncode: '' });
          this._alertService.error('Screen out can not be selected');
        }
      });
  }
  appealFormInitialize() {
    this.appealForm = this.formBuilder.group({
      appealdate: ['', [Validators.required]],
      dispositioncode: ['', [Validators.required]],
      remarks: ['', [Validators.required]]
    });
  }
  formIntakeSummaryInitilize() {
    this.intakeSummaryForm = this.formBuilder.group({
      intakenumber: ['']
    });
  }
  formAssignInitilize() {
    this.assignedCaseForm = this.formBuilder.group({
      serreqno: ['']
    });
  }
  formPreIntakeInitilize() {
    this.preIntakeForm = this.formBuilder.group({
      intakenumber: ['']
    });
  }
  getIntakeSummary(selectPage: number, status: string) {
    this.currentStatus = status;
    const pageSource = this.pageStreamIntake$.pipe(map(pageNumber => {
      this.paginationInfo.pageNumber = pageNumber;
      return {
        search: this.dynamicObjectIntakeSummary,
        page: pageNumber
      };
    }));

    const searchSource = this.searchTermStreamIntake$.pipe(
      debounceTime(1000),
      map(searchTerm => {
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
          this.searchCriteria = {
            intakenumber: '',
            status: this.currentStatus,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy
          };
        } else {
          this.searchCriteria = {
            intakenumber: this.intakeSummaryForm.value.intakenumber,
            status: this.currentStatus,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy
          };
        }
        return this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: this.paginationInfo.pageSize,
            page: selectPage,
            method: 'post',
            where: this.searchCriteria
          }),
          'Intakedastagings/listdadetails'
        );
      }),)
      .subscribe(result => {
        this.intakesSummary = result.data;
        if (this.paginationInfo.pageNumber === 1) {
          this.totalRecords = result.count;
        }
      });
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.getIntakeSummary(
      this.paginationInfo.pageNumber,
      this.currentStatus
    );
  }

  onSorted($event: ColumnSortedEvent) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getIntakeSummary(
      this.paginationInfo.pageNumber,
      this.currentStatus
    );
  }
  onSearch(field: string, value: string) {
    this.dynamicObjectIntakeSummary[field] = {
      like: '%25' + value + '%25'
    };
    if (!value) {
      delete this.dynamicObjectIntakeSummary[field];
    }
    this.searchTermStreamIntake$.next(this.dynamicObjectIntakeSummary);
  }

  onSortedCaseCloded($event: ColumnSortedEvent) {
    this.tobeassignedPaginationInfo.sortBy =
      $event.sortColumn + ' ' + $event.sortDirection;
    this.pageStreamAssgine$.next(
      this.tobeassignedPaginationInfo.pageNumber
    );
  }

  getAssignCase(selectPage: number, assigned: boolean) {
    this.assignedStatus = assigned;
    const pageSource = this.pageStreamAssgine$.pipe(map(pageNumber => {
      this.tobeassignedPaginationInfo.pageNumber = pageNumber;
      return { search: this.dynamicObjectAssignCase, page: pageNumber };
    }));

    const searchSource = this.searchTermStreamAssignCase$.pipe(
      debounceTime(1000),
      map(searchTerm => {
        this.dynamicObjectAssignCase = searchTerm;
        return { search: searchTerm, page: 1 };
      }),);
     merge(searchSource,pageSource).pipe(
      startWith({
        search: this.dynamicObjectAssignCase,
        page: this.paginationInfo.pageNumber
      }),
      mergeMap((params: { search: DynamicObject; page: number }) => {
        if (this.assignedCaseForm.value.serreqno === '') {
          this.searchCriteria = {
            serreqno: '',
            assigned: this.assignedStatus
          };
        } else {
          this.searchCriteria = {
            serreqno: this.assignedCaseForm.value.serreqno,
            assigned: this.assignedStatus
          };
        }
        return this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: this.paginationInfo.pageSize,
            page: selectPage,
            method: 'post',
            where: this.searchCriteria
          }),
          'Intakedastagings/getroutedda'
        );
      }),)
      .subscribe(result => {
        result.data.forEach(item => {
          item.isCollapsed = true;
        });
        this.assingedCaseSummary = result.data;
        if (this.paginationInfo.pageNumber === 1) {
          this.totalRecordsAssingedCase = result.count;
        }
      });
  }

  getAppeal(selectPage: number) {
    const pageSource = this.pageStreamAssgine$.pipe(map(pageNumber => {
      this.tobeassignedPaginationInfo.pageNumber = pageNumber;
      return { search: this.dynamicObjectAssignCase, page: pageNumber };
    }));

    const searchSource = this.searchTermStreamAssignCase$.pipe(
      debounceTime(1000),
      map(searchTerm => {
        this.dynamicObjectAssignCase = searchTerm;
        return { search: searchTerm, page: 1 };
      }),);

    merge(searchSource,pageSource).pipe(
      startWith({
        search: this.dynamicObjectAssignCase,
        page: this.paginationInfo.pageNumber
      }),
      mergeMap((params: { search: DynamicObject; page: number }) => {
        if (this.assignedCaseForm.value.serreqno === '') {
          this.searchCriteria = {
            serreqno: ''
          };
        } else {
          this.searchCriteria = {
            serreqno: this.assignedCaseForm.value.serreqno
          };
        }
        return this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: this.paginationInfo.pageSize,
            page: selectPage,
            method: 'post',
            where: this.searchCriteria
          }),
          'Intakedastagings/getappealda'
        );
      }),)
      .subscribe(result => {
        this.assingedCaseSummary = result.data;
        if (this.paginationInfo.pageNumber === 1) {
          this.totalRecordsAssingedCase = result.count;
        }
      });
  }

  appealPageChanged(pageInfo: any) {
    this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
    this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
    if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
      this.previousPage = pageInfo.page;
    }
    this.getAppeal(this.tobeassignedPaginationInfo.pageNumber);
  }

  pageAssignedChanged(pageInfo: any) {
    this.tobeassignedPaginationInfo.pageNumber = pageInfo.page;
    this.tobeassignedPaginationInfo.pageSize = pageInfo.itemsPerPage;
    if (this.tobeassignedPaginationInfo.pageNumber !== 1) {
      this.previousPage = pageInfo.page;
    }
    this.getAssignCase(
      this.tobeassignedPaginationInfo.pageNumber,
      this.assignedStatus
    );
  }
  onSearchAssignCase(field: string, value: string) {
    this.dynamicObjectAssignCase[field] = { like: '%25' + value + '%25' };
    if (!value) {
      delete this.dynamicObjectAssignCase[field];
    }
    this.searchTermStreamAssignCase$.next(this.dynamicObjectAssignCase);
  }
  getRoutingUser(modal: AssignedCase) {
    this.getServicereqid = modal.servicereqid;
    this.zipCode = modal.incidentlocation;
    this.getUsersList = [];
    this.originalUserList = [];
    this.isGroup = modal.isgroup;
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'INVR' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe(result => {
        this.getUsersList = result.data;
        this.originalUserList = this.getUsersList;
        this.listUser('TOBEASSIGNED');
      });
  }
  listUser(assigned: string) {
    this.selectedPerson = '';
    this.getUsersList = [];
    this.mergeUsersList = [];
    this.getUsersList = this.originalUserList;
    if (assigned === 'TOBEASSIGNED') {
      this.getUsersList = this.getUsersList.filter(res => {
        if (res.issupervisor === false) {
          this.isSupervisor = false;
          return res;
        }
      });
      this.reusableListUserFn();

    } else {
      this.getUsersList = this.getUsersList.filter(res => {
        if (res.issupervisor === true) {
          this.isSupervisor = true;
          return res;
        }
      });
      this.reusableListUserFn()
    }
  }
  // Associated with listUser function
  private reusableListUserFn() {
    this.getUsersList.forEach(data => {
      if (data.homelocationcode === this.zipCode || data.worklocationcode === this.zipCode) {
        this.mergeUsersList.push(data);
        this.zipCodeIndex = this.getUsersList.indexOf(data);
        this.getUsersList.splice(this.zipCodeIndex, 1);
      }
    });
    if (this.mergeUsersList !== undefined) {
      this.getUsersList = this.mergeUsersList.concat(this.getUsersList);
    }
  }

  selectPerson(row: any) {
    this.selectedPerson = row;
  }
  assignUser() {
    if (this.selectedPerson) {
      this._commonService
        .getPagedArrayList(
          new PaginationRequest({
            where: {
              appeventcode: 'INVT',
              serreqid: this.getServicereqid,
              assigneduserid: this.selectedPerson.userid,
              isgroup: this.isGroup
            },
            method: 'post'
          }),
          'Intakedastagings/routeda'
        )
        .subscribe(() => {
          this._alertService.success('Case assigned successfully!');
          this.getAssignCase(1, false);
          this.closePopup();
        });
    } else {
      this._alertService.warn('Please select a person');
    }
  }

  getPreIntakeSummary(
    selectPage: number,
    status: string,
    ispreintake: boolean
  ) {
    this.preIntakeStatus = status;
    this.ispreIntake = ispreintake;
    const pageSource = this.pageStreamPreIntake$.pipe(map(pageNumber => {
      this.paginationInfo.pageNumber = pageNumber;
      return { search: this.dynamicObjectPreIntake, page: pageNumber };
    }));

    const searchSource = this.searchTermStreamPreIntake$.pipe(
      debounceTime(1000),
      map(searchTerm => {
        this.dynamicObjectPreIntake = searchTerm;
        return { search: searchTerm, page: 1 };
      }),);
    merge(searchSource,pageSource).pipe(
      startWith({
        search: this.dynamicObjectPreIntake,
        page: this.paginationInfo.pageNumber
      }),
      mergeMap((params: { search: DynamicObject; page: number }) => {
        if (this.preIntakeForm.value.intakenumber === '') {
          this.searchCriteria = {
            ispreintake: true,
            intakenumber: '',
            status: status,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy
          };
        } else {
          this.searchCriteria = {
            ispreintake: true,
            intakenumber: this.preIntakeForm.value.intakenumber,
            status: status,
            sortcolumn: this.paginationInfo.sortColumn,
            sortorder: this.paginationInfo.sortBy
          };
        }
        return this._commonService.getPagedArrayList(
          new PaginationRequest({
            limit: this.paginationInfo.pageSize,
            page: selectPage,
            method: 'post',
            where: this.searchCriteria
          }),
          'Intakedastagings/listdadetails'
        );
      }),)
      .subscribe(result => {
        this.preIntakeSummary = result.data;
        if (this.paginationInfo.pageNumber === 1) {
          this.totalRecordsPreIntake = result.count;
        }
      });
  }

  pageChangedPreIntake(pageInfo: any) {
    this.preIntakePaginationInfo.pageNumber = pageInfo.page;
    this.preIntakePaginationInfo.pageSize = pageInfo.itemsPerPage;
    this.getPreIntakeSummary(
      this.preIntakePaginationInfo.pageNumber,
      this.preIntakeStatus,
      this.ispreIntake
    );
  }

  onSortedPreIntake($event: any) {
    this.paginationInfo.sortBy = $event.sortDirection;
    this.paginationInfo.sortColumn = $event.sortColumn;
    this.getPreIntakeSummary(
      this.preIntakePaginationInfo.pageNumber,
      this.preIntakeStatus,
      this.ispreIntake
    );
  }
  onSearchPreIntake(field: string, val: Event) {
    const value = (val.target as HTMLInputElement).value;
    this.dynamicObjectPreIntake[field] = { like: '%25' + value + '%25' };
    if (!value) {
      delete this.dynamicObjectPreIntake[field];
    }
    this.searchTermStreamPreIntake$.next(this.dynamicObjectPreIntake);
  }
  getAssignIntakeUser(modal: PreIntakeAssign) {
    this.getPreIntake = modal;
    this.selectIntake = null;
    this._commonService
      .getPagedArrayList(
        new PaginationRequest({
          where: { appevent: 'SITR' },
          method: 'post'
        }),
        'Intakedastagings/getroutingusers'
      )
      .subscribe(result => {
        this.getIntakeUsers = result.data;
        this.getIntakeUsers = this.getIntakeUsers.filter(res => {   // NOSONAR
          if (res.issupervisor === false) {
            this.isSupervisor = false;
            return res;
          }
        });
      });
  }
  selectIntaker(row: any) {
    this.selectIntake = row;
  }
  assignIntaker(modal: any) {
    if (this.selectIntake) {
      this._commonService
        .getPagedArrayList(
          new PaginationRequest({
            where: {
              appeventcode: modal,
              intakenumber: this.getPreIntake.intakenumber,
              assigneduserid: this.selectIntake.userid
            },
            method: 'post'
          }),
          'Intakedastagings/assignIntake'
        )
        .subscribe(() => {
          this._alertService.success('Intake assigned successfully!');
          if (modal === 'SITR') {
            this.getPreIntakeSummary(1, 'PREINRU', false);
          } else if (modal === 'INTR') {
            this.getIntakeSummary(1, 'approved');
            $('#case-complete-tab').click();
          }
          this.closePopup();
        });
    } else {
      this._alertService.warn('Please select a person');
    }
  }

  closePopup() {
    (<any>$('#intake-caseassign')).modal('hide');
    (<any>$('#assign-preintake')).modal('hide');
    (<any>$('#reopen-intake')).modal('hide');
  }
  routToIntake(intakeId: any) {
    this._intakeUtils.redirectIntake(intakeId);
  }
  getBroadCostMessage() {
    const userid = this._authService.getCurrentUser().userId;
    this._commonService
      .getSingle({
        method: 'get',
        where: { userid: userid }
      }, 'announcement/getuserannouncement?filter')
      .subscribe(result => {
        if (result !== null) {
          (<any>$('#broadcoastmessage')).modal('show');
          this.showBroadCostMessage = result;
        }
      });
  }
  acceptAnnouncement() {
    this._commonService.endpointUrl = 'announcement/acceptannouncement';
    (<any>$('#broadcoastmessage')).modal('hide');
    this._commonService
      .patch(this.showBroadCostMessage.userannouncementid, {
        id: this.showBroadCostMessage.userannouncementid
      })
      .subscribe();
  }
  openAppeal(modal: any) {
    this.appealIntakeReqId = modal.servicereqid;
    this.statusDropdownItems$ = this._commonService
      .getArrayList(
        new PaginationRequest({
          nolimit: true,
          where: {
            intakeserviceid: '7da1e14f-6714-4cc4-b2ef-ae8d9af53959',
            statuskey: 'Approved'
          },
          method: 'get'
        }),
        'daconfig/servicerequesttypeconfigdispositioncode/getdispositionlist?filter'
      ).pipe(
      map(result => {
        return result.map(
          res =>
            new DropdownModel({
              text: res.description,
              value: res.dispositioncode
            })
        );
      }));
  }
  saveAppeal() {
    const appeal = this.appealForm.value;
    appeal.intakeserviceid = this.appealIntakeReqId;
    appeal.status = 'Approved';
    this._appealService.create(appeal).subscribe(
      () => {
        this._alertService.success(
          'Your intake has been appealed successfully.'
        );
        $('#case-appeal').click();
        this.appealForm.reset();
        this.getAppeal(1);
        (<any>$('#appeal-modal')).modal('hide');
      },
      (_err: any) => {
        this._alertService.success(
          'Unable to appeal your intake. Please try again!'
        );
      }
    );
  }

  groupShow(row: any, id: any) {
    this.assingedCaseSummary[row].isCollapsed = !this.assingedCaseSummary[
      row
    ].isCollapsed;
  }
}
