import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArReversalReceiptComponent } from './ar-reversal-receipt.component';

describe('ArReversalReceiptComponent', () => {
  let component: ArReversalReceiptComponent;
  let fixture: ComponentFixture<ArReversalReceiptComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArReversalReceiptComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArReversalReceiptComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
