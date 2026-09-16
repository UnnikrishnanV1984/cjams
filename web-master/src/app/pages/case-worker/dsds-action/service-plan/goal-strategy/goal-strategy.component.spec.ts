import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { GoalStrategyComponent } from './goal-strategy.component';

describe('GoalStrategyComponent', () => {
  let component: GoalStrategyComponent;
  let fixture: ComponentFixture<GoalStrategyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ GoalStrategyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(GoalStrategyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
