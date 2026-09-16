import { TestBed, inject } from '@angular/core/testing';

import { TitleIVeGuardianshipService } from './titleIVe-guardianship.service';

describe('Title4eFosterCareService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TitleIVeGuardianshipService]
    });
  });

  it('should be created', inject([TitleIVeGuardianshipService], (service: TitleIVeGuardianshipService) => {
    expect(service).toBeTruthy();
  }));
});
