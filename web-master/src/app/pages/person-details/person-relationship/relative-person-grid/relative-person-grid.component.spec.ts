import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { RelativePersonGridComponent } from './relative-person-grid.component';

describe('RelativePersonGridComponent', () => {
  let component: RelativePersonGridComponent;
  let fixture: ComponentFixture<RelativePersonGridComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ RelativePersonGridComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RelativePersonGridComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
