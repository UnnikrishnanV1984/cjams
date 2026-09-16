import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementBreakthelineComponent } from './placement-breaktheline.component';

describe('PlacementBreakthelineComponent', () => {
  let component: PlacementBreakthelineComponent;
  let fixture: ComponentFixture<PlacementBreakthelineComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementBreakthelineComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementBreakthelineComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
