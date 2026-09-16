import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwAssignmentsComponent } from './cw-assignments.component';

describe('CwAssignmentsComponent', () => {
  let component: CwAssignmentsComponent;
  let fixture: ComponentFixture<CwAssignmentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwAssignmentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwAssignmentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
