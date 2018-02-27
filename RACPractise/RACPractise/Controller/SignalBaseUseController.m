//
//  SignalBaseUseController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "SignalBaseUseController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SignalBaseUseController ()

@end

@implementation SignalBaseUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self method1];
    [self method2];
    
}

- (void)method1{
    //1.0 创建信号
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {//block被订阅才会触发
        //1. 发送信号
        [subscriber sendNext:@1];
        
        //2.0 抛弃信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"我被销毁了");
        }];
        
    }];
    
    
    
    
    //2.0 订阅信号 激活上面的block
    
    [s1 subscribeNext:^(id x) {
        NSLog(@"我收到了%@",x);
        
    }];
    

}

- (void)method2{
    //1.0 创建信号
    RACReplaySubject *s2 = [RACReplaySubject subject];
    
    //2.0 发送信号 会存起来
    [s2 sendNext:@1];
    
    [s2 sendNext:@2];
    
    //3.0 订阅信号
    
    //3.1 block执行两次
    [s2 subscribeNext:^(id x) {
        NSLog(@"%@",x);//1 2
    }];
    
    //3.2 block执行两次
    [s2 subscribeNext:^(id x) {
        NSLog(@"%@",x);//1 2
    }];

}


@end
