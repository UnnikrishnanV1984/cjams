import { TestBed, inject } from '@angular/core/testing';

import { EmploymentProfileService } from './employment-profile.service';

describe('EmploymentProfileService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [EmploymentProfileService]
    });
  });

  it('should be created', inject([EmploymentProfileService], (service: EmploymentProfileService) => {
    expect(service).toBeTruthy();
  }));
});
