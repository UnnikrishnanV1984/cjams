import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralComplaintsgridComponent } from './intake-referral-complaintsgrid.component';

describe('IntakeReferralComplaintsgridComponent', () => {
  let component: IntakeReferralComplaintsgridComponent;
  let fixture: ComponentFixture<IntakeReferralComplaintsgridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralComplaintsgridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralComplaintsgridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
