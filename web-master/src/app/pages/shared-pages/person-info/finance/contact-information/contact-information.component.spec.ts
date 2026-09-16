import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ContactInformation } from './contact-information.component';

describe('ContactInformation', () => {
  let component: ContactInformation;
  let fixture: ComponentFixture<ContactInformation>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ContactInformation ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContactInformation);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
