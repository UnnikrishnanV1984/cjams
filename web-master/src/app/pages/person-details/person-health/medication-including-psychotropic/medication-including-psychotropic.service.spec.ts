import { TestBed, inject } from '@angular/core/testing';

import { MedicationIncludingPsychotropicService } from './medication-including-psychotropic.service';

describe('MedicationIncludingPsychotropicService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MedicationIncludingPsychotropicService]
    });
  });

  it('should be created', inject([MedicationIncludingPsychotropicService], (service: MedicationIncludingPsychotropicService) => {
    expect(service).toBeTruthy();
  }));
});
