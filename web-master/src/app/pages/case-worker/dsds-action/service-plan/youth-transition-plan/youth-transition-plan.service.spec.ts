/* tslint:disable:no-unused-variable */

import { TestBed, inject } from '@angular/core/testing';
import { YouthTransitionPlanService } from './youth-transition-plan.service';

describe('Service: YouthTransitionPlan', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [YouthTransitionPlanService]
    });
  });

  it('should ...', inject([YouthTransitionPlanService], (service: YouthTransitionPlanService) => {
    expect(service).toBeTruthy();
  }));
});
