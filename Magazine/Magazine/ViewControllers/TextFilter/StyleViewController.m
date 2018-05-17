//
//  StyleViewController.m
//  Magazine
//
//  Created by iOSpro on 25/2/18.
//  Copyright © 2018 iOSpro. All rights reserved.
//

#import "StyleViewController.h"
#import "UIColor+Expanded.h"
#import "StyleText.h"
#import "THLabel.h"

#import "Magazine-Swift.h"

#define TEXT 0
#define STROKE 1
#define BACKGROUND 2
#define SHADOW 3

#define rgba(r,g,b,a)                [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgb(r,g,b)                    rgba(r, g, b, 1.0f)

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0f * M_PI)

@interface StyleViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewEditor;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet THLabel *text;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewColor;
@property (nonatomic, strong) NSArray *colors;
@property (weak, nonatomic) IBOutlet UIButton *btnDownRed;
@property (weak, nonatomic) IBOutlet UIButton *btnUpRed;
@property (weak, nonatomic) IBOutlet UILabel *lbRed;
@property (weak, nonatomic) IBOutlet UISlider *sliderRed;

@property (weak, nonatomic) IBOutlet UIButton *btnDownGreen;
@property (weak, nonatomic) IBOutlet UIButton *btnUpGreen;
@property (weak, nonatomic) IBOutlet UILabel *lbGreen;
@property (weak, nonatomic) IBOutlet UISlider *sliderGreen;

@property (weak, nonatomic) IBOutlet UIButton *btnDownBlue;
@property (weak, nonatomic) IBOutlet UIButton *btnUpBlue;
@property (weak, nonatomic) IBOutlet UILabel *lbBlue;
@property (weak, nonatomic) IBOutlet UISlider *sliderBlue;


@property (weak, nonatomic) IBOutlet UIButton *btnDownAlpha;
@property (weak, nonatomic) IBOutlet UIButton *btnUpAlpha;
@property (weak, nonatomic) IBOutlet UILabel *lbAlpha;
@property (weak, nonatomic) IBOutlet UISlider *sliderAlpha;


@property (weak, nonatomic) IBOutlet UIButton *btnDownWidthStroke;
@property (weak, nonatomic) IBOutlet UIButton *btnUpWidthStroke;
@property (weak, nonatomic) IBOutlet UILabel *lbWidthStroke;
@property (weak, nonatomic) IBOutlet UISlider *sliderWidthStroke;
@property (weak, nonatomic) IBOutlet UIView *viewStroke;

@property (weak, nonatomic) IBOutlet UIButton *btnDownWidthBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnUpWidthBackground;
@property (weak, nonatomic) IBOutlet UILabel *lbWidthBackground;
@property (weak, nonatomic) IBOutlet UISlider *sliderWidthBackground;

@property (weak, nonatomic) IBOutlet UIButton *btnDownHeightBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnUpHeightBackground;
@property (weak, nonatomic) IBOutlet UILabel *lbHeightBackground;
@property (weak, nonatomic) IBOutlet UISlider *sliderHeightBackground;


@property (weak, nonatomic) IBOutlet UIButton *btnDownCornerBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnUpCornerBackground;
@property (weak, nonatomic) IBOutlet UILabel *lbCornerBackground;
@property (weak, nonatomic) IBOutlet UISlider *sliderCornerBackground;

@property (weak, nonatomic) IBOutlet UIView *viewBackground;

@property (weak, nonatomic) IBOutlet UIButton *btnDownShadowAlpha;
@property (weak, nonatomic) IBOutlet UIButton *btnUpShadowAlpha;
@property (weak, nonatomic) IBOutlet UILabel *lbShadowAlpha;
@property (weak, nonatomic) IBOutlet UISlider *sliderShadowAlpha;

