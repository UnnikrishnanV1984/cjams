import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacementAddEditComponent } from './placement-add-edit.component';

describe('PlacementAddEditComponent', () => {
  let component: PlacementAddEditComponent;
  let fixture: ComponentFixture<PlacementAddEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacementAddEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacementAddEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
