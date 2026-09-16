import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AssessmentCansOutComponent } from './assessment-cans-out.component';

describe('AssessmentCansOutComponent', () => {
  let component: AssessmentCansOutComponent;
  let fixture: ComponentFixture<AssessmentCansOutComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AssessmentCansOutComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentCansOutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