@property (weak, nonatomic) IBOutlet UIButton *btnDownShadowBlur;
@property (weak, nonatomic) IBOutlet UIButton *btnUpShadowBlur;
@property (weak, nonatomic) IBOutlet UILabel *lbShadowBlur;
@property (weak, nonatomic) IBOutlet UISlider *sliderShadowBlur;

@property (weak, nonatomic) IBOutlet UIButton *btnDownShadowX;
@property (weak, nonatomic) IBOutlet UIButton *btnUpShadowX;
@property (weak, nonatomic) IBOutlet UILabel *lbShadowX;
@property (weak, nonatomic) IBOutlet UISlider *sliderShadowX;

@property (weak, nonatomic) IBOutlet UIButton *btnDownShadowY;
@property (weak, nonatomic) IBOutlet UIButton *btnUpShadowY;
@property (weak, nonatomic) IBOutlet UILabel *lbShadowY;
@property (weak, nonatomic) IBOutlet UISlider *sliderShadowY;
@property (weak, nonatomic) IBOutlet UIView *viewShadow;
@property (nonatomic) CGRect frameText;

@end

@implementation StyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.userImage;
    
    self.colors = [[NSArray alloc] initWithObjects:@"ffffff", @"bfbfbf", @"808080", @"404040", @"000000",   @"ff8080", @"ff4040", @"e01717", @"990000", @"570000", @"ffcced", @"ff7abd", @"ff4099", @"ff0080", @"c80049",    @"ffffc0", @"ffff8a", @"ffff52", @"9e9e00", @"424200",   @"ffe0b8", @"ffaa55", @"ff8000", @"ff4200", @"8a3800", @"472100",   @"e2aaff", @"c752e6", @"8514b8", @"610575",   @"8aebff", @"38d1f0", @"0f94b3", @"005277", @"00334d",    @"76ffff", @"38f0f0", @"0fbfbf", @"008f8f", @"004242",    @"a3ffe0", @"52e6c2", @"00b394", @"007552", @"003d29",    @"aaffaa", @"42e642", @"1ab31a", @"005200", @"002600",   @"e6ff8a", @"9ef229", @"539e0f", @"2e4700", nil];
    
    
    [self.scrollViewColor setContentSize:CGSizeMake(self.scrollViewColor.frame.size.height * self.colors.count, self.scrollViewColor.frame.size.height)];
    
    for (int i = 0; i < self.colors.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * 50, 0, 50, 50)];
        [button addTarget:self action:@selector(btnSelectColor:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setBackgroundColor:[self colorFromHexString:[self.colors objectAtIndex:i]]];
        [self.scrollViewColor addSubview:button];
    }
    
    CALayer * l = [self.imageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    
    self.sliderAlpha.maximumTrackTintColor = [UIColor blackColor];
    self.sliderRed.maximumTrackTintColor = [UIColor blackColor];
    self.sliderGreen.maximumTrackTintColor = [UIColor blackColor];
    self.sliderBlue.maximumTrackTintColor = [UIColor blackColor];
    self.sliderWidthStroke.maximumTrackTintColor = [UIColor blackColor];
    self.sliderWidthBackground.maximumTrackTintColor = [UIColor blackColor];
    self.sliderHeightBackground.maximumTrackTintColor = [UIColor blackColor];
    self.sliderCornerBackground.maximumTrackTintColor = [UIColor blackColor];
    self.sliderShadowAlpha.maximumTrackTintColor = [UIColor blackColor];
    self.sliderShadowBlur.maximumTrackTintColor = [UIColor blackColor];
    self.sliderShadowX.maximumTrackTintColor = [UIColor blackColor];
    self.sliderShadowY.maximumTrackTintColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    
    self.text.text = self.style.text;
    
    self.text.font = [UIFont fontWithName:self.style.fontName size:50];
    [self loadStyle];
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor blackColor],NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.viewBackground.frame.origin.y + self.viewBackground.frame.size.height)];
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//
//
//    self.navigationController.navigationBarHidden = NO;
//
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}

