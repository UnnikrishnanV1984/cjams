import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ListEducationComponent } from './list-education.component';

describe('ListEducationComponent', () => {
  let component: ListEducationComponent;
  let fixture: ComponentFixture<ListEducationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ListEducationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListEducationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
