import { TestBed, inject } from '@angular/core/testing';

import { PersonWorksDetailsService } from './person-works-details.service';

describe('PersonWorksDetailsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonWorksDetailsService]
    });
  });

  it('should be created', inject([PersonWorksDetailsService], (service: PersonWorksDetailsService) => {
    expect(service).toBeTruthy();
  }));
});
