import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ServiceAgreementComponent } from './service-agreement.component';

describe('ServiceAgreementComponent', () => {
  let component: ServiceAgreementComponent;
  let fixture: ComponentFixture<ServiceAgreementComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ServiceAgreementComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ServiceAgreementComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
