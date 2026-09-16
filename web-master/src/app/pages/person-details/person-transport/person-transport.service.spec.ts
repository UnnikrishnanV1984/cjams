import { TestBed, inject } from '@angular/core/testing';

import { PersonTransportService } from './person-transport.service';

describe('PersonTransportService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonTransportService]
    });
  });

  it('should be created', inject([PersonTransportService], (service: PersonTransportService) => {
    expect(service).toBeTruthy();
  }));
});
