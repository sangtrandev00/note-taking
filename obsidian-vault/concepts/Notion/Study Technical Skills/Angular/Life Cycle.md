  

  

Cơ chế hoạt động của Angular. Cơ chế render của Angular, mỗi lần thay đổi sự kiện component đó có rerender lại hay không ?

  

  

Contructor khác gì ngOnInit () của Angular  
* Về mặt khái niệm  
+ Contructor là khái niệm của classs → typescript  
+ Khởi tạo sau khi. classs được khởi tạo  
+ khởi tạo trước khi các component được render lên UI  
⇒ contructor khởi tạo trước ngOninit  

  

  

* Về mặt mục đích sử dụng  
  
+ Contrcutor khởi tạo các dependency → khở tạo các service để sài  
+ NgOnint  
  
  
  
  

The `ngOnInit` lifecycle hook in Angular is executed **before** the component is fully rendered. To understand this in detail, it's important to grasp the sequence of lifecycle events in Angular:

1. **Constructor**: The constructor of the component is called first when Angular creates a new instance of the component. This is where dependency injection happens, and basic initializations are performed.
2. **ngOnChanges**: This lifecycle hook is called before `ngOnInit` and whenever one or more data-bound input properties change. It is called multiple times throughout the component's lifecycle, not just at the beginning.
3. **ngOnInit**: This lifecycle hook is called once after the first `ngOnChanges` and just before the component's view is rendered. It is only called once per component instance and is used to perform component initialization that requires the component's inputs to be set.
4. **ngDoCheck**: This hook is called during every change detection run, immediately after `ngOnChanges` and `ngOnInit`.
5. **ngAfterContentInit**: This hook is called after Angular projects external content into the component's view (via `<ng-content>`).
6. **ngAfterContentChecked**: This hook is called after every check of the content projected into the component.
7. **ngAfterViewInit**: This hook is called after Angular initializes the component's view and its child views.
8. **ngAfterViewChecked**: This hook is called after every check of the component's view and its child views.
9. **ngOnDestroy**: This hook is called just before Angular destroys the component. This is the place to perform any necessary cleanup.

### Sequence with Focus on ngOnInit and Component Rendering

Here's the specific sequence emphasizing `ngOnInit` and the rendering process:

1. **Constructor**: Component instance is created.
2. **ngOnChanges**: Called if any `@Input` properties are set.
3. **ngOnInit**: Called after the first `ngOnChanges` and before the component is rendered.
4. **First Rendering**: The component's view is rendered.
5. **ngDoCheck**: Called during every change detection run.
6. **ngAfterContentInit**: Called after content projection is done.
7. **ngAfterContentChecked**: Called after every check of the projected content.
8. **ngAfterViewInit**: Called after the component's view and child views are initialized.
9. **ngAfterViewChecked**: Called after every check of the component's view and child views.

In summary, `ngOnInit` is called **before** the component is rendered. This allows you to perform any necessary initialization that needs to be done before the view is displayed to the user, ensuring that the component is fully set up and ready for rendering.

  

  

[https://chatgpt.com/c/3d959ff8-5c53-4a78-b039-8cc09278a261](https://chatgpt.com/c/3d959ff8-5c53-4a78-b039-8cc09278a261)