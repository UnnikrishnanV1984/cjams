import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InvolvedPersonViewAddressInformationComponent } from './involved-person-view-address-information.component';

describe('InvolvedPersonViewAddressInformationComponent', () => {
  let component: InvolvedPersonViewAddressInformationComponent;
  let fixture: ComponentFixture<InvolvedPersonViewAddressInformationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InvolvedPersonViewAddressInformationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InvolvedPersonViewAddressInformationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
