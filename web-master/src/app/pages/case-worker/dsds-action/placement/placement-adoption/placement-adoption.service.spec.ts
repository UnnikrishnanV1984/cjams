import { TestBed, inject } from '@angular/core/testing';

import { PlacementAdoptionService } from './placement-adoption.service';

describe('PlacementAdoptionService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PlacementAdoptionService]
    });
  });

  it('should be created', inject([PlacementAdoptionService], (service: PlacementAdoptionService) => {
    expect(service).toBeTruthy();
  }));
});
