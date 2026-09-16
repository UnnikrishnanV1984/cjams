
import {map, debounceTime, startWith, mergeMap, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';
import { Observable, merge, Subject } from 'rxjs';

import { environment } from '../../../../environments/environment';
import { AppUser } from '../../../@core/entities/authDataModel';
import { DropdownModel, DynamicObject, PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';
import { AlertService, AuthService, CommonHttpService, GenericService } from '../../../@core/services';
import { ColumnSortedEvent } from '../../../shared/modules/sortable-table/sort.service';
import { AdminUrlConfig } from '../admin-url.config';
import { AssessmentBuilder } from './entities/assessment-builder.model';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'assessment-builder',
    templateUrl: './assessment-builder.component.html',
    styleUrls: ['./assessment-builder.component.scss'],
    standalone: false
})
export class AssessmentBuilderComponent implements OnInit {
    activeFlag: any = '1';
    targetList$!: Observable<DropdownModel[]>;
    categoryList$!: Observable<DropdownModel[]>;
    subcategoryList$!: Observable<DropdownModel[]>;
    assessmentbuilderForm!: FormGroup;
    paginationInfo: PaginationInfo = new PaginationInfo();
    totalRecords$!: Observable<number>;
    canDisplayPager$!: Observable<boolean>;
    assessmentBuilder$!: Observable<AssessmentBuilder[]>;
    assessmentBuilder: AssessmentBuilder = new AssessmentBuilder();
    private formBuilderUrl!: string;
    private token!: AppUser;
    safeUrl!: SafeResourceUrl | null;
    dynamicObject: DynamicObject = {
        categoryid: null,
        subcategoryid: null,
        targetid: null,
        isactive: '1'
    };
    deletepopupid = '#delete-popup';
    private searchTermStream$ = new Subject<DynamicObject>();
    pageStream$ = new Subject<number>();
    constructor(
        private _alertService: AlertService,
        private formBulider: FormBuilder,
        private _service: GenericService<AssessmentBuilder>,
        private _authService: AuthService,
        private _dropDownService: CommonHttpService,
        public sanitizer: DomSanitizer
    ) {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.AssessmentBuilder.AssessmentTemplatelistdataUrl;
    }
    ngOnInit() {
        this.formInitilize();
        this.token = this._authService.getCurrentUser();
        this.paginationInfo.sortBy = 'assessmenttemplatetargetid asc';
        this.getPage();
        this.loadCategory();
        this.loadTarget();
    }
    formInitilize() {
        this.assessmentbuilderForm = this.formBulider.group({
            assessmenttemplatecategory: [''],
            assessmenttemplateSubcategory: [''],
            target: [''],
            activeflag: ['']
        });
    }
    getPage() {
        const pageSource = this.pageStream$.pipe(map((pageNumber) => {
            this.paginationInfo.pageNumber = pageNumber;
            return { search: this.dynamicObject, page: pageNumber };
        }));

        const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm) => {
            this.paginationInfo.pageNumber = 1;
            this.dynamicObject = searchTerm;
            return { search: searchTerm, page: 1 };
        }),);

        const source = merge(searchSource,pageSource).pipe(
            startWith({
                search: this.dynamicObject,
                page: this.paginationInfo.pageNumber
            }),
            mergeMap((params: { search: DynamicObject; page: number }) => {
                return this._service.getPagedArrayList(
                    new PaginationRequest({
                        limit: this.paginationInfo.pageSize,
                        page: params.page,
                        where: params.search,
                        count: this.paginationInfo.total,
                        method: 'get',
                        order: this.paginationInfo.sortBy
                    }),
                    AdminUrlConfig.EndPoint.AssessmentBuilder.AssessmentTemplatelistdataUrl + '?filter'
                ).pipe(
                    map((result) => {
                        return {
                            data: result.data,
                            count: result.count,
                            canDisplayPager: result.count > this.paginationInfo.pageSize
                        };
                    }));
            }),
            share(),);
        this.assessmentBuilder$ = source.pipe(pluck('data'));
        if (this.paginationInfo.pageNumber === 1) {
            this.totalRecords$ = source.pipe(pluck('count'));
            this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
        }
    }
    addTemplate() {
        const baseUrl = environment.formBuilderHost;
        const token = encodeURIComponent(this.token.id);
        this.formBuilderUrl = environment.formBuilderHost + `/#/create/form?t=${token}`;
        if (this.isTrustedUrl(this.formBuilderUrl, baseUrl)) {
            this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl(this.formBuilderUrl);
        } else {
            this.safeUrl = null;
        }
    }
    viewTemplate(assessmentBuilder: AssessmentBuilder) {
        const baseUrl = environment.formBuilderHost;
        const token = encodeURIComponent(this.token.id);
        this.formBuilderUrl = environment.formBuilderHost + `/#/form/${assessmentBuilder.external_templateid}/?t=${token}`;
        if (this.isTrustedUrl(this.formBuilderUrl, baseUrl)) {
            this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl(this.formBuilderUrl);
        } else {
            this.safeUrl = null;
        }
    }

    private isTrustedUrl(url: string, base: string): boolean {
        try {
        const parsed = new URL(url);
        const allowed = new URL(base);

        // Only allow if hostname + protocol match the trusted host
        return parsed.hostname === allowed.hostname &&
                parsed.protocol === allowed.protocol;
        } catch {
        return false;
        }
    }
    
    onChangeCategory(option: any) {
        this.assessmentBuilder.assessmenttemplateid = option.value;
        this.subcategoryList$ = this._dropDownService
            .getArrayList(
                {
                    include: 'servicerequestsubtype',
                    nolimit: true,
                    where: {
                        intakeservreqtypeid: this.assessmentBuilder.assessmenttemplateid,
                        activeflag: 1
                    },
                    method: 'get'
                },
                'admin/intakeservicerequesttype' + '?filter'
            ).pipe(
            map((data) => {
                return data[0].servicerequestsubtype.map((res: { description: any; servicerequestsubtypeid: any; }) => new DropdownModel({ text: res.description, value: res.servicerequestsubtypeid }));
            }));
    }

    onChangeSubCategory(option: any) {
        this.assessmentBuilder.external_templateid = option.value;
    }
    loadTarget() {
        this.targetList$ = this._dropDownService.getArrayList(
            {
                nolimit: true,
                where: {
                    activeflag: 1
                },
                method: 'get'
            },
            'admin/Assessmenttemplatetarget?filter'
        );
    }
    searchForms() {
        if (this.assessmentbuilderForm.value.activeflag) {
            this.activeFlag = '1';
        } else {
            this.activeFlag = null;
        }
        this.dynamicObject['isactive'] = this.activeFlag ? this.activeFlag : null;
        this.assessmentBuilder.target = this.assessmentbuilderForm.controls['target'].value ? this.assessmentbuilderForm.controls['target'].value: null;
        this.dynamicObject['categoryid'] = this.assessmentBuilder.assessmenttemplateid ? this.assessmentBuilder.assessmenttemplateid : null;
        this.dynamicObject['subcategoryid'] = this.assessmentBuilder.external_templateid ? this.assessmentBuilder.external_templateid : null;
        this.dynamicObject['targetid'] = this.assessmentBuilder.target ? this.assessmentBuilder.target : null;
        this.searchTermStream$.next(this.dynamicObject);
    }

    loadCategory() {
        this.categoryList$ = this._dropDownService.getArrayList(
            {
                nolimit: true,
                where: { activeflag: 1 },
                method: 'get'
            },
            'admin/intakeservicerequesttype' + '?filter'
        );
    }

    editTemplate(assessmentBuilder: AssessmentBuilder) {
        const baseUrl = environment.formBuilderHost;
        const token = encodeURIComponent(this.token.id);
        this.formBuilderUrl = environment.formBuilderHost + `/#/form/${assessmentBuilder.external_templateid}/edit?t=${token}`;
        if (this.isTrustedUrl(this.formBuilderUrl, baseUrl)) {
            this.safeUrl = this.sanitizer.bypassSecurityTrustResourceUrl(this.formBuilderUrl);
        } else {
            this.safeUrl = null;
        }
    }

    deleteTemplate() {
        this._service.endpointUrl = AdminUrlConfig.EndPoint.AssessmentBuilder.AssessmenttemplateUrl;
        this._service.remove(this.assessmentBuilder.assessmenttemplateid).subscribe(
            (response) => {
                if (response) {
                    this._alertService.success('Assessment deleted successfully');
                    this.assessmentBuilder = new AssessmentBuilder();
                    this.pageStream$.next(this.paginationInfo.pageNumber);
                    $(this.deletepopupid).modal('hide');
                }
            },
            () => {
                $(this.deletepopupid).modal('hide');
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    }

    declineDelete() {
        $(this.deletepopupid).modal('hide');
    }
    confirmDelete(requestData: AssessmentBuilder) {
        this.assessmentBuilder = requestData;
        $(this.deletepopupid).modal('show');
    }
    refresh() {
        this.assessmentbuilderForm.reset();
        this.assessmentbuilderForm.patchValue({ assessmenttemplatecategory: '', assessmenttemplateSubcategory: '', target: '' });
        this.dynamicObject = { categoryid: null, subcategoryid: null, targetid: null, isactive: '1' };
        this.searchTermStream$.next(this.dynamicObject);
    }

    pageChanged(event: any) {
        this.paginationInfo.pageNumber = event.page;
        this.paginationInfo.pageSize = event.itemsPerPage;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSorted($event: ColumnSortedEvent) {
        this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
        this.pageStream$.next(this.paginationInfo.pageNumber);
    }

    onSearch(field: string, value: string) {
        this.dynamicObject[field] = { like: '%25' + value + '%25' };
        if (!value) {
            delete this.dynamicObject[field];
        }
        this.searchTermStream$.next(this.dynamicObject);
    }
}
