import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildRemovalDetailComponent } from './child-removal-detail.component';

describe('ChildRemovalDetailComponent', () => {
  let component: ChildRemovalDetailComponent;
  let fixture: ComponentFixture<ChildRemovalDetailComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildRemovalDetailComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildRemovalDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
