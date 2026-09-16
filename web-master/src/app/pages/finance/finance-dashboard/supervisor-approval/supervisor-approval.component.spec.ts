import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SupervisorApprovalComponent } from './supervisor-approval.component';

describe('SupervisorApprovalComponent', () => {
  let component: SupervisorApprovalComponent;
  let fixture: ComponentFixture<SupervisorApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SupervisorApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SupervisorApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
