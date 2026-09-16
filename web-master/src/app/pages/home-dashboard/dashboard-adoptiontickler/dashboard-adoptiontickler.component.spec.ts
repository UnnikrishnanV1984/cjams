import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashboardAdoptionticklerComponent } from './dashboard-adoptiontickler.component';

describe('DashboardAdoptionticklerComponent', () => {
  let component: DashboardAdoptionticklerComponent;
  let fixture: ComponentFixture<DashboardAdoptionticklerComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashboardAdoptionticklerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashboardAdoptionticklerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
