import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementAddressInfoComponent } from './placement-address-info.component';

describe('PlacementAddressInfoComponent', () => {
  let component: PlacementAddressInfoComponent;
  let fixture: ComponentFixture<PlacementAddressInfoComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementAddressInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementAddressInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
