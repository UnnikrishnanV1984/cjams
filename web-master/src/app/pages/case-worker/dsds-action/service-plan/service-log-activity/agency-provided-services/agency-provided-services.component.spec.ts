import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AgencyProvidedServicesComponent } from './agency-provided-services.component';

describe('AgencyProvidedServicesComponent', () => {
  let component: AgencyProvidedServicesComponent;
  let fixture: ComponentFixture<AgencyProvidedServicesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AgencyProvidedServicesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AgencyProvidedServicesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
