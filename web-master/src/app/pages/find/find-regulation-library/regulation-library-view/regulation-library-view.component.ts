import { RegulationLibraryResult } from '../../_entities/find-entity.module';
import { Component, Input } from '@angular/core';
@Component({
    selector: 'regulation-library-view',
    templateUrl: './regulation-library-view.component.html',
    styleUrls: ['./regulation-library-view.component.scss'],
    standalone: false
})
export class RegulationLibraryViewComponent {
    @Input() selectedRegulation!: RegulationLibraryResult;
}
