//
//  OSPRendererGL.m
//  test2
//
//  Created by Quang Viet on 2/25/14.
//  Copyright (c) 2014 Quang Viet. All rights reserved.
//

#import "OSPRendererGL.h"
#import "CCPage.h"
#import <GLKit/GLKit.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>

@implementation OSPRendererGL

- (id) init
{
    self = [super init];
    if (self)
    {
        myContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        [EAGLContext setCurrentContext:myContext];
        width = 1024;
        height = 1024;
        [self setupOpenGL];
        [EAGLContext setCurrentContext:nil];
    }
    return self;
}

- (void)dealloc
{
}

-(void) setupOpenGL
{
    glGenFramebuffersOES(1, &framebuffer);
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, framebuffer);
    
    glGenRenderbuffersOES(1, &colorRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_RGBA8_OES, width, height);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
    
    glGenRenderbuffersOES(1, &depthRenderbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
    glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, width, height);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    
    glGenFramebuffersOES(1, &msaaFramebuffer);
    glGenRenderbuffersOES(1, &msaaRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, msaaFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, msaaRenderbuffer);
    
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER_OES, 4, GL_RGBA8_OES, width, height);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, msaaRenderbuffer);
    
    glGenRenderbuffersOES(1, &msaaDepthbuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, msaaDepthbuffer);
    glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER_OES, 4, GL_DEPTH_COMPONENT16_OES, width, height);
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, msaaDepthbuffer);
    
    rightPage_ = [[CCPage alloc] init];
    rightPage_.currentFrame = 0;
    rightPage_.framesPerCycle = 120;
    rightPage_.width = 0.8f;
    rightPage_.height = 1.0f;
    rightPage_.columns = PAGE_COLUMNS;
    rightPage_.rows = PAGE_ROWS;
    [rightPage_ createMesh];
    
    texture[1] = [self loadTextureWithImage:[UIImage imageNamed:@"paper2.png" ]];
    texture[2] = [self loadTextureWithImage:[UIImage imageNamed:@"paper19.png" ]];
}

- (void)setCover:(UIImage*)cover
{
    [EAGLContext setCurrentContext:myContext];
    if (texture[0]) {
        glDeleteTextures(1, &texture[0]);
        texture[0] = 0;
    }
    texture[0] = [self loadTextureWithImage:cover];
    [EAGLContext setCurrentContext:nil];
}

