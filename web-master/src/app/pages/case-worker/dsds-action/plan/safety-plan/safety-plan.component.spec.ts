import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SafetyPlanComponent } from './safety-plan.component';

describe('SafetyPlanComponent', () => {
  let component: SafetyPlanComponent;
  let fixture: ComponentFixture<SafetyPlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SafetyPlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SafetyPlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
