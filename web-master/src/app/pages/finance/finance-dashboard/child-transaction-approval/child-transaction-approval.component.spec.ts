import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildTransactionApprovalComponent } from './child-transaction-approval.component';

describe('ChildTransactionApprovalComponent', () => {
  let component: ChildTransactionApprovalComponent;
  let fixture: ComponentFixture<ChildTransactionApprovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildTransactionApprovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildTransactionApprovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
