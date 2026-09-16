import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ScPlacementGapComponent } from './sc-placement-gap.component';

describe('ScPlacementGapComponent', () => {
  let component: ScPlacementGapComponent;
  let fixture: ComponentFixture<ScPlacementGapComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ScPlacementGapComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ScPlacementGapComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
