import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { EmploymentProfileComponent } from './employment-profile.component';

describe('EmploymentProfileComponent', () => {
  let component: EmploymentProfileComponent;
  let fixture: ComponentFixture<EmploymentProfileComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ EmploymentProfileComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(EmploymentProfileComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
