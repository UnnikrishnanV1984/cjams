import {Component, Input} from '@angular/core';

@Component({
    selector: 'ui-modal',
    templateUrl: './modal.component.html',
    standalone: false
})
export class ModalComponent {

	@Input() modalId !: string;

	@Input() title !: string;
	
	close() {
		const id =  '#' + this.modalId;
		(<any>$(id)).modal('hide');
	}
}