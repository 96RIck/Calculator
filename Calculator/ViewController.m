//
//  ViewController.m
//  Calculator
//
//  Created by Rick on 2017/9/2.
//  Copyright © 2017年 Rick. All rights reserved.
//

#define MainScreenWidth [[UIScreen mainScreen]bounds].size.width
#define MainScreenHeight [[UIScreen mainScreen]bounds].size.height



#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    //设置按钮区域总宽高，显示label总宽高，单个按钮宽高
    float ButtonWidth = MainScreenWidth/4;
    float ButtonHeight = ButtonWidth;
    float ButtonRectHeight = ButtonHeight*5;
    float ButtonRectWidth = MainScreenWidth ;
    float ResultLabelRectHeight = MainScreenHeight-ButtonRectHeight;
    float ResultLabelRectWidth = MainScreenWidth ;
    
    //获取屏幕高度/宽度
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    _DeviceScreenWidth = size.width;
    _DeviceScreenHeight = size.height;

    NSString * DeviceVersion ;
    
    //判断机型，设置全局Button字体
    if (_DeviceScreenWidth == 320 && _DeviceScreenHeight == 480) {
        DeviceVersion = @"IPhone4";
        _fontSize = 26;
    }
    else if (_DeviceScreenWidth == 320 && _DeviceScreenHeight == 568)
    {
        DeviceVersion = @"IPhone5/5s" ;
        _fontSize = 32 ;
    }
    else if (_DeviceScreenWidth == 375 && _DeviceScreenHeight == 667)
    {
        DeviceVersion = @"IPhone6/7" ;
        _fontSize = 36 ;
    }
    else if (_DeviceScreenWidth == 414 && _DeviceScreenHeight == 736)
    {
        DeviceVersion = @"IPhone6P/7P" ;
        _fontSize = 40 ;
    }
 
    self.view.backgroundColor = [UIColor blackColor];
    UILabel *labelRect = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth*3, ButtonHeight)];
    labelRect.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:labelRect];
    
    
    //创建ResultLabel
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ResultLabelRectWidth, ResultLabelRectHeight)] ;
    [self.view addSubview:_label] ;
    self.label.backgroundColor = [UIColor blackColor] ;
    self.label.textColor = [UIColor whiteColor] ;
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.font = [UIFont systemFontOfSize:32.4] ;
    
    
    //添加1-9数字
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil] ;
    int n = 0 ;
    for (int i = 1 ; i<4; i++)
    {
        for (int j = 0; j<3; j++)
        {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom] ;
            self.button.frame = CGRectMake(0+ButtonRectWidth/4*j, ResultLabelRectHeight+ButtonRectHeight/5*i, ButtonWidth, ButtonHeight);
            [self.button setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal] ;
            [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
         
            //设置字体
            self.button.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
            
            //设置边框粗细颜色
            [self.button.layer setMasksToBounds:YES];
            self.button.layer.cornerRadius = 0.0 ;
            self.button.layer.borderWidth = 0.5 ;
            self.button.layer.borderColor = [[UIColor darkGrayColor]CGColor];
            
            [self.view addSubview:_button] ;
            [self.button addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
        }
    }
    
    
    //添加数字 ”0“
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(ButtonWidth, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight);
    
        //设置字体
    button0.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
        //设置按钮边框
    [button0.layer setMasksToBounds:YES];
    button0.layer.cornerRadius = 0.0;
    button0.layer.borderWidth = 0.5;
    [button0.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    
    [button0 setTitle:@"0" forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button0 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [button0 setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button0] ;
    
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonPoint setFrame:CGRectMake(0, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight)];
    [buttonPoint setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    buttonPoint.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    [buttonPoint.layer setMasksToBounds:YES];
    buttonPoint.layer.borderWidth = 0.5;
    [buttonPoint.layer setBorderColor:[[UIColor darkGrayColor]CGColor]] ;
    
    [buttonPoint addTarget:self action:@selector(shuzi:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonPoint] ;
    
    
    //添加运算符：
    NSArray *array1 = [NSArray arrayWithObjects:@"＋",@"－",@"×",@"÷", nil] ;
    for (int i = 0; i<4; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonHeight*i, ButtonWidth, ButtonWidth)] ;
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
        [button1 setTintColor:[UIColor whiteColor]];
        
        
        [button1.layer setMasksToBounds:YES];
        [button1.layer setCornerRadius:0.0];
        [button1.layer setBorderWidth:.5];
        [button1.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
        
        
        button1.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize] ;
        [self.view addSubview: button1] ;
        [button1 addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    
    //添加 “=” 号 EqualSign
    UIButton *buttonEqualSign = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonEqualSign setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonRectHeight/5*4,ButtonWidth, ButtonHeight)] ;
    [buttonEqualSign setTitle:@"＝" forState:UIControlStateNormal] ;
    [buttonEqualSign setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
    
    [buttonEqualSign setTintColor:[UIColor whiteColor]];
    
    [buttonEqualSign.layer setMasksToBounds:YES];
    [buttonEqualSign.layer setCornerRadius:0.0];
    [buttonEqualSign.layer setBorderWidth:.5];
    [buttonEqualSign.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    
    buttonEqualSign.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    [buttonEqualSign addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonEqualSign] ;
    
    //添加”AC“建 clean
    UIButton * buttonClean = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonClean setFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth, ButtonHeight)] ;
    [buttonClean setTitle:@"AC" forState:UIControlStateNormal] ;
    [buttonClean setTintColor:[UIColor blackColor]];
    [buttonClean setBackgroundColor:[UIColor clearColor]];
    
    [buttonClean.layer setMasksToBounds:YES];
    [buttonClean.layer setCornerRadius:.0];
    [buttonClean.layer setBorderWidth:.5];
    [buttonClean.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    buttonClean.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [buttonClean addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonClean] ;
    
    
    //添加“back”按钮
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonBack setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight+ButtonHeight*4, ButtonWidth, ButtonHeight)] ;
    [buttonBack setImage:[UIImage imageNamed:@"erase_symbol"]forState:UIControlStateNormal];
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonBack setTintColor:[UIColor blackColor]];
    
    [buttonBack.layer setMasksToBounds:YES];
    [buttonBack.layer setCornerRadius:.0];
    [buttonBack.layer setBorderWidth:.5];
    [buttonBack.layer setBorderColor:[[UIColor grayColor]CGColor]];
     
    [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonBack] ;
    
    //添加“+/-”按钮
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight, ButtonWidth, ButtonHeight)];
    [button3 setImage:[UIImage imageNamed:@"iTunesArtwork"] forState:UIControlStateNormal];
    
    
    self.string = [[NSMutableString alloc]init] ;
    self.str = [[NSString alloc]init];
    
}

-(void)shuzi:(id)sender
{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
