import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PeriodTablePopUpComponent } from './period-table-pop-up.component';

describe('PeriodTablePopUpComponent', () => {
  let component: PeriodTablePopUpComponent;
  let fixture: ComponentFixture<PeriodTablePopUpComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PeriodTablePopUpComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PeriodTablePopUpComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
