import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { OffsetReceiptComponent } from './offset-receipt.component';

describe('OffsetReceiptComponent', () => {
  let component: OffsetReceiptComponent;
  let fixture: ComponentFixture<OffsetReceiptComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ OffsetReceiptComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OffsetReceiptComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
