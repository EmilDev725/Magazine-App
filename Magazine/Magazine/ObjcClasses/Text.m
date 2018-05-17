//
//  Text.m
//  Ukeblad
//
//  Created by Thanh on 9/1/15.
//  Copyright (c) 2015 Gill. All rights reserved.
//

#import "Text.h"
#import "StyleText.h"


@implementation Text

@dynamic color;
@dynamic font;
@dynamic size;
@dynamic text;
@dynamic textAlpha;
@dynamic x;
@dynamic y;
@dynamic angle;
@dynamic a;
@dynamic b;
@dynamic c;
@dynamic d;
@dynamic tx;
@dynamic algin;
@dynamic ty;
@dynamic strokeColor;
@dynamic strokeAlpha;
@dynamic strokeWidth;
@dynamic backgroundColor;
@dynamic backgroundAlpha;
@dynamic backgroundWidth;
@dynamic backgroundHeight;
@dynamic backgroundCorner;
@dynamic shadowColor;
@dynamic shadowAlpha;
@dynamic shadowBlur;
@dynamic shadowX;
@dynamic shadowY;

+ (Text *) create: (NSManagedObjectContext *) context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Text" inManagedObjectContext:context];
}

+ (Text *) create: (NSManagedObjectContext *) context style:(StyleText *)t{
    
    Text *text =  [NSEntityDescription insertNewObjectForEntityForName:@"Text" inManagedObjectContext:context];
    
    text.text = t.text;
    text.font = t.fontName;
    text.color = t.textColor;
    text.textAlpha = t.textAlpha;
    text.size = t.size;
    text.angle = t.angle;
    text.a = t.a;
    text.b = t.b;
    text.c = t.c;
    text.d = t.d;
    text.tx = t.tx;
    text.ty = t.ty;
    text.x = t.x;
    text.y = t.y;
    text.algin = t.algin;
    
    text.strokeAlpha = t.strokeAlpha;
    text.strokeColor = t.strokeColor;
    text.strokeWidth = t.strokeWidth;
    
    text.backgroundColor = t.backgroundColor;
    text.backgroundAlpha = t.backgroundAlpha;
    text.backgroundWidth = t.backgroundWidth;
    text.backgroundHeight = t.backgroundHeight;
    text.backgroundCorner = t.backgroundCorner;
    
    text.shadowColor = t.shadowColor;
    text.shadowAlpha = t.shadowAlpha;
    text.shadowBlur = t.shadowBlur;
    text.shadowX = t.shadowX;
    text.shadowY = t.shadowY;
    return text;
}
@end
