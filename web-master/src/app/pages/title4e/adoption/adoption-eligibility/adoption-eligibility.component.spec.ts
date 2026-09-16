import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionEligibilityComponent } from './adoption-eligibility.component';

describe('AdoptionEligibilityComponent', () => {
  let component: AdoptionEligibilityComponent;
  let fixture: ComponentFixture<AdoptionEligibilityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionEligibilityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionEligibilityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
