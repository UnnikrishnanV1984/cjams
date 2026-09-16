import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { LivingArrangmentEditComponent } from './living-arrangment-edit.component';

describe('LivingArrangmentEditComponent', () => {
  let component: LivingArrangmentEditComponent;
  let fixture: ComponentFixture<LivingArrangmentEditComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ LivingArrangmentEditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(LivingArrangmentEditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
