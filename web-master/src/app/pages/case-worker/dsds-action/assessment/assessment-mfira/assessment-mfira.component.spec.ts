import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AssessmentMfiraComponent } from './assessment-mfira.component';

describe('AssessmentMfiraComponent', () => {
  let component: AssessmentMfiraComponent;
  let fixture: ComponentFixture<AssessmentMfiraComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AssessmentMfiraComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentMfiraComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
