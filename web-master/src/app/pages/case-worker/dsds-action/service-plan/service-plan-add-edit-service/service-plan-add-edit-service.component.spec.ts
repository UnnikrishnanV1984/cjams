import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServicePlanAddEditServiceComponent } from './service-plan-add-edit-service.component';

describe('ServicePlanAddEditServiceComponent', () => {
  let component: ServicePlanAddEditServiceComponent;
  let fixture: ComponentFixture<ServicePlanAddEditServiceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServicePlanAddEditServiceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServicePlanAddEditServiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
