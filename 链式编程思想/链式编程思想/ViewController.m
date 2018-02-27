//
//  ViewController.m
//  链式编程思想
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "ViewController.h"
#import "CalMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   int result = [CalMaker makeResults:^(CalMaker *make) {
        make.add(1).add(2).add(3);
    }];
    
    NSLog(@"%d",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
