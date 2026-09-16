import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PayableAncillaryComponent } from './payable-ancillary.component';

describe('PayableAncillaryComponent', () => {
  let component: PayableAncillaryComponent;
  let fixture: ComponentFixture<PayableAncillaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PayableAncillaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PayableAncillaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
