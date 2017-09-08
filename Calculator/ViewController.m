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



//按下数字1~9事件
-(void)num:(id)sender
{
    if ([_labelOperators.text isEqualToString:@"="]) {
        [_display setString:@""];
        _labelOperators .text = @"";
        _lengthString = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
        [_display setString:@""];
        _labelDisplay.text = @"";
        _labelOperators.text = @"";
        _labelResult.text = @"0";
        _haveChar = @"";
        havePoint = NO;
    }
    [_display appendString:[sender currentTitle]];
    self.labelResult.text = [NSString stringWithString:_display];
    self.resultNum = [self.labelResult.text doubleValue];
    _leftNum = [_display doubleValue];
}
//按下数字0事件
-(void)numZero:(id)sender
{
    if ([_labelOperators.text isEqualToString:@"="]) {
        _labelOperators.text = @"";
        _labelResult.text = @"0";
        [_display setString:@""];
        return;
    }
    [_display appendString:[sender currentTitle]];
    
    if ([_display isEqualToString:@"0"]) {
        [_display setString:@""];
        self.labelResult.text = @"0";
    }
    else
    {
        self.labelResult.text = [NSString stringWithString:_display];
    }
    _leftNum = [_display doubleValue];
    self.resultNum = [self.labelResult.text doubleValue];
}
//按下数字点.事件
-(void)point:(id)sender
{
    if ([_labelResult.text containsString:@"."]) {
        havePoint = YES;
    }
    else
    {
        havePoint = NO;
    }
    if ([_labelOperators.text isEqualToString:@"="]) {
        _labelOperators.text = @"";
        _labelResult.text = @"0";
        [_display setString:@""];
        return;
    }
    
    [_display appendString:[sender currentTitle]];
    
    if ([_display isEqualToString:@"."]) {
        [_display setString:@"0."];
        self.labelResult.text = @"0.";
        havePoint = YES;
        _leftNum = [_display doubleValue];
    }
    else if (havePoint)
    {
            NSRange deleteRange = {[_display length] -1,1};  //创建deleteRange
           [_display deleteCharactersInRange:deleteRange];
    }
   
    _leftNum = [_labelResult.text doubleValue];
    self.labelResult.text = [NSString stringWithString:_display];
    self.resultNum  = [self.labelResult.text doubleValue];

}
//按下运算按钮（＋ － × ÷ ）事件
-(void) operators:(id)sender
{
 
    if (![_labelResult.text isEqualToString:@""] && ![_labelOperators.text isEqualToString:@""] && ![_labelDisplay.text isEqualToString:@""])
    {
    if (isFinish ==YES && ![_labelDisplay.text isEqualToString:@""])
    {
        return;
    }
    if ([_labelOperators.text isEqualToString:@"－"] && [[sender currentTitle]  isEqual: @"×"])
    {
        _labelOperators.text = [NSString stringWithString:[sender currentTitle]];
        _haveChar = @"";
        return;
    }
        _haveChar = [sender currentTitle];
        _labelOperators.text = _haveChar;
        _haveChar = @"";
        return;
    }
    
    if ([_haveChar isEqualToString:@""])
    {
       
        if ([_labelResult.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""]) {
            _labelOperators.text = [sender currentTitle];
            
            return;
        }
        if ([_display isEqualToString:@""]) {
            return;
        }
        _haveChar = [sender currentTitle];
        if(isFinish == YES)
        {
            _leftNum = _resultNum;
            [_display setString:@""];
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
            _labelDisplay.text = [NSString stringWithString:_lengthString];
            _rightNum = _leftNum;
             [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _lengthString = @"";
            _leftNum = 0;
            _length = 0;
            [_display setString:@""];

            isFinish = NO;
            
            if ([_labelResult.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""])
            {
                _haveChar = @"";
                return;
            }
        }
        else
        {
            _rightNum = _leftNum;
            _labelDisplay.text = [NSString stringWithString:_display];
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
        }
    }
    else if([_display isEqualToString:@"0"] && ![_haveChar isEqualToString:@""])
    {
        if ([_haveChar isEqualToString:@"＋"] | [_haveChar isEqualToString:@"－"] | [_haveChar isEqualToString:@"×"] | [_haveChar isEqualToString:@"÷"] )
        {
            _haveChar = @"";
        }
    }
    else if (![_display isEqualToString:@""] && ![_labelOperators.text isEqualToString:@""] )
    {
        return;
    }
    else
    {
        if ([[sender currentTitle] isEqualToString:@"＋"]) {
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
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
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"－"]) {
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
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
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"×"]) {
            _haveChar = [sender currentTitle];
            //把新输入的_string加入到_num1中
            _leftNum = [_labelResult.text doubleValue];
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
            [_display setString:@""];
            _labelOperators.text = [sender currentTitle];
            _labelResult.text = @"0";
            _leftNum = 0;
            [_labelDisplay setText:_lengthString];
        }
        
        if ([[sender currentTitle] isEqualToString:@"÷"])
        {
 
            if ([_labelResult.text isEqualToString:@"0"] | [_labelResult.text isEqualToString:@"0."] )
            {
                _haveChar = @"÷";
            }
            else
            {
                _haveChar = [sender currentTitle];
                //把新输入的_string加入到_num1中
                _leftNum = [_labelResult.text doubleValue];
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
                [_display setString:@""];
                _labelOperators.text = [sender currentTitle];
                _labelResult.text = @"0";
                _leftNum = 0;
                [_labelDisplay setText:_lengthString];
            }
        }
    }
}
//按下等于号（ = ）事件
-(void)run:(id)sender
{
    isMinus = NO;
    _haveChar = _labelOperators.text;
    if ([_labelResult.text isEqualToString:@"0"] && ![_labelOperators.text isEqualToString:@""] && ![_labelDisplay.text isEqualToString:@""]) {
        _haveChar = @"";
        
        return;
    }
    
    if ([_haveChar isEqualToString:@"="]) //[_haveChar isEqualToString:@""] |
    {
        _haveChar = @"";
    }
    else if (![_haveChar isEqualToString:@""])
    {
        if ([_haveChar isEqualToString:@"＋"]) {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelDisplay.text doubleValue];
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
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }else if ([_haveChar isEqualToString:@"－"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelDisplay.text doubleValue];
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
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }else if ([_haveChar isEqualToString:@"×"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelDisplay.text doubleValue];
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
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }
        else if ([_haveChar isEqualToString:@"÷"])
        {
            _leftNum = [_labelResult.text doubleValue];
            //计算结果Num3
            _rightNum = [_labelDisplay.text doubleValue];
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
            _haveChar = @"";
            _labelResult.text = [NSString stringWithString: _lengthString];
        }
        _labelOperators.text = @"=";
        _labelDisplay.text = @"";
        
        isFinish = YES;
    }
}
//按下AC键事件
-(void)clean:(id)sender
{
    isMinus = NO;
    _lengthString = @"";
    _resultNum = 0;
    _rightNum = 0;
    _leftNum = 0;
    _length = 0;
    [_display setString:@""];
    _labelDisplay.text = @"";
    _labelOperators.text = @"";
    _labelResult.text = @"0";
    _haveChar = @"";
    havePoint = NO;
}
//按下（back）事件
-(void)back:(id)sender
{
    isMinus = NO;
    if ([_labelOperators.text isEqualToString:@""] && [_labelResult.text isEqualToString:@"0"] )
    {
        [_display setString:@""];
        _haveChar = @"";
        havePoint = NO;
        
        return;
    }
    else if ([_labelOperators.text isEqualToString:@"="])
    {
        _lengthString = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
        [_display setString:@""];
        _labelDisplay.text = @"";
        _labelOperators.text = @"";
        _labelResult.text = @"0";
        _haveChar = @"";
        havePoint = NO;
    }
    else if([_labelResult.text isEqualToString:@"0."])
    {
        [_display setString:@""];
        _labelResult.text = @"0";
    }
    else
    {
        
    
        if (![_labelResult.text isEqualToString:@"0"])
        {
            if (_display.length == 1)
            {
                [_display setString:@""];
                _labelResult.text = @"0";
                havePoint = NO;
                return;
            }
        
            else if (![_labelResult.text isEqualToString:@"0"]) {
                NSRange deleteRange = { [_display length] - 1, 1 };
                [_display deleteCharactersInRange:deleteRange];
            }
            _labelResult.text = _display;
        }
    }
}
//按下 （±）事件
-(void)overTern:(id)sender
{
    if ([_labelResult.text containsString:@"-"]) {
        isMinus = YES;
    }
    

    if ([_labelOperators.text isEqualToString:@"="]) {
        return;
    }
    _resultNum = [_labelResult.text doubleValue];
    
    _overTurnNum = _resultNum*2;
    
    _overTurnNum =  fabs(_overTurnNum);
    
    if(([_labelResult.text isEqualToString:@"0"] | [_labelResult.text isEqualToString:@"0."])&&[_labelDisplay.text isEqualToString:@""]&&[_labelOperators.text isEqualToString:@""])
    {
        _lengthString = @"";
        _resultNum = 0;
        _rightNum = 0;
        _leftNum = 0;
        _length = 0;
        [_display setString:@""];
        _labelDisplay.text = @"";
        _labelOperators.text = @"";
        _labelResult.text = @"0";
        _haveChar = @"";
        return;
    }
    else if (([_labelResult.text isEqualToString:@"0"] | [_labelResult.text isEqualToString:@"0."])&&![_labelOperators.text isEqualToString:@""] )
    {
       
        [_display setString:@""];
        
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
        
        _labelResult.text = _lengthString;
        [_display setString:_lengthString];
    }
    else if(![_labelOperators.text isEqualToString:@""] && [_labelResult.text isEqualToString:@"0"])
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
        _labelResult.text = _lengthString;
        
        //输入值清零
        [_display setString:_lengthString];
        
    }
}


