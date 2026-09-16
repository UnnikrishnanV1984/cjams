import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PlacmentWrapperComponent } from './placment-wrapper.component';

describe('PlacmentWrapperComponent', () => {
  let component: PlacmentWrapperComponent;
  let fixture: ComponentFixture<PlacmentWrapperComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PlacmentWrapperComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PlacmentWrapperComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
