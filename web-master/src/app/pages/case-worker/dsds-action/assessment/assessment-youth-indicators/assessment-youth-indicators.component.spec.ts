import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssessmentYouthIndicatorsComponent } from './assessment-youth-indicators.component';

describe('AssessmentYouthIndicatorsComponent', () => {
  let component: AssessmentYouthIndicatorsComponent;
  let fixture: ComponentFixture<AssessmentYouthIndicatorsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AssessmentYouthIndicatorsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentYouthIndicatorsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
