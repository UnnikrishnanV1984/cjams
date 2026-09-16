import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { VendorPayFileCalendarComponent } from './vendor-pay-file-calendar.component';

describe('VendorPayFileCalendarComponent', () => {
  let component: VendorPayFileCalendarComponent;
  let fixture: ComponentFixture<VendorPayFileCalendarComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ VendorPayFileCalendarComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VendorPayFileCalendarComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
