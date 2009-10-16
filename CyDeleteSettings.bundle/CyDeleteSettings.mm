#import "CyDeleteSettings.h"

static CFNotificationCenterRef darwinNotifyCenter = CFNotificationCenterGetDarwinNotifyCenter();

@implementation CyDeleteSettingsController

- (void)viewDidBecomeVisible {
	NSFileManager *manager = [NSFileManager defaultManager];
	_cydiaPresent = [manager fileExistsAtPath:@"/Applications/Cydia.app/Info.plist"];
	_icyPresent = [manager fileExistsAtPath:@"/Applications/Icy.app/Info.plist"];
//	if(!_cydiaPresent) [self removeSpecifier:[_specifiers objectAtIndex:5] animated:YES];
//	if(!_icyPresent) [self removeSpecifier:[_specifiers objectAtIndex:6] animated:YES];
}

- (id)specifiers {
	return [self localizedSpecifiersWithSpecifiers:[self loadSpecifiersFromPlistName:@"CyDelete" target:self]];
}

- (void)donationButton:(id)arg {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=4275311"]];
}

-(void)setPreferenceValue:(id)value specifier:(id)specifier {
	[super setPreferenceValue:value specifier:specifier];
	// Post a notification.
	NSString *notification = [specifier propertyForKey:@"postNotification"];
	CFNotificationCenterPostNotification(darwinNotifyCenter, (CFStringRef)notification, NULL, NULL, true);
}

/*
- (id)setCydiaProtection:(CFBooleanRef)value specifier:(id)specifier {
	if(value == kCFBooleanFalse) {
		if(!_icyPresent) value = kCFBooleanTrue;
	}
	[self setPreferenceValue:(id)value specifier:specifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
*/

@end
