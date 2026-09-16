import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PermanencyPlanFormComponent } from './permanency-plan-form.component';

describe('PermanencyPlanFormComponent', () => {
  let component: PermanencyPlanFormComponent;
  let fixture: ComponentFixture<PermanencyPlanFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PermanencyPlanFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PermanencyPlanFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
