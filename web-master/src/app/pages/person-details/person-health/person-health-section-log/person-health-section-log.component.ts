import { Component, OnInit } from '@angular/core';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-health-section-log',
    templateUrl: './person-health-section-log.component.html',
    styleUrls: ['./person-health-section-log.component.scss'],
    standalone: false
})
export class PersonHealthSectionLogComponent implements OnInit {

    log: any = null;

    ngOnInit() {
        this.log = {
            createdDate: '',
            createdWorkerID: '',
            createdWorkerName: '',
            updatedDate: '',
            updatedWorkerID: '',
            updatedWorkerName: '',
            completedDate: '',
            completedWorkerID : '',
            completedWorkerName : ''
        };
    }

}
