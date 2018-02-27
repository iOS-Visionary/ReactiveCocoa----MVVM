//
//  MutableUseController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "MutableUseController.h"
#import "DelegateView.h"
#import <ReactiveCocoa.h>
@interface MutableUseController ()

@end

@implementation MutableUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self reduce];
    return;
    
    //delegate
    DelegateView *view = [[DelegateView alloc]initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:view];
    
    [[view rac_signalForSelector:@selector(click)] subscribeNext:^(id x) {
        NSLog(@"被点了");
        
        view.center = CGPointMake(400, 400);
    }];
    //kvo
    
    [[view rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //btn 事件
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 500, 50, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        NSLog(@"红色被点了");
    }];
    
    //监听通知
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(300, 500, 50, 20)];
    field.backgroundColor = [UIColor grayColor];
    [self.view addSubview:field];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //监听文本
    [[field rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
   
    //全部完成后再调用
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"json1"];
        return nil;
    }];
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"json2"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(completeRequest::) withSignals:s1,s2, nil];
    
    //宏的使用
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 50, 20)];
    [self.view addSubview:label];
    
    RAC(label,text) = field.rac_textSignal;
    
    //flattenMap 使用
    [[field.rac_textSignal flattenMap:^RACStream *(id value) {
        return [RACSignal return:value];
    }] subscribeNext:^(id x) {
        NSLog(@"hahaha:%@",x);
    }];
    //map 使用
//    [[field.rac_textSignal map:^id(id value) {
//        return [NSString stringWithFormat:@"我是:%@",value];
//    }] subscribeNext:^(id x) {
//        NSLog(@"hahaha:%@",x);
//    }];
    
    
}
- (void)completeRequest:(id)data1 :(id)data2{
    NSLog(@"%@--%@",data1,data2);
}
- (void)reduce{
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    RACSignal *combineS = [RACSignal combineLatest:@[s1,s2] reduce:^id(NSNumber *n1,NSNumber *n2){
        return @(n1 >0 && n2 > 0);
    }];
    
    
    [combineS subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
    }];
}
- (void)combine{
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号1 发出内容"];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号2 发出内容"];
        return nil;
    }];
    
    RACSignal *combineS = [s1 combineLatestWith:s2];
    
    [combineS subscribeNext:^(id x) { //得到一个元祖
        RACTupleUnpack(NSString *d1,NSString *d2) = x;
        NSLog(@"%@--%@",d1,d2);
        
    }];
}
- (void)zip{
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号1 发出内容"];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号2 发出内容"];
        return nil;
    }];
    
    RACSignal *zipS = [s1 zipWith:s2];
    
    [zipS subscribeNext:^(id x) { //得到一个元祖
        RACTupleUnpack(NSString *d1,NSString *d2) = x;
        NSLog(@"%@--%@",d1,d2);
      
    }];
}
- (void)merge{
    
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号1 发出内容"];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号2 发出内容"];
        return nil;
    }];
    
    RACSignal *mergeS = [s1 merge:s2];
    
    [mergeS subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
   
}
- (void)then{
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号1 发出内容"];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号2 发出内容"];
        return nil;
    }];
    
    RACSignal *thenS = [s1 then:^RACSignal *{
        return s2;
    }];
    
    [thenS subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
- (void)concact{
    RACSignal *s1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号1 发出内容"];
        [subscriber sendCompleted];//必须写
        return nil;
    }];
    
    RACSignal *s2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我是信号2 发出内容"];
        return nil;
    }];
    
    RACSignal *conS = [s1 concat:s2];
    
    [conS subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    

}


@end
