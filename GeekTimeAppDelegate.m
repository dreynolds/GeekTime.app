//
//  GeekTimeAppDelegate.m
//  GeekTime
//
//  Created by David Reynolds on 24/08/2010.
//

#import "GeekTimeAppDelegate.h"

@implementation GeekTimeAppDelegate

- (NSString *)updateGeekTime {
	NSDate *now = [NSDate date];
	NSTimeZone *utc = [NSTimeZone timeZoneWithName:@"UTC"];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:utc];
    [dateFormatter setDateFormat:@"HH:mm:ss:SSS"];
	NSString *dateString = [dateFormatter stringFromDate:now];
	NSArray *bits = [dateString componentsSeparatedByString:@":"];
	
	NSInteger hours = [[bits objectAtIndex:0] integerValue];
	NSInteger minutes = [[bits objectAtIndex:1] integerValue];
	NSInteger seconds = [[bits objectAtIndex:2] integerValue];
	NSInteger microseconds = [[bits objectAtIndex:3] integerValue];
	
	int geektime = 65536 * ((3600000 * hours) + (60000 * minutes) + (1000 * seconds) + microseconds) / (24 * 60 * 60 * 1000);
	NSString *padding;
	if (geektime < 1000) {
		padding = @"0";
	}
	else if (geektime < 100) {
		padding = @"00";
	}
	else if (geektime < 10) {
		padding = @"000";
	}
	else {
		padding = @"";
	}
	NSString *geekTimeUpperHex = [[NSString stringWithFormat:@"%x", geektime] uppercaseString];
	NSString *geekdateString = [NSString stringWithFormat:@"0x%@%@", padding, geekTimeUpperHex];
	return geekdateString;
}

- (void)tick {
	[statusItem setTitle:[self updateGeekTime]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	NSDate *start_time = [NSDate date];	
	// Create the statusbar item
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:70.0] retain];
	// Set initial time
	[statusItem setTitle:[self updateGeekTime]];
	// Let it be highlighted when clicked
	[statusItem setHighlightMode:YES];
	
	menu = [[NSMenu alloc] init];
	NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
	[menu addItem:menuItem];
	[menuItem release];
	[statusItem setMenu:menu];
	[menu release];
	
	NSTimer *timer = [[NSTimer alloc] initWithFireDate:start_time interval:0.65 target:self selector:@selector(tick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[timer fire];
	[timer release];
}

@end
