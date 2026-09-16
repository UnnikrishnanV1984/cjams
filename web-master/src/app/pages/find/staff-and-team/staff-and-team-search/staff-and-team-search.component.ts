
import {pluck, share, map} from 'rxjs/operators';



import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { forkJoin ,  Observable, Subject } from 'rxjs';

import { ObjectUtils } from '../../../../@core/common/initializer';
import { DropdownModel, PaginationRequest } from '../../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { StaffSearchCriteria, UsersSearchResult } from '../../_entities/find-entity.module';
import { FindUrlConfig } from '../../find.url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'staff-and-team-search',
    templateUrl: './staff-and-team-search.component.html',
    styleUrls: ['./staff-and-team-search.component.scss'],
    standalone: false
})
export class StaffAndTeamSearchComponent implements OnInit {

    @Input()
    searchListSubject$!: Subject<Observable<UsersSearchResult[]>>;
    @Input()
    totalRecordsSubject$!: Subject<Observable<number>>;
    @Input()
    pageNumberSubject$!: Subject<number>;

    teamNumberDropdownItems$!: Observable<DropdownModel[]>;
    teamTypeDropdownItems$!: Observable<DropdownModel[]>;
    countyDropdownItems$!: Observable<DropdownModel[]>;
    regionDropdownItems$!: Observable<DropdownModel[]>;
    positionTitleDropdownItems$!: Observable<DropdownModel[]>;
    searchCriteria!: StaffSearchCriteria;

    formSearchCriteria: FormGroup;

    constructor(private _commonService: CommonHttpService, private _service: GenericService<UsersSearchResult>,
        private formBuilder: FormBuilder) {

        this.formSearchCriteria = this.formBuilder.group({
            LastName: '',
            FirstName: '',
            Position: '',
            positionTitle: '',
            orgNumber: '',
            TeamNo: '',
            TeamType: '',
            city: '',
            zipcode: '',
            county: '',
            region: '',
            UserCity: '',
            UserZipCode: '',
            UserCounty: '',
        });
    }

    ngOnInit() {
        this.getAllDropdownData();
        this.pageNumberSubject$.subscribe(data => {
            this.search(data, this.searchCriteria);
        });
    }

    getAllDropdownData() {
        const teamNumberRequest = this._commonService.getAll(
            FindUrlConfig.EndPoint.staffnteam.teamNumber +
            '?filter={"order": "teamnumber asc"}'
        );
        const teamTypeRequest = this._commonService.getAll(
            FindUrlConfig.EndPoint.staffnteam.teamType +
            `?filter={"order": "description asc","where": {"activeflag": 1}}`);

        const positionTitleRequest = this._commonService.getAll(
            FindUrlConfig.EndPoint.staffnteam.positionTitle +
            '?filter={"order": "roletypekey asc","where": {"activeflag": 1}}'
        );

        const countyTypeRequest = this._commonService.getAll(
            FindUrlConfig.EndPoint.common.counties
        );

        const regionTypeRequest = this._commonService.getAll(
            FindUrlConfig.EndPoint.common.regions
        );

        const source = forkJoin([
            teamNumberRequest,
            teamTypeRequest,
            positionTitleRequest,
            countyTypeRequest,
            regionTypeRequest,
        ]).pipe(
            map(result => {
                return {
                    teamNumberTypes: result[0].map(
                        res =>
                            new DropdownModel({
                                text: res.teamnumber,
                                value: res.teamtypekey
                            })
                    ),
                    teamTypes: result[1].map(
                        res =>
                            new DropdownModel({
                                text: res.description,
                                value: res.teamtypekey
                            })
                    ),
                    positionTitleTypes: result[2].map(
                        res1 =>
                            new DropdownModel({
                                text: res1.description,
                                value: res1.teamtypekey
                            })
                    ),
                    countries: result[3].map(
                        res =>
                            new DropdownModel({
                                text: res.countyname,
                                value: res.countyname
                            })
                    ),
                    regions: result[4].map(
                        res =>
                            new DropdownModel({
                                text: res.regionname,
                                value: res.regionname
                            })
                    ),
                };
            }),share(),);

        this.positionTitleDropdownItems$ = source.pipe(pluck('positionTitleTypes'));
        this.teamNumberDropdownItems$ = source.pipe(pluck('teamNumberTypes'));
        this.countyDropdownItems$ = source.pipe(pluck('countries'));
        this.regionDropdownItems$ = source.pipe(pluck('regions'));
        this.teamTypeDropdownItems$ = source.pipe(pluck('teamTypes'));
    }

    search(pageNo: number, params: StaffSearchCriteria) {
        this.searchCriteria = params;
        this._service.endpointUrl =
            FindUrlConfig.EndPoint.staffnteam.userSearch;
        ObjectUtils.removeEmptyProperties(params);
        params = Object.assign(new StaffSearchCriteria(), params);
        const source = this._service
            .getAllFilter(
                new PaginationRequest({
                    where: params,
                    page: pageNo,
                    limit: 10
                })
            ).pipe(
            share());

        this.searchListSubject$.next(source.pipe(pluck('data')));
        if (pageNo === 1) {
            this.totalRecordsSubject$.next(source.pipe(pluck('count')));
        }
    }

    clear() {
        this.formSearchCriteria.reset();
        this.formSearchCriteria.patchValue({
            positionTitle: '',
            TeamNo: '',
            TeamType: '',
            city: '',
            zipcode: '',
            county: '',
            region: '',
            UserCounty: '',
        });
    }
}
