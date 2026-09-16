import { TestBed, inject } from '@angular/core/testing';

import { PersonBasicDetailsService } from './person-basic-details.service';

describe('PersonBasicDetailsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonBasicDetailsService]
    });
  });

  it('should be created', inject([PersonBasicDetailsService], (service: PersonBasicDetailsService) => {
    expect(service).toBeTruthy();
  }));
});
