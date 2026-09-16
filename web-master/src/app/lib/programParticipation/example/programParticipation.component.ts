import {Component} from '@angular/core';
import {ProgramParticipationService} from './../programParticipation.service';

@Component({
    selector: 'program-participation',
    templateUrl: './programParticipation.component.html',
    standalone: false
})
export class ProgramParticipationComponent {

	person: any;

	constructor(public programParticipationService: ProgramParticipationService) { }
	
	ngOnInit() {
		this.person = {
			mdmId: "MDT-139406431"
		}
	}
}