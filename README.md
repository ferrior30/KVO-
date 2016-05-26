# KVO-
## KVO本质
* 是对set方法的监听
* 原理
  * 当给类A的属性比如name添加观察者时，就会修改这个类A的isa指针指向一个利用运行时动态添加的类B(类B是类A的子类)。
  * 然后给类A设置观察者
  * 在类B中重写要监听的属性name的set方法 ->取出观察者 -> 调用观察者的方法,完成监听。
  
## 主要用到的runtime的方法
```objc
- (void)cw_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
  
    // 修改isa指针 : 当self的方法被调用时，先从这个isa指向的类NSNotification_Person找，找不到再到它的父类也就是self中找。
    // NSNotification_Person 是 Persn的子类
    object_setClass(self, [NSNotification_Person class]);
    
    // 给属性设置观察者
    /**
     *  id object： 给哪个对象object设置观察者
     *  const void *key : 设置观察者的key，（作用：取出观察者时）
     *  id value ： 谁来观察
     * objc_AssociationPolicy policy ：添加obsever的方式（原子性和内存管理）注：observer遵守实现了copy协议，才能用copy方式。
     */
    objc_setAssociatedObject(self, keyNameObsever, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setName:(NSString *)name {
    [super setName: name];
    
    // 取出观察者
    id observer = objc_getAssociatedObject(self, keyNameObsever);
    
    // 调用观察者方法
    [observer observeValueForKeyPath:name ofObject:self change:nil context:nil];
}
```
