# ICPageViewController
A container which easy to add children viewcontrollers and support horizontal scroll.

## Preview
![screenshot](https://github.com/interchen/ICPageViewController/blob/master/ICPageViewController-screenshot.gif)

## Create ICPageViewController instance
```swift
let pageViewController = ICPageViewController()
    
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    pageViewController.pageViewDelegate = self
    self.addChildViewController(pageViewController)
    self.view.addSubview(pageViewController.view)
    pageViewController.didMove(toParentViewController: self)
}

override func viewDidLayoutSubviews() {
    pageViewController.view.frame = self.view.bounds
}
```

## Implement ICPageViewControllerDelegate
```swift
func numberOfItems(in pageViewController: ICPageViewController) -> Int {
    return 10
}

func pageViewController(_ pageViewController: ICPageViewController, viewControllerForItemAt index: Int) -> UIViewController {
    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "demoViewController") as? SubViewController
    viewController?.label = "sub viewcontroller \(index)"
    switch index {
    case 0:
        viewController?.view.backgroundColor = .blue

    case 1:
        viewController?.view.backgroundColor = .red

    case 2:
        viewController?.view.backgroundColor = .gray

    default:
        viewController?.view.backgroundColor = .white
    }
    return viewController!
}
```

## Cocoapods
`pod 'ICPageViewController'`

## Don't forget to star if you think this is helpful.

