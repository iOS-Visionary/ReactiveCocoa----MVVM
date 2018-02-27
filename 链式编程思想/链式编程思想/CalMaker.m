//
//  CalMaker.m
//  链式编程思想
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import "CalMaker.h"

@implementation CalMaker
+ (int)makeResults:(void (^)(CalMaker *make))makerBlock{
    CalMaker *maker = [[CalMaker alloc] init];
    makerBlock(maker);//这一步调用计算方法
    return maker.result;
}
- (CalMaker *(^)(int))add{
    return ^CalMaker *(int value){
        self.result += value;
        return self;
    };//block计算完毕后是有个返回值的
    
}
@end
