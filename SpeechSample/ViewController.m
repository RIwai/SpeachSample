//
//  ViewController.m
//  SpeechSample
//
//  Created by Ryota Iwai on 2014/04/17.
//  Copyright (c) 2014年 Ryota Iwai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
	self.speechSynthesizer.delegate = self;

	self.poseButton.enabled = NO;
	self.stopButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Speak
- (void)speak {
	NSString *speechText = self.inputTextView.text;
	if (speechText == nil || speechText.length == 0) {
		return;
	}
    [self.inputTextView resignFirstResponder];

	// AVSpeechUtteranceに再生テキストを設定し、インスタンス作成
	AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speechText];
	// 日本語に設定し、AVSpeechSynthesisVoiceのインスタンス作成
	AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ja-JP"];
	// AVSpeechSynthesisVoiceをAVSpeechUtterance.voiceに指定。
	utterance.voice =  voice;

	utterance.rate = self.rateSlider.value;
	utterance.pitchMultiplier = self.pitchSlider.value;

	// 少しだけ発話前にためを作りたいので、Delayに値を設定
	utterance.preUtteranceDelay = 0.2f;
	// 再生開始
	[self.speechSynthesizer speakUtterance:utterance];
}

#pragma mark - Action Method

- (IBAction)tapSpeech:(id)sender {
	[self speak];
}

- (IBAction)tapPause:(id)sender {
	if (self.speechSynthesizer.paused == YES) {
		[self.speechSynthesizer continueSpeaking];
		[self.poseButton setTitle:@"Resume!" forState:UIControlStateNormal];
	}
	else {
		[self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
		[self.poseButton setTitle:@"Pause!" forState:UIControlStateNormal];
	}
}

- (IBAction)tapFinish:(id)sender {
	[self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (IBAction)rateChange:(id)sender
{
    self.rateLabel.text = [NSString stringWithFormat:@"Rate: %1.1f",self.rateSlider.value];
}

- (IBAction)pitchChange:(id)sender
{
    self.pitchLabel.text = [NSString stringWithFormat:@"Pitch: %1.1f",self.pitchSlider.value];
}

#pragma mark - AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
	NSLog(@"読み上げを開始しました");

	[self.poseButton setTitle:@"Pause!" forState:UIControlStateNormal];
	self.speechButton.enabled = NO;
	self.poseButton.enabled = YES;
	self.stopButton.enabled = YES;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
	NSLog(@"読み上げを終了しました");
	self.speechButton.enabled = YES;
	self.poseButton.enabled = NO;
	self.stopButton.enabled = NO;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
	NSLog(@"読み上げを一時停止しました");
	self.speechButton.enabled = YES;
	self.poseButton.enabled = YES;
	self.stopButton.enabled = NO;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
	NSLog(@"読み上げを再開しました");
	self.speechButton.enabled = NO;
	self.poseButton.enabled = YES;
	self.stopButton.enabled = NO;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
	NSLog(@"読み上げを停止しました");
	self.speechButton.enabled = YES;
	self.poseButton.enabled = NO;
	self.stopButton.enabled = NO;
}

@end
