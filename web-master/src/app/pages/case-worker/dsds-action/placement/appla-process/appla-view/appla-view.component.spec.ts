import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApplaViewComponent } from './appla-view.component';

describe('ApplaViewComponent', () => {
  let component: ApplaViewComponent;
  let fixture: ComponentFixture<ApplaViewComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApplaViewComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApplaViewComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
