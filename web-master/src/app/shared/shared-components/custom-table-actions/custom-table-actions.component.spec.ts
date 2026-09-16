import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CustomTableActionsComponent } from './custom-table-actions.component';

describe('CustomTableActionsComponent', () => {
  let component: CustomTableActionsComponent;
  let fixture: ComponentFixture<CustomTableActionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CustomTableActionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CustomTableActionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
