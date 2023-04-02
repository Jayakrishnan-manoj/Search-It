import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'openAi_key', obfuscate: true)
  static final openAi_key = _Env.openAi_key;
}
