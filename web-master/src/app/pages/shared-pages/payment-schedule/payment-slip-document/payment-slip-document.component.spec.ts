import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PaymentSlipDocumentComponent } from './payment-slip-document.component';

describe('PaymentSlipDocumentComponent', () => {
  let component: PaymentSlipDocumentComponent;
  let fixture: ComponentFixture<PaymentSlipDocumentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PaymentSlipDocumentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PaymentSlipDocumentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
