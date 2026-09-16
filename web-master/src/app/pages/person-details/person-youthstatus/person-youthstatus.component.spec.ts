import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonYouthstatusComponent } from './person-youthstatus.component';

describe('PersonYouthstatusComponent', () => {
  let component: PersonYouthstatusComponent;
  let fixture: ComponentFixture<PersonYouthstatusComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonYouthstatusComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonYouthstatusComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
