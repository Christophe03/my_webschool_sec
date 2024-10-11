import 'package:flutter/material.dart';

// final String demoText = "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>" +
// //'''<iframe width="560" height="315" src="https://www.youtube.com/embed/-WRzl9L4z3g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'''+
// //'''<video controls src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"></video>''' +
// //'''<iframe src="https://player.vimeo.com/video/226053498?h=a1599a8ee9" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>''' +
// "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s</p>";

class HtmlBodyWidget extends StatelessWidget {
  final String content;
  final bool isVideoEnabled;
  final bool isimageEnabled;
  final bool isIframeVideoEnabled;
  final double? fontSize;

  const HtmlBodyWidget({
    Key? key,
    required this.content,
    required this.isVideoEnabled,
    required this.isimageEnabled,
    required this.isIframeVideoEnabled,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     child: Html(
  //       data: '''$content''',
  //       onLinkTap: (String? url, RenderContext context1,
  //           Map<String, String> attributes, _) {
  //         AppService().openLinkWithCustomTab(context, url!);
  //       },
  //       onImageTap: (String? url, RenderContext context1,
  //           Map<String, String> attributes, _) {
  //         nextScreen(context, FullScreenImage(imageUrl: url!));
  //       },
  //       style: {
  //         "body": Style(
  //           margin: EdgeInsets.zero,
  //           padding: EdgeInsets.zero,

  //           //Enable the below line and disble the upper line to disble full width image/video

  //           //padding: EdgeInsets.all(20),

  //           fontSize: fontSize == null ? FontSize(14.0) : FontSize(16.0),
  //           lineHeight: LineHeight(1.7),
  //           fontFamily: 'Open Sans',
  //           fontWeight: FontWeight.w400,
  //           color: context.watch<ThemeBloc>().darkTheme == false
  //               ? CustomColor().bodyTextColorLight
  //               : CustomColor().bodyTextColorDark,
  //         ),
  //         "figure": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),

  //         //Disable this line to disble full width image/video
  //         "p,h1,h2,h3,h4,h5,h6": Style(margin: EdgeInsets.all(20)),
  //       },
  //       customRenders: {
  //         AppService.videoMatcher():
  //             CustomRender.widget(widget: (context1, buildChildren) {
  //           String _videoSource = context1.tree.attributes['src'].toString();
  //           print(_videoSource.toString());
  //           if (isVideoEnabled == false) return Container();
  //           return VideoPlayerWidget(
  //               videoUrl: _videoSource, videoType: 'network');
  //         }),
  //         AppService.iframeMatcher():
  //             CustomRender.widget(widget: (context1, children) {
  //           final String _videoSource =
  //               context1.tree.element!.attributes['src'].toString();
  //           if (isIframeVideoEnabled == false) return Container();
  //           if (_videoSource.contains('youtube')) {
  //             return VideoPlayerWidget(
  //                 videoUrl: _videoSource, videoType: 'youtube');
  //           } else if (_videoSource.contains('vimeo')) {
  //             return VideoPlayerWidget(
  //                 videoUrl: _videoSource, videoType: 'vimeo');
  //           }
  //           return Container();
  //         })
  //       },
  //     ),
  //   );
  // }
}
