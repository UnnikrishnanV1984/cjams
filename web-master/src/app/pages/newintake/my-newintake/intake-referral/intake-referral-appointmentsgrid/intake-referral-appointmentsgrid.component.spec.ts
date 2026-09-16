import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralAppointmentsgridComponent } from './intake-referral-appointmentsgrid.component';

describe('IntakeReferralAppointmentsgridComponent', () => {
  let component: IntakeReferralAppointmentsgridComponent;
  let fixture: ComponentFixture<IntakeReferralAppointmentsgridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralAppointmentsgridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralAppointmentsgridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
