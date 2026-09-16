import { TestBed, inject } from '@angular/core/testing';

import { PlacementGapService } from './placement-gap.service';

describe('PlacementGapService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PlacementGapService]
    });
  });

  it('should be created', inject([PlacementGapService], (service: PlacementGapService) => {
    expect(service).toBeTruthy();
  }));
});
