//
//  BTAppDelegate.h
//  aargh
//
//  Created by Benedikt Terhechte on 18/07/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface BTAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webView;
@property (assign) IBOutlet NSLayoutConstraint *loadURLConstraint;
@property (assign) IBOutlet NSView *loadURLView;

- (IBAction)open:(id)sender;
- (IBAction)openURL:(id)sender;
- (IBAction)cancelURL:(id)sender;

- (IBAction)loadURLAction:(id)sender;

@end