- (IBAction)btnDoneClicked:(id)sender {

    
    
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[AddTextVC class]]){
//            self.text.shadowBlur = self.style.shadowBlur;
//            self.text.shadowColor = [self colorFromHexString:self.style.shadowColor];
//            self.text.shadowOffset = CGSizeMake(self.style.shadowX, self.style.shadowY);
//            self.text.innerShadowBlur = self.style.shadowBlur;
//            self.text.innerShadowColor = [self colorFromHexString:self.style.shadowColor];
//            self.text.innerShadowOffset = CGSizeMake(self.style.shadowX, self.style.shadowY);
            [StyleViewController loadText:self.style lable:self.text];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.editedStyleText = self.text;
            
            [[self navigationController] popToViewController:obj animated:YES];
            return;
        }
    }
}

- (IBAction)btnCancelClicked:(id)sender {
    //    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}


+ (void)loadTextFontSize:(StyleText *)style lable:(THLabel *)lable {
    lable.font = [UIFont fontWithName:style.fontName size:style.size * 30];
    lable.text = style.text;
    [lable sizeToFit];
    CGRect labelRect = [lable.text
                        boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                                     NSFontAttributeName :lable.font
                                     }
                        context:nil];
    CGRect frame = lable.frame;
    frame.size.height = labelRect.size.height * 2;
    frame.size.width = labelRect.size.width;
    lable.frame = frame;
    if (style.algin == 0) {
        lable.textAlignment = NSTextAlignmentLeft;
    } else if(style.algin == 1) {
        lable.textAlignment = NSTextAlignmentCenter;
    } else {
        lable.textAlignment = NSTextAlignmentRight;
    }
    [[lable superview] layoutSubviews];
}

+ (void)loadText:(StyleText *)style lable:(THLabel *)lable {
    
    CGRect labelRect = [lable.text
                        boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                        options:NSStringDrawingUsesLineFragmentOrigin
                        attributes:@{
                                     NSFontAttributeName :lable.font
                                     }
                        context:nil];
    
    int h = labelRect.size.height;
    
    // Text
    
    UIColor *textColor = [UIColor colorWithHexString:style.textColor];
    textColor = [UIColor colorWithRed:textColor.red green:textColor.green blue:textColor.blue alpha:style.textAlpha];
    lable.textColor = textColor;
    
    // Stroke
    UIColor *strokeColor = [UIColor colorWithHexString:style.strokeColor];
    strokeColor = [UIColor colorWithRed:strokeColor.red green:strokeColor.green blue:strokeColor.blue alpha:style.strokeAlpha];
    lable.strokeColor = strokeColor;
    lable.strokeSize = style.strokeWidth;
    
    //Background
    
    lable.transform= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
    CGRect frame = lable.frame;
    CGPoint center = lable.center;
    frame.size.width = labelRect.size.width + (h * 2 * style.backgroundWidth) + (labelRect.size.width * 0.3);
    frame.size.height = labelRect.size.height + (h * 2 * style.backgroundHeight) + (labelRect.size.height * 0.3);
    lable.frame = frame;
    lable.center = center;
    
    lable.layer.cornerRadius = style.backgroundCorner * h;
    UIColor *backgroundColor = [UIColor colorWithHexString:style.backgroundColor];
    backgroundColor = [UIColor colorWithRed:backgroundColor.red green:backgroundColor.green blue:backgroundColor.blue alpha:style.backgroundAlpha];
    
    lable.backgroundColor = backgroundColor;
    
    // Shadow
    UIColor *shadowColor = [UIColor colorWithHexString:style.shadowColor];
    shadowColor = [UIColor colorWithRed:shadowColor.red green:shadowColor.green blue:shadowColor.blue alpha:style.shadowAlpha];
    lable.shadowColor = shadowColor;
    
    lable.shadowBlur = style.shadowBlur * 10;
    lable.shadowOffset = CGSizeMake(h / 4 * style.shadowX, h / 4 * style.shadowY);
    [[lable superview] layoutSubviews];
}

