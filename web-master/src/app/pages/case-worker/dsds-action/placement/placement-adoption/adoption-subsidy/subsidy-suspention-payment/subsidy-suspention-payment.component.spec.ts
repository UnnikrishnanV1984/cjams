import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SubsidySuspentionPaymentComponent } from './subsidy-suspention-payment.component';

describe('SubsidySuspentionPaymentComponent', () => {
  let component: SubsidySuspentionPaymentComponent;
  let fixture: ComponentFixture<SubsidySuspentionPaymentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SubsidySuspentionPaymentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubsidySuspentionPaymentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
