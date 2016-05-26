//
//  ViewController.m
//  KVO底层实现
//
//  Created by ChenWei on 16/5/26.
//  Copyright © 2016年 cw. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+KVO.h"
#import "NSNotification_Person.h"

@interface ViewController ()
@property (strong, nonatomic) Person *person;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _person = [Person new];
    
    [_person cw_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static NSInteger i = 0 ;
    i++;
   _person.name = [NSString stringWithFormat:@"%zd", i];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@", _person.name);
}


@end
