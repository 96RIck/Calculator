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

//UI及其他工具
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化可变字符串，分配内存
    _inPutStr=[NSMutableString stringWithCapacity:20];
    [_inPutStr setString:@""];
    _lengthString = @"";
    _strChar = @"";
    _resultNum = 0;
    _rightNum = 0;
    _leftNum = 0;
    _length = 0;
    
    //MARK1 : -总体UI搭建和相关设置
    
    //相关设置
    
    //设置按钮区域总宽高，显示label总宽高，单个按钮宽高
    float ButtonWidth = MainScreenWidth/4;
    float ButtonHeight = ButtonWidth;
    float ButtonRectHeight = ButtonHeight*5;
    float ButtonRectWidth = MainScreenWidth ;
    float ResultLabelRectHeight = MainScreenHeight-ButtonRectHeight;
    float ResultLabelRectWidth = MainScreenWidth ;
    
    //获取屏幕高度/宽度
    _DeviceScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    _DeviceScreenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    //判断机型，设置全局Button所需字体
    switch (_DeviceScreenHeight) {
            
        case 480:
            _fontSize = 32;
            break;
            
        case 569:
            _fontSize = 38 ;
            break;
            
        case 667:
            _fontSize = 42;
            break;
            
        case 736:
            _fontSize = 48;
        default:
            break;
    }
    
    
    //搭建UI
    
    //背景色
    self.view.backgroundColor = [UIColor blackColor];
    
    //创建清除键等案件背景label
    UILabel *cleanButtonBackgroundLabel = [[UILabel alloc]init];
    [cleanButtonBackgroundLabel setFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth*3, ButtonHeight)];
    [cleanButtonBackgroundLabel setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:cleanButtonBackgroundLabel];
    
    //创建labelResultBottom
    self.labelResultBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight/2, ResultLabelRectWidth-20, ResultLabelRectHeight/2)] ;
    self.labelResultBottom.backgroundColor = [UIColor blackColor] ;
    self.labelResultBottom.textColor = [UIColor whiteColor] ;
    self.labelResultBottom.textAlignment = NSTextAlignmentRight;
    self.labelResultBottom.font = [UIFont fontWithName:@"PingFangTc-Ultralight" size:_fontSize+15];
    self.labelResultBottom.text = @"0";
    [self.view addSubview:_labelResultBottom] ;
    
    //创建labelResultTop
    _labelResultTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, ResultLabelRectWidth-20, ResultLabelRectHeight/2)];
    self.labelResultTop.backgroundColor = [UIColor blackColor] ;
    self.labelResultTop.textColor = [UIColor whiteColor] ;
    self.labelResultTop.textAlignment = NSTextAlignmentRight;
    self.labelResultTop.font = [UIFont fontWithName:@"PingFangTc-Ultralight" size:_fontSize-10];
    self.labelResultTop.text = @"";
    [self.view addSubview:_labelResultTop];
    
    //创建labelOperators
    _labelOperators = [[UILabel alloc]initWithFrame:CGRectMake(0, ButtonHeight+30, ButtonWidth/2, ButtonHeight-30)];
    self.labelOperators.backgroundColor = [UIColor blackColor] ;
    self.labelOperators.textColor = [UIColor whiteColor] ;
    self.labelOperators.textAlignment = NSTextAlignmentCenter;
    self.labelOperators.font = [UIFont fontWithName:@"PingFangTc-Ultralight" size:_fontSize-6];
    self.labelOperators.text = @"";
    [self.view addSubview:_labelOperators];
    
    //添加1-9数字
    NSArray * array = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil] ;
    int n = 0 ;
    for (int i = 1 ; i<4; i++)
    {
        for (int j = 0; j<3; j++)
        {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom] ;
            //设置位置大小
            [self.button setFrame:CGRectMake(0+ButtonRectWidth/4*j, ResultLabelRectHeight+ButtonRectHeight/5*i, ButtonWidth, ButtonHeight)];
            //设置字体
            [self.button.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
            [self.button setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal] ;
            [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            //设置边框粗细颜色
            [self.button.layer setMasksToBounds:YES];
            [self.button.layer setBorderWidth:0.5] ;
            [self.button.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
            [self.button addTarget:self action:@selector(touchNumber:) forControlEvents:UIControlEventTouchUpInside] ;
            [self.view addSubview:_button] ;
            
        }
    }
    
    //添加数字 ”0“
    UIButton *buttonZero = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonZero setFrame: CGRectMake(0, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth*2, ButtonHeight)];
    //设置字体
    [buttonZero.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
    //设置按钮边框
    [buttonZero.layer setMasksToBounds:YES];
    [buttonZero.layer setCornerRadius:.0];
    [buttonZero.layer setBorderWidth:.5];
    [buttonZero.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    //设置按下效果和标题
    [buttonZero setTitle:@"0" forState:UIControlStateNormal];
    [buttonZero setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonZero setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //设置背景图片和点击事件
    [buttonZero setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonZero addTarget:self action:@selector(touchZero:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonZero] ;
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonPoint setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight)];
    [buttonPoint setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [buttonPoint.layer setMasksToBounds:YES];
    [buttonPoint.layer setCornerRadius:.0];
    [buttonPoint.layer setBorderWidth:0.5];
    [buttonPoint.layer setBorderColor:[[UIColor darkGrayColor]CGColor]] ;
    [buttonPoint addTarget:self action:@selector(touchPoint:) forControlEvents:UIControlEventTouchUpInside] ;
    [buttonPoint.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
    [self.view addSubview:buttonPoint] ;
    
    
    
    //添加运算符：
    NSArray *array1 = [NSArray arrayWithObjects:@"＋",@"－",@"×",@"÷", nil] ;
    for (int i = 0; i<4; i++)
    {
        UIButton *buttonOperator = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonOperator setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonHeight*i, ButtonWidth, ButtonWidth)] ;
        [buttonOperator setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        [buttonOperator setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
        [buttonOperator setTintColor:[UIColor whiteColor]];
        [buttonOperator setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [buttonOperator.layer setMasksToBounds:YES];
        [buttonOperator.layer setCornerRadius:0.0];
        [buttonOperator.layer setBorderWidth:.5];
        [buttonOperator.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
        [buttonOperator.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
        [buttonOperator addTarget:self action:@selector(touchOperators:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview: buttonOperator] ;
    }
    
    //添加 “=” 号 EqualSign
    UIButton *buttonEqualSign = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonEqualSign setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonRectHeight/5*4,ButtonWidth, ButtonHeight)] ;
    [buttonEqualSign setTitle:@"＝" forState:UIControlStateNormal] ;
    [buttonEqualSign setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
    [buttonEqualSign setTintColor:[UIColor whiteColor]];
    [buttonEqualSign.layer setMasksToBounds:YES];
    [buttonEqualSign.layer setCornerRadius:0.0];
    [buttonEqualSign.layer setBorderWidth:.5];
    [buttonEqualSign.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
    [buttonEqualSign.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
    [buttonEqualSign addTarget:self action:@selector(touchEqualSign:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonEqualSign] ;
    
    //添加”AC“建 clean
    UIButton * buttonClean = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [buttonClean setFrame:CGRectMake(0, ResultLabelRectHeight, ButtonWidth, ButtonHeight)] ;
    [buttonClean setTitle:@"AC" forState:UIControlStateNormal] ;
    [buttonClean setTintColor:[UIColor whiteColor]];
    [buttonClean.layer setMasksToBounds:YES];
    [buttonClean.layer setCornerRadius:.0];
    [buttonClean.layer setBorderWidth:.5];
    [buttonClean.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [buttonClean.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
    [buttonClean addTarget:self action:@selector(touchClean:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonClean] ;
    
    //添加“back”按钮
    UIButton *buttonBackSpace = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonBackSpace setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight, ButtonWidth, ButtonHeight)] ;
    [buttonBackSpace setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
    [buttonBackSpace setTintColor:[UIColor blackColor]];
    [buttonBackSpace.layer setMasksToBounds:YES];
    [buttonBackSpace.layer setCornerRadius:.0];
    [buttonBackSpace.layer setBorderWidth:.5];
    [buttonBackSpace.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [buttonBackSpace addTarget:self action:@selector(touchBackSpace:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonBackSpace] ;
    
    //添加“+/-”按钮
    UIButton *buttonSign = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonSign setFrame:CGRectMake(ButtonWidth, ResultLabelRectHeight, ButtonWidth, ButtonHeight)];
    [buttonSign setTitle:@"±" forState:UIControlStateNormal];
    [buttonSign setTintColor:[UIColor whiteColor]];
    [buttonSign.layer setMasksToBounds:YES];
    [buttonSign.layer setCornerRadius:.0];
    [buttonSign.layer setBorderWidth:.5];
    [buttonSign.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [buttonSign.layer setMasksToBounds:YES];
    [buttonSign.layer setBorderWidth:.5];
    [buttonSign.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [buttonSign.titleLabel setFont:[UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize]];
    [buttonSign addTarget:self action:@selector(touchSign:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSign];
    //以上完成UI搭建
}
//按下数字1~9事件
- (void)touchNumber:(id)sender {
    
    //如果再次输入数字时符号label是等号，则全部做清零处理
    if ([_labelOperators.text isEqualToString:@"="])
    {
        [_inPutStr setString:@""];
        getPoint = NO;
        _labelResultTop.text = @"";
        _labelOperators.text = @"";
        _labelResultBottom.text = @"0";
        _lengthString = @"";
        _strChar = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
    }
    //进行追加
    [_inPutStr appendString:[sender currentTitle]];
    [_labelResultBottom setText:[NSString stringWithString:_inPutStr]];
    _resultNum = [self.labelResultBottom.text doubleValue];
    _leftNum = [_inPutStr doubleValue];
}
//按下数字0事件
- (void)touchZero:(id)sender {
    
    if ([_labelOperators.text isEqualToString:@"="]) {
        
        _labelOperators.text = @"";
        
        _labelResultBottom.text = @"0";
        
        [_inPutStr setString:@""];
        
        return;
    }
    [_inPutStr appendString:[sender currentTitle]];
    
    if ([_inPutStr isEqualToString:@"0"]) {
        [_inPutStr setString:@""];
        self.labelResultBottom.text = @"0";
    }
    else
    {
        self.labelResultBottom.text = [NSString stringWithString:_inPutStr];
    }
    _leftNum = [_inPutStr doubleValue];
    self.resultNum = [self.labelResultBottom.text doubleValue];
}
//按下数字点.事件
- (void)touchPoint:(id)sender {
    if ([_labelResultBottom.text containsString:@"."]) {
        getPoint = YES;
    }
    else
    {
        getPoint = NO;
    }
    if ([_labelOperators.text isEqualToString:@"="]) {
        _labelOperators.text = @"";
        _labelResultBottom.text = @"0";
        [_inPutStr setString:@""];
        return;
    }
    
    [_inPutStr appendString:[sender currentTitle]];
    
    if ([_inPutStr isEqualToString:@"."]) {
        [_inPutStr setString:@"0."];
        self.labelResultBottom.text = @"0.";
        getPoint = YES;
        _leftNum = [_inPutStr doubleValue];
    }
    else if (getPoint)
    {
            NSRange deleteRange = {[_inPutStr length] -1,1};  //创建deleteRange
           [_inPutStr deleteCharactersInRange:deleteRange];
    }
   
    _leftNum = [_labelResultBottom.text doubleValue];
    self.labelResultBottom.text = [NSString stringWithString:_inPutStr];
    self.resultNum  = [self.labelResultBottom.text doubleValue];

}
//按下运算按钮（＋ － × ÷ ）事件
- (void)touchOperators:(id)sender {
 
    if (![_labelResultBottom.text isEqualToString:@""] && ![_labelOperators.text isEqualToString:@""] && ![_labelResultTop.text isEqualToString:@""])
    {
    if (isFinish ==YES && ![_labelResultTop.text isEqualToString:@""])
    {
        return;
    }
    if ([_labelOperators.text isEqualToString:@"－"] && [[sender currentTitle]  isEqual: @"×"])
    {
        _labelOperators.text = [NSString stringWithString:[sender currentTitle]];
        _strChar = @"";
        return;
    }
        _strChar = [sender currentTitle];
        _labelOperators.text = _strChar;
        _strChar = @"";
        return;
    }
    
    if ([_strChar isEqualToString:@""])
    {
       
        if ([_labelResultBottom.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""]) {
            _labelOperators.text = [sender currentTitle];
            
            return;
        }
        if ([_inPutStr isEqualToString:@""]) {
            return;
        }
        _strChar = [sender currentTitle];
        if(isFinish == YES)
        {
            _leftNum = _resultNum;
            [_inPutStr setString:@""];
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."])
                {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            _labelResultTop.text = [NSString stringWithString:_lengthString];
            _rightNum = _leftNum;
             [_inPutStr setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResultBottom.text = @"0";
            _lengthString = @"";
            _leftNum = 0;
            _length = 0;
            [_inPutStr setString:@""];

            isFinish = NO;
            
            if ([_labelResultBottom.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""])
            {
                _strChar = @"";
                return;
            }
        }
        else
        {
            _rightNum = _leftNum;
            _labelResultTop.text = [NSString stringWithString:_inPutStr];
            [_inPutStr setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResultBottom.text = @"0";
        }
    }
    else if([_inPutStr isEqualToString:@"0"] && ![_strChar isEqualToString:@""])
    {
        if ([_strChar isEqualToString:@"＋"] | [_strChar isEqualToString:@"－"] | [_strChar isEqualToString:@"×"] | [_strChar isEqualToString:@"÷"] )
        {
            _strChar = @"";
        }
    }
    else if (![_inPutStr isEqualToString:@""] && ![_labelOperators.text isEqualToString:@""] )
    {
        return;
    }
    else
    {
        if ([[sender currentTitle] isEqualToString:@"＋"]) {
            _strChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum +_leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            [_inPutStr setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResultBottom.text = @"0";
            _leftNum = 0;
            [_labelResultTop setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"－"]) {
            _strChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum -_leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            [_inPutStr setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResultBottom.text = @"0";
            _leftNum = 0;
            [_labelResultTop setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"×"]) {
            _strChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _resultNum = _rightNum *_leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            [_inPutStr setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResultBottom.text = @"0";
            _leftNum = 0;
            [_labelResultTop setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"÷"])
        {
 
            if ([_labelResultBottom.text isEqualToString:@"0"] | [_labelResultBottom.text isEqualToString:@"0."] )
            {
                _strChar = @"÷";
            }
            else
            {
                _strChar = [sender currentTitle];
                //把新输入的_string加入到_num1中
                _leftNum = [_labelResultBottom.text doubleValue];
                //计算结果Num3
                _resultNum = _rightNum / _leftNum ;
                _rightNum = _resultNum ;
                
                _lengthString = [NSString stringWithFormat:@"%f", _rightNum];
                
                _length = [_lengthString length];
                for(int i = 0; i<=5; i++)
                {
                    NSString *subString = [_lengthString substringFromIndex:_length - i];
                    if([subString isEqualToString:@"0"])
                    {
                        _lengthString = [_lengthString substringToIndex:_length - i];
                    }
                }
                //当结尾是.0时删除.0变成整数
                if ([_lengthString hasSuffix:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                    if ([_lengthString hasSuffix:@"."]) {
                        _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                    }
                }
                [_inPutStr setString:@""];
                _labelOperators.text = [sender currentTitle];
                _labelResultBottom.text = @"0";
                _leftNum = 0;
                [_labelResultTop setText:_lengthString];
            }
        }
    }
}
//按下等于号（ = ）事件
- (void)touchEqualSign:(id)sender {
    isMinus = NO;
    _strChar = _labelOperators.text;
    if ([_labelResultBottom.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""] && ![_labelResultTop.text isEqualToString:@""]) {
        _strChar = @"";
        
        return;
    }
    
    if ([_strChar isEqualToString:@"="]) //[_strChar isEqualToString:@""] |
    {
        _strChar = @"";
    }
    else if (![_strChar isEqualToString:@""])
    {
        if ([_strChar isEqualToString:@"＋"]) {
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelResultTop.text doubleValue];
            _resultNum = _rightNum + _leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            _strChar = @"";
            _labelResultBottom.text = [NSString stringWithString: _lengthString];
        }else if ([_strChar isEqualToString:@"－"])
        {
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelResultTop.text doubleValue];
            _resultNum = _rightNum - _leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            _strChar = @"";
            _labelResultBottom.text = [NSString stringWithString: _lengthString];
        }else if ([_strChar isEqualToString:@"×"])
        {
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelResultTop.text doubleValue];
            _resultNum = _rightNum * _leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            _strChar = @"";
            _labelResultBottom.text = [NSString stringWithString: _lengthString];
        }
        else if ([_strChar isEqualToString:@"÷"])
        {
            _leftNum = [_labelResultBottom.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelResultTop.text doubleValue];
            _resultNum = _rightNum / _leftNum ;
            _rightNum = _resultNum ;
            _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
            _length = [_lengthString length];
            for(int i = 0; i<=5; i++)
            {
                NSString *subString = [_lengthString substringFromIndex:_length - i];
                if([subString isEqualToString:@"0"])
                {
                    _lengthString = [_lengthString substringToIndex:_length - i];
                }
                
            }
            //当结尾是.0时删除.0变成整数
            if ([_lengthString hasSuffix:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                if ([_lengthString hasSuffix:@"."]) {
                    _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
                }
            }
            _strChar = @"";
            _labelResultBottom.text = [NSString stringWithString: _lengthString];
        }
        _labelOperators.text = @"=";
        _labelResultTop.text = @"";
        
        isFinish = YES;
    }
}
//按下AC键事件
- (void)touchClean:(id)sender {
    isMinus = NO;
    _lengthString = @"";
    _resultNum = 0;
    _rightNum = 0;
    _leftNum = 0;
    _length = 0;
    [_inPutStr setString:@""];
    _labelResultTop.text = @"";
    _labelOperators.text = @"";
    _labelResultBottom.text = @"0";
    _strChar = @"";
    getPoint = NO;
}
//按下（back）事件
- (void)touchBackSpace:(id)sender {
    isMinus = NO;
    if ([_labelOperators.text isEqualToString:@""] && [_labelResultBottom.text isEqualToString:@"0"] )
    {
        [_inPutStr setString:@""];
        _strChar = @"";
        getPoint = NO;
        
        return;
    }
    else if ([_labelOperators.text isEqualToString:@"="])
    {
        _lengthString = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
        [_inPutStr setString:@""];
        _labelResultTop.text = @"";
        _labelOperators.text = @"";
        _labelResultBottom.text = @"0";
        _strChar = @"";
        getPoint = NO;
    }
    else if([_labelResultBottom.text isEqualToString:@"0."])
    {
        [_inPutStr setString:@""];
        _labelResultBottom.text = @"0";
    }
    else
    {
        
    
        if (![_labelResultBottom.text isEqualToString:@"0"])
        {
            if (_inPutStr.length == 1)
            {
                [_inPutStr setString:@""];
                _labelResultBottom.text = @"0";
                getPoint = NO;
                return;
            }
        
            else if (![_labelResultBottom.text isEqualToString:@"0"]) {
                NSRange deleteRange = { [_inPutStr length] - 1, 1 };
                [_inPutStr deleteCharactersInRange:deleteRange];
            }
            _labelResultBottom.text = _inPutStr;
        }
    }
}
//按下 （±）事件
- (void)touchSign:(id)sender {
    if ([_labelResultBottom.text containsString:@"-"]) {
        isMinus = YES;
    }
    

    if ([_labelOperators.text isEqualToString:@"="]) {
        return;
    }
    _resultNum = [_labelResultBottom.text doubleValue];
    
    _overTurnNum = _resultNum*2;
    
    _overTurnNum =  fabs(_overTurnNum);
    
    if(([_labelResultBottom.text isEqualToString:@"0"] | [_labelResultBottom.text isEqualToString:@"0."])&&[_labelResultTop.text isEqualToString:@""]&&[_labelOperators.text isEqualToString:@""])
    {
        _lengthString = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
        [_inPutStr setString:@""];
        _labelResultTop.text = @"";
        _labelOperators.text = @"";
        _labelResultBottom.text = @"0";
        _strChar = @"";
        return;
    }
    else if (([_labelResultBottom.text isEqualToString:@"0"] | [_labelResultBottom.text isEqualToString:@"0."])&&![_labelOperators.text isEqualToString:@""] )
    {
       
        [_inPutStr setString:@""];
        
        return;
    }
    
    if (isMinus) {
        _resultNum += _overTurnNum;
        isMinus = !isMinus;
        
        _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
        _length = [_lengthString length];
        for(int i = 0; i<=5; i++)
        {
            NSString *subString = [_lengthString substringFromIndex:_length - i];
            if([subString isEqualToString:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:_length - i];
            }
            
        }
        if ([_lengthString hasSuffix:@"0"])
        {
           _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
            if ([_lengthString hasSuffix:@"."]) {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
            }
        }
        
        _labelResultBottom.text = _lengthString;
        [_inPutStr setString:_lengthString];
    }
    else if(![_labelOperators.text isEqualToString:@""] && [_labelResultBottom.text isEqualToString:@"0"])
    {
        return;
    }
    else
    {
        _resultNum -= _overTurnNum;
        isMinus = !isMinus;

        _lengthString = [NSString stringWithFormat:@"%f", _resultNum];
        _length = [_lengthString length];
        for(int i = 0; i<=5; i++)
        {
            NSString *subString = [_lengthString substringFromIndex:_length - i];
            if([subString isEqualToString:@"0"])
            {
                _lengthString = [_lengthString substringToIndex:_length - i];
            }
            
        }
        
        //当结尾是.0时删除.0变成整数
        if ([_lengthString hasSuffix:@"0"])
        {
            _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
            if ([_lengthString hasSuffix:@"."]) {
                _lengthString = [_lengthString substringToIndex:[_lengthString length] - 2];
            }
        }
        //显示结果
        _labelResultBottom.text = _lengthString;
        
        //输入值清零
        [_inPutStr setString:_lengthString];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
