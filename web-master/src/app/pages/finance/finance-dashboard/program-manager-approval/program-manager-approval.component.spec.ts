import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ProgramManagerApprovalComponent } from './program-manager-approval.component';

describe('ProgramManagerApprovalComponent', () => {
  let component: ProgramManagerApprovalComponent;
  let fixture: ComponentFixture<ProgramManagerApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ProgramManagerApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProgramManagerApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
