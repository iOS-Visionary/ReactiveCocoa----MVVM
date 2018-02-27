//
//  CommandUseController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "CommandUseController.h"
#import <ReactiveCocoa.h>
@interface CommandUseController ()

@end

@implementation CommandUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self commandUse1];
//    [self subjectUse];
//    [self connectionUse];
}

- (void)commandUse1{
    RACCommand *cmd =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"1");
        NSLog(@"%@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"2");
            [subscriber sendNext:@"网络json"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    //2.0 订阅
    [cmd.executionSignals subscribeNext:^(id x) {//cmd block 执行完后 就执行这句代码
        [x subscribeNext:^(id x) {
            NSLog(@"我接收到:%@",x);
        }];
        
    }];
//    [cmd.executionSignals.switchToLatest subscribeNext:^(id x) {
//        NSLog(@"我接收到:%@",x);
//    }];
    
    //3.0 执行
    [cmd execute:@"我是传入参数"];
    
    
}
- (void)subjectUse{
    RACSubject *s = [RACSubject subject];
    RACSubject *beSendS = [RACSubject subject];
    
    [s subscribeNext:^(id x) {//1
       [x subscribeNext:^(id x) {
           NSLog(@"%@",x);//2
       }];
    }];
    [s sendNext:beSendS];// 调用 x subscribeNext ：x订阅了信号
    
    [beSendS sendNext:@"2"];//执行2 处block
}
- (void)connectionUse{
    RACSignal *s = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"开始请求");
        [subscriber sendNext:@"json"];
        return nil;
    }];
    
    RACMulticastConnection *connect = [s publish];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //激活信号
    [connect connect];
    
}

@end
