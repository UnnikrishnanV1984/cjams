import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralCasegridComponent } from './intake-referral-casegrid.component';

describe('IntakeReferralCasegridComponent', () => {
  let component: IntakeReferralCasegridComponent;
  let fixture: ComponentFixture<IntakeReferralCasegridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralCasegridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralCasegridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
