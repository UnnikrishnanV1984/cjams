import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAddressDetailsComponent } from './person-address-details.component';

describe('PersonAddressDetailsComponent', () => {
  let component: PersonAddressDetailsComponent;
  let fixture: ComponentFixture<PersonAddressDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAddressDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAddressDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
