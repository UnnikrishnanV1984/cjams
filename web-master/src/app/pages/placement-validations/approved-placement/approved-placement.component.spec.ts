import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApprovedPlacementComponent } from './approved-placement.component';

describe('ApprovedPlacementComponent', () => {
  let component: ApprovedPlacementComponent;
  let fixture: ComponentFixture<ApprovedPlacementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApprovedPlacementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApprovedPlacementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
