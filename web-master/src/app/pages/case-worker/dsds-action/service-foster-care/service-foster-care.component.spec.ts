import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceFosterCareComponent } from './service-foster-care.component';

describe('ServiceFosterCareComponent', () => {
  let component: ServiceFosterCareComponent;
  let fixture: ComponentFixture<ServiceFosterCareComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceFosterCareComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceFosterCareComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
