#import "substrate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MediaRemote/MediaRemote.h>
#import <SpringBoard/SpringBoard.h>
#import <AudioToolbox/AudioServices.h>

#import "colors/CCColorCube.h"

NSString *oldLyrics;

@interface UILabel (Octave)
- (void)setMarqueeEnabled:(BOOL)arg1;
- (void)setMarqueeRunning:(BOOL)arg1;
@end

@interface UIView (Octave)
- (UIViewController *)_viewControllerForAncestor;
- (void)setOverrideUserInterfaceStyle:(NSInteger)style;
@end

@interface _UISlideriOSVisualElement: UIView
@end

@interface MRPlatterViewController : UIViewController
@property (assign,nonatomic) id delegate;
@end

@interface MRUNowPlayingViewController : UIViewController
@property (assign,nonatomic) id delegate;
@end

@interface MRUNowPlayingTimeControlsView : UIView
@property (nonatomic,retain) UILabel *elapsedTimeLabel;
@property (nonatomic,retain) UILabel *remainingTimeLabel;
@property (nonatomic,retain) UIView *elapsedTrack;
@property (nonatomic,retain) UIView *knobView;
@property (nonatomic,retain) UIView *remainingTrack;
@end

@interface MRUTransportButton : UIButton
@property (nonatomic,retain) UIImageView *imageView;
-(void)setStylingProvider:(id)arg1;
@end

@interface MRUNowPlayingTransportControlsView : UIView
@property (nonatomic,retain) MRUTransportButton *leftButton;
@property (nonatomic,retain) MRUTransportButton *middleButton;
@property (nonatomic,retain) MRUTransportButton *rightButton;
@end

@interface MRUNowPlayingVolumeSlider : UISlider
@property (nonatomic,retain) UIImage *minimumValueImage;
@property (nonatomic,retain) UIImage *maximumValueImage;
@property (nonatomic,retain) UIImage *currentThumbImage;
@property (nonatomic,retain) UIImage *currentMinimumTrackImage;
@property (nonatomic,retain) UIImage *currentMaximumTrackImage;
@property (nonatomic,retain) UIColor *minimumTrackTintColor;
@property (nonatomic,retain) UIColor *maximumTrackTintColor;
@end

@interface SBMediaController : NSObject
+ (id)sharedInstance;
- (BOOL)isPaused;
- (BOOL)isPlaying;
- (void)setNowPlayingInfo:(id)arg1;
- (BOOL)changeTrack:(int)arg1 eventSource:(long long)arg2;
- (BOOL)togglePlayPauseForEventSource:(long long)arg1;
- (BOOL)toggleShuffleForEventSource:(long long)arg1;
- (BOOL)toggleRepeatForEventSource:(long long)arg1;
@end

@interface MediaControlsHeaderView : UIView
@end

@interface CSAdjunctItemView : UIView
@end

@interface CSAdjunctListView : UIView
@end

@interface CSCoverSheetView : UIView
@end

@interface CSMainPageView : UIView
@property (nonatomic, retain) UIView *octaveView;
// @property (nonatomic, retain) UIVisualEffectView *artistTitleMask;
@property (nonatomic, retain) CAGradientLayer *gradientView;
@property (nonatomic, retain) UIImageView *artworkImageView;
@property (nonatomic, retain) UIButton *lyricsButton;
@property (nonatomic, retain) UILabel *songTitleLabel;
@property (nonatomic, retain) UILabel *artistTitleLabel;
@property (nonatomic, retain) UITextView *lyricsScrollView;
-(void)presentLyrics;
-(void)updateLyricsView;
-(NSString *)getLyricsForSong:(NSString *)keyword;
@end
