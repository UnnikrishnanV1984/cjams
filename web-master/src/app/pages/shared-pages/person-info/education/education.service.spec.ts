import { TestBed, inject } from '@angular/core/testing';

import { EducationInfoService } from './education.service';

describe('EducationService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [EducationInfoService]
    });
  });

  it('should be created', inject([EducationInfoService], (service: EducationInfoService) => {
    expect(service).toBeTruthy();
  }));
});
