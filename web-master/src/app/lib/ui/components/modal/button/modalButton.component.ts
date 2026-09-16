import {Component, EventEmitter, Input, Output} from '@angular/core';

@Component({
    selector: 'ui-modal-button',
    templateUrl: './modalButton.component.html',
    standalone: false
})
export class ModalButtonComponent {

	@Input() modalId : string='';

	@Input() label : string='';

	@Input() data : any;

  	@Output() didClick = new EventEmitter<any>();
	id?: string;
	
	onClick() {
		this.didClick.emit(this.data);
		this.open();
	}

	open() {
		this.id =  '#' + this.modalId;
		(<any>$(this.id)).modal('show');
	}
}