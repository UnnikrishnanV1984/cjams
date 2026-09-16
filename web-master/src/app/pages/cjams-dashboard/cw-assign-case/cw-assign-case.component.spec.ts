import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwAssignCaseComponent } from './cw-assign-case.component';

describe('CwAssignCaseComponent', () => {
  let component: CwAssignCaseComponent;
  let fixture: ComponentFixture<CwAssignCaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwAssignCaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwAssignCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
