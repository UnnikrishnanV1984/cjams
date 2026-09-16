import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { TeamDetails } from '../../admin/team-position/_entities/teamposition.data.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'team-position',
    templateUrl: './team-position.component.html',
    styleUrls: ['./team-position.component.scss'],
    standalone: false
})
export class TeamPositionComponent implements OnInit {
  teamDetailIdSubject$ = new Subject<Observable<TeamDetails>>();
  totalCount$ = new Subject<any>();
  reloadTreeSubject = new Subject();
  selectedTreeSubject = new Subject();
  teamDetails$!: Observable<TeamDetails>;
  selectedTeamId = new Subject<string>();
  pageChangedRequest$ = new Subject<any>();
  emailSearch$ = new Subject<string>();
  teamMemeberDetails: TeamDetails = new TeamDetails();

  ngOnInit() {
   this.teamDetailIdSubject$.subscribe(value => {
     this.teamDetails$ = value;
     value.subscribe((item) => {
       if (item) {
        this.teamMemeberDetails = item.team;
       }
     });
   });

  }


}
