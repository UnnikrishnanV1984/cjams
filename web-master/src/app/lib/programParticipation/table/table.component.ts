import {Component, Input} from '@angular/core';
import { ProgramParticipationService } from '../programParticipation.service';

@Component({
    selector: 'program-participation-table',
    templateUrl: './table.component.html',
    styleUrls: ['./table.component.scss'],
    standalone: false
})
export class TableComponent {
	
	constructor(public programParticipationService: ProgramParticipationService) { }

	@Input() isLoading : boolean = true;
	
	@Input() programs : any[] = [];
	
	expanded : any = null;

	handleClick(id: any) {
		this.expand(id);
		this.programParticipationService.loadCaseDetails(id);
	}


	expand(id: any) {
		
		if (this.expanded === id) {
			this.expanded = null
			return
		}

		this.expanded = id
	}

	columns: any[] = [
		{
			name: 'Case ID',
			property: 'id'
		},
		{
			name: 'Source',
			property: 'source'
		},
		{
			name: 'Local Office',
			property: 'localOffice'
		},
		{
			name: 'Program',
			property: 'program'
		},
		{
			name: 'Sub Program',
			property: 'subProgram'
		},
		{
			name: 'Status',
			property: 'status'
		},
		{
			name: 'Start',
			property: 'start'
		},
		{
			name: 'End',
			property: 'end'
		},
		{
			name: 'Worker',
			property: 'worker'
		},
		{
			name: 'Supervisor',
			property: 'supervisor'
		}
	];
}