//UI及其他工具
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化可变字符串，分配内存
    self.display=[NSMutableString stringWithCapacity:20];
    _haveChar = @"";
    _lengthString = @"";
    _resultNum = 0;
    _rightNum = 0;
    _leftNum = 0;
    _length = 0;
    [_display setString:@""];
    _labelDisplay.text = @"";
    _labelOperators.text = @"";
    _labelResult.text = @"0";
    havePoint = NO;
    
    //MARK1 : -总体UI搭建和相关设置
    
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
    if (_DeviceScreenWidth == 320 && _DeviceScreenHeight == 480)
    {
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
    labelRect.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:labelRect];
    
    
    //搭建UI
    
    //创建ResultLabel1
    self.labelResult = [[UILabel alloc]initWithFrame:CGRectMake(0, ResultLabelRectHeight/2, ResultLabelRectWidth-20, ResultLabelRectHeight/2)] ;
    [self.view addSubview:_labelResult] ;
    self.labelResult.backgroundColor = [UIColor blackColor] ;
    self.labelResult.textColor = [UIColor whiteColor] ;
    self.labelResult.textAlignment = NSTextAlignmentRight;
    self.labelResult.font = [UIFont systemFontOfSize:_fontSize] ;
    self.labelResult.text = @"0";
    
    //创建ResultlabelDisplay
    _labelDisplay = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ResultLabelRectWidth-20, ResultLabelRectHeight/2)];
    [self.view addSubview:_labelDisplay];
    self.labelDisplay.backgroundColor = [UIColor blackColor] ;
    self.labelDisplay.textColor = [UIColor whiteColor] ;
    self.labelDisplay.textAlignment = NSTextAlignmentRight;
    self.labelDisplay.font = [UIFont systemFontOfSize:_fontSize-15] ;
    self.labelDisplay.text = @"";
    
    //创建ResultlabelOperators
    _labelOperators = [[UILabel alloc]initWithFrame:CGRectMake(0, ButtonHeight+30, ButtonWidth/2, ButtonHeight-30)];
    [self.view addSubview:_labelOperators];
    self.labelOperators.backgroundColor = [UIColor blackColor] ;
    self.labelOperators.textColor = [UIColor whiteColor] ;
    self.labelOperators.textAlignment = NSTextAlignmentCenter;
    self.labelOperators.font = [UIFont systemFontOfSize:_fontSize-6] ;
    self.labelOperators.text = @"";
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
            self.button.tag = n;
            
            [self.view addSubview:_button] ;
            [self.button addTarget:self action:@selector(num:) forControlEvents:UIControlEventTouchUpInside] ;
        }
    }
    
    
    //添加数字 ”0“
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
    button0.frame = CGRectMake(0, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth*2, ButtonHeight);
    
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
    
    button0.tag = 0;
    [button0 setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(numZero:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:button0] ;
    
    
    //添加 “.” 小数点
    UIButton *buttonPoint = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonPoint setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight+ButtonRectHeight/5*4, ButtonWidth, ButtonHeight)];
    [buttonPoint setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonPoint setTitle:@"." forState:UIControlStateNormal] ;
    [buttonPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [buttonPoint setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    buttonPoint.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    buttonPoint.tag = 10;
    
    [buttonPoint.layer setMasksToBounds:YES];
    buttonPoint.layer.borderWidth = 0.5;
    [buttonPoint.layer setBorderColor:[[UIColor darkGrayColor]CGColor]] ;
    
    
    [buttonPoint addTarget:self action:@selector(point:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonPoint] ;
    
    
    
    //添加运算符：
    NSArray *array1 = [NSArray arrayWithObjects:@"＋",@"－",@"×",@"÷", nil] ;
    for (int i = 0; i<4; i++)
    {
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setFrame:CGRectMake(ButtonWidth*3, ResultLabelRectHeight+ButtonHeight*i, ButtonWidth, ButtonWidth)] ;
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"keypad_button_colored_background"] forState:UIControlStateNormal];
        [button1 setTintColor:[UIColor whiteColor]];
        button1.tag = i;
        
        [button1.layer setMasksToBounds:YES];
        [button1.layer setCornerRadius:0.0];
        [button1.layer setBorderWidth:.5];
        [button1.layer setBorderColor:[[UIColor darkGrayColor]CGColor]];
        
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button1.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize] ;
        [self.view addSubview: button1] ;
        [button1 addTarget:self action:@selector(operators:) forControlEvents:UIControlEventTouchUpInside] ;
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
    
    buttonEqualSign.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    
    [buttonEqualSign addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside] ;
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
    
    buttonClean.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [buttonClean addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonClean] ;
    
    
    //添加“back”按钮
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom] ;
    [buttonBack setFrame:CGRectMake(ButtonWidth*2, ResultLabelRectHeight, ButtonWidth, ButtonHeight)] ;
    [buttonBack setImage:[UIImage imageNamed:@"back"]forState:UIControlStateNormal];
   // [buttonBack setBackgroundImage:[UIImage imageNamed:@"keypad_button_darker_background"] forState:UIControlStateNormal];
    [buttonBack setTintColor:[UIColor blackColor]];
    
    [buttonBack.layer setMasksToBounds:YES];
    [buttonBack.layer setCornerRadius:.0];
    [buttonBack.layer setBorderWidth:.5];
    [buttonBack.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    [buttonBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:buttonBack] ;
    
    //添加“+/-”按钮
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(ButtonWidth, ResultLabelRectHeight, ButtonWidth, ButtonHeight)];
    [button3 setTitle:@"±" forState:UIControlStateNormal];
    [button3 setTintColor:[UIColor whiteColor]];
    
    
    [button3.layer setMasksToBounds:YES];
    [button3.layer setCornerRadius:.0];
    [button3.layer setBorderWidth:.5];
    [button3.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    [button3.layer setMasksToBounds:YES];
    [button3.layer setBorderWidth:.5];
    [button3.layer setBorderColor:[[UIColor grayColor]CGColor]];
    
    button3.titleLabel.font = [UIFont fontWithName:@"STHeitiTC-Light" size:_fontSize];
    [button3 addTarget:self action:@selector(overTern:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    //以上完成UI搭建
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
