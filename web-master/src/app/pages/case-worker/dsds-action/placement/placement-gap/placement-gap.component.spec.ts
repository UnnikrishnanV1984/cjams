import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementGapComponent } from './placement-gap.component';

describe('PlacementGapComponent', () => {
  let component: PlacementGapComponent;
  let fixture: ComponentFixture<PlacementGapComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementGapComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementGapComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
