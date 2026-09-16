import { Component, OnInit } from '@angular/core';
import { TeamDetails } from '../../team-position/_entities/teamposition.data.model';
import { Observable ,  Subject } from 'rxjs';

@Component({
    selector: 'resource-new',
    templateUrl: './resource-new.component.html',
    standalone: false
})
export class ResourceNewComponent implements OnInit {
  teamMemeberDetails: TeamDetails = new TeamDetails();
  teamDetails$: Observable<any> = new Observable<any>();
  totalCount$ = new Subject<any>();
  resourceDetailIdSubject$ = new Subject<Observable<any>>();
  pageChangedRequest$ = new Subject<any>();
  reloadTreeSubject = new Subject();
  selectedResourceId = new Subject<string>();
  selectedTreeSubject = new Subject();

  ngOnInit() {
    this.resourceDetailIdSubject$.subscribe(value => {
      this.teamDetails$ = value;
    });
  }

}
