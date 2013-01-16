//
//  ITAppDelegate.m
//  Expanding Search
//
//  Created by Ilija Tovilo on 12/3/12.
//  Copyright (c) 2012 Ilija Tovilo. All rights reserved.
//

// Copyright (c) 2012, Ilija Tovilo
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice,
// this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
// INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "ITAppDelegate.h"

@implementation ITAppDelegate

/*
 * Everything in the .m file is optional
 */

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [self.searchField setDelegate:self];
}

- (void)searchFieldDidExpand:(ITSearchField *)searchField {
    NSLog(@"expanded");
}

- (void)searchFieldDidCollapse:(ITSearchField *)searchField {
    NSLog(@"collapsed");
}

- (BOOL)searchFieldShouldCollapse:(ITSearchField *)searchField {
    return YES;
}

- (BOOL)searchFieldShouldExpand:(ITSearchField *)searchField {
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    NSLog(@"%d", self.searchField.isCollapsed);
    return NSTerminateCancel;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
    if (!self.searchField.isCollapsed && !self.searchField.stringValue.length) {
        self.searchField.isCollapsed = YES;
    }
}

- (void)controlTextDidBeginEditing:(NSNotification *)obj {
    if (self.searchField.isCollapsed) {
        self.searchField.isCollapsed = NO;
    }
}

@end