+ (void)loadTextPosition:(StyleText *)style lable:(THLabel *)lable {
    lable.center = CGPointMake(style.x, style.y);
    lable.transform= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(style.angle));
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
- (void) btnSelectColor:(UIButton *)sender {
    [self setBarColor:[self colorFromHexString:[self.colors objectAtIndex:sender.tag]]];
}

- (void) setBarColor:(UIColor *)color {
    self.sliderRed.value = [color red] * 255;
    self.sliderGreen.value = [color green] * 255;
    self.sliderBlue.value = [color blue] * 255;
    [self slideRedChanged:nil];
    [self slideGreenChanged:nil];
    [self slideBlueChanged:nil];
}

- (void) setBarAlpha:(float)alpha {
    switch (self.segment.selectedSegmentIndex) {
        case TEXT:
        case STROKE:
        case BACKGROUND:
            self.sliderAlpha.value = alpha;
            [self slideAlphaChanged:nil];
            break;
        case SHADOW:
            self.sliderShadowAlpha.value = alpha;
            [self slideShadowAlphaChanged:nil];
            break;
        default:
            break;
    }
}


- (void) setWidthStroke:(int)width {
    self.sliderWidthStroke.value = width;
    [self slideWidthTextChanged:nil];
}

- (void) setBackgroundWidth:(float)width height:(float)height corner:(float)corner {
    self.sliderWidthBackground.value = width;
    self.sliderHeightBackground.value = height;
    self.sliderCornerBackground.value = corner;
    [self slideWidthBackgroundChanged:nil];
    [self slideHeightBackgroundChanged:nil];
    [self slideCornerBackgroundChanged:nil];
}

- (void) setBlur:(float)blur x:(float)x y:(float)y {
    self.sliderShadowBlur.value = self.style.shadowBlur;
    self.sliderShadowX.value = self.style.shadowX;
    self.sliderShadowY.value = self.style.shadowY;
    [self slideShadowBlurChanged:nil];
    [self slideShadowXChanged:nil];
    [self slideShadowYChanged:nil];
}

- (void) shadowChanged {
    self.style.shadowBlur = self.sliderShadowBlur.value;
    self.style.shadowX = self.sliderShadowX.value;
    self.style.shadowY = self.sliderShadowY.value;
    [StyleViewController loadText:self.style lable:self.text];
}

- (void) backgroundChanged {
    self.style.backgroundWidth = self.sliderWidthBackground.value;
    self.style.backgroundHeight = self.sliderHeightBackground.value;
    self.style.backgroundCorner = self.sliderCornerBackground.value;
    [StyleViewController loadText:self.style lable:self.text];
}

- (void) colorChanged {
    switch (self.segment.selectedSegmentIndex) {
        case TEXT:
            self.style.textColor = [rgb(self.sliderRed.value, self.sliderGreen.value, self.sliderBlue.value) hexStringValue];
            break;
        case STROKE:
            self.style.strokeColor = [rgb(self.sliderRed.value, self.sliderGreen.value, self.sliderBlue.value) hexStringValue];
            self.style.strokeWidth = self.sliderWidthStroke.value;
            break;
        case BACKGROUND:
            self.style.backgroundColor = [rgb(self.sliderRed.value, self.sliderGreen.value, self.sliderBlue.value) hexStringValue];
            break;
        case SHADOW:
            self.style.shadowColor = [rgb(self.sliderRed.value, self.sliderGreen.value, self.sliderBlue.value) hexStringValue];
            
            break;
        default:
            break;
    }
    [StyleViewController loadText:self.style lable:self.text];
}


- (void)alphaChanged {
    switch (self.segment.selectedSegmentIndex) {
        case TEXT:
            self.style.textAlpha = self.sliderAlpha.value;
            break;
        case STROKE:
            self.style.strokeAlpha = self.sliderAlpha.value;
            break;
        case BACKGROUND:
            self.style.backgroundAlpha = self.sliderAlpha.value;
            break;
        case SHADOW:
            self.style.shadowAlpha = self.sliderShadowAlpha.value;
            break;
        default:
            break;
    }
    [StyleViewController loadText:self.style lable:self.text];
}

