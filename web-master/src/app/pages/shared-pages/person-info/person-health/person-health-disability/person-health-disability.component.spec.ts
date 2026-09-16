import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonHealthDisabilityComponent } from './person-health-disability.component';

describe('PersonHealthDisabilityComponent', () => {
  let component: PersonHealthDisabilityComponent;
  let fixture: ComponentFixture<PersonHealthDisabilityComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonHealthDisabilityComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonHealthDisabilityComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
