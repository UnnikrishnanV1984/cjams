import { TestBed, inject } from '@angular/core/testing';

import { PersonAlertsService } from './person-alerts.service';

describe('PersonAlertsService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [PersonAlertsService]
    });
  });

  it('should be created', inject([PersonAlertsService], (service: PersonAlertsService) => {
    expect(service).toBeTruthy();
  }));
});
