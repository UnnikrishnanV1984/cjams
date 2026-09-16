import { TestBed, inject } from '@angular/core/testing';

import { CompliantDetailsResolverService } from './compliant-details-resolver.service';

describe('CompliantDetailsResolverService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [CompliantDetailsResolverService]
    });
  });

  it('should be created', inject([CompliantDetailsResolverService], (service: CompliantDetailsResolverService) => {
    expect(service).toBeTruthy();
  }));
});
