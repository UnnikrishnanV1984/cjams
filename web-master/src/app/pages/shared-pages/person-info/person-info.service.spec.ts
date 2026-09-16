import { TestBed, inject } from '@angular/core/testing';

import { PersonInfoService } from './person-info.service';

describe('PersonInfoService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonInfoService]
    });
  });

  it('should be created', inject([PersonInfoService], (service: PersonInfoService) => {
    expect(service).toBeTruthy();
  }));
});
