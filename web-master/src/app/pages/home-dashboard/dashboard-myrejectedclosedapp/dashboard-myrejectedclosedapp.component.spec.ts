import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardMyrejectedclosedappComponent } from './dashboard-myrejectedclosedapp.component';

describe('DashboardMyrejectedclosedappComponent', () => {
  let component: DashboardMyrejectedclosedappComponent;
  let fixture: ComponentFixture<DashboardMyrejectedclosedappComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardMyrejectedclosedappComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardMyrejectedclosedappComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
