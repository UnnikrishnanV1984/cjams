import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonNamesRelationsComponent } from './person-names-relations.component';

describe('PersonNamesRelationsComponent', () => {
  let component: PersonNamesRelationsComponent;
  let fixture: ComponentFixture<PersonNamesRelationsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonNamesRelationsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonNamesRelationsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
