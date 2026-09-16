import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardChecklistNotificationComponent } from './dashboard-checklist-notification.component';

describe('DashboardChecklistNotificationComponent', () => {
  let component: DashboardChecklistNotificationComponent;
  let fixture: ComponentFixture<DashboardChecklistNotificationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardChecklistNotificationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardChecklistNotificationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
