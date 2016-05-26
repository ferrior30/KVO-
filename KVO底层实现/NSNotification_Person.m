//
//  NSNotification_Person.m
//  KVO底层实现
//
//  Created by ChenWei on 16/5/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "NSNotification_Person.h"
@import ObjectiveC.runtime;

 extern char *const keyNameObsever;

@implementation NSNotification_Person
- (void)setName:(NSString *)name {
    [super setName: name];
    
    // 取出观察者
    id observer = objc_getAssociatedObject(self, keyNameObsever);
    
    // 调用观察者方法
    [observer observeValueForKeyPath:name ofObject:self change:nil context:nil];
}
@end
