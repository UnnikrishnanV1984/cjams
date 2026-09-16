import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ClientPaymentResultComponent } from './client-payment-result.component';

describe('ClientPaymentResultComponent', () => {
  let component: ClientPaymentResultComponent;
  let fixture: ComponentFixture<ClientPaymentResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ClientPaymentResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientPaymentResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
