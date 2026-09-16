import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardTeamperformanceComponent } from './dashboard-teamperformance.component';

describe('DashboardTeamperformanceComponent', () => {
  let component: DashboardTeamperformanceComponent;
  let fixture: ComponentFixture<DashboardTeamperformanceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardTeamperformanceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardTeamperformanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
