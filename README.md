HAWTiltedImageView
==================

A view that uses motion to show all of an image.

## Installation

Install with [CocoaPods](http://cocoapods.org):

	pod 'HAWTiltedImageView'

## Usage

### Creating an HAWTiltedImageView

1. Import:

    `#import "HAWTiltedImageView.h"`

2. Create a view without a motion mananger 

    `HAWTiltedImageView *view = [[HAWTiltedImageView alloc] init];`

   or with a motion mananger :

    ` HAWTiltedImageView *view = [[HAWTiltedImageView alloc] initWithMotionManager:self.motionManager];`
    
## Examples

There is an example included with the project. To install, 

```
	$ pod install
 	$ open TiledImageViewExample.xcworkspace/
```

##Contribute

Send me pull requests !!

##Authors

James Paolantonio - [@jpaolantonio](http://twitter.com/jPaolantonio)

####Extra 

This was built while standing up.