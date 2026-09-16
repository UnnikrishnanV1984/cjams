import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { NoticePreintakeLetterComponent } from './notice-preintake-letter.component';

describe('NoticePreintakeLetterComponent', () => {
  let component: NoticePreintakeLetterComponent;
  let fixture: ComponentFixture<NoticePreintakeLetterComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ NoticePreintakeLetterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NoticePreintakeLetterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
