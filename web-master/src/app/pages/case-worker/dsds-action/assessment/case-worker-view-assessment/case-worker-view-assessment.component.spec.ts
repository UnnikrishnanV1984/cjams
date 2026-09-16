import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseWorkerViewAssessmentComponent } from './case-worker-view-assessment.component';

describe('CaseWorkerViewAssessmentComponent', () => {
  let component: CaseWorkerViewAssessmentComponent;
  let fixture: ComponentFixture<CaseWorkerViewAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseWorkerViewAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseWorkerViewAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
