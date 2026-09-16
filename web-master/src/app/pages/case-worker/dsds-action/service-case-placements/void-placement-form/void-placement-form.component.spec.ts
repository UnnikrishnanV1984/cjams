import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { VoidPlacementFormComponent } from './void-placement-form.component';

describe('VoidPlacementFormComponent', () => {
  let component: VoidPlacementFormComponent;
  let fixture: ComponentFixture<VoidPlacementFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ VoidPlacementFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VoidPlacementFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
