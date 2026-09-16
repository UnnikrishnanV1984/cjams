import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { IntakeRoaComponent } from './intake-roa.component';

describe('IntakeRoaComponent', () => {
  let component: IntakeRoaComponent;
  let fixture: ComponentFixture<IntakeRoaComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ IntakeRoaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IntakeRoaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
