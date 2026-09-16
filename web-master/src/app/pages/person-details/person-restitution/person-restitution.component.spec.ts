import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonRestitutionComponent } from './person-restitution.component';

describe('PersonRestitutionComponent', () => {
  let component: PersonRestitutionComponent;
  let fixture: ComponentFixture<PersonRestitutionComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonRestitutionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonRestitutionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