- (void) loadStyle {
    [self setBarColor:[UIColor colorWithHexString:self.style.textColor]];
    [self setBarAlpha:self.style.textAlpha];
    [self setWidthStroke:self.style.strokeWidth];
    [self setBackgroundWidth:self.style.backgroundWidth height:self.style.backgroundHeight corner:self.style.backgroundCorner];
    [self setBlur:self.style.shadowBlur x:self.style.shadowX y:self.style.shadowY];
}
- (IBAction)segmentChange:(UISegmentedControl *)segment {
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:NO];
    [self.viewStroke setHidden:YES];
    [self.viewBackground setHidden:YES];
    [self.viewShadow setHidden:YES];
    switch (segment.selectedSegmentIndex) {
        case TEXT:
            [self setBarColor:[UIColor colorWithHexString:self.style.textColor]];
            [self setBarAlpha:self.style.textAlpha];
            break;
        case STROKE:
            [self.viewStroke setHidden:NO];
            [self setBarColor:[UIColor colorWithHexString:self.style.strokeColor]];
            if (self.style.strokeAlpha == 0 && self.style.strokeWidth == 0) {
                self.style.strokeAlpha = 0.5f;
                self.style.strokeWidth = 3;
            }
            [self setBarAlpha:self.style.strokeAlpha];
            [self setWidthStroke:self.style.strokeWidth];
            break;
        case BACKGROUND:
            [self.viewBackground setHidden:NO];
            if (self.style.backgroundAlpha == 0) {
                self.style.backgroundAlpha = 0.2;
            }
            [self setBarColor:[UIColor colorWithHexString:self.style.backgroundColor]];
            [self setBarAlpha:self.style.backgroundAlpha];
            [self setBackgroundWidth:self.style.backgroundWidth height:self.style.backgroundHeight corner:self.style.backgroundCorner];
            break;
        case SHADOW:
            [self.viewShadow setHidden:NO];
            if (self.style.shadowAlpha == 0 && self.style.shadowBlur == 0) {
                self.style.shadowAlpha = 0.5;
                self.style.shadowBlur = 0.36;
                self.style.shadowX = 0.2;
                self.style.shadowY = 0.2;
            }
            [self setBarColor:[UIColor colorWithHexString:self.style.shadowColor]];
            [self setBarAlpha:self.style.shadowAlpha];
            [self setBlur:self.style.shadowBlur x:self.style.shadowX y:self.style.shadowY];
            break;
        default:
            break;
    }
}



#pragma mark - Color sliders
- (IBAction)btnDownRedClicked:(id)sender {
    self.sliderRed.value -= 1.0f;
    [self slideRedChanged:nil];
}

- (IBAction)btnUpRedClicked:(id)sender {
    self.sliderRed.value += 1.0f;
    [self slideRedChanged:nil];
}

- (IBAction)slideRedChanged:(UISlider *)slider {
    [self.btnDownRed setEnabled:self.sliderRed.value != 0];
    [self.btnUpRed setEnabled:self.sliderRed.value != 255];
    [self.lbRed setText:[NSString stringWithFormat:@"%d", (int)self.sliderRed.value]];
    [self colorChanged];
}

- (IBAction)btnDownGreenClicked:(id)sender {
    self.sliderGreen.value -= 1.0f;
    [self slideGreenChanged:nil];
}

- (IBAction)btnUpGreenClicked:(id)sender {
    self.sliderGreen.value += 1.0f;
    [self slideGreenChanged:nil];
}

- (IBAction)slideGreenChanged:(UISlider *)slider {
    [self.btnDownGreen setEnabled:self.sliderGreen.value != 0];
    [self.btnUpGreen setEnabled:self.sliderGreen.value != 255];
    [self.lbGreen setText:[NSString stringWithFormat:@"%d", (int)self.sliderGreen.value]];
    [self colorChanged];
}


