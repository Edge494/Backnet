//
//  AppDelegate.h
//  Backnet
//
//  Created by Edmond van der Plas on 16-03-13.
//  Copyright (c) 2013 Edmond van der Plas. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppDelegate : NSObject <NSApplicationDelegate>


@property (assign) IBOutlet NSWindow *window;
- (IBAction)connect:(id)sender; 
- (IBAction)sync:(id)sender;
- (IBAction)takeIPFrom:(id)sender;
- (IBAction)takeAccountFrom:(id)sender;
- (IBAction)takePasswordFrom:(id)sender;
- (IBAction)takeBronMapFrom:(id)sender;
- (IBAction)takeDoelMapFrom:(id)sender;
- (IBAction)disconnect:(id)sender;

@property (weak) IBOutlet NSTextField *ipField;
@property (weak) IBOutlet NSTextField *accountField;
@property (weak) IBOutlet NSSecureTextField *passwordField;
@property (weak) IBOutlet NSTextField *bronMapField;
@property (weak) IBOutlet NSTextField *doelMapField;
@property (weak) IBOutlet NSTextFieldCell *textView;

// - (void)readPipe:(NSNotification *)notification;

@end