- (void)renderPage:(id)obj withTexture:(GLuint)texId
{
    const Vertex3f  *vertices   = [obj vertices];
    const Vertex2f  *textures   = [obj textureArray];
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    // Load our vertex and texture arrays. This needs to be done only once since the front and back pages share this data.
    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glTexCoordPointer(2, GL_FLOAT, 0, textures);
    
    const GLushort  *frontStrip = [obj frontStrip];
    GLuint   stripLength  = [obj stripLength];
    
    // Draw the front page
    glBindTexture(GL_TEXTURE_2D, texId);
    glDrawElements(GL_TRIANGLE_STRIP, stripLength, GL_UNSIGNED_SHORT, frontStrip);
    
    // This application only creates a single color renderbuffer which is already bound at this point.
    // This call is redundant, but needed if dealing with multiple renderbuffers.
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [myContext presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void)renderShadow:(id)obj
{
    const Vertex3f  *vertices   = [obj vertices];
    
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glDisable(GL_TEXTURE_2D);
    glColor4f(0, 0, 0, 0.7);
    
    const GLushort  *frontStrip = [obj frontStrip];
    GLuint   stripLength  = [obj stripLength];
    glDrawElements(GL_TRIANGLE_STRIP, stripLength, GL_UNSIGNED_SHORT, frontStrip);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [myContext presentRenderbuffer:GL_RENDERBUFFER_OES];
    glColor4f(1, 1, 1, 1);
    glEnable(GL_TEXTURE_2D);
}

-(GLuint)loadTextureWithImage:(UIImage*)image
{
    GLuint texId;
    
    glGenTextures(1, &texId);
    
    glBindTexture(GL_TEXTURE_2D, texId);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
    
    GLuint xwidth = CGImageGetWidth(image.CGImage);
    GLuint xheight = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    xwidth = 1024;
    xheight = 1024;
    
    void *imageData = malloc( xheight * xwidth * 4 );
    
    CGContextRef bitmapContext = CGBitmapContextCreate( imageData, xwidth, xheight, 8, 4 * xwidth, colorSpace,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    
    // Flip the Y-axis
    CGContextTranslateCTM (bitmapContext, 0, xheight);
    CGContextScaleCTM (bitmapContext, 1.0, -1.0);
    
    CGColorSpaceRelease(colorSpace);
    CGContextClearRect(bitmapContext, CGRectMake( 0, 0, xwidth, xheight ) );
    CGContextDrawImage(bitmapContext, CGRectMake( 0, 0, xwidth, xheight ), image.CGImage );
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, xwidth, xheight, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
    
    CGContextRelease(bitmapContext);
    
    free(imageData);
    //    [image release];
    //    [texData release];
    
    return texId;
}

-(UIImage *) render
{
    
    return [self renderWithBackground:[UIImage imageNamed:@"bg1.png"]];
}

-(UIImage *) renderWithBackgroundColor:(UIColor*)color
{
    return [self renderWithBackground:nil color:color];
}

-(UIImage *) renderWithBackground:(UIImage*)srcBackground
{
    return [self renderWithBackground:srcBackground color:nil];
}

-(UIImage *) renderWithBackground:(UIImage*)srcBackground color:(UIColor*)color
{
    [EAGLContext setCurrentContext:myContext];
    
    glBindFramebuffer(GL_FRAMEBUFFER_OES, msaaFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, msaaRenderbuffer);
    
    glViewport(0, 0, width, height);
    glEnable(GL_LINE_SMOOTH);
    glEnable(GL_POINT_SMOOTH);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    if (color)
    {
        const CGFloat *components = CGColorGetComponents([color CGColor]);
        GLfloat red = components[0];
        GLfloat green = components[1];
        GLfloat blue = components[2];
        
        glClearColor(red, green, blue, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    }
    else
    {
        glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    }
    
    const GLfloat zNear = 0.01f, zFar = 100.0f, fieldOfView = 40.0f;
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    GLfloat size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0f);
    GLfloat aspectRatio = (GLfloat) width/height;
    glFrustumf(-size, size, -size / aspectRatio, size / aspectRatio, zNear, zFar);
    glViewport(0, 0, width, height);
    glTranslatef(0.0f, -0.5f, -2.5f);
    
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glEnable(GL_TEXTURE_2D);
    
    glMatrixMode(GL_PROJECTION);
    glTranslatef(-0.35, -0.13, 0);
    glScalef(1.8, 1.8, 1.5);
    
    if (srcBackground)
    {
        if (texture[3]) {
            glDeleteTextures(1, &texture[3]);
            texture[3] = 0;
        }
        texture[3] = [self loadTextureWithImage:srcBackground];
        
        glPushMatrix();
        glTranslatef(0, -0.04, -1);
        glScalef(2.05, 1.62, 0);
        glTranslatef(-0.3, -0.26, 0);
        [rightPage_ deformForTime:0.0001];
        [self renderPage:rightPage_ withTexture:texture[3]];
        
        glMatrixMode(GL_PROJECTION);
        glPopMatrix();
    }
    
    glRotatef(0, 0, 0, 1);
    glRotatef(35, 0, 1, 0);
    glRotatef(-45, 1, 0, 0);
    
    glPushMatrix();
    glTranslatef(-0.004, -0.003, -0.01);
    [rightPage_ deformForTime:0.006];
    [self renderShadow:rightPage_];
    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
    
    glPushMatrix();
    glTranslatef(0.01, 0, 0.002);
    [self renderPage:rightPage_ withTexture:texture[0]];
    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
    
    [rightPage_ deformForTime: 0.008];
    for (int i = 2; i < 6; i++)
    {
        glMatrixMode(GL_PROJECTION);
        glTranslatef(0, 0, 0.004);
        [self renderPage:rightPage_ withTexture:texture[1]];
    }
    [rightPage_ deformForTime:0.014];
    [self renderPage:rightPage_ withTexture:texture[2]];
    
    [rightPage_ deformForTime:0.026];
    [self renderPage:rightPage_ withTexture:texture[0]];
    
    // msaa
    
    glBindFramebufferOES(GL_READ_FRAMEBUFFER_APPLE, msaaFramebuffer);
    glBindFramebufferOES(GL_DRAW_FRAMEBUFFER_APPLE, framebuffer);
    
    glResolveMultisampleFramebufferAPPLE();
    
    glBindFramebuffer(GL_FRAMEBUFFER_OES, framebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER, colorRenderbuffer);
    
    // grabbing image from FBO
    
    GLint backingWidth, backingHeight;
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    NSInteger x = 0, y = 0;
    NSInteger dataLength = width * height * 4;
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, width, height), iref);
    UIImage *ximage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
    
    [EAGLContext setCurrentContext:nil];
    
    return ximage;
}

@end