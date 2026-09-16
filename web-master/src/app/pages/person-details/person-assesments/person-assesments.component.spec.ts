import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonAssesmentsComponent } from './person-assesments.component';

describe('PersonAssesmentsComponent', () => {
  let component: PersonAssesmentsComponent;
  let fixture: ComponentFixture<PersonAssesmentsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonAssesmentsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonAssesmentsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
