

<h2 align="center">Buttons that show progress!</h2>

<p align="center">
With asynch actions, use the buttons that soeak for themselves, show what they are doing and avoid duplicate clicks
   <br>
</p>




## Getting Started
Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  progressive_buttons: ^1.0.0
```

### Add import package

```dart
import 'package:progressive_buttons/progressive_buttons.dart';
```

### Easy to use
Its super easy to use Progressive Button<br>
Copy this code to see a progressive button 😊

```dart
ProgressiveButton(
    text: 'Click to Perform',
    onPressed: (index){Future.delayed(Duration(seconds: 2));},
)
```
