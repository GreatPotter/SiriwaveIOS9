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
static const CGFloat kDefaultAmplitude          = 1.0f;
static const CGFloat kDefaultIdleAmplitude      = 0.01f;
static const CGFloat kDefaultNumberOfWaves      = 5.0f;
static const CGFloat kDefaultPhaseShift         = -0.15f;
static const CGFloat kDefaultDensity            = 5.0f;
static const CGFloat kDefaultPrimaryLineWidth   = 3.0f;
static const CGFloat kDefaultSecondaryLineWidth = 1.0f;

@interface SCSiriWaveformView ()

@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat amplitude;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic) NSMutableArray *curves;


@end

@implementation SCSiriWaveformView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        _width = frame.size.width;
        _height = frame.size.height;
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
    self.waveColor = [UIColor whiteColor];
    
    self.frequency = kDefaultFrequency;
    
    self.amplitude = kDefaultAmplitude;
    self.idleAmplitude = kDefaultIdleAmplitude;
    
    self.numberOfWaves = kDefaultNumberOfWaves;
    self.phaseShift = kDefaultPhaseShift;
    self.density = kDefaultDensity;
    
    self.primaryWaveLineWidth = kDefaultPrimaryLineWidth;
    self.secondaryWaveLineWidth = kDefaultSecondaryLineWidth;
    
    self.colors = [NSArray arrayWithObjects :
                    [UIColor colorWithRed:32.0/255.0 green:133.0/255.0 blue:252.0/255.0 alpha:1.0],
                    [UIColor colorWithRed:94.0/255.0 green:252.0/255.0 blue:169.0/255.0 alpha:1.0],
                    [UIColor colorWithRed:253.0/255.0 green:71.0/255.0 blue:103.0/255.0 alpha:1.0],
                    nil];
}

-(void)configure
{
    self.curves = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _colors.count; i++) {
        UIColor *col = self.colors[i];
        for (int j = 0; j < 3 * ((float)rand() / RAND_MAX); j++) {
            SiriWaveCurve *curve = [[SiriWaveCurve alloc] init];
            curve.color = col;
            curve.parent = self;
            [self.curves addObject:curve];
        }
    }
}

- (void)updateWithLevel:(CGFloat)level
{
    self.phase += self.phaseShift;
    self.amplitude = fmax(level, self.idleAmplitude);
    
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
    // We draw multiple sinus waves, with equal phases but altered amplitudes, multiplied by a parable function.
    for (int i = 0; i < self.curves.count; i++) {
        
        CGFloat height2 = CGRectGetHeight(self.bounds) / 2.0f;
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat width2 = width / 2.0f;
        CGFloat width4 = width / 4.0f;
        
        
        CGFloat progress = 1.0f - (CGFloat)i / self.numberOfWaves;
        
        CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
        [[self.waveColor colorWithAlphaComponent:multiplier * CGColorGetAlpha(self.waveColor.CGColor)] set];
        [self.curves[i] changeTick];
        
        const CGFloat maxAmplitude = height2 - 2;
        
        SiriWaveCurve *curve = self.curves[i];
        CGFloat xBase = width2 + (-width4 + curve.seed * width2);
        CGFloat yBase = height2;
        
        CGFloat x, y, xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase + [self.curves[i] _ypos:j  amplitude:self.amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
                CGContextMoveToPoint(context, x, y);
            } else {
                CGContextAddLineToPoint(context, x, y);
            }
        }
        
        xInit = 10000000;
        for (CGFloat j = -3; j <= 3; j += 0.01) {
            x = xBase + j * width4;
            y = yBase - [self.curves[i] _ypos:j  amplitude:self.amplitude maxAmplitude:maxAmplitude];
            
            xInit = fmin(xInit, x);
            
            if (j == -3) {
                CGContextMoveToPoint(context, x, y);
            } else {
                CGContextAddLineToPoint(context, x, y);
            }
        }
        
        CGContextStrokePath(context);
//
//        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
//        UIColor *color = self.colors[i%3];
//        const CGFloat *col = CGColorGetComponents( color.CGColor );
//        CGFloat components[] = {
//            col[0], col[1], col[2], 0.4f,
//            col[0], col[1], col[2], 0.2f,
//        };
//        CGFloat locations[] = {0, 1};
//        CGPoint center = CGPointMake(xBase, yBase);
//
//        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, 2);
//        CGContextDrawRadialGradient(context, gradient, center, _height * 1.15, center, _height * 0.3, 0);
//
//        // Release objects
//        CGColorSpaceRelease(colorSpaceRef);
//        CGGradientRelease(gradient);
    }
}

@end

