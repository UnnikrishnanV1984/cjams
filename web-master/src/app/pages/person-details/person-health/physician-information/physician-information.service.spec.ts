import { TestBed, inject } from '@angular/core/testing';

import { PhysicianInformationService } from './physician-information.service';

describe('PhysicianInformationService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PhysicianInformationService]
    });
  });

  it('should be created', inject([PhysicianInformationService], (service: PhysicianInformationService) => {
    expect(service).toBeTruthy();
  }));
});
