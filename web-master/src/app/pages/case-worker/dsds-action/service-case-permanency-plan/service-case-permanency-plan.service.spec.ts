import { TestBed, inject } from '@angular/core/testing';

import { ServiceCasePermanencyPlanService } from './service-case-permanency-plan.service';

describe('ServiceCasePermanencyPlanService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ServiceCasePermanencyPlanService]
    });
  });

  it('should be created', inject([ServiceCasePermanencyPlanService], (service: ServiceCasePermanencyPlanService) => {
    expect(service).toBeTruthy();
  }));
});
