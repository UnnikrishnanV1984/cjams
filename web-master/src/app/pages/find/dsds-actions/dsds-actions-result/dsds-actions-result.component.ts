import { Component, Input } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { DsdsActionResult } from '../../_entities/find-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'dsds-actions-result',
    templateUrl: './dsds-actions-result.component.html',
    styleUrls: ['./dsds-actions-result.component.scss'],
    standalone: false
})
export class DsdsActionsResultComponent {
    @Input()
    pageNumberResult$!: Subject<number>;
    @Input()
    dsdsActionResultData$!: Observable<DsdsActionResult[]>;
    @Input()
    totalResulRecords$!: Observable<number>;
    @Input() showTable: boolean;
    paginationInfo: PaginationInfo = new PaginationInfo();
    constructor() {
        this.showTable = false;
    }
    
    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.pageNumberResult$.next(page);
    }
}
