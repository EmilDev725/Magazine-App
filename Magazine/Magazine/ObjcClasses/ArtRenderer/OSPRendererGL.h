#import "CCCommon.h"
#import "CCPage.h"
#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <UIKit/UIKit.h>

@interface OSPRendererGL: NSObject
{
    EAGLContext* myContext;
    GLuint framebuffer;
    GLuint colorRenderbuffer;
    GLuint depthRenderbuffer;
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    GLuint resolveFramebuffer;
    GLuint msaaFramebuffer, msaaRenderbuffer, msaaDepthbuffer;
    
    int width;
    int height;
    GLuint texture[5];
    
    CCPage *rightPage_;
}

- (void)setCover:(UIImage*)cover;
-(void) setupOpenGL;
-(id) init;
-(GLuint)loadTextureWithImage:(UIImage*)image;
-(UIImage *) render;
-(UIImage *) renderWithBackground:(UIImage*)srcBackground;
-(UIImage *) renderWithBackgroundColor:(UIColor*)color;
-(UIImage *) renderWithBackground:(UIImage*)srcBackground color:(UIColor*)color;

@end
