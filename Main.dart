import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

import 'Handler.dart';

void main() async {
  Router app = Router();

  app.get('/', index);
  app.get('/<text>', await words);

  await io.serve(app, 'localhost', 8083);
}