import 'package:equatable/equatable.dart';

class TidalAuthError extends Equatable {
  final String errorCode;
  final String errorMesssage;

  const TidalAuthError({
    required this.errorCode,
    required this.errorMesssage,
  });

  @override
  List<Object?> get props => [errorCode, errorMesssage];
}
