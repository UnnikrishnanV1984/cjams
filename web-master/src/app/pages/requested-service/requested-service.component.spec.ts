import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RequestedServiceComponent } from './requested-service.component';

describe('RequestedServiceComponent', () => {
  let component: RequestedServiceComponent;
  let fixture: ComponentFixture<RequestedServiceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ RequestedServiceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RequestedServiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
