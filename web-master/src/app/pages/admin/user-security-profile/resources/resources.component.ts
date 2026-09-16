import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';
import { TeamDetails } from '../../team-position/_entities/teamposition.data.model';


@Component({
    selector: 'resources',
    templateUrl: './resources.component.html',
    standalone: false
})
export class ResourcesComponent implements OnInit {

    resourceDetailIdSubject$ = new Subject<Observable<any>>();
    totalCount$ = new Subject<any>();
    reloadTreeSubject = new Subject();
    selectedTreeSubject = new Subject();
    teamDetails$: Observable<any> = new Observable<any>();
    selectedResourceId = new Subject<string>();
    pageChangedRequest$ = new Subject<any>();
    teamMemeberDetails: TeamDetails = new TeamDetails();

    ngOnInit() {
        this.resourceDetailIdSubject$.subscribe(value => {
            this.teamDetails$ = value;
            value.subscribe((item) => {
                if (item) {
                    this.teamMemeberDetails = item.team;
                }
            });
        });

    }


}
