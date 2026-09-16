import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
    selector: 'custom-info-tooltip',
    templateUrl: './custom-info-tooltip.component.html',
    styleUrls: ['./custom-info-tooltip.component.scss'],
    standalone: false
})
export class CustomInfoTooltip {
    @Input() message: string = '';
    @Output() close: EventEmitter<any> = new EventEmitter();

    constructor() { 
        //No operation needed here
    }

    closeDialog() {
        this.close.emit();
    }
}
