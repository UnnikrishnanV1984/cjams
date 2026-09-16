import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementAdoptionComponent } from './placement-adoption.component';

describe('PlacementAdoptionComponent', () => {
  let component: PlacementAdoptionComponent;
  let fixture: ComponentFixture<PlacementAdoptionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementAdoptionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementAdoptionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
