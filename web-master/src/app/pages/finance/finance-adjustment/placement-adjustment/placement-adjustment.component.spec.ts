import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementAdjustmentComponent } from './placement-adjustment.component';

describe('PlacementAdjustmentComponent', () => {
  let component: PlacementAdjustmentComponent;
  let fixture: ComponentFixture<PlacementAdjustmentComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementAdjustmentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementAdjustmentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
