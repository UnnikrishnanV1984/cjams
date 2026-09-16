
import {share, pluck, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { GenericService } from '../../../@core/services';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { AdminUrlConfig } from '../admin-url.config';
import { BatchAnnualApplication } from './entities/batch-annual-application.model';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'batch-annual-application',
    templateUrl: './batch-annual-application.component.html',
    standalone: false
})
export class BatchAnnualApplicationComponent implements OnInit {
  batchFormGroup!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();
  totalRecords$!: Observable<number>;
  batchAnnualApplication: BatchAnnualApplication[] = [];
  batchAnnualApplication$!: Observable<BatchAnnualApplication[]>;
  previousActivities$!: Observable<any>;

  constructor(private _httpService: CommonHttpService,
    private formBuilder: FormBuilder, private _service: GenericService<BatchAnnualApplication>) {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.General.ProgressNoteUrl;
  }

  ngOnInit() {
    this.batchFormGroup = this.formBuilder.group({
        leftSelectedItems: [''],
        rightSelectedItems: ['']
    });
    this.pageSubject$.subscribe(pageNumber => {
      this.paginationInfo.pageNumber = pageNumber;
      this.getPage(this.paginationInfo.pageNumber);
    });
    this.getPage(1);
  }
  getPage(page: number) {
    this.paginationInfo.pageNumber = page;
    const source = this._service.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        where: { 'provideragreementtypekey': 'string' },
        count: this.paginationInfo.total,
        method: 'get'
      }), AdminUrlConfig.EndPoint.General.ProgressNoteUrl + '/list?filter'
    ).pipe(map(result => {
      return { data: result.data, count: result.count };
    }),share(),);
    this.batchAnnualApplication$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
    }
  }
  activityListDate(model: any) {
    const source = this._service.getById(model.progressnoteid, AdminUrlConfig.EndPoint.General.ProgressNoteDetailUrl).pipe(map(result => {
      return { activity: result };
    }),share(),);
    this.previousActivities$ = source.pipe(pluck('activity'));
  }
  createAnnualApplication() {
      this._httpService.getArrayList({}, AdminUrlConfig.EndPoint.General.ProviderAgreementTypeUrl)
      .subscribe(result => {
        this.batchAnnualApplication = result;
      });
  }
  saveItem() {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.General.ProviderAgreementUrl;
  }
  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.paginationInfo.pageSize = event.itemsPerPage;
    this.pageSubject$.next(this.paginationInfo.pageNumber);
  }

  selectAll() {
      this.batchAnnualApplication = this.batchAnnualApplication.map(item => {
          item.isSelected = true;
          return item;
      });
  }

  select() {
      if (this.batchFormGroup.value.leftSelectedItems) {
          this.batchAnnualApplication = this.batchAnnualApplication.map(item => {
              this.batchFormGroup.value.leftSelectedItems.map((id: string) => {
                  if (item.provideragreementtypekey === id) {
                      item.isSelected = true;
                  }
              });
              return item;
          });
      }
  }
  unSelect() {
      if (this.batchFormGroup.value.rightSelectedItems) {
          this.batchAnnualApplication = this.batchAnnualApplication.map(item => {
              this.batchFormGroup.value.rightSelectedItems.map((id: string) => {
                  if (item.provideragreementtypekey === id) {
                      item.isSelected = false;
                  }
              });
              return item;
          });
      }
  }
  unSelectAll() {
      this.batchAnnualApplication = this.batchAnnualApplication.map(item => {
          item.isSelected = false;
          return item;
      });
  }
}
