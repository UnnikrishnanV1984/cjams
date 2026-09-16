import { TestBed, inject } from '@angular/core/testing';
import { provideHttpClientTesting } from '@angular/common/http/testing';

import { HttpService } from './http.service';
import { AlertService } from './alert.service';
import { RouterTestingModule } from '@angular/router/testing';
import { config } from '../../../environments/config';
import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';

fdescribe('HttpService against STATE environment configuration', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
    imports: [RouterTestingModule],
    providers: [HttpService, AlertService, provideHttpClient(withInterceptorsFromDi()), provideHttpClientTesting()]
});
    //TO DO: make environment variables an injectable service 
    config.workEnvironment = 'state';
  });
  afterEach(() => {
    //clean up: TO DO make environment variables an injectable service 
    config.workEnvironment = 'local';
  });

  it('should be created', inject([HttpService], (service: HttpService) => {
    expect(service).toBeTruthy();
  }));

});
