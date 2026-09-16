import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionChildAssessmentComponent } from './adoption-child-assessment.component';

describe('AdoptionChildAssessmentComponent', () => {
  let component: AdoptionChildAssessmentComponent;
  let fixture: ComponentFixture<AdoptionChildAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionChildAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionChildAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
