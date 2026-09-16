import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonEducationDetailsComponent } from './person-education-details.component';

describe('PersonEducationDetailsComponent', () => {
  let component: PersonEducationDetailsComponent;
  let fixture: ComponentFixture<PersonEducationDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonEducationDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonEducationDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
