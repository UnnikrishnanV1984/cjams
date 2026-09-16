import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionApplicabilityDecisionComponent } from './adoption-applicability-decision.component';

describe('AdoptionApplicabilityDecisionComponent', () => {
  let component: AdoptionApplicabilityDecisionComponent;
  let fixture: ComponentFixture<AdoptionApplicabilityDecisionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionApplicabilityDecisionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionApplicabilityDecisionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
