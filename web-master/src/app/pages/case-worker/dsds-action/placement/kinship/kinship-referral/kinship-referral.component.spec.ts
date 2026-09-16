import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { KinshipReferralComponent } from './kinship-referral.component';

describe('KinshipReferralComponent', () => {
  let component: KinshipReferralComponent;
  let fixture: ComponentFixture<KinshipReferralComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ KinshipReferralComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(KinshipReferralComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
