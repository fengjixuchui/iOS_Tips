//
//  SLAPMViewController.m
//  DarkMode
//
//  Created by wsl on 2020/7/13.
//  Copyright © 2020 https://github.com/wsl2ls   ----- . All rights reserved.
//

#import "SLAPMViewController.h"
#import "SLAPMManager.h"


/*
 参考资料：
 https://www.jianshu.com/p/95df83780c8f
 https://www.jianshu.com/p/8123fc17fe0e
 https://juejin.im/post/5e92a113e51d4547134bdadb
 */

@interface SLAPMViewController ()

@end

@implementation SLAPMViewController

#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"APM监控";
    [self setupNavigationBar];
    [SLAPMManager manager].type = SLAPMTypeThreadCount;
}

//测试卡顿
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //耗时任务
//    sleep(1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
    });
}

#pragma mark - UI
- (void)setupNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:([SLAPMManager manager].isMonitoring ? @"停止":@"开始") style:UIBarButtonItemStyleDone target:self action:@selector(changeMonitorState)];
}

#pragma mark - Events Handle
///改变监听状态
- (void)changeMonitorState{
    if ([SLAPMManager manager].isMonitoring) {
        [[SLAPMManager manager] stopMonitoring];
    }else {
        [[SLAPMManager manager] startMonitoring];
    }
    [self setupNavigationBar];
}

@end
