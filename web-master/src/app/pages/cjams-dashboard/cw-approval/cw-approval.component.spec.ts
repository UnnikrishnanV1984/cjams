import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwApprovalComponent } from './cw-approval.component';

describe('CwApprovalComponent', () => {
  let component: CwApprovalComponent;
  let fixture: ComponentFixture<CwApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
