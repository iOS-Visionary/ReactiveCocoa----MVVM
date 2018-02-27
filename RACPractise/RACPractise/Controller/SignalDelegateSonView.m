//
//  SignalDelegateSonView.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "SignalDelegateSonView.h"

@implementation SignalDelegateSonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
- (void)click{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"按钮被点了"];
    }
}

@end
