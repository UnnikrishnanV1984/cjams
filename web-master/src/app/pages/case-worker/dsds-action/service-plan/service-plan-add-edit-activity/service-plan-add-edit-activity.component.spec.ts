import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServicePlanAddEditActivityComponent } from './service-plan-add-edit-activity.component';

describe('ServicePlanAddEditActivityComponent', () => {
  let component: ServicePlanAddEditActivityComponent;
  let fixture: ComponentFixture<ServicePlanAddEditActivityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServicePlanAddEditActivityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServicePlanAddEditActivityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