- (IBAction)btnDownBlueClicked:(id)sender {
    self.sliderBlue.value -= 1.0f;
    [self slideBlueChanged:nil];
}

- (IBAction)btnUpBlueClicked:(id)sender {
    self.sliderBlue.value += 1.0f;
    [self slideBlueChanged:nil];
}

- (IBAction)slideBlueChanged:(UISlider *)slider {
    [self.btnDownBlue setEnabled:self.sliderBlue.value != 0];
    [self.btnUpBlue setEnabled:self.sliderBlue.value != 255];
    [self.lbBlue setText:[NSString stringWithFormat:@"%d", (int)self.sliderBlue.value]];
    [self colorChanged];
}


- (IBAction)btnDownAlphaClicked:(id)sender {
    self.sliderAlpha.value -= 0.01f;
    [self slideAlphaChanged:nil];
}

- (IBAction)btnUpAlphaClicked:(id)sender {
    self.sliderAlpha.value += 0.01f;
    [self slideAlphaChanged:nil];
}

- (IBAction)slideAlphaChanged:(UISlider *)slider {
    [self.btnDownAlpha setEnabled:self.sliderAlpha.value != 0];
    [self.btnUpAlpha setEnabled:self.sliderAlpha.value != 1];
    [self.lbAlpha setText:[NSString stringWithFormat:@"%.2f", self.sliderAlpha.value]];
    [self alphaChanged];
}


- (IBAction)btnDownWidthTextClicked:(id)sender {
    self.sliderWidthStroke.value -= 1.0f;
    [self slideWidthTextChanged:nil];
}

- (IBAction)btnUpWidthTextClicked:(id)sender {
    self.sliderWidthStroke.value += 1.0f;
    [self slideWidthTextChanged:nil];
}

- (IBAction)slideWidthTextChanged:(UISlider *)slider {
    [self.btnDownWidthStroke setEnabled:self.sliderWidthStroke.value != 0];
    [self.btnUpWidthStroke setEnabled:self.sliderWidthStroke.value != 8];
    [self.lbWidthStroke setText:[NSString stringWithFormat:@"%d", (int)self.sliderWidthStroke.value]];
    [self colorChanged];
}



- (IBAction)btnDownWidthBackgroundClicked:(id)sender {
    self.sliderWidthBackground.value -= 0.01f;
    [self slideWidthBackgroundChanged:nil];
}

- (IBAction)btnUpWidthBackgroundClicked:(id)sender {
    self.sliderWidthBackground.value += 0.01f;
    [self slideWidthBackgroundChanged:nil];
}

- (IBAction)slideWidthBackgroundChanged:(UISlider *)slider {
    [self.btnDownWidthBackground setEnabled:self.sliderWidthBackground.value != 0];
    [self.btnUpWidthBackground setEnabled:self.sliderWidthBackground.value != 3];
    [self.lbWidthBackground setText:[NSString stringWithFormat:@"%.2f", self.sliderWidthBackground.value]];
    [self backgroundChanged];
}



- (IBAction)btnDownHeightBackgroundClicked:(id)sender {
    self.sliderHeightBackground.value -= 0.01f;
    [self slideHeightBackgroundChanged:nil];
}

- (IBAction)btnUpHeightBackgroundClicked:(id)sender {
    self.sliderHeightBackground.value += 0.01f;
    [self slideHeightBackgroundChanged:nil];
}

- (IBAction)slideHeightBackgroundChanged:(UISlider *)slider {
    [self.btnDownHeightBackground setEnabled:self.sliderHeightBackground.value != 0];
    [self.btnUpHeightBackground setEnabled:self.sliderHeightBackground.value != 2];
    [self.lbHeightBackground setText:[NSString stringWithFormat:@"%.2f", self.sliderHeightBackground.value]];
    [self backgroundChanged];
}


