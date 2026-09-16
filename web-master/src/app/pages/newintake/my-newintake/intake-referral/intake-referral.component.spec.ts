import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralComponent } from './intake-referral.component';

describe('IntakeReferralComponent', () => {
  let component: IntakeReferralComponent;
  let fixture: ComponentFixture<IntakeReferralComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
