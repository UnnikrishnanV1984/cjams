import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CommingledTransactionApprovalComponent } from './commingled-transaction-approval.component';

describe('CommingledTransactionApprovalComponent', () => {
  let component: CommingledTransactionApprovalComponent;
  let fixture: ComponentFixture<CommingledTransactionApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CommingledTransactionApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CommingledTransactionApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
