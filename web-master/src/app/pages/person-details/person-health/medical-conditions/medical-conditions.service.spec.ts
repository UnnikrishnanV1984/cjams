import { TestBed, inject } from '@angular/core/testing';

import { MedicalConditionsService } from './medical-conditions.service';

describe('MedicalConditionsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MedicalConditionsService]
    });
  });

  it('should be created', inject([MedicalConditionsService], (service: MedicalConditionsService) => {
    expect(service).toBeTruthy();
  }));
});
