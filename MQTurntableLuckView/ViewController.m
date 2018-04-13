//
//  ViewController.m
//  MQTurntableLuckView
//
//  Created by 120v on 2018/4/12.
//  Copyright © 2018年 MQ. All rights reserved.
//

#import "ViewController.h"
#import "MQAutoLuckViewController.h"
#import "MQHandLuckViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)autoBtnAction:(id)sender {
    MQAutoLuckViewController * vc = [[MQAutoLuckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)handleBtnAction:(id)sender {
    MQHandLuckViewController * vc = [[MQHandLuckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
