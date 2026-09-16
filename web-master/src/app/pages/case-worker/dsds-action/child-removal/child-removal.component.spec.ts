import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ChildRemovalComponent } from './child-removal.component';

describe('ChildRemovalComponent', () => {
  let component: ChildRemovalComponent;
  let fixture: ComponentFixture<ChildRemovalComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ChildRemovalComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ChildRemovalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
