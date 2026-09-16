import { TestBed, inject } from '@angular/core/testing';

import { CaseSearchService } from './case-search.service';

describe('CaseSearchService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CaseSearchService]
    });
  });

  it('should be created', inject([CaseSearchService], (service: CaseSearchService) => {
    expect(service).toBeTruthy();
  }));
});
