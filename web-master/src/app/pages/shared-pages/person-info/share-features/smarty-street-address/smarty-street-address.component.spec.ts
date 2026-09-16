import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SmartyStreetAddressComponent } from './smarty-street-address.component';

describe('SmartyStreetAddressComponent', () => {
  let component: SmartyStreetAddressComponent;
  let fixture: ComponentFixture<SmartyStreetAddressComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SmartyStreetAddressComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SmartyStreetAddressComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
