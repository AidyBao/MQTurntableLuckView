//
//  MQAutoLuckViewController.m
//  MQTurntableLuckView
//
//  Created by 120v on 2018/4/13.
//  Copyright © 2018年 MQ. All rights reserved.
//

#import "MQAutoLuckViewController.h"
#import "MQAutoLuckView.h"


#define screenW self.view.bounds.size.width

@interface MQAutoLuckViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) MQAutoLuckView *luckView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSString *labelText;
@property (nonatomic, assign) NSInteger turnAngle;
@property(nonatomic, assign) BOOL isAnimation;

@end

@implementation MQAutoLuckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 转盘View
    self.luckView = [[MQAutoLuckView alloc] initWithFrame:CGRectMake(0, 0, screenW-50, screenW-50)];
    self.luckView.center = self.view.center;
    [self.luckView.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.luckView];
    
    //显示奖励的label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.luckView.frame)+50, screenW-200, 30)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.label];
}

-(void)startAnimaition{
    
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
    
    //    NSInteger turnAngle;
    NSInteger randomNum = arc4random()%80;//控制概率
    NSInteger turnsNum = arc4random()%5+1;//控制圈数
    //    NSInteger turnsNum = 6;//控制圈数
    
    if (randomNum < 10) {
        _turnAngle = 0;
    }else if (randomNum < 20){
        _turnAngle = 45;
    }else if (randomNum < 30){
        _turnAngle = 90;
    }else if (randomNum < 40){
        _turnAngle = 135;
    }else if (randomNum < 50){
        _turnAngle = 180;
    }else if (randomNum < 60){
        _turnAngle = 225;
    }else if (randomNum < 70){
        _turnAngle = 270;
    }else if (randomNum < 80){
        _turnAngle = 315;
    }
    
    
    
    /*
     if (randomNum>=0 && randomNum<20) {//80%的概率 就是0-80
     
     if (randomNum < 40) {
     turnAngle = 0;
     }else{
     turnAngle = 135;
     }
     self.labelText = self.turntable.numberArray[0];
     //        NSLog(@"抽中了500");
     
     } else if (randomNum>=20 && randomNum<40) {
     
     if (randomNum < 75) {
     turnAngle = 45;
     }else{
     turnAngle = 225;
     }
     self.labelText = self.turntable.numberArray[3];
     //        NSLog(@"抽中了鲜花");
     
     } else if (randomNum >=40 && randomNum<60) {
     
     turnAngle = 315;
     self.labelText = self.turntable.numberArray[7];
     //        NSLog(@"抽中了2000");
     
     } else if(randomNum >=60 && randomNum<80){
     
     if (randomNum < 95) {
     turnAngle = 90;
     }else{
     turnAngle = 270;
     }
     self.labelText = self.turntable.numberArray[2];
     //        NSLog(@"抽中了5000");
     
     }else{
     
     turnAngle = 180;
     self.labelText = self.turntable.numberArray[4];
     //        NSLog(@"抽中了20000");
     }
     */
    
    //    NSLog(@"%@",self.labelText);
    NSLog(@"randomNum = %ld , turnAngle = %ld , turnsNum = %ld",randomNum,_turnAngle,turnsNum);
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_turnAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.luckView.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    _isAnimation = NO;
    
    NSLog(@"动画停止");
    NSString *title;
#warning -注意:这里是反向取值
    if (_turnAngle == 0) {
        title = self.luckView.numberArray[0];
    }else if (_turnAngle == 45){
        title = self.luckView.numberArray[7];
    }else if (_turnAngle == 90){
        title = self.luckView.numberArray[6];
    }else if (_turnAngle == 135){
        title = self.luckView.numberArray[5];
    }else if (_turnAngle == 180){
        title = self.luckView.numberArray[4];
    }else if (_turnAngle == 225){
        title = self.luckView.numberArray[3];
    }else if (_turnAngle == 270){
        title = self.luckView.numberArray[2];
    }else if (_turnAngle == 315){
        title = self.luckView.numberArray[1];
    }
    
    
    // 转盘结束后调用，显示获得的对应奖励
    self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",title];
    
    NSLog(@"%@",title);
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
