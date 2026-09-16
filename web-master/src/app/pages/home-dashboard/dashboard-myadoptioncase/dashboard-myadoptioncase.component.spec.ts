import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardMyadoptioncaseComponent } from './dashboard-myadoptioncase.component';

describe('DashboardMyadoptioncaseComponent', () => {
  let component: DashboardMyadoptioncaseComponent;
  let fixture: ComponentFixture<DashboardMyadoptioncaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardMyadoptioncaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardMyadoptioncaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
