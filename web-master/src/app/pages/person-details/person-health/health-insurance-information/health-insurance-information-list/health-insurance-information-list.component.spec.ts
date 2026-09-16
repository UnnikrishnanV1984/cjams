import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthInsuranceInformationListComponent } from './health-insurance-information-list.component';

describe('HealthInsuranceInformationListComponent', () => {
  let component: HealthInsuranceInformationListComponent;
  let fixture: ComponentFixture<HealthInsuranceInformationListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthInsuranceInformationListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthInsuranceInformationListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
