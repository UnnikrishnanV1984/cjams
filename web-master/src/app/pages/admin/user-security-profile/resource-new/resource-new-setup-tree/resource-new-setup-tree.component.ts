
import {map, pluck} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { AdminUrlConfig } from '../../../admin-url.config';
import { GenericService, DataStoreService, CommonHttpService } from '../../../../../@core/services';
import { TeamPosition } from '../../../team-position/_entities/teamposition.data.model';
import { Observable ,  Subject } from 'rxjs';


@Component({
    selector: 'resource-new-setup-tree',
    templateUrl: './resource-new-setup-tree.component.html',
    styleUrls: ['./resource-new-setup-tree.component.scss'],
    standalone: false
})
export class ResourceNewSetupTreeComponent implements OnInit {
    @Input() resourceDetailIdSubject$ = new Subject<Observable<any>>();
    @Input() totalCount$ = new Subject<any>();
    @Input() pageChangedRequest$ = new Subject<any>();
    @Input() reloadTreeSubject = new Subject();
    @Input() selectedTreeSubject = new Subject();
    @Input() selectedResourceId = new Subject<string>();
    teamDetails: any;
    teamId: any = '';
    selectedIndex: string | undefined;
    parentid: string | undefined;
    teamTreeview$: Observable<any[]> = new Observable<any[]>();
    modulename: any;

    constructor(private _service: GenericService<TeamPosition>, private _dataStore: DataStoreService, private _commonService: CommonHttpService) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl;
    }

    ngOnInit() {
        this.reloadTreeSubject.subscribe(value => this.getPage());
        this.getPage();
        this.onSelected(null, 1, true);
        this.pageChangedRequest$.subscribe((item) => {
            if (item.id) {
                this.onSelected(item.name, item.page.page);
            } else {
                this.onSelected(null, item.page);
            }
        });
        this.selectedTreeSubject.subscribe((value: any) => this.onSelected(value.id, value.pageNo));    
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

    onSelected(event?: any, pageNo?: number, treeSelected?: boolean) {
        this.selectedIndex = event;
        this.modulename = event;
        const whereData = {
            'modulename': this.modulename ? this.modulename : null
        };
        const source = this._commonService.getArrayList({
            page: pageNo,
            limit: 10,
            method: 'get',
            where: whereData,
        }, AdminUrlConfig.EndPoint.resources.ResourcesByModuleListUrl + '?filter').pipe(map((item) => {
            return item;            
        })); 
        this.resourceDetailIdSubject$.next(source.pipe(pluck('data')));
        this._dataStore.setData('Pagination_Reset', true);
        source.pipe(pluck('count')).subscribe((item) => {
            if (item || (item === 0 && treeSelected)) {
                this.totalCount$.next(item);
            } 
        });
        this.selectedResourceId.next(this.modulename);
      
    }


}
