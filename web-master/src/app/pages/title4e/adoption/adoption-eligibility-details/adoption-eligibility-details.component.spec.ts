import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionEligibilityDetailsComponent } from './adoption-eligibility-details.component';

describe('AdoptionEligibilityDetailsComponent', () => {
  let component: AdoptionEligibilityDetailsComponent;
  let fixture: ComponentFixture<AdoptionEligibilityDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionEligibilityDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionEligibilityDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
