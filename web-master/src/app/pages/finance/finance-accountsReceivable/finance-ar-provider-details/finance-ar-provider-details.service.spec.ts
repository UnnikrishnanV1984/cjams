import { TestBed, inject } from '@angular/core/testing';

import { FinanceArProviderDetailsService } from './finance-ar-provider-details.service';

describe('FinanceArProviderDetailsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [FinanceArProviderDetailsService]
    });
  });

  it('should be created', inject([FinanceArProviderDetailsService], (service: FinanceArProviderDetailsService) => {
    expect(service).toBeTruthy();
  }));
});
