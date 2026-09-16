import { TestBed, inject } from '@angular/core/testing';

import { Title4eService } from './title4e.service';

describe('Title4eService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [Title4eService]
    });
  });

  it('should be created', inject([Title4eService], (service: Title4eService) => {
    expect(service).toBeTruthy();
  }));
});
