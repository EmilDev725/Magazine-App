//
//  Style.m
//  Ukeblad
//
//  Created by Thanh on 8/30/15.
//  Copyright (c) 2015 Gill. All rights reserved.
//

#import "StyleText.h"
#import "Text.h"

@implementation StyleText
- (id) init {
    self = [super init];
    if (self) {
        self.fontName = @"GillSans-Bold";
        self.size = 1;
        self.textAlpha = 1;
        self.algin = 1;
    }
    return self;
}

+ (id) initWithText:(Text *)t {
    StyleText *style = [[StyleText alloc] init];
    style.text = t.text;
    style.fontName = t.font;
    style.textColor = t.color;
    style.textAlpha = t.textAlpha;
    style.size = t.size;
    style.angle = t.angle;
    style.a = t.a;
    style.b = t.b;
    style.c = t.c;
    style.d = t.d;
    style.tx = t.tx;
    style.ty = t.ty;
    style.x = t.x;
    style.y = t.y;
    style.algin = t.algin;
    
    style.strokeAlpha = t.strokeAlpha;
    style.strokeColor = t.strokeColor;
    style.strokeWidth = t.strokeWidth;
    
    style.backgroundColor = t.backgroundColor;
    style.backgroundAlpha = t.backgroundAlpha;
    style.backgroundWidth = t.backgroundWidth;
    style.backgroundHeight = t.backgroundHeight;
    style.backgroundCorner = t.backgroundCorner;
    
    style.shadowColor = t.shadowColor;
    style.shadowAlpha = t.shadowAlpha;
    style.shadowBlur = t.shadowBlur;
    style.shadowX = t.shadowX;
    style.shadowY = t.shadowY;
    return style;

}

@end
