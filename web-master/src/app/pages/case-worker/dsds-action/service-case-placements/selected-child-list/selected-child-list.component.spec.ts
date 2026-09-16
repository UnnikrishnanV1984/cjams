import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SelectedChildListComponent } from './selected-child-list.component';

describe('SelectedChildListComponent', () => {
  let component: SelectedChildListComponent;
  let fixture: ComponentFixture<SelectedChildListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SelectedChildListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SelectedChildListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
