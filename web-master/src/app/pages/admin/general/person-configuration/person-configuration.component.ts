import { Component } from '@angular/core';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-configuration',
    templateUrl: './person-configuration.component.html',
    standalone: false
})
export class PersonConfigurationComponent {
    selected: any;
    isInitialSelect = true;
    route!: string;
    personConfigTabList: any;
}
