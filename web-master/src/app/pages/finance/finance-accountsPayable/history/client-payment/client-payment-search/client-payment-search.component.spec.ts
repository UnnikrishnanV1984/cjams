import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ClientPaymentSearchComponent } from './client-payment-search.component';

describe('ClientPaymentSearchComponent', () => {
  let component: ClientPaymentSearchComponent;
  let fixture: ComponentFixture<ClientPaymentSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ClientPaymentSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClientPaymentSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
