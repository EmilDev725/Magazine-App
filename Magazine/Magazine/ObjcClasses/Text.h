//
//  Text.h
//  Ukeblad
//
//  Created by Thanh on 9/1/15.
//  Copyright (c) 2015 Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class StyleText;
@interface Text : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * font;
@property (nonatomic) float size;
@property (nonatomic) float textAlpha;
@property (nonatomic, retain) NSString * text;
@property (nonatomic) float  x;
@property (nonatomic) float  y;
@property (nonatomic) float  angle;

@property (nonatomic) float  a;
@property (nonatomic) float  b;
@property (nonatomic) float  c;
@property (nonatomic) float  d;
@property (nonatomic) float  tx;
@property (nonatomic) int  algin;
@property (nonatomic) float  ty;
@property (nonatomic, retain) NSString * strokeColor;
@property (nonatomic) float  strokeAlpha;
@property (nonatomic) int  strokeWidth;
@property (nonatomic, retain) NSString * backgroundColor;
@property (nonatomic) float  backgroundAlpha;
@property (nonatomic) float  backgroundWidth;
@property (nonatomic) float  backgroundHeight;
@property (nonatomic) float  backgroundCorner;
@property (nonatomic, retain) NSString * shadowColor;
@property (nonatomic) float  shadowAlpha;
@property (nonatomic) float  shadowBlur;
@property (nonatomic) float  shadowX;
@property (nonatomic) float  shadowY;

+ (Text *) create: (NSManagedObjectContext *) context;
+ (Text *) create: (NSManagedObjectContext *) context style:(StyleText *)style;
@end
