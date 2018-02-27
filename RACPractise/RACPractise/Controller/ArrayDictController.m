//
//  ArrayDictController.m
//  RACPractise
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "ArrayDictController.h"
#import <ReactiveCocoa.h>
@interface ArrayDictController ()

@end

@implementation ArrayDictController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self testArray];
    [self testDict];
    
}
- (void)testArray{
    NSArray *arr = @[@1,@2,@3];
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}
- (void)testDict{
    NSDictionary *dict = @{@"1":@"yi",@"2":@"er",@"3":@"san"};
    
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(NSString *key,NSString *v) = x;
        NSLog(@"key:%@--value:%@",key,v);
        
    }];
}

@end
