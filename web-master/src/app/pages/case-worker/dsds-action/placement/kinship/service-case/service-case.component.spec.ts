import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceCaseComponent } from './service-case.component';

describe('ServiceCaseComponent', () => {
  let component: ServiceCaseComponent;
  let fixture: ComponentFixture<ServiceCaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceCaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
