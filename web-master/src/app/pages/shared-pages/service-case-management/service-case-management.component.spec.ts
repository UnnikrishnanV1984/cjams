import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceCaseManagementComponent } from './service-case-management.component';

describe('ServiceCaseManagementComponent', () => {
  let component: ServiceCaseManagementComponent;
  let fixture: ComponentFixture<ServiceCaseManagementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceCaseManagementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceCaseManagementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
