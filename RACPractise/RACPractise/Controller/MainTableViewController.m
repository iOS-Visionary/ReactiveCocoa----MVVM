//
//  MainTableViewController.m
//  ZLL_Monary
//
//  Created by YiXue on 16/9/2.
//  Copyright © 2016年 YiXue. All rights reserved.
//

#import "MainTableViewController.h"
#import "SignalBaseUseController.h"
#import "SignalDelegateFatherController.h"
#import "ArrayDictController.h"
#import "CommandUseController.h"
#import "MutableUseController.h"
#import "FilterController.h"

@interface MainTableViewController ()
@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,strong) NSArray *VCS;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"signal基本使用",
                        @"signal作为代理运用",
                        @"数组字典使用",
                        @"Command使用",
                        @"杂项使用",
                        @"过滤"];
    NSArray *VCS = @[@"SignalBaseUseController",
                     @"SignalDelegateFatherController",
                     @"ArrayDictController",
                     @"CommandUseController",
                     @"MutableUseController",
                     @"FilterController"];
    _titles = titles;
    _VCS = VCS;
    
    
}



#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *clsName = _VCS[indexPath.row];
    Class cls = NSClassFromString(clsName);
    UIViewController *vc = [[cls alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
