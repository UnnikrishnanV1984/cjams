import { TestBed, inject } from '@angular/core/testing';

import { IntakeReferralService } from './intake-referral.service';

describe('IntakeReferralService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [IntakeReferralService]
    });
  });

  it('should be created', inject([IntakeReferralService], (service: IntakeReferralService) => {
    expect(service).toBeTruthy();
  }));
});
