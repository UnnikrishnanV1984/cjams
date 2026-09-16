import { Component, Input } from '@angular/core';
import { PersonDetail } from '../../_entities/involvedperson.data.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-view-clearing',
    templateUrl: './involved-person-view-clearing.component.html',
    styleUrls: ['./involved-person-view-clearing.component.scss'],
    standalone: false
})
export class InvolvedPersonViewClearingComponent {

    @Input() clearing: PersonDetail[] = [];
}
