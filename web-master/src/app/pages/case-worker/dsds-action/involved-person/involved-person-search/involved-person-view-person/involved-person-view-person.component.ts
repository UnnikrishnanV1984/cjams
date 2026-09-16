import { Component, Input } from '@angular/core';
import { PersonDetail } from '../../_entities/involvedperson.data.model';
import { Subject } from 'rxjs';

@Component({
  // tslint:disable-next-line:component-selector
  selector: 'involved-person-view-person',
  templateUrl: './involved-person-view-person.component.html',
  styleUrls: ['./involved-person-view-person.component.scss']
})
export class InvolvedPersonViewPersonComponent {

    @Input() person: PersonDetail[] = [];
    @Input() person$ = new Subject<PersonDetail>();
}
