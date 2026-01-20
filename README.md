# tooltip_plus

A powerful and flexible tooltip package for Flutter that goes beyond simple text. Create beautiful, highly customizable tooltips with rich content, shadows, blurs, and precise control over positioning and styling.

## Features

*   **Rich Content Support**: Create tooltips with titles, descriptions, icons, or any custom widget.
*   **Flexible Positioning**: Position tooltips TOP, BOTTOM, LEFT, or RIGHT of the target.
*   **Arrow Customization**: precise control over arrow direction, width, height, and offset.
*   **Styling**: Configure background colors, borders, shadows, and even background blur effects.
*   **Factory Constructors**: Built-in `minimal`, `rich`, and `error` factories for quick and beautiful presets.
*   **Auto-dismiss**: Optional auto-dismiss timer.
*   **Builders**: Dynamic content generation using builders.

## Getting started

Add `tooltip_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  tooltip_plus: ^0.0.1
```

## Usage

Wrap any widget with `TooltipTarget` to add a tooltip to it.

### Basic Usage

```dart
TooltipTarget(
  tooltipContent: Text(
    "Hello World!",
    style: TextStyle(color: Colors.white),
  ),
  tooltipColor: Colors.black,
  child: Icon(Icons.info),
)
```

### Minimal Tooltip

Use the `.minimal` factory for simple text tooltips.

```dart
TooltipTarget.minimal(
  text: "Copied to clipboard!",
  child: IconButton(
    icon: Icon(Icons.copy),
    onPressed: () {},
  ),
)
```

### Rich Tooltip

Use the `.rich` factory for more complex notifications or information.

```dart
TooltipTarget.rich(
  title: "Feature Available",
  description: "You can now use the new improved search functionality.",
  icon: Icons.new_releases,
  child: Icon(Icons.info_outline),
)
```

### Arrow Customization

You can fully customize the arrow's size and position. This is useful when you want a specific look or need to align the arrow with a specific part of your UI.

```dart
TooltipTarget(
  arrowWidth: 20.0,   // Customize width
  arrowHeight: 15.0,  // Customize height
  customArrowOffset: 0.5, // Center the arrow (0.0 to 1.0)
  direction: TooltipDirection.top,
  child: MyWidget(),
  // ... other properties
)
```

### Error Tooltip

```dart
TooltipTarget.error(
  message: "Network connection lost.",
  child: Icon(Icons.wifi_off),
)
```

## Configuration

The `TooltipTarget` widget offers extensive configuration options:

| Parameter | Type | Description |
|---|---|---|
| `direction` | `TooltipDirection` | Top, Bottom, Left, or Right. |
| `arrowDirection` | `TooltipArrowDirection` | Direction the arrow points (usually matches `direction`). |
| `arrowWidth` | `double` | Width of the arrow base. |
| `arrowHeight` | `double` | Height of the arrow. |
| `customArrowOffset` | `double` | Relative position of the arrow (0.0 to 1.0). |
| `tooltipHeight/Width` | `double` | Dimensions of the tooltip container. |
| `shadow` | `TooltipShadowConfig` | Configure shadow blur, color, and elevation. |
| `blur` | `TooltipBlurConfig` | Apply a blur effect to the background behind the tooltip. |
| `border` | `TooltipBorderConfig` | Configure border color, width, and radius. |
| `autoDismiss` | `Duration?` | automatically close the tooltip after this duration. |

## License

MIT
