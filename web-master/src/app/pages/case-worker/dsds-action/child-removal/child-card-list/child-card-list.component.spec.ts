import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildCardListComponent } from './child-card-list.component';

describe('ChildCardListComponent', () => {
  let component: ChildCardListComponent;
  let fixture: ComponentFixture<ChildCardListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildCardListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildCardListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
