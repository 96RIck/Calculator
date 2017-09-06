//
//  ViewController.h
//  Calculator
//
//  Created by Rick on 2017/9/2.
//  Copyright © 2017年 Rick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ViewController : UIViewController
{
    BOOL isPlus;
    BOOL isMinus;
    BOOL isMultiply;
    BOOL isDivide;
    BOOL isleftNum;
    BOOL isrightNum;
    BOOL havePoint;
    BOOL isOperate;
    BOOL isFirstInput;
    BOOL isSecondInput;
}
@property(nonatomic,retain) UIButton *button ;
@property(nonatomic,assign) int fontSize;
@property(nonatomic,assign) int length;
@property(nonatomic,retain) UILabel *labelResult ;
@property(nonatomic,retain) UILabel *labelOperators ;
@property(nonatomic,retain) UILabel *labelDisplay ;
@property(nonatomic,assign) CGFloat DeviceScreenWidth ;
@property(nonatomic,assign) CGFloat DeviceScreenHeight ;

@property(nonatomic,retain) NSMutableString *display;
@property(nonatomic,retain) NSString *haveChar;
@property(nonatomic,retain) NSString *lengthString;
@property(nonatomic,assign) double leftNum;
@property(nonatomic,assign) double rightNum;
@property(nonatomic,assign) double resultNum;
@property(nonatomic,assign) double numDisplay;

@property(nonatomic,retain) NSArray *numbers;
@property(nonatomic,retain) NSArray *Operators;
@property(nonatomic,retain) NSArray *Clears;




@end

