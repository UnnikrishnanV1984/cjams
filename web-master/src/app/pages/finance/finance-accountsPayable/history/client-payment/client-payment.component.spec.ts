import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ClientPaymentComponent } from './client-payment.component';

describe('ClientPaymentComponent', () => {
  let component: ClientPaymentComponent;
  let fixture: ComponentFixture<ClientPaymentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ClientPaymentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
