import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeDecisionComponent } from './intake-decision.component';

describe('IntakeDecisionComponent', () => {
  let component: IntakeDecisionComponent;
  let fixture: ComponentFixture<IntakeDecisionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeDecisionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeDecisionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
