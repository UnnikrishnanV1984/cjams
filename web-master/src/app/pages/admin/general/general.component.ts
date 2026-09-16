import { Component } from '@angular/core';

import { routerTransition } from '../../../router.animations';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-admin-general',
    templateUrl: './general.component.html',
    styleUrls: ['./general.component.scss'],
    animations: [routerTransition()],
    standalone: false
})
export class GeneralComponent { }
