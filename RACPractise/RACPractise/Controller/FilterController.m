//
//  FilterController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/27.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "FilterController.h"
#import <ReactiveCocoa.h>

@interface FilterController ()

@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(300, 70, 100, 20)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    
//    [[field.rac_textSignal filter:^BOOL(NSString *value) {
//        return value.length > 8;
//    }] subscribeNext:^(id x) {
//        NSLog(@"密码长度大于8:%@",x);
//    }];
    
//    [[field.rac_textSignal ignore:@"123"] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    [[field.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    [[field.rac_textSignal take:5] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];//默认刚创建已经执行2次?
    
//    [[field.rac_textSignal takeLast:2] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];//最后2次的
    
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"1");
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id x) {
         NSLog(@"2");
    }] doCompleted:^{
        NSLog(@"3");
    }] subscribeNext:^(id x) {
         NSLog(@"4");
    }];
    
    
    
    
}



@end
