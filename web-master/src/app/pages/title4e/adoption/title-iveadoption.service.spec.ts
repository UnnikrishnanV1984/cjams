import { TestBed, inject } from '@angular/core/testing';

import { TitleIveadoptionService } from './title-iveadoption.service';

describe('TitleIveadoptionService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TitleIveadoptionService]
    });
  });

  it('should be created', inject([TitleIveadoptionService], (service: TitleIveadoptionService) => {
    expect(service).toBeTruthy();
  }));
});
