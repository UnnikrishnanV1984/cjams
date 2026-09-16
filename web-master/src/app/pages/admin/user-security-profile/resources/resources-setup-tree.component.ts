
import {pluck, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { DataStoreService, GenericService } from '../../../../@core/services';
import { AdminUrlConfig } from '../../admin-url.config';
import { TeamPosition } from '../../team-position/_entities/teamposition.data.model';
import { PaginationInfo } from './../../../../@core/entities/common.entities';
import { CommonHttpService } from './../../../../@core/services/common-http.service';


@Component({
    selector: 'resources-setup-tree',
    templateUrl: './resources-setup-tree.component.html',
    styleUrls: ['./resources-setup-tree.component.scss'],
    standalone: false
})
export class ResourcesSetupTreeComponent implements OnInit {


    @Input() resourceDetailIdSubject$ = new Subject<Observable<any>>();
    @Input() reloadTreeSubject = new Subject();
    @Input() selectedTreeSubject = new Subject();
    @Input() selectedResourceId = new Subject<string>();
    @Input() totalCount$ = new Subject<any>();
    @Input() pageChangedRequest$ = new Subject<any>();
    teamTreeview$: Observable<any[]> = new Observable<any[]>();
    paginationInfo: PaginationInfo = new PaginationInfo();
    private pageSubject$ = new Subject<number>();
    teamDetails: any;
    teamId: any = '';
    selectedIndex: any;
    parentid: string | undefined;


    constructor(private _service: GenericService<TeamPosition>, private _dataStore: DataStoreService, private _commonService: CommonHttpService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl;
    }

    ngOnInit() {
        this.reloadTreeSubject.subscribe(value => this.getPage());
        this.pageChangedRequest$.subscribe((item) => {
            if (item.id) {
                this.onSelected(item.id, item.page.page, item.page.itemsPerPage);
            } else {
                this.onSelected(this.teamId, item.page, item.itemsPerPage);
            }
        });
        this.getPage();
        this.onReload(null , 1);
        this.selectedTreeSubject.subscribe((value: any) => this.onReload(value.id, value.pageNo));
    }


    getPage() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl;
        const source1 = this._commonService.getArrayList(
            {
                nolimit: true,
                method: 'get',
                where: {
                    resourcetype: '2'
                }
            },
            AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter'
        ).pipe(map(response => {
            return response;
        }));

        this.teamTreeview$ = source1.pipe(pluck('data')) as Observable<any>;
    }

    onSelected(event?: any, pageNo?: number, pageSize?: number, treeSelected?: boolean, index?: number) {
        this.selectedIndex = event;
        this.teamId = event;
        let whereData: any;
        if (this.teamId) {
            whereData = {
                parentid: this.teamId,
                id: this.teamId
            };
        } else {
            whereData = {
                'parentid': null
            };
        }
        const source = this._commonService.getArrayList({
            page: pageNo,
            // limit: pageSize,
            limit: 10,
            method: 'get',
            where: whereData,
        }, AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter').pipe(map((item) => {
            return item;
        }));
        this.resourceDetailIdSubject$.next(source.pipe(pluck('data')));
        this._dataStore.setData('Pagination_Reset', true);

        source.pipe(pluck('count')).subscribe((item) => {
            if ((item) || (item === 0 && treeSelected)) {
                this.totalCount$.next(item);
            }
        });
        this.selectedResourceId.next(this.teamId);
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl;
    }

    onReload(id: string | null | undefined , pageNo?: number) {
        this.selectedIndex = id;
        this.teamId = id;
        let whereData1: any;
        if (this.teamId) {
            whereData1 = {
                parentid: this.teamId,
                id: this.teamId
            };
        } else {
            whereData1 = {
                'parentid': null
            };
        }
        
        const source = this._commonService.getArrayList({
            page: pageNo ? pageNo : 1,
            limit: 10,
            // nolimit: 'true',
            method: 'get',
            where: whereData1,
        }, AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter').pipe(map((item) => {
            return item;
        }));
        this.resourceDetailIdSubject$.next(source.pipe(pluck('data')));
        source.pipe(pluck('count')).subscribe((item) => {
            if ((item) || (item === 0)) {
                this.totalCount$.next(item);
            }
        });
    }

}
