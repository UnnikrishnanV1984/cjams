import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { OutOfHomePlacementComponent } from './out-of-home-placement.component';

describe('OutOfHomePlacementComponent', () => {
  let component: OutOfHomePlacementComponent;
  let fixture: ComponentFixture<OutOfHomePlacementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ OutOfHomePlacementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(OutOfHomePlacementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
