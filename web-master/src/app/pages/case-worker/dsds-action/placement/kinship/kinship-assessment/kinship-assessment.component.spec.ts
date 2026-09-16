import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { KinshipAssessmentComponent } from './kinship-assessment.component';

describe('KinshipAssessmentComponent', () => {
  let component: KinshipAssessmentComponent;
  let fixture: ComponentFixture<KinshipAssessmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ KinshipAssessmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(KinshipAssessmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
