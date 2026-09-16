import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardGapticklerComponent } from './dashboard-gaptickler.component';

describe('DashboardGapticklerComponent', () => {
  let component: DashboardGapticklerComponent;
  let fixture: ComponentFixture<DashboardGapticklerComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardGapticklerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardGapticklerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
