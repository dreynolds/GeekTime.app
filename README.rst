A simple OS X menu bar status item for geektime.org.

I updated it to be native Objective C.  The only issue I came across is that getting microseconds from an NSDate seems to be pretty much impossible therefore the accuracy is a little off from the original PyObjC version. 

I didn't bother implementing the int2base method since it was simpler to just use Objective C string formatter to covert to Hex.