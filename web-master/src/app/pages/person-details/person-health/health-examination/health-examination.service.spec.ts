import { TestBed, inject } from '@angular/core/testing';

import { HealthExaminationService } from './health-examination.service';

describe('HealthExaminationService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [HealthExaminationService]
    });
  });

  it('should be created', inject([HealthExaminationService], (service: HealthExaminationService) => {
    expect(service).toBeTruthy();
  }));
});
