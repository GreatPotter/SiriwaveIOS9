//
//  SCSiriWaveformView.m
//  SCSiriWaveformView
//
//  Created by Stefan Ceriu on 12/04/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

#import "SCSiriWaveformView.h"
#import "SiriWaveCurve.h"
#import "math.h"

static const CGFloat kDefaultFrequency          = 1.5f;
static const CGFloat kDefaultAmplitude          = 0.1f;
<<<<<<< HEAD

@interface SCSiriWaveformView ()

=======
static const CGFloat kDefaultIdleAmplitude      = 0.01f;
static const CGFloat kDefaultNumberOfWaves      = 5.0f;
static const CGFloat kDefaultPhaseShift         = -0.15f;
static const CGFloat kDefaultDensity            = 5.0f;
static const CGFloat kDefaultPrimaryLineWidth   = 3.0f;
static const CGFloat kDefaultSecondaryLineWidth = 1.0f;

@interface SCSiriWaveformView ()

@property (nonatomic, assign) CGFloat phase;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
@property (nonatomic) NSMutableArray *curves;

@end

@implementation SCSiriWaveformView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.frequency = kDefaultFrequency;
    self.amplitude = kDefaultAmplitude;
<<<<<<< HEAD
=======
    self.idleAmplitude = kDefaultIdleAmplitude;
    
    self.numberOfWaves = kDefaultNumberOfWaves;
    self.phaseShift = kDefaultPhaseShift;
    self.density = kDefaultDensity;
    
    self.primaryWaveLineWidth = kDefaultPrimaryLineWidth;
    self.secondaryWaveLineWidth = kDefaultSecondaryLineWidth;
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
}

-(void)configure
{
    self.curves = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _colors.count; i++) {
<<<<<<< HEAD
        for (int j = 0; j < 3 * ((float)rand() / RAND_MAX) + 1; j++) {
            [self.curves addObject:[[SiriWaveCurve alloc] init]];
=======
        UIColor *col = self.colors[i];
        for (int j = 0; j < 3 * ((float)rand() / RAND_MAX) + 1; j++) {
            SiriWaveCurve *curve = [[SiriWaveCurve alloc] init];
            curve.color = col;
            curve.parent = self;
            [self.curves addObject:curve];
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
        }
    }
}

- (void)updateWithLevel:(CGFloat)level
{
<<<<<<< HEAD
=======
    self.phase += self.phaseShift;
//    self.amplitude = fmax(level, self.idleAmplitude);
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
    CGFloat speed = 0.1;
    if (fabs(self.amplitude - _intensity) < speed) {
        self.amplitude = _intensity;
    } else {
        if (self.amplitude < _intensity) {
            self.amplitude += speed;
        } else {
            self.amplitude -= speed;
        }
    }
    
    [self setNeedsDisplay];
}

// Thanks to Raffael Hannemann https://github.com/raffael/SISinusWaveView
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, self.bounds);
    
    [self.backgroundColor set];
    CGContextFillRect(context, rect);
    
    if (!self.curves) return;
    
    CGFloat height2 = CGRectGetHeight(self.bounds) / 2.0f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat width2 = width / 2.0f;
    CGFloat width4 = width / 4.0f;
    
    for (int i = 0; i < self.curves.count; i++) {
        context = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        CGContextSaveGState(context);
        
        [self.curves[i] changeTick];
        
        const CGFloat maxAmplitude = height2 - 2;
        
        SiriWaveCurve *curve = self.curves[i];
        CGFloat xBase = width2 + (-width4 + curve.seed * width2);
        CGFloat yBase = height2;
        
        CGFloat t_amplitude = (float) (_amplitude / (fabs(width2 - xBase) / width4 + 0.5));
        
        CGFloat x, y, xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase + [self.curves[i] _ypos:j  amplitude:t_amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
<<<<<<< HEAD
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
=======
//                CGContextMoveToPoint(context, x, y);
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
//                CGContextAddLineToPoint(context, x, y);
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
                CGPathAddLineToPoint(path, NULL, x, y);
            }
        }
        CGPathAddLineToPoint(path, NULL, xInit, yBase);
        
        xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase - [self.curves[i] _ypos:j  amplitude:t_amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
<<<<<<< HEAD
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
=======
                //                CGContextMoveToPoint(context, x, y);
                CGPathMoveToPoint(path, NULL, x, y);
            } else {
                //                CGContextAddLineToPoint(context, x, y);
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
                CGPathAddLineToPoint(path, NULL, x, y);
            }
        }
        
        CGFloat h = fabs([curve _ypos:0 amplitude:self.amplitude maxAmplitude:maxAmplitude]);
        
        CGPathAddLineToPoint(path, NULL, xInit, yBase);
        
        CGContextAddPath(context, path);
        CGContextClip(context);
        
<<<<<<< HEAD
=======
//        CGContextStrokePath(context);

>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        UIColor *color = self.colors[i%3];
        const CGFloat *col = CGColorGetComponents( color.CGColor );
        CGFloat components[] = {
            col[0], col[1], col[2], 1.0f,
            col[0], col[1], col[2], 0.2f,
        };
        CGFloat locations[] = {0, 1};
        CGPoint center = CGPointMake(xBase, yBase);

        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, 2);
        CGContextDrawRadialGradient(context, gradient, center, width2 , center, h * 0.3, kCGGradientDrawsAfterEndLocation);
        
<<<<<<< HEAD
=======

        // Release objects
//        CGColorSpaceRelease(colorSpaceRef);
//        CGGradientRelease(gradient);
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2
        CGContextRestoreGState(context);
    }
}

@end

