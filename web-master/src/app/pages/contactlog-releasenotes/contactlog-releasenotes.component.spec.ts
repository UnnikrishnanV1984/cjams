import { TestBed, inject } from '@angular/core/testing';

import { ContactlogReleasenotesComponent } from './contactlog-releasenotes.component';

describe('a contactlog-releasenotes component', () => {
	let component: ContactlogReleasenotesComponent;

	// register all needed dependencies
	beforeEach(() => {
		TestBed.configureTestingModule({
			providers: [
				ContactlogReleasenotesComponent
			]
		});
	});

	// instantiation through framework injection
	beforeEach(inject([ContactlogReleasenotesComponent], (ContactlogReleasenotesComponent1) => {
		component = ContactlogReleasenotesComponent1;
	}));

	it('should have an instance', () => {
		expect(component).toBeDefined();
	});
});