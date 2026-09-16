import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonDisabilityComponent } from './person-disability.component';

describe('PersonDisabilityComponent', () => {
  let component: PersonDisabilityComponent;
  let fixture: ComponentFixture<PersonDisabilityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonDisabilityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonDisabilityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
