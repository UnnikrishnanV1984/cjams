import { TestBed, inject } from '@angular/core/testing';

import { MilitaryService } from './military.service';

describe('MilitaryService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [MilitaryService]
    });
  });

  it('should be created', inject([MilitaryService], (service: MilitaryService) => {
    expect(service).toBeTruthy();
  }));
});
