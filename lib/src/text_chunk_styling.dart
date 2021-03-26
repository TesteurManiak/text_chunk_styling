import 'package:flutter/material.dart';

/// Wrapper around [RichText] Widget which allows to aply a specific [TextStyle]
/// to some parts contained inside the `text` argument.
class TextChunkStyling extends StatelessWidget {
  /// The base text to display.
  final String text;

  /// List of string inside `text` that should be highlighted.
  final List<String> highlightText;

  /// If `caseSensitive` is disabled, then case is ignored.
  final bool caseSensitive;

  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? textStyle;

  /// Style to apply to the highlighted text.
  final TextStyle highlightTextStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [text] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any. If there is no ambient
  /// [Directionality], then this must not be null.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int? maxLines;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  final StrutStyle? strutStyle;

  TextChunkStyling({
    Key? key,
    required this.text,
    required List<String> highlightText,
    this.caseSensitive = true,
    this.textStyle,
    required this.highlightTextStyle,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.softWrap = true,
    this.textDirection,
    this.locale,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.textWidthBasis = TextWidthBasis.parent,
    this.strutStyle,
  })  : assert(highlightText.isNotEmpty),
        assert(maxLines == null || maxLines > 0),
        this.highlightText = highlightText
            .map((e) => caseSensitive ? e : e.toLowerCase())
            .toList(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(textDirection != null || debugCheckHasDirectionality(context));

    // Define used TextStyle for classicText.
    final defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = textStyle;
    if (textStyle == null || textStyle!.inherit)
      effectiveTextStyle = defaultTextStyle.style.merge(textStyle);

    final pattern =
        RegExp('${highlightText.join("|")}', caseSensitive: caseSensitive);
    final startWithPattern = text.startsWith(pattern);
    final classicText = text.split(pattern)..removeWhere((e) => e.isEmpty);

    // Create a string separator to isolate the text to highlight.
    String strSeparator = '*';
    while (text.contains(strSeparator)) strSeparator += '*';
    final textToHighlight = text
        .splitMapJoin(pattern,
            onMatch: (m) => '${m.group(0)}', onNonMatch: (_) => strSeparator)
        .split(strSeparator)
          ..removeWhere((e) => e.isEmpty);

    // Combine the two list in correct order
    final combined = <String>[];
    if (startWithPattern) {
      for (int i = 0; i < textToHighlight.length; i++) {
        if (i < textToHighlight.length)
          combined.add(textToHighlight.elementAt(i));
        if (i < classicText.length) combined.add(classicText.elementAt(i));
      }
    } else {
      for (int i = 0; i < classicText.length; i++) {
        if (i < classicText.length) combined.add(classicText.elementAt(i));
        if (i < textToHighlight.length)
          combined.add(textToHighlight.elementAt(i));
      }
    }

    return RichText(
      strutStyle: strutStyle,
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection ?? Directionality.of(context),
      locale: locale ?? Localizations.localeOf(context),
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      text: TextSpan(
        children: combined
            .map<TextSpan>((e) => TextSpan(
                  text: e,
                  style: highlightText.contains(e.toLowerCase())
                      ? highlightTextStyle
                      : effectiveTextStyle,
                ))
            .toList(),
      ),
    );
  }
}
