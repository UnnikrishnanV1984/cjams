import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ExitPlacementsComponent } from './exit-placements.component';

describe('ExitPlacementsComponent', () => {
  let component: ExitPlacementsComponent;
  let fixture: ComponentFixture<ExitPlacementsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ExitPlacementsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExitPlacementsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
