import { Component, Input } from '@angular/core';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'placement-search-view',
    templateUrl: './finance-placement-search-view.component.html',
    styleUrls: ['./finance-placement-search-view.component.scss'],
    standalone: false
})
export class FinancePlacementSearchViewComponent {
    @Input() selectedPlacement: any;
}
