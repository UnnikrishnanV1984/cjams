import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServicePlanActivityComponent } from './service-plan-activity.component';

describe('ServicePlanActivityComponent', () => {
  let component: ServicePlanActivityComponent;
  let fixture: ComponentFixture<ServicePlanActivityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServicePlanActivityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServicePlanActivityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
