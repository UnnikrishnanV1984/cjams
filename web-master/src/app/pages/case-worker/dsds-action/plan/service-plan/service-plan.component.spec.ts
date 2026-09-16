import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServicePlanComponent } from './service-plan.component';

describe('ServicePlanComponent', () => {
  let component: ServicePlanComponent;
  let fixture: ComponentFixture<ServicePlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServicePlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServicePlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
