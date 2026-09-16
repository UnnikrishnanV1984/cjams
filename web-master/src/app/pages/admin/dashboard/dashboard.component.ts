import { Component } from '@angular/core';
import { routerTransition } from '../../../router.animations';

@Component({
    selector: 'app-dashboard',
    templateUrl: './dashboard.component.html',
    animations: [routerTransition()],
    standalone: false
})
export class DashboardComponent { }
