//
//  BTAppDelegate.m
//  aargh
//
//  Created by Benedikt Terhechte on 18/07/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import "BTAppDelegate.h"

@implementation BTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
}

- (IBAction)open:(id)sender {
    
    [self toggleURLFieldHide];
    
    NSOpenPanel *openPanel = [[NSOpenPanel alloc] init];
    openPanel.allowedFileTypes = @[@"htm", @"html"];
    openPanel.allowsMultipleSelection = NO;
    [openPanel beginSheetModalForWindow:self.window
                      completionHandler:^(NSInteger result) {
                          NSURL *file = openPanel.URL;
                          [self processURL:file];
                      }];
}

- (IBAction)openURL:(id)sender {
    [self toggleURLFieldShow];
}

- (IBAction)cancelURL:(id)sender {
    [self toggleURLFieldHide];
}

- (IBAction)loadURLAction:(id)sender {
    
    NSString *urlString = [(NSTextField*)sender stringValue];
    
    if (!urlString || urlString.length == 0)return;

    if (![[urlString substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"http://"])
        urlString = [NSString stringWithFormat:@"http://%@", urlString];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url) {
        [self processURL:url];
    }
    
    [self toggleURLFieldHide];
}

- (void) processURL:(NSURL*)file {
    NSURLRequest *r = [[NSURLRequest alloc] initWithURL:file];
    [self.webView.mainFrame loadRequest:r];
    
    // store in open recent
    [[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL:
     file];
}

- (void) toggleURLFieldShow {
    [self.loadURLView setHidden:NO];
    [[self.loadURLConstraint animator] setConstant:52];
}

- (void) toggleURLFieldHide {
    [[self.loadURLConstraint animator] setConstant:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadURLView setHidden:YES];
    });
}

@end
