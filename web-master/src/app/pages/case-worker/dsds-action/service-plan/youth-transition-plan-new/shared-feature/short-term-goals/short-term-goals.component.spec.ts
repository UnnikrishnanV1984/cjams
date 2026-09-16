import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ShortTermGoalsComponent } from './short-term-goals.component';

describe('ShortTermGoalsComponent', () => {
  let component: ShortTermGoalsComponent;
  let fixture: ComponentFixture<ShortTermGoalsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ShortTermGoalsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ShortTermGoalsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
