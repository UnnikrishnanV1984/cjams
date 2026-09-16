import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardMytodoComponent } from './dashboard-mytodo.component';

describe('DashboardMytodoComponent', () => {
  let component: DashboardMytodoComponent;
  let fixture: ComponentFixture<DashboardMytodoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardMytodoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardMytodoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
