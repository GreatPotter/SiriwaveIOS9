//
//  SiriWaveCurve.h
//  RNSiriWaveView
//
//  Created by Harry Potter on 3/16/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "SCSiriWaveformView.h"

@class SCSiriWaveformView;

@interface SiriWaveCurve : NSObject

@property (nonatomic, weak) SCSiriWaveformView *parent;
@property (nonatomic, assign) CGFloat tick;
@property (nonatomic, assign) CGFloat amplitude;
@property (nonatomic, assign) CGFloat seed;
@property (nonatomic, assign) CGFloat openClass;
@property (nonatomic) UIColor *color;

- (void)respawn;

- (CGFloat)_ypos:(CGFloat)i amplitude:(CGFloat)amplitude maxAmplitude:(CGFloat)maxAmplitude;

- (void)changeTick;

@end
