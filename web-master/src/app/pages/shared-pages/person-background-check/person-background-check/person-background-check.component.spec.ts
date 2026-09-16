import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonBackgroundCheckComponent } from './person-background-check.component';

describe('PersonBackgroundCheckComponent', () => {
  let component: PersonBackgroundCheckComponent;
  let fixture: ComponentFixture<PersonBackgroundCheckComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonBackgroundCheckComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonBackgroundCheckComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
