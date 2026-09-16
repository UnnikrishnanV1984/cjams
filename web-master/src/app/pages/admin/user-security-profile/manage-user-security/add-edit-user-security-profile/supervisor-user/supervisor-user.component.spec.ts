import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SupervisorUserComponent } from './supervisor-user.component';

describe('SupervisorUserComponent', () => {
  let component: SupervisorUserComponent;
  let fixture: ComponentFixture<SupervisorUserComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SupervisorUserComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SupervisorUserComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
