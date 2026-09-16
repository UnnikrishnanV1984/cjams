import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ExternalAssessmentComponent } from './external-assessment.component';

describe('ExternalAssessmentComponent', () => {
  let component: ExternalAssessmentComponent;
  let fixture: ComponentFixture<ExternalAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ExternalAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExternalAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
