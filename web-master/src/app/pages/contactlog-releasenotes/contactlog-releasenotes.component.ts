import { Component } from '@angular/core';

@Component({
    // moduleId: module.id,
    selector: 'contactlog-releasenotes',
    templateUrl: './contactlog-releasenotes.component.html',
    styleUrls: ['./contactlog-releasenotes.component.scss'],
    standalone: false
})

export class ContactlogReleasenotesComponent {
	tabDetails = [
        {
            id: 'view-tickets',
            title: 'View Tickets',
            name:'View Tickets',
            route: 'view-tickets'
        },
        {
            id: 'Release-Notes',
            title: 'Release Notes',
            name:'Release Notes',
            route: 'Release-Notes'
        }
	// 	,
    //     {
    //       id: 'approved',
    //       title: 'approved',
    //       name: 'approved',
    //       route: 'approved'
    //   }
    ];
}