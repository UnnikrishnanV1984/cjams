import { TestBed, inject } from '@angular/core/testing';

import { LivingArrangementDetailsService } from './living-arrangement-details.service';

describe('LivingArrangementDetailsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [LivingArrangementDetailsService]
    });
  });

  it('should be created', inject([LivingArrangementDetailsService], (service: LivingArrangementDetailsService) => {
    expect(service).toBeTruthy();
  }));
});
