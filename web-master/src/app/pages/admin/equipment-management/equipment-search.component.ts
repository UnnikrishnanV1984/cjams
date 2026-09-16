
import {share, pluck, map} from 'rxjs/operators';
import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable ,  Subject } from 'rxjs';

import { DropdownModel, PaginationInfo } from '../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { GenericService } from '../../../@core/services/generic.service';
import { AdminUrlConfig } from '../admin-url.config';
import { EquipmentManagement } from './_entities/equipment-management.models';
import * as found from './_configurations/found.json';
import * as disposed from './_configurations/disposed.json';
import * as replacement from './_configurations/replacement.json';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'equipment-search',
    templateUrl: './equipment-search.component.html',
    styleUrls: ['./equipment-search.component.scss'],
    standalone: false
})
export class EquipmentSearchComponent implements OnInit {
    @Input()
    equipmentSearchSubject$ = new Subject<Observable<any[]>>();
    @Input() totalRecordsSubject$ = new Subject<Observable<number>>();
    @Input() canDisplayPagerSubject$= new Subject<Observable<boolean>>();
    @Input() equipmentSearchPageSubject$ = new Subject<number>();
    @Input() equipmentSearchTriggeredSubject$!: Subject<string>;
    types$!: Observable<DropdownModel[]>;
    paginationInfo: PaginationInfo = new PaginationInfo();
    private searchFields = {
        typekey: '',
        manufactur: '',
        model: '',
        serialno: '',
        whitetagnumber: '',
        yellowtagno: '',
        loadno: '',
        organisationno: '',
        found: false,
        disposed: false,
        upforrep: false
    };
    formGroup!: FormGroup;
    foundDropdown!:DropdownModel[];
    disposedDropdown!:DropdownModel[];
    replacementDropdown!:DropdownModel[];
    constructor(
        private _formBuilder: FormBuilder,
        private _service: GenericService<EquipmentManagement>,
        private _equipmentConfigHttpService: CommonHttpService
    ) {
        _service.endpointUrl =
            AdminUrlConfig.EndPoint.EquipmentMgmt.EquipmentSearchUrl;
    }

    ngOnInit() {
        this.foundDropdown=<any>found;
        this.disposedDropdown=<any>disposed;
        this.replacementDropdown=<any>replacement;
        this.formBuilderGroup();
        this.equipmentSearchPageSubject$.subscribe(pageNo => {
            this.search(pageNo);
        });
        this.types$ = this._equipmentConfigHttpService
            .getArrayList({}, AdminUrlConfig.EndPoint.EquipmentMgmt.EquipmenTypeUrl).pipe(
            map(result => {
                return {
                    dropdown: result.map(
                        res =>
                            new DropdownModel({
                                text: res.equipmenttypekey,
                                value: res.equipmenttypekey
                            })
                    )
                };
            }),
            pluck('dropdown'),);
    }

    search(pageNumber: number) {
        this.searchFields.typekey = this.formGroup.value.typekey;
        this.searchFields.manufactur = this.formGroup.value.manufactur;
        this.searchFields.model = this.formGroup.value.model;
        this.searchFields.serialno = this.formGroup.value.serialno;
        this.searchFields.whitetagnumber = this.formGroup.value.whitetagnumber;
        this.searchFields.yellowtagno = this.formGroup.value.yellowtagno;
        this.searchFields.loadno = this.formGroup.value.loadno;
        this.searchFields.organisationno = this.formGroup.value.organisationno;
        this.searchFields.found = this.formGroup.value.found;
        this.searchFields.disposed = this.formGroup.value.disposed;
        this.searchFields.upforrep = this.formGroup.value.upforrep;
        this.getPage(pageNumber);
    }
    clearItem() {
        this.formBuilderGroup();
    }

    getPage(pageNumber: number) {
        this.paginationInfo.pageNumber = pageNumber;
        const source = this._service
            .getPagedArrayList({
                limit: this.paginationInfo.pageSize,
                page: this.paginationInfo.pageNumber,
                where: {
                    typekey: this.searchFields.typekey,
                    manufactur: this.searchFields.manufactur,
                    model: this.searchFields.model,
                    serialno: this.searchFields.serialno,
                    whitetagnumber: this.searchFields.whitetagnumber,
                    yellowtagno: this.searchFields.yellowtagno,
                    loadno: this.searchFields.loadno,
                    organisationno: this.searchFields.organisationno,
                    found: this.searchFields.found,
                    disposed: this.searchFields.disposed,
                    upforrep: this.searchFields.upforrep
                },
                method: 'post',
            }).pipe(
            map((result) => {
                return { data: result.data,
                    count: result.count,
                    canDisplayPager: result.count > this.paginationInfo.pageSize};
            }),
            share(),);
        this.equipmentSearchTriggeredSubject$.next(this.searchFields.typekey);
        this.equipmentSearchSubject$.next(source.pipe(pluck('data')));
        if (pageNumber === 1) {
            this.totalRecordsSubject$.next(source.pipe(pluck('count')) as Observable<number>); // NOSONAR
            this.canDisplayPagerSubject$.next(source.pipe(pluck('canDisplayPager')) as Observable<boolean>); // NOSONAR
        }
    }

    formBuilderGroup() {
        this.formGroup = this._formBuilder.group({
            typekey: [''],
            manufactur: [''],
            model: [''],
            serialno: [''],
            whitetagnumber: [''],
            yellowtagno: [''],
            loadno: [''],
            organisationno: [''],
            found: [false],
            disposed: [false],
            upforrep: [false]
        });
      }
}
