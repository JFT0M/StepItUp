
#import "XHAlbumPhotoCollectionViewCell.h"

@implementation XHAlbumPhotoCollectionViewCell

#pragma mark - Propertys

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _photoImageView.image = [UIImage imageNamed:@"MeIcon"];
    }
    return _photoImageView;
}

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}

@end
