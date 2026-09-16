import { TestBed, inject } from '@angular/core/testing';

import { HealthInsuranceInformationService } from './health-insurance-information.service';

describe('HealthInsuranceInformationService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [HealthInsuranceInformationService]
    });
  });

  it('should be created', inject([HealthInsuranceInformationService], (service: HealthInsuranceInformationService) => {
    expect(service).toBeTruthy();
  }));
});
