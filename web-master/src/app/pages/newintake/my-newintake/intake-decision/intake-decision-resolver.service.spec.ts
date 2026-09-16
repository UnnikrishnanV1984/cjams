import { TestBed, inject } from '@angular/core/testing';

import { IntakeDecisionResolverService } from './intake-decision-resolver.service';

describe('IntakeDecisionResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [IntakeDecisionResolverService]
    });
  });

  it('should be created', inject([IntakeDecisionResolverService], (service: IntakeDecisionResolverService) => {
    expect(service).toBeTruthy();
  }));
});
