//
//  CalMaker.h
//  链式编程思想
//
//  Created by YiXue on 2018/2/26.
//  Copyright © 2018年 YiXue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalMaker : NSObject
@property(nonatomic,assign) int result;
+ (int)makeResults:(void(^)(CalMaker *))maker;
- (CalMaker *(^)(int))add;
@end
