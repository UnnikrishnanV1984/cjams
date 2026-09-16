
import {pluck, share, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo, PaginationRequest, TreeViewModel } from '../../../@core/entities/common.entities';
import { GenericService, DataStoreService } from '../../../@core/services';
import { TeamPosition } from '../../admin/team-position/_entities/teamposition.data.model';
import { AdminUrlConfig } from '../admin-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'team-setup-tree',
    templateUrl: './team-setup-tree.component.html',
    styleUrls: ['./team-setup-tree.component.scss'],
    standalone: false
})
export class TeamSetupTreeComponent implements OnInit {

  @Input() teamDetailIdSubject$ = new Subject<Observable<any>>();
  @Input() reloadTreeSubject = new Subject();
  @Input() selectedTreeSubject = new Subject();
  @Input() selectedTeamId = new Subject<string>();
  @Input() totalCount$ = new Subject<any>();
  @Input() pageChangedRequest$ = new Subject<any>();
  @Input() emailSearch$ = new Subject<string>();
  teamTreeview$: Observable<TreeViewModel[]> = new Observable<TreeViewModel[]>();
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageSubject$ = new Subject<number>();
  teamDetails: any;
  teamId:any = '';


  constructor(private _service: GenericService<TeamPosition>, private _dataStore: DataStoreService) {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamTreeListUrl;
  }

  ngOnInit() {
    this.reloadTreeSubject.subscribe(value => this.getPage());
    this.pageChangedRequest$.subscribe((item) => {
      this.onSelected(null, this.teamId, item.page, item.itemsPerPage);
    });
    this.emailSearch$.subscribe((item) => {
      this.onSelected(item, this.teamId, 1, 10);
    });
    this.getPage();
    this.selectedTreeSubject.subscribe(value => this.onReload(this.teamId));
  }


  getPage() {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamTreeListUrl;
    this.teamTreeview$ = this._service.getArrayList({}).pipe(map(response => {
      return response;
    }));
  }

  onSelected(email?: any, event?: any, pageNo?: number, pageSize?: number, treeSelected?: boolean, isonselected?: boolean) {
    this._dataStore.setData('Email_Search_Reset', isonselected);
    this.teamId = event;
      this._service.endpointUrl = 'manage/team/details';
      const source = this._service.getArrayList({
        page: pageNo,
        limit: pageSize,
        email: email,
        method: 'get'
      }, AdminUrlConfig.EndPoint.TeamPosition.TeamDetailsUrl + '/' + this.teamId + '?filter').pipe(share());
       this.teamDetailIdSubject$.next(source.pipe(pluck('data')));
       this._dataStore.setData('Pagination_Reset', true);
       this._dataStore.setData('Email_Search_Reset', false);
      source.pipe(pluck('count')).subscribe((item) => {
        if (item ||  (item === 0 && treeSelected)) {
          this.totalCount$.next(item);
        }
      });
       this.selectedTeamId.next(this.teamId);
       this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamTreeListUrl;
  }

     onReload(id: string) {
      this._service.endpointUrl = 'manage/team/details';
      const source = this._service.getPagedArrayList(new PaginationRequest({
        page: 1,
        limit: 10,
        method: 'get'
      }), AdminUrlConfig.EndPoint.TeamPosition.TeamDetailsUrl + '/' + id + '?filter').pipe(share());
      this.teamDetailIdSubject$.next(source.pipe(pluck('data')));
      this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamTreeListUrl;
     }

  }

