import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';

class DeepLinkHandler {
  final _appLinks = AppLinks();

  void init(GoRouter router) {
    // App estaba cerrada y se abrió desde el enlace
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) _handle(router, uri);
    });

    // App ya estaba abierta
    _appLinks.uriLinkStream.listen((uri) {
      _handle(router, uri);
    });
  }

  void _handle(GoRouter router, Uri uri) {
    // scout://invite/{listId}/{token}
    final segments = uri.pathSegments;
    if (segments.length == 3 && segments[0] == 'invite') {
      router.go('/invite/${segments[1]}/${segments[2]}');
    }
  }
}