import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildRemovalListComponent } from './child-removal-list.component';

describe('ChildRemovalListComponent', () => {
  let component: ChildRemovalListComponent;
  let fixture: ComponentFixture<ChildRemovalListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildRemovalListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildRemovalListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
