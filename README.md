# Double Tap to Like

*The heart animation that appears where you double tap.*

![Swift](https://img.shields.io/badge/Swift-5.0-F05138?style=flat-square&logo=swift&logoColor=white) ![UIKit](https://img.shields.io/badge/UIKit-2396F3?style=flat-square&logo=uikit&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-17.5%2B-000000?style=flat-square&logo=apple&logoColor=white) ![Topic](https://img.shields.io/badge/topic-gesture%20and%20animation-6366F1?style=flat-square) ![Dependencies](https://img.shields.io/badge/dependencies-none-16A34A?style=flat-square)

## Overview

A double tap places a heart at the touch location, scales it up, holds briefly and fades it out. The detail that makes it feel right is that the heart appears under the finger rather than in the centre of the view.

## How it works

```mermaid
flowchart TD
    G["UITapGestureRecognizer<br/>numberOfTapsRequired = 2"] --> H["didDoubleTap(_:)"]
    H --> LOC["gesture.location(in: view)"]
    LOC --> PLACE["position the heart image at that point"]
    PLACE --> A1["UIView.animate<br/>scale up, alpha to 1"]
    A1 --> A2["completion: UIView.animate<br/>hold, then alpha to 0"]
    A2 --> CLEAN["remove the heart"]
```

## Implementation notes

- **Location from the recogniser.** `location(in:)` gives the tap point in the view coordinate space, which is what anchors the heart to the finger.
- **Animations chained through completions.** The grow and the fade are separate blocks, so the hold between them is explicit rather than hidden in one long duration.
- **Transform rather than frame.** Scaling uses `CGAffineTransform`, which animates on the compositor and does not trigger layout.
- **The heart is transient.** It is created per tap and removed on completion, so rapid taps do not leave views behind.

## Project structure

```
DoubleTapLike/
└── ViewController.swift
```

## Requirements

Xcode 15 or later, iOS 17.5 or later. No external dependencies.
