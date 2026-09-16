import { TestBed, inject } from '@angular/core/testing';

import { SocialHistoryService } from './social-history.service';

describe('SocialHistoryService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SocialHistoryService]
    });
  });

  it('should be created', inject([SocialHistoryService], (service: SocialHistoryService) => {
    expect(service).toBeTruthy();
  }));
});
