import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwAssessmentComponent } from './cw-assessment.component';

describe('CwAssessmentComponent', () => {
  let component: CwAssessmentComponent;
  let fixture: ComponentFixture<CwAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
