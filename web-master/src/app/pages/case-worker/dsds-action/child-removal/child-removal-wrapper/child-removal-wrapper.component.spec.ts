import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildRemovalWrapperComponent } from './child-removal-wrapper.component';

describe('ChildRemovalWrapperComponent', () => {
  let component: ChildRemovalWrapperComponent;
  let fixture: ComponentFixture<ChildRemovalWrapperComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildRemovalWrapperComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildRemovalWrapperComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
