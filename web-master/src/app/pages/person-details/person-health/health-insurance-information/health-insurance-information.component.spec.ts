import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthInsuranceInformationComponent } from './health-insurance-information.component';

describe('HealthInsuranceInformationComponent', () => {
  let component: HealthInsuranceInformationComponent;
  let fixture: ComponentFixture<HealthInsuranceInformationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthInsuranceInformationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthInsuranceInformationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
