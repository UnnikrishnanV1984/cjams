import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AssessmentLapComponent } from './assessment-lap.component';

describe('AssessmentLapComponent', () => {
  let component: AssessmentLapComponent;
  let fixture: ComponentFixture<AssessmentLapComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AssessmentLapComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AssessmentLapComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});