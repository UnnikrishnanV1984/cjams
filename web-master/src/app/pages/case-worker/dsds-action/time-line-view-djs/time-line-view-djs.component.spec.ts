import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { TimeLineViewDjsComponent } from './time-line-view-djs.component';

describe('TimeLineViewDjsComponent', () => {
  let component: TimeLineViewDjsComponent;
  let fixture: ComponentFixture<TimeLineViewDjsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ TimeLineViewDjsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TimeLineViewDjsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
