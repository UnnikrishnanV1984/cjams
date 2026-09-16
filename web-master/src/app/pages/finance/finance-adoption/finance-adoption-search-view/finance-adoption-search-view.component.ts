import { Component, Input } from '@angular/core';
import { FinanceAdoptionSearchEntry} from '../../_entities/finance-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-search-view',
    templateUrl: './finance-adoption-search-view.component.html',
    styleUrls: ['./finance-adoption-search-view.component.scss'],
    standalone: false
})
export class FinanceAdoptionSearchViewComponent {
    @Input() selectedAdoption!: FinanceAdoptionSearchEntry;
}
