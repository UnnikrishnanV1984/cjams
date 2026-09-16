import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { HistoryOfAbuseComponent } from './history-of-abuse.component';

describe('HistoryOfAbuseComponent', () => {
  let component: HistoryOfAbuseComponent;
  let fixture: ComponentFixture<HistoryOfAbuseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ HistoryOfAbuseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HistoryOfAbuseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
