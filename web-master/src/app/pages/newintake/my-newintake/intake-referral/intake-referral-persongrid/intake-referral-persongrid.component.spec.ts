import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeReferralPersongridComponent } from './intake-referral-persongrid.component';

describe('IntakeReferralPersongridComponent', () => {
  let component: IntakeReferralPersongridComponent;
  let fixture: ComponentFixture<IntakeReferralPersongridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeReferralPersongridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeReferralPersongridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
