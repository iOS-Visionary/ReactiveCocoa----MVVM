//
//  SignalDelegateFatherController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "SignalDelegateFatherController.h"
#import "SignalDelegateSonView.h"

@interface SignalDelegateFatherController ()

@end

@implementation SignalDelegateFatherController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    
    SignalDelegateSonView *view = [[SignalDelegateSonView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:view];
    
    //1.0
    RACSubject *s1 = [RACSubject subject];
    
    //2.0
    [s1 subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //3.0
    view.delegateSignal = s1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
