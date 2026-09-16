import { TestBed, inject } from '@angular/core/testing';

import { ExitPlacementService } from './exit-placement.service';

describe('ExitPlacementService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ExitPlacementService]
    });
  });

  it('should be created', inject([ExitPlacementService], (service: ExitPlacementService) => {
    expect(service).toBeTruthy();
  }));
});
