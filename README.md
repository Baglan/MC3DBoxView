# MC3DBoxView



## Goal of the project

Create a very easy-to-use "2.5D" view.

Here is a screenshot from the sample project:

![Sample project screenshot](https://github.com/Baglan/MC3DBoxView/raw/master/MC3DBoxView.png)

## License

This code is available under the MIT license.

## Installation

1. Drag files from the Classes folder to your project;
2. \#import "MC3DBixView.h" wherever you want to use it.

## Usage

Here's how you create MC3DBoxView and it add to your view hierarchy (example assumes that you do that from a view controller):

```
    MC3DBoxView *boxView = [[MC3DBoxView alloc] initWithFrame:self.view.bounds
                                                     sideSize:self.view.frame.size
                                                     distance:-500];
    [self.view addSubview:boxView];
```

__sideSize__ is the size of the view which will be used as the sides of the box. By specifying this parameter, you can make box wider, taller and so on. __distance__ is used to give a perception of depth when box is rotated. Usual values are somewhere between -500 and -2000.

Views for the four sides of the box are available as properties __frontView__, __leftView__, __rightView__, __backView__. Here's for example, how you would use an image to add texture to them:

```
    UIColor *bg = [UIColor colorWithPatternImage:[UIImage imageNamed:@"checkers"]];
    
    boxView.frontView.backgroundColor = bg;
    boxView.rightView.backgroundColor = bg;
    boxView.backView.backgroundColor = bg;
    boxView.leftView.backgroundColor = bg;
```

And here's how you would add, say, a map to one of the sides:

```
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [boxView.frontView addSubview:mapView];
```