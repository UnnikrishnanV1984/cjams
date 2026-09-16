import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ResourceNewSetupTreeComponent } from './resource-new-setup-tree.component';

describe('ResourceNewSetupTreeComponent', () => {
  let component: ResourceNewSetupTreeComponent;
  let fixture: ComponentFixture<ResourceNewSetupTreeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ResourceNewSetupTreeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ResourceNewSetupTreeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
