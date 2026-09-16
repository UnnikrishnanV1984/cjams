import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LifeSkillsAssessmentComponent } from './life-skills-assessment.component';

describe('LifeSkillsAssessmentComponent', () => {
  let component: LifeSkillsAssessmentComponent;
  let fixture: ComponentFixture<LifeSkillsAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LifeSkillsAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LifeSkillsAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
