import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ReceiptFastEntryComponent } from './receipt-fast-entry.component';

describe('ReceiptFastEntryComponent', () => {
  let component: ReceiptFastEntryComponent;
  let fixture: ComponentFixture<ReceiptFastEntryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ReceiptFastEntryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ReceiptFastEntryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
