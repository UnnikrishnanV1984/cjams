import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AssessmentCansFComponent } from './assessment-cans-f.component';

describe('AssessmentCansFComponent', () => {
  let component: AssessmentCansFComponent;
  let fixture: ComponentFixture<AssessmentCansFComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AssessmentCansFComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentCansFComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
