
import {mergeMap, startWith, map, debounceTime} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PaginationInfo, DynamicObject, PaginationRequest } from '../../../@core/entities/common.entities';
import { IntakeSummary } from '../_entities/dashBoard-datamodel';
import { Subject, merge } from 'rxjs';
import { AuthService, CommonHttpService } from '../../../@core/services';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { NewUrlConfig } from '../../newintake/newintake-url.config';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { CommonModule } from '@angular/common';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSortModule } from '@angular/material/sort';
import { SortTableModule } from '../../../shared/modules/sortable-table/sortable-table.module';

@Component({
    selector: 'dash-my-intake-summary',
    templateUrl: './dash-my-intake-summary.component.html',
    styleUrls: ['./dash-my-intake-summary.component.scss'],
    imports:[SortTableModule,MatSortModule,PaginationModule,FormsModule,CommonModule,ReactiveFormsModule,MatFormFieldModule,MatInputModule],
    standalone: true
})
export class DashMyIntakeSummaryComponent implements OnInit {
  intakeSummaryForm!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  intakesSummary: IntakeSummary[] = [];
  totalRecords!: number;
  dynamicObjectIntakeSummary: DynamicObject = {};
  currentStatus!: string;
  previousPage!: number;
  searchCriteria: any;
  selectedPerson: any;
  selectIntake: any;
  isSupervisor: boolean = false;
  ispreIntake: boolean = false;
  getServicereqid!: string;
  private searchTermStreamIntake$ = new Subject<DynamicObject>();
  private pageStreamIntake$ = new Subject<number>();
  isDjs = false;

  constructor(
      private _authService: AuthService,
      private _commonService: CommonHttpService,
      private formBuilder: FormBuilder,
       private _intakeUtils: IntakeUtils
  ) {
  }

  ngOnInit() {
      this.paginationInfo.sortColumn = 'datesubmitted';
      this.paginationInfo.sortBy = 'desc';
      this.formIntakeSummaryInitilize();
      this.getIntakeSummary(1, 'pending');
      this.isDjs = this._authService.isDJS();
  }
  formIntakeSummaryInitilize() {
      this.intakeSummaryForm = this.formBuilder.group({
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

  onSorted($event: any) {
      this.paginationInfo.sortBy = $event.sortDirection;
      this.paginationInfo.sortColumn = $event.sortColumn;
      this.getIntakeSummary(
          this.paginationInfo.pageNumber,
          this.currentStatus
      );
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
    this._intakeUtils.redirectIntake(intakeId);
  }

openIntake(intakeNumber: any) {
  if (intakeNumber) {
      this._intakeUtils.redirectIntake(intakeNumber, 'edit');
  } else {
      this._commonService.getArrayList({}, NewUrlConfig.EndPoint.Intake.GetNextNumberUrl).subscribe((result: any) => {
          this._intakeUtils.redirectIntake(result['nextNumber'], 'add');
      });
  }
}
}
