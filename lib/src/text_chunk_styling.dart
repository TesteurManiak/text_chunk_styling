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

  /// Style to apply to the all elements of [highlightText].
  final TextStyle? highlightTextStyle;

  /// Multiple styles to apply to the text.
  /// Each element in this list correspond to the style to apply at the same
  /// index of [highlightText].
  ///
  /// This list must be the same length as [highlightText].
  final List<TextStyle> multiTextStyles;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
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
    this.highlightTextStyle,
    this.multiTextStyles = const [],
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
        assert(
          highlightTextStyle == null || multiTextStyles.isEmpty,
          'Cannot provide both highlightTextStyle and multiTextStyles',
        ),
        highlightText = highlightText
            .map((e) => caseSensitive ? e : e.toLowerCase())
            .toList(),
        super(key: key) {
    if (multiTextStyles.isNotEmpty) {
      assert(multiTextStyles.length == highlightText.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(textDirection != null || debugCheckHasDirectionality(context));

    // Define used TextStyle for non-highlighted text.
    final defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = textStyle;
    if (textStyle == null || textStyle!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(textStyle);
    }

    // Define used TextStyle for highlighted text.
    final _highlightTextStyles = highlightTextStyle != null
        ? List<TextStyle>.generate(
            highlightText.length, (_) => highlightTextStyle!)
        : multiTextStyles;

    final pattern =
        RegExp(highlightText.join("|"), caseSensitive: caseSensitive);

    final _texts = <TextSpan>[];
    var i = 0, j = 0;
    while ((j = text.indexOf(pattern, i)) != -1) {
      if (j > i) _texts.add(TextSpan(text: text.substring(i, j)));
      final currentText = text.substring(j);
      late final String what;
      for (final e in highlightText) {
        if (currentText.startsWith(RegExp(e, caseSensitive: caseSensitive))) {
          what = e;
          break;
        }
      }
      _texts.add(
        TextSpan(
          text: text.substring(j, j + what.length),
          style: _highlightTextStyles[highlightText.indexOf(what)],
        ),
      );
      i = j + what.length;
    }
    if (i < text.length) _texts.add(TextSpan(text: text.substring(i)));

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
      text: TextSpan(children: _texts, style: effectiveTextStyle),
    );
  }
}
