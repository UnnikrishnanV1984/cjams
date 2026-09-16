import {Component, Input } from '@angular/core';

@Component({
    selector: 'details-table',
    templateUrl: './detailsTable.component.html',
    standalone: false
})
export class DetailsTableComponent {

	@Input() rows: any[]=[];

	columns: string[] = ['id', 'description', 'value'];
}
