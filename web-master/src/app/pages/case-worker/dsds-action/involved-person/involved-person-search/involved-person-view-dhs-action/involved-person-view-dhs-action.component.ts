import { Component, Input } from '@angular/core';
import { PersonDetail } from '../../_entities/involvedperson.data.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-view-dhs-action',
    templateUrl: './involved-person-view-dhs-action.component.html',
    styleUrls: ['./involved-person-view-dhs-action.component.scss'],
    standalone: false
})
export class InvolvedPersonViewDhsActionComponent {

    @Input() dhsAction: PersonDetail[] = [];
  }
