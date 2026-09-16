import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HealthInsuranceInformationCreateEditComponent } from './health-insurance-information-create-edit.component';

describe('HealthInsuranceInformationCreateEditComponent', () => {
  let component: HealthInsuranceInformationCreateEditComponent;
  let fixture: ComponentFixture<HealthInsuranceInformationCreateEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HealthInsuranceInformationCreateEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HealthInsuranceInformationCreateEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
