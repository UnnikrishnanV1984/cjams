import { TestBed, inject } from '@angular/core/testing';

import { Title4eFosterCareService } from './title4e-foster-care.service';

describe('Title4eFosterCareService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [Title4eFosterCareService]
    });
  });

  it('should be created', inject([Title4eFosterCareService], (service: Title4eFosterCareService) => {
    expect(service).toBeTruthy();
  }));
});
