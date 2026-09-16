import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceLogActivityComponent } from './service-log-activity.component';

describe('ServiceLogActivityComponent', () => {
  let component: ServiceLogActivityComponent;
  let fixture: ComponentFixture<ServiceLogActivityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceLogActivityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceLogActivityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
