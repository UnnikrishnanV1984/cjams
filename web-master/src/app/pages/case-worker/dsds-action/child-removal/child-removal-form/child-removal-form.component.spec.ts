import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildRemovalFormComponent } from './child-removal-form.component';

describe('ChildRemovalFormComponent', () => {
  let component: ChildRemovalFormComponent;
  let fixture: ComponentFixture<ChildRemovalFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildRemovalFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildRemovalFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
