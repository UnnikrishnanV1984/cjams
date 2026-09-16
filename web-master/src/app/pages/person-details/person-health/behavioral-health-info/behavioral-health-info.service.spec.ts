import { TestBed, inject } from '@angular/core/testing';

import { BehavioralHealthInfoService } from './behavioral-health-info.service';

describe('BehavioralHealthInfoService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BehavioralHealthInfoService]
    });
  });

  it('should be created', inject([BehavioralHealthInfoService], (service: BehavioralHealthInfoService) => {
    expect(service).toBeTruthy();
  }));
});
