import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceCasePermanencyPlanComponent } from './service-case-permanency-plan.component';

describe('ServiceCasePermanencyPlanComponent', () => {
  let component: ServiceCasePermanencyPlanComponent;
  let fixture: ComponentFixture<ServiceCasePermanencyPlanComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceCasePermanencyPlanComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceCasePermanencyPlanComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
