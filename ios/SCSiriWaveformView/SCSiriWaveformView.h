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

<<<<<<< HEAD
@property (nonatomic, assign)  IBInspectable CGFloat intensity;
=======

@property (nonatomic, assign)  IBInspectable CGFloat intensity;
/*
 * Line width used for the proeminent wave
 * Default: 3.0f
 */
@property (nonatomic, assign)  IBInspectable CGFloat primaryWaveLineWidth;

/*
 * Line width used for all secondary waves
 * Default: 1.0f
 */
@property (nonatomic, assign) IBInspectable CGFloat secondaryWaveLineWidth;

/*
 * The amplitude that is used when the incoming amplitude is near zero.
 * Setting a value greater 0 provides a more vivid visualization.
 * Default: 0.01
 */
@property (nonatomic, assign) IBInspectable CGFloat idleAmplitude;
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2

@property (nonatomic, assign) IBInspectable CGFloat frequency;

<<<<<<< HEAD
@property (nonatomic, assign) IBInspectable CGFloat amplitude;
=======
/*
 * The current amplitude
 */
@property (nonatomic, assign) IBInspectable CGFloat amplitude;

/*
 * The lines are joined stepwise, the more dense you draw, the more CPU power is used.
 * Default: 5
 */
@property (nonatomic, assign) IBInspectable CGFloat density;

/*
 * The phase shift that will be applied with each level setting
 * Change this to modify the animation speed or direction
 * Default: -0.15
 */
@property (nonatomic, assign) IBInspectable CGFloat phaseShift;
>>>>>>> 0613abefb0528881f6caad3377566447ab77a3a2

@end
