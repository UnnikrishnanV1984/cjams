import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewAssessmentCansFSummaryComponent } from './view-assessment-cans-f-summary.component';

describe('ViewAssessmentCansFSummaryComponent', () => {
  let component: ViewAssessmentCansFSummaryComponent;
  let fixture: ComponentFixture<ViewAssessmentCansFSummaryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ViewAssessmentCansFSummaryComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ViewAssessmentCansFSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
}); 