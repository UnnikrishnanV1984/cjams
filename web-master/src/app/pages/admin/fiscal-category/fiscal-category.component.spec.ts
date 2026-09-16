import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { FiscalCategoryComponent } from './fiscal-category.component';

describe('FiscalCategoryComponent', () => {
  let component: FiscalCategoryComponent;
  let fixture: ComponentFixture<FiscalCategoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ FiscalCategoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FiscalCategoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
