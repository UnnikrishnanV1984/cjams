import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SafetyPlanHistoryComponent } from './safety-plan-history.component';

describe('SafetyPlanHistoryComponent', () => {
  let component: SafetyPlanHistoryComponent;
  let fixture: ComponentFixture<SafetyPlanHistoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SafetyPlanHistoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SafetyPlanHistoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
