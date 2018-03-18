//
//  SCSiriWaveformView.h
//  SCSiriWaveformView
//
//  Created by Stefan Ceriu on 12/04/2014.
//  Copyright (c) 2014 Stefan Ceriu. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE
@interface SCSiriWaveformView : UIView

/*
 * Tells the waveform to redraw itself using the given level (normalized value)
 */
- (void)updateWithLevel:(CGFloat)level;
- (void)configure;


@property (nonatomic, strong) IBInspectable NSArray *colors;

@property (nonatomic, assign)  IBInspectable CGFloat intensity;

@property (nonatomic, assign) IBInspectable CGFloat frequency;

@property (nonatomic, assign) IBInspectable CGFloat amplitude;

@end
