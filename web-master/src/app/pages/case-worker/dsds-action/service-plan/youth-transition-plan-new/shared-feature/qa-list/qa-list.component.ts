import { Component, Input } from '@angular/core';

@Component({
    selector: 'qa-list',
    templateUrl: './qa-list.component.html',
    styleUrls: ['./qa-list.component.scss'],
    standalone: false
})
export class QaListComponent {

  @Input() questions: any;
}
