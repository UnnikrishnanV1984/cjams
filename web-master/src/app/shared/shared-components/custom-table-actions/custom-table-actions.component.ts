import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
    selector: 'custom-table-actions',
    templateUrl: './custom-table-actions.component.html',
    styleUrls: ['./custom-table-actions.component.scss'],
    standalone: false
})
export class CustomTableActionsComponent {

    @Input() statuslist: any;
    @Input() selectedStatus: any;
    @Output() selectValue: EventEmitter<any> = new EventEmitter();

    selectStatus(status: any): void {
        this.selectedStatus = status.value;
        this.selectValue.emit(status);
    }

}
