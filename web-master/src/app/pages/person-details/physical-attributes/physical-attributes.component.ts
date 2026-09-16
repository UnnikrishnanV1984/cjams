import { Component, OnInit } from '@angular/core';
import { PersonDetailsService } from '../person-details.service';
import { AppConstants } from '../../../@core/common/constants';

@Component({
    selector: 'physical-attributes',
    templateUrl: './physical-attributes.component.html',
    styleUrls: ['./physical-attributes.component.scss'],
    standalone: false
})
export class PhysicalAttributesComponent implements OnInit {
  height!: string;
  weight!: string;
  tattoo!: string;
  physicalMark!: string;
  constructor(public personService: PersonDetailsService) { }

  ngOnInit() {
    this.height = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.HEIGHT);
    this.weight = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.WEIGHT);
    this.tattoo = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.TATTOO);
    this.physicalMark = this.personService.findPhysicalAttribute(this.personService.person.personphysicalattribute, AppConstants.PERSON_IDENTIFIER.PHYSICAL_MARK);

  }

}
