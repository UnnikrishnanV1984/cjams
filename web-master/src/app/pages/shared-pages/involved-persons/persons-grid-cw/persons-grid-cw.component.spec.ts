import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonsGridCwComponent } from './persons-grid-cw.component';

describe('PersonsGridCwComponent', () => {
  let component: PersonsGridCwComponent;
  let fixture: ComponentFixture<PersonsGridCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonsGridCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonsGridCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
