import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAlsoKnownAsComponent } from './person-also-known-as.component';

describe('PersonAlsoKnownAsComponent', () => {
  let component: PersonAlsoKnownAsComponent;
  let fixture: ComponentFixture<PersonAlsoKnownAsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAlsoKnownAsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAlsoKnownAsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
