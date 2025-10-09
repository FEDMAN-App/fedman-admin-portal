import 'package:flutter/widgets.dart';
import '../utils/responsive_helper.dart';

class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  
  // Row properties
  final MainAxisAlignment? rowMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final MainAxisSize? rowMainAxisSize;
  
  // Column properties
  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final MainAxisSize? columnMainAxisSize;
  
  // Common properties
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  
  final ResponsiveLayout layout;
  final double? spacing;
  final bool wrapInExpanded;
  final bool excludeSpacingFromExpanded;
  final List<int>? flexValues;

  const ResponsiveRowColumn({
    super.key,
    required this.children,
    this.rowMainAxisAlignment,
    this.rowCrossAxisAlignment,
    this.rowMainAxisSize,
    this.columnMainAxisAlignment,
    this.columnCrossAxisAlignment,
    this.columnMainAxisSize,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.layout = ResponsiveLayout.mobileColumn,
    this.spacing,
    this.wrapInExpanded = false,
    this.excludeSpacingFromExpanded = true,
    this.flexValues,
  });

  // Backward compatibility constructor
  const ResponsiveRowColumn.legacy({
    super.key,
    required this.children,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.layout = ResponsiveLayout.mobileColumn,
    this.spacing,
    this.wrapInExpanded = false,
    this.excludeSpacingFromExpanded = true,
  }) : rowMainAxisAlignment = mainAxisAlignment,
       rowCrossAxisAlignment = crossAxisAlignment,
       rowMainAxisSize = mainAxisSize,
       columnMainAxisAlignment = mainAxisAlignment,
       columnCrossAxisAlignment = crossAxisAlignment,
       columnMainAxisSize = mainAxisSize,
       flexValues = null;

  @override
  Widget build(BuildContext context) {
    final isColumn = _shouldUseColumn(context);
    final filteredChildren = _filterChildren(isColumn);
    final childrenWithSpacing = _addSpacing(isColumn, filteredChildren);

    if (isColumn) {
      return Column(
        mainAxisAlignment: columnMainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: columnCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: columnMainAxisSize ?? MainAxisSize.max,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: childrenWithSpacing,
      );
    } else {
      return Row(
        mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: rowCrossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisSize: rowMainAxisSize ?? MainAxisSize.max,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        textBaseline: textBaseline,
        children: wrapInExpanded ? _wrapChildrenInExpanded(childrenWithSpacing) : childrenWithSpacing,
      );
    }
  }

  List<Widget> _filterChildren(bool isColumn) {
    return children.where((child) {
      // Filter out SizedBox() widgets (commonly used as conditional placeholders)
      if (child is SizedBox && 
          (child.width == null || child.width == 0) && 
          (child.height == null || child.height == 0) &&
          child.child == null) {
        return false;
      }
      return true;
    }).toList();
  }

  List<Widget> _wrapChildrenInExpanded(List<Widget> childrenList) {
    return childrenList.asMap().entries.map((entry) {
      final index = entry.key;
      final child = entry.value;
      
      // Don't wrap spacing widgets (SizedBox) in Expanded if excludeSpacingFromExpanded is true
      if (excludeSpacingFromExpanded && child is SizedBox) {
        return child;
      }
      
      // Calculate flex index accounting for spacing widgets
      int flexIndex = index;
      if (excludeSpacingFromExpanded && spacing != null) {
        flexIndex = index ~/ 2; // Each spacing widget reduces the flex index
      }
      
      // Use custom flex value if provided, otherwise default to 1
      final flex = (flexValues != null && flexIndex < flexValues!.length) 
          ? flexValues![flexIndex] 
          : 1;
      
      return Expanded(flex: flex, child: child);
    }).toList();
  }

  bool _shouldUseColumn(BuildContext context) {
    switch (layout) {
      case ResponsiveLayout.mobileColumn:
        return ResponsiveHelper.isMobile(context);
      case ResponsiveLayout.tabletColumn:
        return ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTablet(context);
      case ResponsiveLayout.alwaysColumn:
        return true;
      case ResponsiveLayout.alwaysRow:
        return false;
      case ResponsiveLayout.mobileTabletColumn:
        return !ResponsiveHelper.isDesktop(context);
    }
  }

  List<Widget> _addSpacing(bool isColumn, List<Widget> childrenList) {
    if (spacing == null || childrenList.isEmpty) {
      return childrenList;
    }

    final spacingWidget = isColumn 
        ? SizedBox(height: spacing)
        : SizedBox(width: spacing);

    final result = <Widget>[];
    for (int i = 0; i < childrenList.length; i++) {
      result.add(childrenList[i]);
      if (i < childrenList.length - 1) {
        result.add(spacingWidget);
      }
    }
    return result;
  }
}

enum ResponsiveLayout {
  mobileColumn,
  tabletColumn,
  mobileTabletColumn,
  alwaysColumn,
  alwaysRow,
}

class ResponsiveWrap extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final WrapAlignment runAlignment;
  final double runSpacing;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final Clip clipBehavior;
  
  final ResponsiveLayout wrapAt;

  const ResponsiveWrap({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.wrapAt = ResponsiveLayout.mobileColumn,
  });

  @override
  Widget build(BuildContext context) {
    final shouldWrap = _shouldWrap(context);

    if (shouldWrap) {
      return Wrap(
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runAlignment: runAlignment,
        runSpacing: runSpacing,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        clipBehavior: clipBehavior,
        children: children,
      );
    } else {
      return direction == Axis.horizontal
          ? Row(
              mainAxisAlignment: _convertToMainAxisAlignment(alignment),
              crossAxisAlignment: _convertToCrossAxisAlignment(crossAxisAlignment),
              textDirection: textDirection,
              children: children.map((child) => child).toList(),
            )
          : Column(
              mainAxisAlignment: _convertToMainAxisAlignment(alignment),
              crossAxisAlignment: _convertToCrossAxisAlignment(crossAxisAlignment),
              children: children,
            );
    }
  }

  bool _shouldWrap(BuildContext context) {
    switch (wrapAt) {
      case ResponsiveLayout.mobileColumn:
        return ResponsiveHelper.isMobile(context);
      case ResponsiveLayout.tabletColumn:
        return ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTablet(context);
      case ResponsiveLayout.mobileTabletColumn:
        return !ResponsiveHelper.isDesktop(context);
      case ResponsiveLayout.alwaysColumn:
        return true;
      case ResponsiveLayout.alwaysRow:
        return false;
    }
  }

  MainAxisAlignment _convertToMainAxisAlignment(WrapAlignment wrapAlignment) {
    switch (wrapAlignment) {
      case WrapAlignment.start:
        return MainAxisAlignment.start;
      case WrapAlignment.center:
        return MainAxisAlignment.center;
      case WrapAlignment.end:
        return MainAxisAlignment.end;
      case WrapAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case WrapAlignment.spaceAround:
        return MainAxisAlignment.spaceAround;
      case WrapAlignment.spaceEvenly:
        return MainAxisAlignment.spaceEvenly;
    }
  }

  CrossAxisAlignment _convertToCrossAxisAlignment(WrapCrossAlignment wrapCrossAlignment) {
    switch (wrapCrossAlignment) {
      case WrapCrossAlignment.start:
        return CrossAxisAlignment.start;
      case WrapCrossAlignment.center:
        return CrossAxisAlignment.center;
      case WrapCrossAlignment.end:
        return CrossAxisAlignment.end;
    }
  }
}