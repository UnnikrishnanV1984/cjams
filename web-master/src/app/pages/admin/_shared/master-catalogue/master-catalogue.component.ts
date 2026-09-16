import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { AbstractControl, FormControl, FormGroup } from '@angular/forms';
import { Observable } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { GeneralConfig, MasterCatelogConfig } from '../../general/_entities/general.data.models';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'general-master-catalogue',
    templateUrl: './master-catalogue.component.html',
    standalone: false
})
export class MasterCatalogueComponent implements OnInit {
    @Input() isDescriptionFieldRequired = true;
    @Input() disableOnEdit = false;
    @Input() paginationInfo!: PaginationInfo;
    @Input() componentConfig!: MasterCatelogConfig;
    @Input() catelogList!: Observable<GeneralConfig[]>;
    @Input() totalRecords!: Observable<number>;
    @Input() formGroup!: FormGroup;
    @Input() canDisplayPager$!: Observable<boolean>;
    @Output() catelogSaved = new EventEmitter<GeneralConfig>();
    @Output() catelogDeleted = new EventEmitter<GeneralConfig>();
    @Output() pageChanged = new EventEmitter<any>();
    @Output() onSort = new EventEmitter<ColumnSortedEvent>();
    @Output() onSearch = new EventEmitter<any>();
    catelogData: GeneralConfig = new GeneralConfig();
    masterCatlogControl!: AbstractControl | null;
    ngOnInit() {
        this.masterCatlogControl = this.formGroup.get('name');
    }

    clearCatelog() {
        this.catelogData = Object.assign({}, new GeneralConfig());
        this.disableOnEdit = false;
        this.formGroup.reset();
        this.masterCatlogControl?.enable();
    }

    editCatelog(catelog: GeneralConfig) {
        this.catelogData = Object.assign({}, catelog);
        if (this.isDescriptionFieldRequired) {
            this.disableOnEdit = true;
            this.formGroup.setValue({
                name: this.catelogData.name,
                description: this.catelogData.description
            });
            this.masterCatlogControl?.disable();
        } else {
            this.masterCatlogControl?.enable();
            this.disableOnEdit = true;
            this.formGroup.setValue({
                name: this.catelogData.name
            });
        }
    }
    saveCatelog() {
        if (this.formGroup.dirty && this.formGroup.valid) {
            this.catelogData.name = this.formGroup.value.name;
            this.catelogData.description = this.formGroup.value.description;
            if (this.catelogData.sequencenumber != null) {
                this.catelogSaved.emit(this.catelogData);
            } else {
                this.catelogSaved.emit(
                    new GeneralConfig({
                        sequencenumber: 0,
                        activeflag: 0,
                        datavalue: 0,
                        editable: 0,
                        effectivedate: new Date(),
                        expirationdate: null,
                        description: this.catelogData.description,
                        id: 0,
                        name: this.catelogData.name
                    })
                );
            }
            this.disableOnEdit = false;
            this.formGroup.reset();
            this.masterCatlogControl?.enable();
        }
    }

    deleteCatelog(catelog: any) {
        this.catelogDeleted.emit(catelog);
        this.formGroup.reset();
        this.masterCatlogControl?.enable();
    }

    changePage(event: any): void {
        this.pageChanged.emit(event);
        this.formGroup.reset();
    }

    onSorted($event: ColumnSortedEvent) {
        this.onSort.emit($event);
    }
    onSearched(field: string, val: Event) {
        const value = (val.target as HTMLInputElement).value;
        this.onSearch.emit({ field: field, value: value });
    }

    get nameControl(): FormControl { 
        return this.formGroup.get('name') as FormControl; 
    }
    
    get descriptionControl(): FormControl { 
        return this.formGroup.get('description') as FormControl; 
    }
}
