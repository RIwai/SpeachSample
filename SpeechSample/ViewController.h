//
//  ViewController.h
//  SpeechSample
//
//  Created by Ryota Iwai on 2014/04/17.
//  Copyright (c) 2014年 Ryota Iwai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVSpeechSynthesizerDelegate>

@property (nonatomic, weak) IBOutlet UITextView *inputTextView;
@property (nonatomic, weak) IBOutlet UIButton *speechButton;
@property (nonatomic, weak) IBOutlet UIButton *poseButton;
@property (nonatomic, weak) IBOutlet UIButton *stopButton;

@property (nonatomic, weak) IBOutlet UILabel *rateLabel;
@property (nonatomic, weak) IBOutlet UISlider *rateSlider;

@property (nonatomic, weak) IBOutlet UILabel *pitchLabel;
@property (nonatomic, weak) IBOutlet UISlider *pitchSlider;

@property (nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;

- (IBAction)tapSpeech:(id)sender;
- (IBAction)tapPause:(id)sender;
- (IBAction)tapFinish:(id)sender;

- (IBAction)rateChange:(id)sender;
- (IBAction)pitchChange:(id)sender;


@end