- (IBAction)btnDownCornerBackgroundClicked:(id)sender {
    self.sliderCornerBackground.value -= 0.01f;
    [self slideCornerBackgroundChanged:nil];
}

- (IBAction)btnUpCornerBackgroundClicked:(id)sender {
    self.sliderCornerBackground.value += 0.01f;
    [self slideCornerBackgroundChanged:nil];
}

- (IBAction)slideCornerBackgroundChanged:(UISlider *)slider {
    [self.btnDownCornerBackground setEnabled:self.sliderCornerBackground.value != 0];
    [self.btnUpCornerBackground setEnabled:self.sliderCornerBackground.value != 0.5];
    [self.lbCornerBackground setText:[NSString stringWithFormat:@"%.2f", self.sliderCornerBackground.value]];
    [self backgroundChanged];
}


- (IBAction)btnDownShadowAlphaClicked:(id)sender {
    self.sliderShadowAlpha.value -= 0.01f;
    [self slideShadowAlphaChanged:nil];
}

- (IBAction)btnUpShadowAlphaClicked:(id)sender {
    self.sliderShadowAlpha.value += 0.01f;
    [self slideShadowAlphaChanged:nil];
}

- (IBAction)slideShadowAlphaChanged:(UISlider *)slider {
    [self.btnDownShadowAlpha setEnabled:self.sliderShadowAlpha.value != 0];
    [self.btnUpShadowAlpha setEnabled:self.sliderShadowAlpha.value != 1];
    [self.lbShadowAlpha setText:[NSString stringWithFormat:@"%.2f", self.sliderShadowAlpha.value]];
    [self alphaChanged];
}


- (IBAction)btnDownShadowBlurClicked:(id)sender {
    self.sliderShadowBlur.value -= 0.01f;
    [self slideShadowBlurChanged:nil];
}

- (IBAction)btnUpShadowBlurClicked:(id)sender {
    self.sliderShadowBlur.value += 0.01f;
    [self slideShadowBlurChanged:nil];
}

- (IBAction)slideShadowBlurChanged:(UISlider *)slider {
    [self.btnDownShadowBlur setEnabled:self.sliderShadowBlur.value != 0];
    [self.btnUpShadowBlur setEnabled:self.sliderShadowBlur.value != 1];
    [self.lbShadowBlur setText:[NSString stringWithFormat:@"%.2f", self.sliderShadowBlur.value]];
    [self shadowChanged];
}


- (IBAction)btnDownShadowXClicked:(id)sender {
    self.sliderShadowX.value -= 0.01f;
    [self slideShadowXChanged:nil];
}

- (IBAction)btnUpShadowXClicked:(id)sender {
    self.sliderShadowX.value += 0.01f;
    [self slideShadowXChanged:nil];
}

- (IBAction)slideShadowXChanged:(UISlider *)slider {
    [self.btnDownShadowX setEnabled:self.sliderShadowX.value != 0];
    [self.btnUpShadowX setEnabled:self.sliderShadowX.value != 1];
    [self.lbShadowX setText:[NSString stringWithFormat:@"%.2f", self.sliderShadowX.value]];
    [self shadowChanged];
}


- (IBAction)btnDownShadowYClicked:(id)sender {
    self.sliderShadowY.value -= 0.01f;
    [self slideShadowYChanged:nil];
}

- (IBAction)btnUpShadowYClicked:(id)sender {
    self.sliderShadowY.value += 0.01f;
    [self slideShadowYChanged:nil];
}

- (IBAction)slideShadowYChanged:(UISlider *)slider {
    [self.btnDownShadowY setEnabled:self.sliderShadowY.value != 0];
    [self.btnUpShadowY setEnabled:self.sliderShadowY.value != 1];
    [self.lbShadowY setText:[NSString stringWithFormat:@"%.2f", self.sliderShadowY.value]];
    [self shadowChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

