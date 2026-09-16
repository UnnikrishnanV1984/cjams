import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonProbationComponent } from './person-probation.component';

describe('PersonProbationComponent', () => {
  let component: PersonProbationComponent;
  let fixture: ComponentFixture<PersonProbationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonProbationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonProbationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
