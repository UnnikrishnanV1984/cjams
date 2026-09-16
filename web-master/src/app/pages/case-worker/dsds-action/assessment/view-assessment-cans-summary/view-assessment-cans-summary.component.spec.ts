import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewAssessmentCansSummaryComponent } from './view-assessment-cans-summary.component';

describe('ViewAssessmentCansSummaryComponent', () => {
  let component: ViewAssessmentCansSummaryComponent;
  let fixture: ComponentFixture<ViewAssessmentCansSummaryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ViewAssessmentCansSummaryComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ViewAssessmentCansSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
