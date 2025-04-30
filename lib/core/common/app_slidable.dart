import 'package:flutter/material.dart';

// AppSlidable is a custom widget that allows a card to slide and reveal actions behind it.
class AppSlidable extends StatefulWidget {
  const AppSlidable({
    required this.slidingCard, // The main card widget that will slide
    required this.slideActions, // A list of action widgets that will be revealed when sliding
    super.key,
  });

  final Widget slidingCard;
  final List<Widget> slideActions;

  @override
  State<AppSlidable> createState() => _AppSlidableState();
}

class _AppSlidableState extends State<AppSlidable> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // Controls the animation of the sliding card
  late Animation<double> _animation; // Defines the animation curve
  double _dragExtent = 0; // Tracks the horizontal drag distance
  double _actionWidth = 0; // Width of the area occupied by slide actions

  // Initialize the state with the provided sliding card and slide actions
  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a duration of 300 milliseconds
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    // Define the animation curve
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Trigger a slight slide animation when the widget loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the initial drag extent to a larger negative value to reveal more actions
      setState(() {
        _dragExtent = -_actionWidth * 0.3; // Adjust this value for the desired slide distance
      });
      _controller.forward().then((_) {
        // Reset the drag extent after the animation completes
        setState(() {
          _dragExtent = 0;
        });
        _controller.reverse();
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free up resources
    _controller.dispose();
    super.dispose();
  }

  // Resets the position of the sliding card if it has been dragged
  void _resetPosition() {
    if (_dragExtent != 0) {
      _controller.reverse(); // Animate the card back to its original position
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Calculate the width for the slide actions based on the available width
        _actionWidth = widget.slideActions.isNotEmpty ? constraints.maxWidth * 0.3 : 0;

        return Stack(
          children: [
            // Positioned.fill ensures the slide actions fill the available space
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Match the main card's border radius
                    child: Transform.translate(
                      offset: Offset(_actionWidth * (1 - _animation.value) * 0.5, 0), // Slight slide to right
                      child: Opacity(
                        opacity: _animation.value, // Animate the opacity of actions
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: widget.slideActions, // Display the slide actions
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // GestureDetector to handle user interactions with the sliding card
            GestureDetector(
              onTap: _resetPosition, // Reset position on tap
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragExtent += details.delta.dx; // Update drag extent based on user input
                  _dragExtent = _dragExtent.clamp(-_actionWidth, 0.0); // Clamp the drag extent
                });
              },
              onHorizontalDragEnd: (details) {
                final velocity = details.velocity.pixelsPerSecond.dx; // Get the drag velocity
                final isOpen = _controller.status == AnimationStatus.completed; // Check if the card is open

                if (velocity < 0 && !isOpen) {
                  _controller.forward(); // Open the card if dragging left
                } else if (velocity > 0 && isOpen) {
                  _controller.reverse(); // Close the card if dragging right
                } else {
                  // Complete the slide in the direction of the drag
                  if (_dragExtent < 0) {
                    _controller.forward(); // Open the card
                  } else {
                    _controller.reverse(); // Close the card
                  }
                }
              },
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_dragExtent * _animation.value, 0), // Translate the card based on drag
                    child: widget.slidingCard,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}