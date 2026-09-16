import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementValidationsComponent } from './placement-validations.component';

describe('PlacementValidationsComponent', () => {
  let component: PlacementValidationsComponent;
  let fixture: ComponentFixture<PlacementValidationsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementValidationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementValidationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
