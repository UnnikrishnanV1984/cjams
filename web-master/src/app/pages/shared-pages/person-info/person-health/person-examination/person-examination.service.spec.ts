import { TestBed, inject } from '@angular/core/testing';

import { PersonExaminationService } from './person-examination.service';

describe('PersonExaminationService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonExaminationService]
    });
  });

  it('should be created', inject([PersonExaminationService], (service: PersonExaminationService) => {
    expect(service).toBeTruthy();
  }));
});
