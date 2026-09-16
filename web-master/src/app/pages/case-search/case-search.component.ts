import { Component } from '@angular/core';

export class IntakeStore {
  number!: string;
  action!: string;
}

@Component({
    selector: 'case-search',
    templateUrl: './case-search.component.html',
    styleUrls: ['./case-search.component.scss'],
    standalone: false
})
export class CaseSearchComponent { }
