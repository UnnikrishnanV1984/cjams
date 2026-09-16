import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementReferralComponent } from './placement-referral.component';

describe('PlacementReferralComponent', () => {
  let component: PlacementReferralComponent;
  let fixture: ComponentFixture<PlacementReferralComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementReferralComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementReferralComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
