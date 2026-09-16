import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwAssignServiceCaseComponent } from './cw-assign-service-case.component';

describe('CwAssignServiceCaseComponent', () => {
  let component: CwAssignServiceCaseComponent;
  let fixture: ComponentFixture<CwAssignServiceCaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwAssignServiceCaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwAssignServiceCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
