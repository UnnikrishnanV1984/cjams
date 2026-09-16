/* tslint:disable:no-unused-variable */
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardLDSSMyinquiriesComponent } from './dashboard-ldss-myinquiries.component';

describe('DashboardLDSSMyinquiriesComponent', () => {
  let component: DashboardLDSSMyinquiriesComponent;
  let fixture: ComponentFixture<DashboardLDSSMyinquiriesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardLDSSMyinquiriesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardLDSSMyinquiriesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
