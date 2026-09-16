import { Component, Input } from '@angular/core';
import { PersonDetail } from '../../_entities/involvedperson.data.model';
import { Subject } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'involved-person-view-address-information',
    templateUrl: './involved-person-view-address-information.component.html',
    styleUrls: ['./involved-person-view-address-information.component.scss'],
    standalone: false
})
export class InvolvedPersonViewAddressInformationComponent implements OnInit {

    @Input() address: PersonDetail[] = [];
    @Input() person$ = new Subject<PersonDetail>();
  }
