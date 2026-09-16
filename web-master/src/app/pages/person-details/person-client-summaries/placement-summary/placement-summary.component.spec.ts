import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementSummaryComponent } from './placement-summary.component';

describe('PlacementSummaryComponent', () => {
  let component: PlacementSummaryComponent;
  let fixture: ComponentFixture<PlacementSummaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementSummaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementSummaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
