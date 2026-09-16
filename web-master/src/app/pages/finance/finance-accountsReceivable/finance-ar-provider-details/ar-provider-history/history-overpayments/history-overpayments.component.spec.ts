import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HistoryOverpaymentsComponent } from './history-overpayments.component';

describe('HistoryOverpaymentsComponent', () => {
  let component: HistoryOverpaymentsComponent;
  let fixture: ComponentFixture<HistoryOverpaymentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HistoryOverpaymentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HistoryOverpaymentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
