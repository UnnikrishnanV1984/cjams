import { TestBed, inject } from '@angular/core/testing';

import { GenerateReportsService } from './generate-reports.service';

describe('GenerateReportsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [GenerateReportsService]
    });
  });

  it('should be created', inject([GenerateReportsService], (service: GenerateReportsService) => {
    expect(service).toBeTruthy();
  }));
});
