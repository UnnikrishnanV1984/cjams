import { TestBed, inject } from '@angular/core/testing';

import { FindIndividualService } from './find-individual.service';

describe('FindIndividualService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [FindIndividualService]
    });
  });

  it('should be created', inject([FindIndividualService], (service: FindIndividualService) => {
    expect(service).toBeTruthy();
  }));
});
