import { Component, Input } from '@angular/core';
import { Observable, Subject } from 'rxjs';

import { PaginationInfo } from '../../../../@core/entities/common.entities';
import { RegulationLibraryResult } from '../../_entities/find-entity.module';

@Component({
    selector: 'regulation-library-result',
    templateUrl: './regulation-library-result.component.html',
    styleUrls: ['./regulation-library-result.component.scss'],
    standalone: false
})
export class RegulationLibraryResultComponent {
    @Input()
    pageNumberResult$!: Subject<number>;
    @Input()
    regulationResultData$!: Observable<RegulationLibraryResult[]>;
    @Input()
    totalResulRecords$!: Observable<number>;
    @Input() showTable: boolean;
    selectedRecord: RegulationLibraryResult;
    paginationInfo: PaginationInfo = new PaginationInfo();
    constructor() {
        this.selectedRecord = new RegulationLibraryResult();
        this.showTable = false;
    }
    
    pageChanged(page: number) {
        this.paginationInfo.pageNumber = page;
        this.pageNumberResult$.next(page);
    }
    selectRegulation(data: RegulationLibraryResult) {
        this.selectedRecord = data;
    }
}
