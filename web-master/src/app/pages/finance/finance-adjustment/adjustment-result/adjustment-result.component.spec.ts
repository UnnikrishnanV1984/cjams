import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdjustmentResultComponent } from './adjustment-result.component';

describe('AdjustmentResultComponent', () => {
  let component: AdjustmentResultComponent;
  let fixture: ComponentFixture<AdjustmentResultComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdjustmentResultComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdjustmentResultComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
