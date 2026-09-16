import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AsInvestigationPlanComponent } from './as-investigation-plan.component';

describe('AsInvestigationPlanComponent', () => {
  let component: AsInvestigationPlanComponent;
  let fixture: ComponentFixture<AsInvestigationPlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AsInvestigationPlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AsInvestigationPlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
