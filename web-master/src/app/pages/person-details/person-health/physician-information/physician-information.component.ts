import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'physician-information',
    templateUrl: './physician-information.component.html',
    styleUrls: ['./physician-information.component.scss'],
    standalone: false
})
export class PhysicianInformationComponent {

  constructor(private route: ActivatedRoute) {  }
}
