import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralAssesmentsgridComponent } from './intake-referral-assesmentsgrid.component';

describe('IntakeReferralAssesmentsgridComponent', () => {
  let component: IntakeReferralAssesmentsgridComponent;
  let fixture: ComponentFixture<IntakeReferralAssesmentsgridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralAssesmentsgridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralAssesmentsgridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
