//
//  NSObject+KVO.m
//  KVO底层实现
//
//  Created by ChenWei on 16/5/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "NSObject+KVO.h"
#import "Person.h"
//#import <objc/runtime.h>
@import ObjectiveC.runtime;

#import "NSNotification_Person.h"

/** keyNameObsever：用来从字典中取出对应属性的观察者 */
char *const keyNameObsever = "keyNameObsever";

@implementation NSObject (KVO)
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


@end
