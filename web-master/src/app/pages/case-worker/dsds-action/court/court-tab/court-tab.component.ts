import { Component } from '@angular/core';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'court-tab',
    host: {
        class: 'court-tab'
    },
    templateUrl: './court-tab.component.html',
    styleUrls: ['./court-tab.component.scss'],
    standalone: false
})
export class CourtTabComponent { }
