import { Component, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'decisions',
    templateUrl: './decisions.component.html',
    standalone: false
})
export class DecisionsComponent {
  @Input() worksheetForm!: FormGroup;
  @Input() eligibilityPerioodData: any;
  isCLW: any;
}
