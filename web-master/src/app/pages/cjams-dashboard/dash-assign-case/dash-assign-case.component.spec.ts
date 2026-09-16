import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DashAssignCaseComponent } from './dash-assign-case.component';

describe('DashAssignCaseComponent', () => {
  let component: DashAssignCaseComponent;
  let fixture: ComponentFixture<DashAssignCaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DashAssignCaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DashAssignCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
