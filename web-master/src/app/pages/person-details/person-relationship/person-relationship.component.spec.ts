import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonRelationshipComponent } from './person-relationship.component';

describe('PersonRelationshipComponent', () => {
  let component: PersonRelationshipComponent;
  let fixture: ComponentFixture<PersonRelationshipComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonRelationshipComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonRelationshipComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
