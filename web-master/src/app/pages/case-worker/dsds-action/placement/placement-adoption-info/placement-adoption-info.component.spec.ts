import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementAdoptionInfoComponent } from './placement-adoption-info.component';

describe('PlacementAdoptionInfoComponent', () => {
  let component: PlacementAdoptionInfoComponent;
  let fixture: ComponentFixture<PlacementAdoptionInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementAdoptionInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementAdoptionInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
