import { TestBed, inject } from '@angular/core/testing';

import { ArProviderHistoryService } from './ar-provider-history.service';

describe('ArProviderHistoryService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ArProviderHistoryService]
    });
  });

  it('should be created', inject([ArProviderHistoryService], (service: ArProviderHistoryService) => {
    expect(service).toBeTruthy();
  }));
});
