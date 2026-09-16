import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardMyservicecaseComponent } from './dashboard-myservicecase.component';

describe('DashboardMyservicecaseComponent', () => {
  let component: DashboardMyservicecaseComponent;
  let fixture: ComponentFixture<DashboardMyservicecaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardMyservicecaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardMyservicecaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
