import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AcknowledgementLetterComponent } from './acknowledgement-letter.component';

describe('AcknowledgementLetterComponent', () => {
  let component: AcknowledgementLetterComponent;
  let fixture: ComponentFixture<AcknowledgementLetterComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AcknowledgementLetterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AcknowledgementLetterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
