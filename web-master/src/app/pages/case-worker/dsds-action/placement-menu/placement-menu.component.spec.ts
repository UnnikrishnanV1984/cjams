import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementMenuComponent } from './placement-menu.component';

describe('PlacementMenuComponent', () => {
  let component: PlacementMenuComponent;
  let fixture: ComponentFixture<PlacementMenuComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementMenuComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementMenuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
