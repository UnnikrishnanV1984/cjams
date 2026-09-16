import { CommonModule, NgIf } from '@angular/common';
import { Component, Input } from '@angular/core';

@Component({
    selector: 'person-information',
    templateUrl: './person-information.component.html',
    styleUrls: ['./person-information.component.scss'],
    imports:[NgIf,CommonModule],
    standalone: true
})
export class PersonInformationComponent {

  @Input() persons: any;

  validate() {
    if (this.persons instanceof Array) {
      if (this.persons && this.persons.length) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

}
