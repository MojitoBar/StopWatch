# StopWatch
 Stopwatch developed with SwiftUI

### ScreenShots
<img src="https://github.com/MojitoBar/StopWatch/blob/main/Stopwatch_Screenshot.gif" width="250"/>

### Skill
- Init timer, count every 0.01s
```Swift
let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
```

- Use timer
```Swift
.onReceive(self.timer, perform: { _ in
    // Do Something...
})
```

---
* Reference by [soapyigu's github](https://github.com/soapyigu/Swift-30-Projects/tree/master/Project%2002%20-%20Stopwatch)
