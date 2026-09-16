import { Component, Input } from '@angular/core';
import { People } from '../../../_entities/involvedperson.data.model';
@Component({
  // tslint:disable-next-line:component-selector
  selector: 'involved-person-role-danger-at-location',
  templateUrl: './involved-person-role-danger-at-location.component.html',
  styleUrls: ['./involved-person-role-danger-at-location.component.scss']
})
export class InvolvedPersonRoleDangerAtLocationComponent implements OnInit {

    @Input() dangerLocation: People[] = [];
}
