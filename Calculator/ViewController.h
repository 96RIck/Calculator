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
    BOOL isMinus;
    BOOL getPoint;
    BOOL isFinish;
    BOOL isFirstInput;
    BOOL isSecondInput;
}

@property(nonatomic,retain) NSMutableString *inPutStr;
@property(nonatomic,retain) UIButton *button ;

@property(nonatomic,assign) NSInteger fontSize;
@property(nonatomic,assign) NSInteger length;
@property(nonatomic,assign) NSInteger DeviceScreenWidth ;
@property(nonatomic,assign) NSInteger DeviceScreenHeight ;

@property(nonatomic,retain) UILabel *labelResultTop ;
@property(nonatomic,retain) UILabel *labelOperators ;
@property(nonatomic,retain) UILabel *labelResultBottom ;

@property(nonatomic,retain) NSString *strChar;
@property(nonatomic,retain) NSString *lengthString;

@property(nonatomic,assign) double leftNum;
@property(nonatomic,assign) double rightNum;
@property(nonatomic,assign) double resultNum;
@property(nonatomic,assign) double overTurnNum;

@property(nonatomic,retain) NSArray *numbers;
@property(nonatomic,retain) NSArray *Operators;

@end

