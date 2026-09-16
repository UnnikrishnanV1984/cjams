import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { Dashboard4eComponent } from './dashboard4e.component';

describe('Dashboard4eComponent', () => {
  let component: Dashboard4eComponent;
  let fixture: ComponentFixture<Dashboard4eComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ Dashboard4eComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Dashboard4eComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
