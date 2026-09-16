import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SafetyPlanPrintViewComponent } from './safety-plan-print-view.component';

describe('SafetyPlanPrintViewComponent', () => {
  let component: SafetyPlanPrintViewComponent;
  let fixture: ComponentFixture<SafetyPlanPrintViewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SafetyPlanPrintViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SafetyPlanPrintViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
