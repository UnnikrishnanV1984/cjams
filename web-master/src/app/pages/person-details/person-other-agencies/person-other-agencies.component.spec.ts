import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonOtherAgenciesComponent } from './person-other-agencies.component';

describe('PersonOtherAgenciesComponent', () => {
  let component: PersonOtherAgenciesComponent;
  let fixture: ComponentFixture<PersonOtherAgenciesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonOtherAgenciesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonOtherAgenciesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
