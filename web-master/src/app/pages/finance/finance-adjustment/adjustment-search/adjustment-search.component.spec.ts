import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdjustmentSearchComponent } from './adjustment-search.component';

describe('AdjustmentSearchComponent', () => {
  let component: AdjustmentSearchComponent;
  let fixture: ComponentFixture<AdjustmentSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdjustmentSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdjustmentSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
