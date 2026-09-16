import { TestBed, inject } from '@angular/core/testing';

import { CasePlanService } from './case-plan.service';

describe('CasePlanService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CasePlanService]
    });
  });

  it('should be created', inject([CasePlanService], (service: CasePlanService) => {
    expect(service).toBeTruthy();
  }));
});
