import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PendingPlacementComponent } from './pending-placement.component';

describe('PendingPlacementComponent', () => {
  let component: PendingPlacementComponent;
  let fixture: ComponentFixture<PendingPlacementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PendingPlacementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PendingPlacementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
