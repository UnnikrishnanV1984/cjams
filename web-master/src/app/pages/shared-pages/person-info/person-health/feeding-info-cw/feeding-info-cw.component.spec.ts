import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FeedingInfoCwComponent } from './feeding-info-cw.component';

describe('FeedingInfoCwComponent', () => {
  let component: FeedingInfoCwComponent;
  let fixture: ComponentFixture<FeedingInfoCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FeedingInfoCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FeedingInfoCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
