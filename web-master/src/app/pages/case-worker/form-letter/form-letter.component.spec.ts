import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FormLetterComponent } from './form-letter.component';

describe('FormLetterComponent', () => {
  let component: FormLetterComponent;
  let fixture: ComponentFixture<FormLetterComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FormLetterComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FormLetterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
