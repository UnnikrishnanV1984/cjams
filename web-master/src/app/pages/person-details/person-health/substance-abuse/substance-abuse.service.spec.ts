import { TestBed, inject } from '@angular/core/testing';

import { SubstanceAbuseService } from './substance-abuse.service';

describe('SubstanceAbuseService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SubstanceAbuseService]
    });
  });

  it('should be created', inject([SubstanceAbuseService], (service: SubstanceAbuseService) => {
    expect(service).toBeTruthy();
  }));
});
