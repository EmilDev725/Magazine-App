//
//  StyleViewController.h
//  Magazine
//
//  Created by iOSpro on 25/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StyleText;
@class THLabel;

@interface StyleViewController : UIViewController
@property (nonatomic, strong) StyleText *style;
@property (nonatomic, strong) UIImage *userImage;

+ (void)loadTextFontSize:(StyleText *)style lable:(THLabel *)lable;

+ (void)loadText:(StyleText *)style lable:(THLabel *)lable;

+ (void)loadTextPosition:(StyleText *)style lable:(THLabel *)lable;

@end

