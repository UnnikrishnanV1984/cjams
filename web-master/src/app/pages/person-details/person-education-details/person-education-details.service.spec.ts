import { TestBed, inject } from '@angular/core/testing';

import { PersonEducationDetailsService } from './person-education-details.service';

describe('PersonEducationDetailsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonEducationDetailsService]
    });
  });

  it('should be created', inject([PersonEducationDetailsService], (service: PersonEducationDetailsService) => {
    expect(service).toBeTruthy();
  }));
});
