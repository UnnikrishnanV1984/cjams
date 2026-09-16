import { Component, Input } from '@angular/core';
import { FinanceGuardianshipSearchEntry} from '../../_entities/finance-entity.module';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'guardianship-search-view',
    templateUrl: './finance-guardianship-search-view.component.html',
    styleUrls: ['./finance-guardianship-search-view.component.scss'],
    standalone: false
})
export class FinanceGuardianshipSearchViewComponent {
    @Input() selectedGuardianship!: FinanceGuardianshipSearchEntry;
}
