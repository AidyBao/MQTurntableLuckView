//
//  MQAutoLuckView.h
//  MQTurntableLuckView
//
//  Created by 120v on 2018/4/13.
//  Copyright © 2018年 MQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MQAutoLuckViewDelegate <NSObject>

- (void)MQAutoLuckViewDidFinishWithIndex:(NSInteger)index;

@end

@interface MQAutoLuckView : UIView

@property (nonatomic,assign) NSInteger numberIndex;

@property (nonatomic,strong) UIButton * playButton;      // 抽奖按钮

@property (nonatomic,strong) UIImageView * rotateWheel;  // 转盘背景

@property (nonatomic,strong) NSArray * numberArray;      // 存放奖励

@property (nonatomic,weak) id <MQAutoLuckViewDelegate>delegate;

@end
