import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ReferredServicesComponent } from './referred-services.component';

describe('ReferredServicesComponent', () => {
  let component: ReferredServicesComponent;
  let fixture: ComponentFixture<ReferredServicesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ReferredServicesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ReferredServicesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
