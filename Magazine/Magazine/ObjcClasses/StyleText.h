//
//  Style.h
//  Ukeblad
//
//  Created by Thanh on 8/30/15.
//  Copyright (c) 2015 Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Text;

@interface StyleText : NSObject
// Text
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) NSString *textColor;
@property (nonatomic) float textAlpha;
@property (nonatomic) float size;
@property (nonatomic) int angle;
@property (nonatomic) float a;
@property (nonatomic) float b;
@property (nonatomic) float c;
@property (nonatomic) float d;
@property (nonatomic) float tx;
@property (nonatomic) float ty;
@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int algin;

//Stroke
@property (nonatomic, strong) NSString *strokeColor;
@property (nonatomic) float strokeAlpha;
@property (nonatomic) int strokeWidth;


//Background
@property (nonatomic, strong) NSString *backgroundColor;
@property (nonatomic) float backgroundAlpha;
@property (nonatomic) float backgroundWidth;
@property (nonatomic) float backgroundHeight;
@property (nonatomic) float backgroundCorner;

//Shadow
@property (nonatomic, strong) NSString *shadowColor;
@property (nonatomic) float shadowAlpha;
@property (nonatomic) float shadowBlur;
@property (nonatomic) float shadowX;
@property (nonatomic) float shadowY;
+ (id) initWithText:(Text *)text;
@end
