import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CommonDatePickerComponent } from './common-date-picker.component';

describe('CommonDatePickerComponent', () => {
  let component: CommonDatePickerComponent;
  let fixture: ComponentFixture<CommonDatePickerComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CommonDatePickerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CommonDatePickerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
