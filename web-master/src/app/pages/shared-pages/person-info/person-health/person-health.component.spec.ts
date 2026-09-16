import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonHealthComponent } from './person-health.component';

describe('PersonHealthComponent', () => {
  let component: PersonHealthComponent;
  let fixture: ComponentFixture<PersonHealthComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonHealthComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonHealthComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
