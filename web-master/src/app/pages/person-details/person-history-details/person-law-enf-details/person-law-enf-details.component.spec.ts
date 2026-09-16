import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonLawEnfDetailsComponent } from './person-law-enf-details.component';

describe('PersonLawEnfDetailsComponent', () => {
  let component: PersonLawEnfDetailsComponent;
  let fixture: ComponentFixture<PersonLawEnfDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonLawEnfDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonLawEnfDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
