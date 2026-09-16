import { TestBed, inject } from '@angular/core/testing';

import { ViewTicketsComponent } from './view-tickets.component';

describe('a view-tickets component', () => {
	let component: ViewTicketsComponent;

	// register all needed dependencies
	beforeEach(() => {
		TestBed.configureTestingModule({
			providers: [
				ViewTicketsComponent
			]
		});
	});

	// instantiation through framework injection
	beforeEach(inject([ViewTicketsComponent], (ViewTicketsComponent2) => {
		component = ViewTicketsComponent2;
	}));

	it('should have an instance', () => {
		expect(component).toBeDefined();
	});
});