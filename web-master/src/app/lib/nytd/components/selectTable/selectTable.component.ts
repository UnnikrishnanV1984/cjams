import {Component, EventEmitter, Input, Output} from '@angular/core';
import {SelectionModel} from '@angular/cdk/collections';

@Component({
    selector: 'select-table',
    templateUrl: './selectTable.component.html',
    styleUrls: ['./selectTable.component.scss'],
    standalone: false
})
export class SelectTableComponent {
	
	@Input() columns: any;

	get displayedColumns() {
		return Object.keys(this.columns);
	}

	@Input() rows?: any[];

	@Input() isLoading?: boolean;

  	@Output() select = new EventEmitter<any>();

	selection: SelectionModel<any> = new SelectionModel<any>(false, []);

	onSelect(row:any) {
		this.selection.toggle(row);
	    this.select.emit(this.selection.selected[0]);
	}
}
